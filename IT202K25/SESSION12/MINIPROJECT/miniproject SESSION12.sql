CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 5. Bảng Bạn bè
CREATE TABLE friends (
    friendship_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status ENUM('pending','accepted','rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_posts_created_at ON posts(created_at);
CREATE VIEW view_user_info AS
SELECT user_id, username, email, created_at
FROM users;

CREATE VIEW view_post_statistics AS
SELECT 
    p.post_id,
    p.content,
    u.username,
    COUNT(DISTINCT l.like_id) AS total_likes,
    COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
LEFT JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.is_deleted = FALSE
GROUP BY p.post_id, p.content, u.username;

DELIMITER //
CREATE PROCEDURE sp_add_user(IN p_username VARCHAR(50), IN p_password VARCHAR(255), IN p_email VARCHAR(100))
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email đã được sử dụng';
    ELSE
        INSERT INTO users(username, password, email) VALUES (p_username, p_password, p_email);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_create_post(IN p_user_id INT, IN p_content TEXT, OUT p_new_post_id INT)
BEGIN
    INSERT INTO posts(user_id, content) VALUES (p_user_id, p_content);
    SET p_new_post_id = LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_get_friends(IN p_user_id INT, IN p_limit INT, IN p_offset INT)
BEGIN
    SELECT u.user_id, u.username, u.email, u.created_at
    FROM friends f
    JOIN users u ON f.friend_id = u.user_id
    WHERE f.user_id = p_user_id AND f.status = 'accepted'
    LIMIT p_limit OFFSET p_offset;
END //
DELIMITER ;

INSERT INTO users(username, password, email) VALUES
('alice', 'pass123', 'alice@example.com'),
('bob', 'pass456', 'bob@example.com'),
('charlie', 'pass789', 'charlie@example.com');

INSERT INTO posts(user_id, content) VALUES
(1, 'Hello world!'),
(2, 'My first post'),
(3, 'Good morning everyone');

INSERT INTO likes(post_id, user_id) VALUES
(1, 2),
(1, 3),
(2, 1);

INSERT INTO comments(post_id, user_id, content) VALUES
(1, 2, 'Nice post!'),
(2, 3, 'Congrats!'),
(3, 1, 'Good morning too!');

INSERT INTO friends(user_id, friend_id, status) VALUES
(1, 2, 'accepted'),
(2, 3, 'accepted'),
(1, 3, 'pending');

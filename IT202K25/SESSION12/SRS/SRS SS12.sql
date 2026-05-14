CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE friends (
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending','accepted')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_not_self_friend CHECK (user_id <> friend_id)
);

CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

CREATE INDEX idx_post_created_at ON posts(created_at);

CREATE VIEW vw_UserInfo AS
SELECT user_id, username, email, created_at
FROM users;

CREATE VIEW vw_PostStatistics AS
SELECT 
    p.post_id,
    p.content,
    u.username,
    COUNT(DISTINCT l.user_id) AS total_likes,
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

SELECT restaurant_name, created_at
FROM Restaurants
LIMIT 5;
-- cách viết đúng --
SELECT restaurant_name, created_at
FROM Restaurants
ORDER BY created_at DESC
LIMIT 5;

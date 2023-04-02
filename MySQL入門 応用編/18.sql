DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES
  ('post-1', 12),
  ('post-2', 8),
  ('post-3', 11),
  ('post-4', 3),
  ('post-5', 5),
  ('post-6', 9),
  ('post-7', 4),
  ('post-8', 10),
  ('post-9', 31);

START TRANSACTION;
UPDATE posts SET likes = likes - 1 WHERE id = 1;
-- UPDATE posts SET likes = likes + 1 WHERE id = 2;
-- COMMIT;
ROLLBACK;

SELECT * FROM posts;

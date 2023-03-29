DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140),
  likes INT
);

DESC posts;
SHOW TABLES;

INSERT INTO posts (message, likes) VALUES
  ('Thanks', 12),
  ('Arigato', 4);

SELECT * FROM posts;

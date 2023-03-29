DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140) UNIQUE,
  likes INT CHECK (likes >= 0 AND likes <= 200)
);

INSERT INTO posts (message, likes) VALUES
  ('Thanks', 12),
  ('Arigato', 4),
  ('Arigato', 154);

SELECT * FROM posts;

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140),
  likes INT,
  is_draft BOOL,
  created_at DATETIME
);

INSERT INTO posts (message, likes, is_draft, created_at) VALUES
  ('Thanks', 12, TRUE, '2020-10-11 15:32:5'),
  ('Arigato', 4, FALSE, '2001-2-16'),
  ('Merci', 4, 0, NOW());

SELECT * FROM posts;

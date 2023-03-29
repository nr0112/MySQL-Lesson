DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140),
  likes INT,
  categories SET('Gadget', 'Game', 'Business')
);

INSERT INTO posts (message, likes, categories) VALUES
  ('Thanks', 12, 3),
  ('Arigato', 4, 'Business'),
  ('Merci', 4, 5);

SELECT * FROM posts;

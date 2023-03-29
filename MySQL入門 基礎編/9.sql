DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  message VARCHAR(140),
  likes INT,
  category ENUM('Gadget', 'Game', 'Business')
);

INSERT INTO posts (message, likes, category) VALUES
  ('Thanks', 12, 'Gadget'),
  ('Arigato', 4, 2),
  ('Merci', 4, 'Business');

SELECT * FROM posts;

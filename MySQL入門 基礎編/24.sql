DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES
  ('Thanks', 12),
  ('Merci', 4),
  ('Arigato', 4),
  ('Gracias', 15),
  ('Danke', 8);

SELECT likes + 10 FROM posts;
UPDATE
  posts
SET
  likes = likes + 5,
  message = UPPER(message)
WHERE
  likes >= 10;
SELECT * FROM posts;

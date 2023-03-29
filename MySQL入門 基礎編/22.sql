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
  ('ありがとう！', 4),
  ('Gracias', 15),
  ('Danke', 8);

SELECT message, SUBSTRING(message, 3, 2) FROM posts;
SELECT CONCAT(message, '-', likes) FROM posts;
SELECT message, CHAR_LENGTH(message) AS len FROM posts;

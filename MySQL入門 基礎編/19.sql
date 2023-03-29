DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES
  ('Thanks', 12),
  ('Arigato', 4),
  ('Merci', NULL),
  ('Gracias', 15),
  ('Danke', NULL);

SELECT * FROM posts WHERE likes <> 12 OR likes IS NULL;

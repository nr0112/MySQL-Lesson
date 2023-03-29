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
  
SELECT
  likes * 500 / 3 AS bonus,
  FLOOR(likes * 500 / 3) floor,
  ROUND(likes * 500 / 3, 2) AS round,
  CEIL(likes * 500 / 3) AS ceil
FROM
posts;

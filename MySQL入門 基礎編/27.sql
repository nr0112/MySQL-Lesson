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

--ALTER TABLE posts ADD auther VARCHAR(225) AFTER id;
--ALTER TABLE posts DROP message;
--ALTER TABLE posts CHANGE likes points INT;
DROP TABLE IF EXISTS messages;
ALTER TABLE posts RENAME messages;
SHOW TABLES;

DESC posts;

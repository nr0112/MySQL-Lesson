DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  area VARCHAR(20),
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes, area) VALUES
  ('post-1', 12, 'Tokyo'),
  ('post-2', 8, 'Fukuoka'),
  ('post-3', 11, 'Tokyo'),
  ('post-4', 3, 'Osaka'),
  ('post-5', 8, 'Tokyo'),
  ('post-6', 9, 'Osaka'),
  ('post-7', 4, 'Tokyo'),
  ('post-8', 10, 'Osaka'),
  ('post-9', 31, 'Fukuoka');

DROP TABLE IF EXISTS posts_tokyo;
CREATE TABLE posts_tokyo AS SELECT * FROM posts having area = 'Tokyo';

DROP TABLE IF EXISTS posts_tokyo_view;
CREATE VIEW posts_tokyo_view AS SELECT * FROM posts having area = 'Tokyo';

UPDATE posts SET likes = 15 WHERE id = 1;

SELECT * FROM posts;
SELECT * FROM posts_tokyo_view;

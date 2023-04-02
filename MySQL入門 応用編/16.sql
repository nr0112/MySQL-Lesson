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

SELECT
  *,
  -- LAG(likes, 1) OVER (ORDER BY likes) AS lag,
  -- LEAD(likes, 1) OVER (ORDER BY likes) AS lead
  -- LAG(likes) OVER (ORDER BY likes) AS lag,
  -- LEAD(likes) OVER (ORDER BY likes) AS lead
  -- likes - LAG(likes) OVER (ORDER BY id) AS diff,
  likes - LAG(likes) OVER (ORDER BY id) AS diff
FROM
  posts;

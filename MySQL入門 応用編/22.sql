DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140),
  PRIMARY KEY (id)
);

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment) VALUES
  (1, 'comment-1-1'),
  (1, 'comment-1-2'),
  (3, 'comment-3-1'),
  (4, 'comment-4-1');

SELECT
  -- *
  -- posts.id, posts.message, comments.comment
  posts.id, message, comment
FROM
  -- posts INNER JOIN comments ON posts.id = comments.post_id;
  posts JOIN comments ON posts.id = comments.post_id;

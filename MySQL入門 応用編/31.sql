DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140),
  parent_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment, parent_id) VALUES
  (1, 'comment-1-1', NULL),
  (1, 'comment-1-2', NULL),
  (3, 'comment-3-1', NULL),
  (1, 'comment-1-2-1', 2),
  (1, 'comment-1-2-2', 2),
  (1, 'comment-1-2-1-1', 4),
  (1, 'new comment', 6);

/*
post-1
  comment-1-1
  comment-1-2
    comment-1-2-1
      comment-1-2-1-1
    comment-1-2-2
post-2
post-3
  comment-3-1
*/

SELECT * FROM posts;
SELECT * FROM comments;

-- CTE (Common Table Expression)
--   再帰的なCTE
--   再帰的ではないCTE

WITH RECURSIVE t AS (
  -- n = 1
  SELECT * FROM comments WHERE parent_id = 2
  UNION ALL
  -- n >= 2
  SELECT
    comments.*
  FROM
    comments JOIN t
  ON
    comments.parent_id = t.id
)
SELECT * FROM t;

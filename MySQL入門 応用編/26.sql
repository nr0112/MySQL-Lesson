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
  PRIMARY KEY (id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');

INSERT INTO comments (post_id, comment) VALUES
  (1, 'comment-1-1'),
  (1, 'comment-1-2'),
  (3, 'comment-3-1');

INSERT INTO posts (message) VALUES
  ('new post!');

INSERT INTO comments (post_id, comment) VALUES
  (LAST_INSERT_ID(), 'new comment');

SELECT * FROM posts;
SELECT * FROM comments;

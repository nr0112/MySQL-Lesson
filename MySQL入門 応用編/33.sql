DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS logs;
DROP TRIGGER IF EXISTS posts_update_trigger;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

CREATE TABLE logs (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  created DATETIME DEFAULT NOW(),
  PRIMARY KEY (id)
);

CREATE TRIGGER
  posts_update_trigger
AFTER UPDATE ON
  posts
FOR EACH ROW
  INSERT INTO
    logs (message)
  VALUES
    -- ('Updated');
    (CONCAT(OLD.message, ' -> ', NEW.message));

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');
UPDATE posts SET message = 'post-1 updated' WHERE id = 1;

SELECT * FROM posts;
SELECT * FROM logs;

-- SHOW TRIGGERS;
SHOW TRIGGERS\G

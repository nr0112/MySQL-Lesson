DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  area VARCHAR(20),
  PRIMARY KEY (id)
);

LOAD DATA LOCAL INFILE 'data.csv' INTO TABLE posts
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES
  (message, likes, area);

-- SHOW INDEX FROM posts\G
-- EXPLAIN SELECT * FROM posts WHERE id = 30\G

ALTER TABLE posts ADD INDEX index_area(area);
-- SHOW INDEX FROM posts\G
-- EXPLAIN SELECT * FROM posts WHERE area = 'Kyoto'\G

ALTER TABLE posts DROP INDEX index_area;
SHOW INDEX FROM posts\G

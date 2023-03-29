-- 集計関数を使う
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  likes INT,
  PRIMARY KEY (id)
);

INSERT INTO posts (message, likes) VALUES
  ('post-1', 12),
  ('post-2', 8),
  ('post-3', 11),
  ('post-4', 3),
  ('post-5', NULL),
  ('post-6', 9),
  ('post-7', 4),
  ('post-8', NULL),
  ('post-9', 31);

--   データの個数を調べる
SELECT COUNT(likes) FROM posts;
SELECT COUNT(id) FROM posts;
SELECT COUNT(*) FROM posts;

-- 合計を調べる
SELECT SUM(likes) FROM posts;
-- 平均を調べる
SELECT AVG(likes) FROM posts;
-- 最大
SELECT MAX(likes) FROM posts;
-- 最小
SELECT MIN(likes) FROM posts;

-- グループ化を行う。
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

-- 重複を省いたデータを抽出
SELECT DISTINCT area FROM posts;
-- レコードをグループ化する
SELECT area, SUM(likes) FROM posts GROUP BY area;
-- グループ化した後に条件を追加したい場合
SELECT area, SUM(likes) FROM posts GROUP BY area HAVING SUM(likes) > 30;
-- likesが10以上のものでグループ化される
SELECT area, SUM(likes) FROM posts WHERE likes > 10 GROUP BY area;
-- likesの数によってのチーム分け(IFの場合)
SELECT * IF(likes > 10, 'A', 'B') AS team FROM posts;
-- CASEの場合
SELECT * 
    CASE 
        WHEN likes > 10 THEN 'A' 
        WHEN likes > 5  THEN 'B'
        ELSE 'C'
    END AS team 
FROM 
    posts;
-- 抽出結果を別テーブルに
DROP TABLE IF EXISTS posts_tokyo; --テーブルが存在するかの確認
CREATE TABLE posts_tokyo AS SELECT * FROM posts WHERE area = 'Tokyo';
-- テーブルのコピー
DROP TABLE IF EXISTS posts_copy;
CREATE TABLE posts_copy AS SELECT * FROM posts;
-- テーブルのコピー（中身のレコードが入らない場合）
DROP TABLE IF EXISTS posts_skeleton;
CREATE TABLE posts_skeleton LIKE posts;
-- 元データから再度、値を抽出してくれる
CREATE VIEW posts_tokyo_view AS SELECT * FROM posts WHERE area = 'Tokyo';

-- 大きい順に並び替え
SELECT * FROM posts ORDER BY likes DESC;
-- 上位三名と最後の１つだけを抽出
SELECT * FROM posts ORDER BY likes DESC LIMIT 3;
SELECT * FROM posts ORDER BY likes LIMIT 1;
-- 90と91行目を１つの結果として表示させたい
(SELECT * FROM posts ORDER BY likes DESC LIMIT 3)
UNION ALL
(SELECT * FROM posts ORDER BY likes LIMIT 1);

-- サブクエリの使用
SELECT
    *
    (SELECT AVG(likes) FROM posts) AS avg
FROM 
    posts;

-- 相関サブクエリの使用
SELECT
    *
    (SELECT AVG(likes) FROM posts) AS avg,
    (SELECT AVG(likes) FROM posts AS t2 WHERE t1.area = t2.area) AS area_avg,
FROM 
    posts AS t1;

-- 抽出条件にサブクエリ
SELECT
    *
FROM
    posts
WHERE  
    likes = (SELECT MAX(likes) FROM posts);

-- 抽出元にサブクエリの使用
SELECT
    AVG(n)
FROM
    (SELECT area, COUNT(*) AS n FROM posts GROUP BY area) AS t;

-- ウィンドウ関数
SELECT
    *,
    AVG(likes) OVER () AS avg,
    -- AVG(likes) OVER (PARTITION BY area) AS area_avg, --パーティションの利用
    -- SUM(likes) OVER (PARTITION BY area) AS area_sum,
    AVG(likes) OVER w AS area_avg, --パーティションの利用
    SUM(likes) OVER w AS area_sum,
FROM
    posts
WINDOW
    w AS (PARTITION BY area);

-- FRAMEの利用
SELECT
    *,
    SUM(likes) OVER (
        PARTITION BY area
        ORDER BY likes
        -- フレームの設定を変更したい場合
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING -- 前後1行をフレームにしたい場合
    ) AS area_sum
FROM
    posts;

-- 順位づけ
SELECT
    *,
    RANK() OVER (ORDER BY likes) AS num, --同着が次の順位が飛ばされる
    -- または
    DENSE_RANK() OVER (ORDER BY likes) AS dense --同着が次の順位が飛ばされない
FROM
    posts;


SELECT
    *,
    LAG(likes, 1) OVER (ORDER BY likes) AS lag, -- 一個前のレコードの値を出す
    LEAD(likes, 1) OVER (ORDER BY likes) AS lag, -- 一個後のレコードの値を出す
    likes - LAG(likes, 1) OVER (ORDER BY likes) AS diff --　このような書き方で差分も求めれる
FROM
    posts;

-- トランザクション：データの整合性が保たれる。
-- トランザクションの利用
START TRANSACTION; -- トランザクションの開始
UPDATE posts SET likes = likes - WHERE id = 1;
UPDATE posts SET likes = likes + 1 WHERE id = 2;
COMMIT; -- トランザクションの終了
ROLLBACK; -- 何らかの障害が起きた場合は、COMMITを削除し、ROLLBACKを書くことで無かったことにできる。


-- 正規化：データを管理しやすくするためにテーブルを分割すること
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

-- 内部結合
SELECT
    *
FROM
    posts INNER JOIN comments ON posts.id = comments.post_id;
            -- or
    posts JOIN comments ON posts.id = comments.post_id;

-- 特定のカラムだけ
SELECT
    posts.id, posts.message, comments.comment
        -- or
    posts.id, message, comment
FROM
    posts INNER JOIN comments ON posts.id = comments.post_id;
            -- or
    posts JOIN comments ON posts.id = comments.post_id;

-- 左外部結合
SELECT
    *
FROM 
    posts LEFT OUTER JOIN comments ON posts.id = commnets.post_id;
        -- or
    posts LEFT JOIN comments ON posts.id = comments.post_id;

-- 右外部結合
SELECT
    *
FROM 
    posts RIGHT OUTER JOIN comments ON posts.id = commnets.post_id;
        -- or
    posts RIGHT JOIN comments ON posts.id = comments.post_id;

-- 外部キー制約
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140),
  PRIMARY KEY (id)
  FOREIGN KEY (post_id) REFERENCES posts(id) -- FOREIGN KEY を書くことで外部キーを制約できる。
);

-- データの整合性
CREATE TABLE comments (
  id INT NOT NULL AUTO_INCREMENT,
  post_id INT,
  comment VARCHAR(140),
  PRIMARY KEY (id)
  FOREIGN KEY (post_id) REFERENCES posts(id) -- FOREIGN KEY を書くことで外部キーを制約できる。
    ON DELETE CASCADE -- postsに対応するデータが削除される
    ON UPDATE CASCADE -- postsに対応するデータが更新される
);

-- LAST_INSERT_ID()
INSERT INTO comments (post_id, commnet) VALUES
    (LAST_INSERT_id(), 'new comments');  -- 直前に挿入されたレコードのIDを調べる命令

-- コメントにコメントをつける
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

INSERT INTO comments (post_id, comment, parent_id) VALUES
  (1, 'comment-1-1', NULL),
  (1, 'comment-1-2', NULL),
  (3, 'comment-3-1', NULL),
  (1, 'comment-1-2-1', 2),
  (1, 'comment-1-2-2', 2),
  (1, 'comment-1-2-1-1', 4);

SELECT * FROM comments WHERE parent_id = 2
UNION ALL
SELECT
  comments.*
FROM
  comments JOIN (
    SELECT * FROM comments WHERE parent_id = 2
  ) AS t
ON
  comments.parent_id = t.id;

-- CTEの利用：一時的なテーブル
-- 再起的なCTEと再起的ではないCTEがある。

-- 再起的ではないCTE
WITH t AS (
    SELECT * FROM comments WHERE parent_id = 2
)
SELECT
    comments.*
FROM
    comments JOIN t
ON
    comments.parent_id = t.id;

-- 再起的なCTE
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

-- トリガーの設定
CREATE TABLE posts (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  PRIMARY KEY (id)
);

CREATE TABLE logs (
  id INT NOT NULL AUTO_INCREMENT,
  message VARCHAR(140),
  createdc DATETIME DEFAULT NOW(),
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
        (CONCAT(OLD.message, ' -> ', NEW.message)); -- logに更新前と更新後の値を含める

INSERT INTO posts (message) VALUES
  ('post-1'),
  ('post-2'),
  ('post-3');
UPDATE posts SET message = 'post-1 updated' WHERE id = 1;

SHOW TRIGGERS; -- トリガーの確認

-- 外部ファイルからのデータの読み込み
LOAD DATA LOCAL INFILE 'data.csv' INTO TABLE posts
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES -- 1行目をスキップ
    (message, likes, area);

-- インデックスの利用：効率よく検索できるようになる（高速になる）
SHOW INDEX FROM posts\G; -- インデックス設定の確認
EXPLAIN SELECT * FROM posts WHERE id = 30\G;

ALTER TABLE posts ADD INDEX index_area(area); -- インデックスをつける
ALTER TABLE posts DROP INDEX index_area; -- インデックスを外す

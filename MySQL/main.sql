-- 集計処理　　likesの場合
-- データの個数
-- SELECT COUNT(likes) FROM posts;
-- 主キーの場合
-- SELECT COUNT(id) FROM posts;
-- 全体の行数可
-- ELECT COUNT(*) FROM posts;
-- 合計
-- SELECT SUM(likes) FROM posts;
-- 平均
-- SELECT AVG(likes) FROM posts;
-- 最大値
-- SELECT MAX(likes) FROM posts;
-- 最小値
-- SELECT MIN(likes) FROM posts;
-- どここの投稿がされたかを表す
-- area VARCHAR(）,
-- 重複を省いたデータを抽出する
-- DISTINCT
-- レコードをグループ化
-- GROUP BY
-- SELECT area, SUM(likes) FROM posts GROUP BY area;
-- WHEREではなくHAVING　　GROUP BYに注意！！！！
-- HAVING
-- SUM(likes) >数字 ;
--  likes の数に応じてチームを分けてみたいといったシーンを想定
-- より大きかったらなどの条件式！
-- IF()
-- いくらでも条件を増やせる
-- CASE
-- 抽出結果を別テーブルとして切り出す方法
-- CREATE TABLE テーブル名 AS 抽出条件
-- データの構造だけコピーして中身のレコードはいらない場合
-- CREATE TABLE テーブル名 LIKE ...
-- 行する度にそれぞれのテーブルを消すために
-- DROP TABLE IF EXISTS
-- 元テーブルと連動する仮想的なテーブルを作ることができる
-- CREATE VIEW
-- likes の大きい順に並べるとき
-- ORDER BY likes DESC
-- 上位 3 名
-- LIMIT 3 
-- ここでこれらをひとつの結果として出したい場合
-- UNION ALL 
-- ・2つのクエリのカラム数とデータ型が一致している必要があり
-- (SELECT * FROM posts ORDER BY likes DESC LIMIT 3)
-- UNION ALL
-- (SELECT * FROM posts ORDER BY likes LIMIT 1);
-- AVG 関数
-- 全てのレコードを集計してひとつのレコードにしてしまう
-- クエリの中で使うクエリ＝サブクエリ
-- 大本のクエリと関連付けながら、実行しているサブクエリ＝相関サブクエリ
-- 抽出元
-- FROM
--   (SELECT area, COUNT(*) AS n FROM posts GROUP BY area) AS t;
-- ウィンドウ関数＝テーブルをパーティション(PARTITION) と呼ばれる単位で集計してその結果を各レコードの横に追加
-- フレーム(FRAME)＝パーティションのサブセット、さらに細かい集計をすることもできる

-- 全体の平均
--  AVG(likes) OVER () AS avg,
--  パーティションを設定する
--  SUM(likes) OVER (PARTITION BY area) AS area_sum
-- likes の小さい順に並び替えたうえで累計を集計
-- ORDER BY likes
-- パーティションの中で前後一行をフレームにしたい場合
-- ROWS BETWEEN ... AND ...
-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
-- likes の小さい順に並び替えたあとにその連番
-- ROW_NUMBER() OVER (ORDER BY li
-- 8 で同着なので、それを考慮して順位をつけたい
--  RANK() OVER (ORDER BY likes) AS rank,　その次の順位が飛ばされる
--   DENSE_RANK() OVER (ORDER BY likes) AS dense　次の順位が飛ばされない
-- 1 個前のレコードの likes の値を求める　 LAG()
-- LAG(likes, 1) OVER (ORDER BY likes) AS lag,
-- 1 個後のレコードの likes の値
-- LEAD(likes, 1) OVER (ORDER BY likes) AS lead
-- 邪魔が入って欲しくない場合
-- START TRANSACTION；
-- 処理の終わり　COMMIT 
-- 実際に障害などが起きた場合　ROLLBACK 
-- 内部結合
--  2つのテーブルに共通のデータを取得する方法
-- 左外部結合
--  postsを軸にしてそれに対応する comment があれば取得する
-- 右外部結合
-- commentだけ全て取得して、そこに紐づいた投稿があれば取得する
-- 該当する投稿がなければは　NULL　になる
-- posts と comments を内部結合したい場合　on紐づけ
-- posts INNER JOIN comments ON posts.id = comments.post_id;
-- 左外部結合　
-- posts LEFT JOIN comments ON posts.id = comments.post_id;
-- 右外部結合
-- posts RIGHT JOIN comments ON posts.id = comments.post_id;
-- posts のほうでレコードが削除されたら、comments のほうでも紐づくレコードが削除されるように設定
-- ON DELETE CASCADE
-- posts のデータが更新されると、紐づくデータも更新されるようになる
-- ON UPDATE CASCADE
-- 自動的に4が入ってくれる
-- （LAST_INSERT_ID(), 'new comment');
-- 縦にくっつけるために
-- UNION ALL
-- もし logs テーブルが存在していたら削除、もしトリガーが存在していたら削除としたい
-- DROP TRIGGER 文
-- DROP TRIGGER IF EXISTS posts_update_trigger;
-- 同じサーバにある外部ファイルを読み込むには、ファイル名を指定
-- LOAD DATA LOCAL INFILE 'data.csv' INTO TABLE posts　どちらのテーブルに流し込むか、
--   FIELDS TERMINATED BY ','　項目の区切りがカンマ
--   LINES TERMINATED BY '\n'行の区切りも指定してあげる
--   IGNORE 1 LINES　データをどのフィールドに挿入するかを最後に指定
-- あとから付け外しすることが多いの
-- インデックスを追加する
-- 　ALTER TABLE posts ADD INDEX index_area(area);
-- インデックスを外す
-- ALTER TABLE posts DROP INDEX index_area;

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
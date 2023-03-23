# MySQL-Lesson
23卒エンジニア内定者研修 菅生

# MySQL入門
## データベース用語
* 表：table
* 行：record
* 列：column

## 基礎知識
命令の区切りは、セミコロンで区切る。
基本的にSQLが用意している命令は、大文字で記述する。
SQL言語などはクエリと呼ばれる。

## コマンド

### テーブルの作成
``` 
CREATE TABLE hoges(
    hoge VARCHAR(140), 
    hoge INT
); 
```
テーブル名は複数形になることが多い。
()の中は、定義したいカラムを書く。カラムはデータ型を指定する必要がある。
### テーブル構造の確認
`DESC hoges;`

### テーブル一覧の確認
`SHOW TABLES;`

### テーブルの削除
`DROP TABLE hoges;`

hogesが存在する時だけ削除

`DROP TABLE IF EXISTS hoges;`

### レコードの挿入
```
INSERT INTO hoges (
    hoge,
    hoge
)
VALUES(
    'hogehoge',
    hoge
)
```

### レコードの確認
`SELECT * FROM hoges;`

### コメントの書き方
三種類ある。
```
--
#
/*  */
```

## データ型
### 整数
|データ型|範囲|
|---|---|
|TINYINT|-128 〜 +127|
|INT|-21億 〜 +21億|
|BIGINT|-922京 〜 922京|
|TINYINT UNSIGNED|0 ~ 255|
|INT UNSIGNED|0 ~ 42億|
|BIGINT UNSIGNED|0 ~ 1844京|

### 実数
|データ型|範囲|
|---|---|
|DECIMAL|固定小数点|
|FLOAT|浮動小数点|
|DOUBLE|浮動小数点（高精度）|

### 文字列
|データ型|範囲|
|---|---|
|CHAR|0 ~ 255文字|
|VARCHAR|0 ~ 65535文字|
|TEXT|それ以上|
|ENUM|特定の文字列から１つ|
|SET|特定の文字列から複数|

### 真偽値
|データ型|範囲|
|---|---|
|BOOL|TRUE / FALSE
|TINYINT(1)|1 / 0|

### 日時
|データ型|範囲|
|---|---|
|DATE|日付|
|TIME|時間|
|DATETIME|日時|

## 使い方

### 真偽値 BOOL
TRUE or FALSE, 0 or 1

### 日時 DATETIME
'2020-10-11 18:00:00'
'2020-10-11' 時間を省略すると00:00:00となる。
NOW() 現在の日時を表す。

### NULL
挿入際に、値を入れなければNULLになる。
値を絶対に設定させたい場合は、`hoge データ型 NOT NULL`とすることで、NULLを許可しないようにできる。（エラーで弾く）

エラーで弾くのではなく、デフォルト値を設定することもできる。   
`hoge データ型 DEFAULT 値`

### 値に制限を設ける
`hoge INT CHECK (likes >= 0 AND likes <= 100) 意味：likesは0~100の間  
挿入の際に、100を超える値を設定するとエラーが出る。

### UNIQUE
重複を許さない。  
`hoge データ型 UNIQUE`

### 主キーの設定
大抵の場合はid

`PRIMARY KEY (id)`

`id INT NOT NULL AUTO_INCREMENT`

とすることで自動的に連番になる。

### データの抽出
`SELECT`を使うことによって抽出できる。

条件をつけたい時は、WHEREを使用する。

### 条件を組み合わせる
AND：なおかつ
OR：もしくは

### 文字列の抽出
=：完全一致の場合

%：0文字以上の任意の文字
BINARY大文字小文字を区別したい

_：任意の一文字

%や_を含むものを抽出する際は\を前につける

### NULLのレコードの抽出
IS NULLと書くことで、抽出できる

反転

IS NOT NULLと書く

### 抽出結果の並び替え
ORDER BYを利用する。
大きい順の場合は、DESC。

数を限定する場合は、LIMIT。

最初の何件かをのぞいて抽出したい場合は、OFFSET。１つ目のデータを0として数える。

### 数値の関数
四則演算：+ - * / %

`AS hoge`で名前をつけることができる。

FLOOR()：端数を切り捨てる

CEIL()：端数を切り上げる

ROUND()：四捨五入をする

### 文字列の関数
SUBSTRING()：指定した場所以降

CONCAT()：文字列の連結

LENGTH()：文字列の長さ

CHAR_LENGTH()：日本語の場合

### 日時の関数
YEAR()：年の抽出

MONTH()：月の抽出

DAY()：日の抽出

DATE_FORMAT()：好きなフォーマットで抽出できる。

DATE_ADD()：日付の計算

DATEDIFF()：日付と日付の差分を抽出。

### レコードの更新
UPDATE：データを更新したい時

`UPDATE テーブル名 SET レコード`

UPPER：全て大文字にする関数

### レコードの削除
DELETE：レコードの削除

このとき、AUTO_INCREMENTS新たな番号が振り分けられる。

TRUNCATE TABLE：テーブルを削除して再作成->連番もリセットされる。

### 作成、更新日時を自動で設定
DEFAULT NOW()

DEFAULT NOW ON UPDATE NOW()

### テーブルの設計を変更
`ALTER TABLE hoge ADD foge`
追加

`ALTER TABLE hoge DROP foge`
削除

`ALTER TABLE hoge CHANGE foge`
変更

`ALTER TABLE hoge RENAME foge`
テーブル名の変更
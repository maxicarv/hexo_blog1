---
title: Hexoで記事ごとにコメント欄を設置する（Landscape編）
set_disqus: true
categories:
  - Web
tags:
  - Hexo
  - disqus
  - node.js
  - EJS
date: 2018-01-27 10:34:48
---
Disqusを使って、Hexoで記事ごとにコメント欄を設置する方法。
テーマにLandscapeを使っていることにご留意をば。
  
<br>

# 内容
1. disqusを設置する
1. テンプレートファイル（EJS）に処理を記述する
1. 記事ごとにコメント欄の有無を設定する  

<br>

## 前提
- Disqusのアカウント登録は[ググれば](https://www.google.co.jp/search?num=50&lr=lang_ja&hl=ja&tbs=lr%3Alang_1ja&ei=uOBrWvv0M8PI0ATgzY6ACw&q=disqus+%E7%99%BB%E9%8C%B2&oq=disqus+%E7%99%BB%E9%8C%B2&gs_l=psy-ab.3..0i30k1l2.11264.16534.0.16818.26.20.0.0.0.0.189.1716.4j11.16.0..2..0...1c.1j4.64.psy-ab..11.15.1723.6..0j0i8i30k1j35i39k1j0i67k1j0i4k1j0i131k1j0i4i10k1j0i203k1j0i4i30k1j0i8i4i30k1.86.n4Fi_ch-ZTM)いくらでも出てくるので省略
- 以下に出てくるコマンドやパスの指定は、`hexo init`で作成したディレクトリがカレントになっていることが前提
  
<br>

# Disqusを設置する
LandScapeにはDisqusを設置する前提となる処理が既に入っている。ゆえに、Disqusの設置自体はコマンド１つで終了。

<pre class=“prettyprint linenums:0”>
hexo config disqus_shortname [DisqusのShortname]
</pre>

`Shortname`はDisqus登録時に指定する`Website Name`とは違うことに注意。
（私はWebsite Name`がそのままShortnameになったと勘違いしていて、Shortnameでは'_'が'-'に変わっていたことに気づかず、15分くらい無駄にしました。。。）
  
<br>

# テンプレートファイル（EJS）に処理を記述する
テンプレートファイル内でページごとに参照できる変数`page`に任意の名称のメンバ変数（ここでは`set_disqus`）を追加する。具体的には「変数`page.set_disqus`がtrueであればコメント欄を表示する」分岐処理を`after-footer.ejs`に追加。
 
**変更前**（themes/landscape/layout/_partial/after-footer.ejs）

```html
<% if (config.disqus_shortname){ %  
  <script>
    var disqus_shortname = '<%= config.disqus_shortname %>';
<!--以下省略-->
```

**変更後**（themes/landscape/layout/_partial/after-footer.ejs:1）

```html
<% if (config.disqus_shortname` && page.set_disqus`){ %>
  <script>
    var disqus_shortname = '<%= config.disqus_shortname %>';
<!--以下省略-->
```

<br>

# 記事ごとにコメント欄の有無を設定する
上述の`page.setdisqus`は投稿する記事のヘッダ部分で`set_disqus: true`とすることにより真の判定となるので、投稿時に変数をヘッダに記述する

まずは投稿のひな形を作成。
<pre class=“prettyprint linenums:0”>
hexo new 'comment'
</pre>

作成したひな形`sourse/_post/comment.md`を編集、`set_disqus: true`を追加する。
```html
---
title: Hexoで記事ごとにコメント欄を設置する（Landscape編）
set_disqus: true
date: 2018-01-27 10:34:48/
---
ここに記事を書く
```

記事を書いて`deloy -g`すれば、記事フッターにDesqusのコメント欄が表示される。

<br>
私の場合、hexo new のひな形`scaffolds/post.md`に`set_disqus: false`を以下のように記述している。

```html
---
title: {{ title }}
date: {{ date }}
set_disqus: false
---
```

`hexo new`して記事を編集する際、すでに記述されている`set_disqus: false`のfalseをtrueに変更することでコメント欄が設置されるようになる。

HexoでテーマにLandscapeを選択したときのdisqusの設置方法について、なぜかまともな日本語情報がなかったので、備忘録として。

<br>
<hr />

## 参考
[Hexoで記事ごとにコンテンツ（フッターや広告など）の表示有無を切り替えたい](https://yoshinorin.net/2017/10/12/hexo-changeable-content/)
---
title: Nuxt.jsでMaterial Components for the Webのチュートリアルを試す（準備編）
set_disqus: true
categories:
  - Web
tags:
  - Nuxt.js
  - MDC-Web
  - Vue.js
  - 静的HTML
date: 2018-06-20 01:42:30
---
＜＜追記＞＞この企画は諸々の理由（実現困難など）により休止しました。Nuxt.jsでマテリアルデザインするなら[Vuetify.js](https://vuetifyjs.com)などの利用をご検討することが吉かと。

[Nuxt.js](https://ja.nuxtjs.org/)といえばSPAでSSRといったイメージが強かろうと思うが、静的HTMLでホームページ等を構築するためのフレームワークとしてもかなり良さげというのが個人的な印象である。（Vue.js含む）Nuxt.jsは公式サイトをはじめ日本語の情報も多く、現在も増加傾向にあるようだ。しかし、Web開発一般についてある程度の知見を有している人が想定ユーザのため、Web開発の経験が希薄な私のような者には若干学習ハードルが高いように見受けられる。そこで、比較的学習ハードルが低い内容でNuxt.jsを使ってみようと思い立ち、Googleが提供するCSSフレームワーク「[Material Conponents for the Web](https://material.io/develop/web/)」（MDC-Web）のチュートリアルをNuxt.jsで実装してみることにした。Nuxt.jsで静的HTMLを構築するための初歩的なステップとして参考になれば幸い。

# はじめに
## 前提となる最低限の知見
- HTML、CSS、JavaScriptについてある程度知っており、静的なHTML文書であれば何とか自力で作成できる。
- Vue.js及びNuxt.jsの公式ガイド等に目を通し、ある程度の実装方法を理解している。少なくともNuxt.jsのスターターテンプレートにあるPages/index.vueの内容が全くわからないようではダメ

## 動作環境
筆者はWindows10上のUbuntuを使用しており、それを基に記事を書いている。

## 今回の目標
Nuxt.jsを導入し、CDN経由でMDC-Webが動作することを確認する。具体的には、Nuxt.jsのスターターテンプレートで使われているボタンをMDC-WebのButtonに置き換える。

# Nuxt.jsの導入
## Nuxt.jsのインストール（スターターテンプレート）
インストールについては[公式サイト](https://ja.nuxtjs.org/guide/installation#nuxt-js-%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%9F%E3%82%B9%E3%82%BF%E3%83%BC%E3%82%BF%E3%83%BC%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88)を参照のこと。

## 生成した静的HTMLを表示するためのサーバ設定
Nuxt.jsでのSPA構築において、MDC-Webを使用する場合は[vue-mdc-adapter](https://github.com/stasson/vue-mdc-adapter)などのコンテナを利用することが推奨されている。実際にMDC-WebのCDNを設定して`npm run dev`で動作確認してみたが、ちゃんと動かなかった。しかし今回は静的HTMLの構築を前提としているので、MDC-WebのCDNを設定し、生成した静的HTMLをWebサーバで動作させることにする。Webサーバの設定は適宜実施すればよいが、ここではPHPの簡易Webサーバ（？）を利用し、`npm run server`コマンドで生成した静的HTMLをブラウザで表示するように設定する。具体的には、スターターテンプレートのインストールディレクトリにある`package.json`の`"scripts"`に以下を追加する。
{% codeblock package.json lang:javascript %}
"server": "php -S localhost:8000 -t dist/"
{% endcodeblock %}

## スターターテンプレートの動作確認
以下のようにコマンドを実行し、スターターテンプレートが正常動作することを確認する。
```
npm run generate
npm run server
```

ブラウザで`localhost:8000`にアクセスすると以下のよう表示が確認できる。
![Nuxt.jsのスターターテンプレート](/img/nuxt_starter_template.png "Nuxt.jsのスターターテンプレート")

# MDC-Webの導入
## CDNの指定
MDC-WebのCDN指定について、今回は静的HTMLのheadタグ内に記述することにする。ページのheadタグはnuxt.config.jsに記述する。具体的には、CSSは`head:{link:}`配列に以下を追加する。
{% codeblock nuxt.config.js lang:javascript %}
{ rel: 'stylesheet', href: 'https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css'}
{% endcodeblock %}

Javascriptは`head:`に以下を追加する。
{% codeblock nuxt.config.js lang:javascript %}
script: [
  { src: 'https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js'}
]
{% endcodeblock %}

## ボタンの置き換え
スターターテンプレートに表示されている２つのボタンをMDC-WebのButtonに置き換える。具体的には、`pages/index.vue`の`button--green`を`mdc-button--outlined`に置き換える。該当箇所が２つあることに注意。

## 動作確認
スターターテンプレートの動作確認と同様に、以下のようにコマンドを実行し、正常動作することを確認する。
```
npm run generate
npm run server
```

ブラウザで`localhost:8000`にアクセスし、ボタンが変わっていることを確認する。
![ボタンのデザインが変わっている](/img/nuxt_starter_MDCButton.png "ボタンのデザインが変わっている")

見栄えが悪いが、見やすさ重視で一目すればボタンのデザインが変わっていることが分かるかと。

## 今後
以上で準備完了。この状態から実際にMDC-Webのチュートリアルを実装していく。
次回、[Web 101: Material basics](https://codelabs.developers.google.com/codelabs/mdc-101-web)を実装していく予定。

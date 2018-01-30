---
title: Chart.jsでHexoの記事に複合グラフを描画する
set_disqus: false
categories:
  - Web
tags:
  - Hexo
  - node.js
  - JavaScript
  - グラフ
  - Chart.js
date: 2018-01-29 04:26:45
---
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.min.js"></script>

[Chart.js 2.0](http://www.chartjs.org/)を使ってHexoの記事に棒グラフと折れ線グラフからなる複合グラフ（複合チャート）を描画する。

[Chart.js 2.0](http://www.chartjs.org/)は、Web上にチャートを描画するためのJavaScriptライブラリ。類似のライブラリがほかにも多数あるが、いくつかの紹介記事を読んだ中で、複合チャートを描画できるものとしてはもっともシンプルで簡単に使えそうだったので選択した。比較検討しているわけではないので、これがHexoにおけるベストソリューションであるかどうかは不明、ということはご了承願いたい。

また、[Chart.js 2.0](http://www.chartjs.org/)の紹介や使い方は[ググれば](https://www.google.co.jp/search?hl=ja&q=chart.js+2.0&lr=lang_ja)多数出てくるので、そちらを参照されたい。ここではHexoでの利用について言及する。
<br>
# HexoにおけるChart.jsの書き方
記事（[タイトル名.md]）にChart.jsのJavaScriptを書くだけ。Markdownは素のHTMLを書くことができるので当然と言えば当然だが。

では、サンプル。
```html
<!--Cahrt.jsのCDNへのソース-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.min.js"></script>

こんにちは。チャートのサンプルです。
<!--グラフを表示する箇所にcanvasタグを書く-->
<div class="container" style="width:80%">  <!--divで囲っている理由は後述-->
  <canvas id="MultipulChart"></canvas>
</div>
チャートのサンプルでした。

<!--グラフの描画スクリプト('id:MultipulChart'で紐づけ)-->
<script>
var ctx = document.getElementById("MultipulChart");
var ChartDemo = new Chart(ctx, {
    type: 'bar',　　//ベースとなるグラフの種類（棒グラフ）
    data: {
        labels: ["1月", "2月", "3月", "4月", "5月", "6月", "7月"],
        datasets: [
        　{
            label: "データ0",
            backgroundColor: "#de9610",
            borderColor: "#de9610",
            data: [30, 70, 55, 66, 65, 78, 46],
            type: 'line',  //ベースのグラフと別種類のグラフ（棒グラフ）
            fill: false,
        　},
        　{
            label: "データ１",
            backgroundColor: "#65ace4",
            data: [22, 30, 15, 9, 5, 5, 4],
            stacked: true
        　},
        　{
            label: "データ2",
            data: [30, 70, 55, 66, 65, 78, 46],
        　},
    　]
    },
    options: {
      scales: {
        xAxes: [{
          stacked: true
        }],
        yAxes: [{
          stacked: true
        }]
      }
    }
});
</script>
```

実際に表示されるグラフがこれ。
--------ここから
こんにちは。チャートのサンプルです。
<div class="container" style="width:80%">
  <canvas id="MultipulChart"></canvas>
</div>
チャートのサンプルでした。
--------ここまで

# 注意点
- 描画はデータの登録順と逆に行われる。ここでは`データ0`が最前面となる。折れ線グラフは必然的にデータを先に書くことになるだろう
- 棒グラフと折れ線グラフを表示する場合、ベースのタイプを`bar`、折れ線グラフのデータの`dataset`に`line`指定しないと正常に描画されない。こんなの不具合じゃん、と思うが、以前のバージョン(2.4.0)でも現バージョン(2.7.1)でも同じ現象が発生し、修正されていないようなので、積極的に直す気がないのだろう。。。

#### divタグを入れた理由
グラフを見ていただくと、環境によってはdivタグを入れている理由が想像できるかもしれない。PCのブラウザで表示した場合、canvasを指定するだけではグラフが大きすぎてしまう。[本家のサンプル](http://www.chartjs.org/docs/latest/)には`<canvas id="myChart" width="400" height="400"></canvas>`などと書いてあるが、`width`や`height`は思うように反映されない。どうやら、[レスポンシブだとサイズがうまく反映されない](http://obel.hatenablog.jp/entry/20160626/1466937585)ようだが。なので、ここではdivタグを入れてお茶を濁しておく（このブログでは、この運用でいいかなあ、などと思っている。面倒なので他のライブラリを試してみる気も起きない(笑)）

というわけで、いくつか問題も散見されるが、すっきりとした見た目でいろいろとカスタマイズもできるので、Hexoで使っていく分には悪くない選択肢だ、と信じたい。。。
<br>
<hr />
## 参考
- [Chart.js](http://www.chartjs.org/)
- [chart.js で複数軸の複合グラフを描く](https://qiita.com/kd9951/items/aece80abe0bd42b3b5d3)
- [Chart.js でレスポンシブ指定をするとサイズが自由に変更できなくなる](http://obel.hatenablog.jp/entry/20160626/1466937585)
- [【Chart.jsを使いこなす】棒グラフをExcel風の配色で表示する](http://chichibulog.com/engineering/use-chartjs1)

<script>
var ctx = document.getElementById("MultipulChart");
var ChartDemo = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["1月", "2月", "3月", "4月", "5月", "6月", "7月"],
        datasets: [
        　{
            label: "データ0",
            backgroundColor: "#de9610",
            borderColor: "#de9610",
            data: [30, 70, 55, 66, 65, 78, 46],
            type: 'line',
            fill: false,
        　},
        　{
            label: "データ１",
            backgroundColor: "#65ace4",
            data: [22, 30, 15, 9, 5, 5, 4],
            stacked: true
        　},
        　{
            label: "データ2",
            data: [30, 70, 55, 66, 65, 78, 46],
        　},
    　]
    },
    options: {
      scales: {
        xAxes: [{
          stacked: true
        }],
        yAxes: [{
          stacked: true
        }]
      }
    }
});
</script>

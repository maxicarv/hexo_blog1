---
title: WSLにWidnows10のフォントを読み込ませたらWidnows側に不具合が出た
set_disqus: false
categories:
  - PC
tags:
  - WSL
  - 日本語環境
date: 2018-11-18 14:13:22
---
VSCodeで開発環境用とテキスト編集（主にマークダウンの編集）で設定を別々に持ちたいと考えたのだけれど、ちょろっと調べるくらいではうまい解決方法が出てこなかったので、いっそのことWSL側のVSCodeは開発用、Windows側はテキスト用、とすることにした。

で、WSL（Ubuntu16.04）側の日本語環境を[ここ](https://qiita.com/dozo/items/97ac6c80f4cd13b84558)を参考にして構築。で、確かにVSCodeで日本語の編集が可能になった。が、Widnwos側のフォントが。。。
![](/img/2018-11-18 13.48.10.jpg "One of Facebook on Chrome")
画像では分かりにくいが、例えば'Facebook'の文字がイタリックになっていたりする。通常このようなフォントの設定はしていないし、VcXsrv上でWSLのVSCodeを立ち上げてから日本語環境を動かす（正確にはどのタイミングかわからないが）とWidnows側のフォント表示に影響が出る。

元記事におけるフォントのインストールは
```
$ sudo apt -y install fontconfig
$ sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/windows
$ sudo fc-cache -fv
```
という風にWindows側にシンボリックリンクを張っている。まあ、分かっていて採用したからアレだけど、やはりキモチワルイので、Ubunto側にnotoフォントをインストールしてやることにした。
```
$ sudo apt-get install fonts-noto-cjk fonts-noto-hinted
$ sudo fc-cache -fv
```
ということで、無事にWidnwos側に影響なくVSCode on WSLで日本語の編集が可能になった。


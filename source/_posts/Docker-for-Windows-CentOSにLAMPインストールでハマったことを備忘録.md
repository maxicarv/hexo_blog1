---
title: Docker for Windows + CentOSにLAMPインストールでハマったことを備忘録
set_disqus: false
categories:
  - null
tags:
  - null
  - null
date: 2019-01-16 10:41:31
---
参照リンクのまとめみたいなものだが、個人的に再度必要になりそうな予感がするので備忘録。

## setenforceコマンドが実行できない
SELinuxをdisableするときのアレ。
```
# setenforce 0
setenforce: command not found
```
### 対策
```libselinux-utils```というパッケージをインストールする
```
# yum install libselinux-utils
```
Ubuntuならselinux-utilsらしい、蛇足だが。

## systemctlを実行できない
例えば、
```$  docker run  -it  --name mycentos centos  /bin/bash```
としてhttpdをインストール、起動すると以下のようになる。
```
# yum install -y httpd
# systemctl start httpd
Failed to  get  D-Bus connection:  Operation not  permitted
```
### 回避策
以下のように起動する。
```
# docker run -d --privileged --name mycentos centos /sbin/init
# docker exec -it mycentos /bin/bash
```
何となく対処療法っぽくてキモチワルイですが。

## mysqldが動かない
これは上記systemctlの対応以後に出たっぽいもの
```
# service mysqld restart
Starting mysqld (via systemctl): Job for mysqld.service failed because the control process exited with error code. See "systemctl status mysqld.service" and "journalctl -xe" for details.
```
＃エラーメッセージは参考リンクのものを引用。少し違ってた気がする。/etc/sysconfig/networkがnot foundだ、というメッセージが出ていたと記憶。

### 対策
```/etc/sysconfig/network```を作成する
```
touch /etc/sysconfig/network
```

※参考リンク
[DockerでCentOS7起動時にsystemctlが動かないとき](https://www.tcmobile.jp/dev_blog/devtool/docker%E3%81%A7centos7%E8%B5%B7%E5%8B%95%E6%99%82%E3%81%AEsystemctl%E3%81%8C%E5%8B%95%E3%81%8B%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D/)
[setenforce: command not found](http://pkgs.loginroot.com/errors/notFound/setenforce)
[CentOS7 + MySQLでエラー](http://dage.jp/post/centos7-mysql%E3%81%A7%E3%82%A8%E3%83%A9%E3%83%BC/)


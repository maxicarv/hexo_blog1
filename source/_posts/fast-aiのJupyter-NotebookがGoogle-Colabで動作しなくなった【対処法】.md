---
title: fast.aiのJupyter NotebookがGoogle Colabで動作しなくなった【対処法】
set_disqus: false
categories:
  - AI
tags:
  - fast.ai
  - AI
  - ディープラーニング
  - google colab
date: 2018-10-18 23:29:37
---
諸事情あって中断していたディープラーニングの勉強を再開しようと、[fast.ai](http://www.fast.ai/)のLesson1を復習しようと試みた。で、講義で使用するJupyter NotebookをGoogle Colab上で実行してみると、見たことがないエラー。
```
ImportError: cannot import name 'as_tensor'
```
どうやらfast.aiのライブラリのバージョンが1.0になったことの影響のようだ。公式フォーラムを見ると、fast.aiをpipでインストールするところでバージョンを指定してやればよいとのことで、
```
fastai==0.7.0
```
として再度実行。が、今度は
```
AttributeError: module ‘torch’ has no attribute ‘float32’
```
とな。再度公式フォーラムを見ると同様の現象が発生している模様。数日間塩漬けにして確認してみると対応方法が掲載されていた。
```
!pip3 install fastai==0.7.0 torchtext==0.2.3
```
torchtextのバージョンも指定してやる必要があるようだ。

ちなみに、私が以前使っていた時はOut of memoryが頻発して受講には使いにくかったのだが、現状で4回ほど3行コードを実行したが、一度もメモリ不足には陥っていない（GPU指定）。

※参考
<https://forums.fast.ai/t/google-colab-attributeerror-module-torch-has-no-attribute-float32/25327>
<https://forums.fast.ai/t/fastai-v0-7-install-issues-thread/24652>
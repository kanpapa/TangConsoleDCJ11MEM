# Paper Tape BASIC
- PmodのSDメモリを使ってPaper TapeBASICが起動できます．
  - Tang ConsoleのSDスロットではなく、PmodにSDメモリインターフェースを接続して使用します。
- SDメモリの先頭から0〜1GBを読み込み用，1GB〜2GBを書き込み用にしたので，SAVEコマンドも動かそうと思えば動かせます．(が、最新版のtop.vではSAVE後にSW2でバッファをフラッシュの機能が外されてるかもしれないので修正が必要です。)

## 使用方法

- [Paper Tape Archive](https://www.vaxhaven.com/Paper_Tape_Archive)から
absolute loader('ABSOLUTE-BINARY-LOADER.ptap')と，Paper Tape BASIC ('DEC-11-AJPB-PB.ptap')を入手し，sdメモリに書き込みます．(頭の000があると読めないようで，先頭の16byteを削除しました．)
- /dev/xxx は生のsdメモリの場所です．(先頭のブロックから書くので数字が付いてないやつ．'fdisk -l'等で調べて下さい．)
- 間違えるとパソコンの他のファイルシステムを破壊するので厳重に注意して行って下さい．

```
cat ABSOLUTE-BINARY-LOADER.ptap DEC-11-AJPB-PB.ptap | dd of=tapeimage.dat bs=1 skip=16
dd if=tapeimage.dat of=/dev/xxx
```
- PmodのSDメモリカードに入れて電源を入れ，ODT consoleから下記のように
してBASICが起動できます．


```
@157744g  ← bootstrap loaderを起動してabsolute loaderを読み込む
157500
@157500g  ← absolute loaderを起動してBASICを読み込む
PDP-11 BASIC, VERSION 007A
*O ?
DO YOU NEED THE EXTENDED FUNCTIONS?Y
HIGH-SPEED READER/PUNCH?N
SET UP THE EXTERNAL FUNCTION?N
MEMORY?56
READY
10 PRINT "HELLO WORLD"
LIST

10 PRINT "HELLO WORLD"
READY
RUN
HELLO WORLD

STOP AT LINE   10
READY
```

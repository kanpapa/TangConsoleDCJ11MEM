# UNIX V6

## お手軽な起動方法
- [diskimage/](../diskimage/)にあるsd-unix-v6.dskをSDメモリにddでを書き込み，TangConsoleのスロットにセットします．
- 773010gでブートローダーを起動するとすぐにプロンプト'@'が出るので，'unix'と入力します．
- loginプロンプトが出るのでrootでログインします．
```
@773010g@unix
mem = 1026
RESTRICTED RIGHTS

Use, duplication or disclosure is subject to
restrictions stated in Contract with Western
Electric Company, Inc.

login: root
# who
root    tty8 Oct 10 14:28
# date
Fri Oct 10 14:28:42 EDT 1975
```

## ディストリビューションテープからのインストール
- [https://www.tuhs.org/Archive/Distributions/Research/Ken_Wellsch_v6/](https://www.tuhs.org/Archive/Distributions/Research/Ken_Wellsch_v6/)にある v6.tape.gz をgunzipしてsdメモリに書き込み，PmodのSDメモリに搭載します．
```
gunzip v6.tape.gz
sudo dd if=v6.tape of=/dev/xxx
```
- Tang Consoleには空のSDメモリ(HDD用)を搭載します．
- https://www.tuhs.org/Archive/Distributions/Research/Documentation/v6_setup.html の手順に従ってインストールします．
- rom.vにより，100000番地以降にテープ用のブートローダーが書かれているのでODTで100000gで0番地に読み込まれます．これを0gで実行します．
```
?
@100000g
100014
@0g=tmrk
disk offset
0
tape offset
100
count
1
=tmrk
disk offset
1
tape offset
101
count
3999
=
137274
@773010g@rkunix
mem = 1035
RESTRICTED RIGHTS

Use, duplication or disclosure is subject to
restrictions stated in Contract with Western
Electric Company, Inc.

login: root
# chdir /usr/sys/conf
# ls
data.s
l.s
m40.s
m45.s
mkconf.c
sysfix
sysfix.c
# cc mkconf.c
# mv a.out mkconf
# ./mkconf
rk
rp
tm
done
# as m40.s
# mv a.out m40.o
# cc -c c.c
# as l.s
# ld -x a.out m40.o c.o ../lib1 ../lib2
# rm /unix
# mv a.out /unix
# 
# /etc/mknod /dev/rk0 b 0 0
# /etc/mknod /dev/rk1 b 0 1
# /etc/mknod /dev/rk2 b 0 2
# /etc/mknod /dev/rp0 b 1 0
# /etc/mknod /dev/mt0 b 3 0
# /etc/mknod /dev/rrk0 c 9 0
# /etc/mknod /dev/rrk1 c 9 1
# /etc/mknod /dev/rrk2 c 9 2
# /etc/mknod /dev/rrp0 c 11 0
# /etc/mknod /dev/rmt0 c 12 0
# sync
# sync
# sync
# 
002502
****リコンフィグボタンでリセット***
@773010g@unix
mem = 1035
RESTRICTED RIGHTS

Use, duplication or disclosure is subject to
restrictions stated in Contract with Western
Electric Company, Inc.

login: root
# dd if=/dev/mt0 of=/dev/rk1 count=4000 skip=4100
4000+0 records in
4000+0 records out
# dd if=/dev/mt0 of=/dev/rk2 count=4000 skip=8100
4000+0 records in
4000+0 records out
# mkdir /usr/doc
# cat >> /etc/rc
/etc/mount /dev/rk1 /usr/source
/etc/mount /dev/rk2 /usr/doc
# sync
# sync
# sync
# sync
# 
002506
@773010g@
000002
@
000002
@773010g@unix
mem = 1035
RESTRICTED RIGHTS

Use, duplication or disclosure is subject to
restrictions stated in Contract with Western
Electric Company, Inc.

login: root
# /etc/mkfs /dev/rp0 40600
isize = 489
free list 4/10
# mkdir /home
# cat >> /etc/rc
/etc/mount /dev/rp0 /home
# icheck /dev/rrp0
/dev/rrp0:
spcl       0
files      0
large      0
direc      1
indir      0
used       1
free   40108
# dcheck /dev/rrp0
/dev/rrp0:
# /etc/mount /dev/rp0 /home
# df /home
/home read error 1
count = 0; errno = 0
# ls /home
# df /dev/rp0
/dev/rp0 40108
# /etc/mount
rk1 on /usr/source
rk2 on /usr/doc
rp0 on /home
# ls /usr/source
as
c
cref
fort
iolib
m6
mdec
rat
run
s1
s2
s3
s4
s5
s7
salloc
sno
tmg
yacc
# ls -l /usr/source
total 36
drwxrwxr-x  2 bin       368 Jul 18 08:59 as
drwxrwxr-x  2 bin       928 Jul 18 09:04 c
drwxrwxr-x  5 bin       128 May 13 20:37 cref
drwxrwxr-x 11 bin       288 Jul 18 09:12 fort
drwxrwxr-x  2 bin      1248 Jul 18 09:16 iolib
drwxrwxr-x  2 bin       320 Jul 18 09:30 m6
drwxrwxr-x  2 bin       464 Jul 18 11:26 mdec
drwxrwxr-x  2 bin       256 Jul 18 09:32 rat
-rw-rw-r--  1 bin       753 May 18 13:50 run
drwxrwxr-x  2 bin      1696 Jul 18 11:33 s1
drwxrwxr-x  2 bin      1280 Jul 18 09:59 s2
drwxrwxr-x  2 bin       816 Jul 18 09:59 s3
drwxrwxr-x  2 bin      2544 Jul 18 10:01 s4
drwxrwxr-x  2 bin      1264 Jul 18 10:03 s5
drwxrwxr-x  2 bin       800 Jul 18 10:06 s7
drwxrwxr-x  2 bin       384 Jul 18 10:06 salloc
drwxrwxr-x  2 bin       224 Jul 18 10:07 sno
drwxrwxr-x  3 bin       176 Jul 18 10:09 tmg
drwxrwxr-x  4 bin        80 May 13 20:37 yacc
# ls -l /usr/doc
total 15
drwxrwxr-x  2 bin        48 Jun 26 20:05 as
drwxrwxr-x  2 bin        80 Jun 26 20:05 bc
drwxrwxr-x  2 bin       176 Jun 26 20:05 beg
drwxrwxr-x  2 bin       240 Jun 26 20:05 c
drwxrwxr-x  2 bin       464 Jun 26 20:05 ctut
drwxrwxr-x  2 bin       176 Jun 26 20:05 ed
drwxrwxr-x  2 bin       144 Jun 26 20:05 hel
drwxrwxr-x  2 bin        48 Jun 26 20:05 iolib
drwxrwxr-x  2 bin        48 Jun 26 20:05 iosys
drwxrwxr-x 11 bin       192 Jun 26 20:37 man
drwxrwxr-x  2 bin        48 Jun 26 20:05 rat
drwxrwxr-x  2 bin        64 Jun 26 20:05 secur
drwxrwxr-x  2 bin        96 Jul 17 12:28 start
drwxrwxr-x  2 bin       192 Jun 26 20:05 unix
drwxrwxr-x  2 bin       288 Jun 26 20:05 yacc
# sync
# sync
# sync
# 
```

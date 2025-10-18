## SDメモリ
- Tang Console本体のSDメモリスロットはHDDエミュレータ用です。
- PmodのSDカードインターフェース(ピン配置はDigilent仕様)のSDメモリは紙テープエミュレータと磁気テープエミュレータ用です。

## メモリイメージの構成
基本的にはtop.vのコメントに書いてあります．最新情報はソースを確認して下さい．
### ハードディスク
```
//---------------------------------------------------------------------------
// RF11 (drum), RK11 (disk), RP11 (with RP03 disk pack) controllers
// and TM11 (magtape)
// RF:  1024 block                             ( 512KB x 1)
// RK:  6144 block (=256cyl *  2sur *12sect)
//     (4872 block)(=203cyl *  2sur *12sect) (2.4 MB x 8)
// RP: 84000 block (=420cyl * 20tra *10sect)
//     (81200-83000 block) (=406-416cyl * 20tra *10sect) (40MB x 4)
// RP03's cylinder is 406, but 2.9BSD says 416.
//
// 1 block = 256word = 512B = 01000B
// SD memory block
//        0-  1023: RF  (00000000)
//     1024-  7167: RK0 (00002000)
//     7168- 13311: RK1 (00016000)
//    13312- 19455: RK2 (00032000)
//    19456- 25599: RK3 (00046000)
//    25600- 31742: RK4 (00062000)
//    31744- 37887: RK5 (00076000)
//    37888- 44031: RK6 (00112000)
//    44032- 50175: RK7 (00126000)
//    50176-134175: RP0 (00142000)
//   134176-218175: RP1 (00406040)
//   218176-302175: RP2 (00652100)
//   302176-386175: RP3 (01116140)
//
// # sample for making a sd image from unix disk drive images
// dd if=rf0 of=sd.dsk bs=512
// (if no rf0 file,  dd if=/dev/zero of=sd.dsk bs=512 count=1024)
// dd if=rk0 of=sd.dsk seek=1024  conv=notrunc
// dd if=rk1 of=sd.dsk seek=7168  conv=notrunc
// dd if=rk2 of=sd.dsk seek=13312 conv=notrunc
// dd if=rk3 of=sd.dsk seek=19456 conv=notrunc
// ...
// dd if=rp0 of=sd.dsk seek=50176 conv=notrunc
// ...
//---------------------------------------------------------------------------

### 磁気テープ
//--------------------------------------------------------------------------
// TM11
// maximum file block = 65536 block = 32MB
//      0-  65535: file0 (00000000)
//  65536- 131071: file1 (00200000)
// 131072- 196607: file2 (00400000)
// 196608- 262143: file3 (00600000)
// 262144- 327679: file4 (01000000)
// 327680- 393215: file5 (01200000)
// 393216- 458751: file6 (01400000)
// 458752- 524287: file7 (01600000)
// ...
// 983040-1048575: file15 (03600000)
//
// # sample for making a sd image from unix disk drive images
// dd if=file0 of=sdtape.dsk
// dd if=file1 of=sdtape.dsk seek=65536 conv=notrunc
// dd if=file2 of=sdtape.dsk seek=131072 conv=notrunc
// dd if=file3 of=sdtape.dsk seek=196608 conv=notrunc
// dd if=file4 of=sdtape.dsk seek=262144 conv=notrunc
// dd if=file5 of=sdtape.dsk seek=327680 conv=notrunc
// dd if=file6 of=sdtape.dsk seek=393216 conv=notrunc
// dd if=file7 of=sdtape.dsk seek=458752 conv=notrunc
// ...
// -----------------------------------------------------------------------
```
### 紙テープ
- 0〜1GBが読み込み用、1GB〜2GBが書き込み用ですが、書き込み機能はtop.vに修正が必要かも。

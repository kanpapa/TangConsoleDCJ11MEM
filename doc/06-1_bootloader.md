# ブートローダー
- 773xxxのアドレスはBM873-YA restart/loader に準拠しています．
- 100000: TM11/TU10(磁気テープリーダ)
- 157744: 紙テープ用ブートストラップ
- 具体的なコードはrom.vを参照して下さい．

```
//---------------------------------------------------------------
// This ROM contains several boot programs
// - Magnetic Tape boot loader to install unix
// - Unix v1 boot ROM
// - BM873-YA restart/loader
// - Bootstrap Loader for paper tape
//
// Boot program entry addresses
//
// 100 000: TM11
// 157 744: PC11 (load absolute loader)
// 773 000: RF11 (not for unix v1, use 773700)
// 773 010: RK11 (unix v6, RT-11)
// 773 050: TM11
// 773 100: RP11
// 773 312: PC11
// 773 700: Unix V1 (RF)
//---------------------------------------------------------------
```

## スイッチレジスタ
```
//---------------------------------------------------------------
// SWR (Console Switches Register, 777570)
//---------------------------------------------------------------
REG_SWR = 'o173700; // UNIX V1 multi user mode
//REG_SWR = 'o073700; // UNIX V1 single user mode
//REG_SWR = 'o173030; // UNIX V6 single user mode
```
## 2.9BSD用の設定
2.9BSDは起動時にCPUタイプを自動判別しているようなのですが，'70'として判別されるとブートに失敗するので強制的に'40'にして起動しています．
詳細は https://www.tuhs.org/Archive/Distributions/UCB/Documentation/2.9bsd_setup.html を参照して下さい．

- CPUタイプを強制的に設定するためにSWRを使用します．
- Class: PDP11s
  - 40: 23, 34, 34A, 40, 60
  - 45: 45, 55
  - 70: 44, 70
- いちいち書くのは面倒なので，下記にレジスタ値を変更してHALTするプログラムを置きました．
  - 100040: SWR=o'000040
  - 100050: SWR=o'000045
  - 100070: SWR=o'000070
  



# 更新ログ
- 2025/09/12
  - PmodにWS2812アレイを接続してアドレスやデータを表示させてみました．
- 2025/09/22
  - PmodのSDメモリに紙テープエミュレータを実装しました．tape BASICの実行や，unix v1, v6で読めます．
- 2025/09/25
  - RT-11 v4がブートできました．
- 2025/09/26
  - READMEにpmod端子，オンボードSWの説明を追加しました．

- top.vにある更新履歴のコメント
```
//---------------------------------------------------------------------------
// 2025/09/02: - Ported from Tang Nano 20K to Tang Console 138K
//             - Use CLK2 as a system clock
//             - Physical memory space extended from 16bit to 18bit
//
// 2025/09/07: - Some debug tool installed
// 2025/09/11: - WS2812 installed
// 2025/09/17: - Bugfix for using without SD memory
// 2025/09/19: - PC-11(Paper-Tape Reader/Punch) emulator implemented
//             - The punch function is disabled to prevent overwriting
//             - the SD card.
// 2025/09/22: - sw2_toggle and sw2_count installed for debug
// 2025/09/25: - Onboard sw's function changed
// 2025/09/26: - Invoke IRQ_ttyo at 60Hz (dirty workaround to boot RT-11)
// 2025/10/01: - Bugfix for disks
// 2025/10/02: - RP11 controller (with RP03) emulator implemented
// 2025/10/06: - TM11/TU10 magnetic tape emulator implemented
//             - Reset by GP (RESET instruction)  implemented
//             - Boot address changed (see rom.v)
// 2025/10/08: - Disk and magtape bugfix
// 2025/10/12: - SD_MEM_FRQ changed from 400kHz to 800kHz
//             - Make read MTSC1(772440) invoke bus error (for uv7 tape boot)
// 2025/10/13: - TM11: Space forward implemented
// 2025/10/14: - TM11: interrupt on 'write IE and no GO' implemented
// 2025/10/16: - Image size for RP03 changed (for 2.9BSD's sys/conf/ioconf.c)
//             - RT-11 causes MTSC1 buserror, so compile flag
//             - 'USE_RT11V4_WORKAROUND' added.
//             - '60Hz IRQ_ttyo' disabled, 'USE_RT11V4_WORKAROUND' enables it.
//             - Compile flag 'USE_MT_WRITE_PROTECT' to avoid overwrite tape
// 2025/10/17: - SD_MEM_FRQ changed from 800kHz to 1MHz
//---------------------------------------------------------------------------
```
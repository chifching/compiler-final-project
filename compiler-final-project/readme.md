資工四A 107502515 許奇青
---
通過基本題前四個公開測資
---
Linux編譯指令
bison -d -o y.tab.c a.y
gcc -c -g -I.. y.tab.c
flex -o lex.yy.c a.l
gcc -c -g -I.. lex.yy.c
gcc -o a y.tab.o lex.yy.o -ll
---
執行指令
./a < "輸入的側資"
---
實做
1.print-num和print-bool的基本輸出數值和真假值
2.基本的數值運算包括加減乘除取餘數
3.基本的邏輯運算其中有AND OR NOT
4.使用遞迴方法解決數值運算中需要連加和連乘的問題
5.邏輯運算也是通過遞迴方式來實現需要連續多個運算的問題

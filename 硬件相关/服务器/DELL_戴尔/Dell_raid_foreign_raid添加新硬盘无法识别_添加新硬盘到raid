关机、重启、按CTRL+R 进入服务器RAID管理；

1.ctr+p看看是否识别到硬盘，正常应该看到4块硬盘，前3块有dg显示online的，是原来的硬盘，新盘如果没有数据应该显示为foreign；

2.crt+n返回controller,光标移到controller 0上按f2---》foreign---》foreing config----》clear确认；

3.ctr+p看看新加的硬盘是否由foreign显示为Ready,如果是就正常,crt+n返回controller；

4.光标移到controller 0上按f2 ---》Create new vd；

5.raid level选RAID-0，把新要加入raid-0的硬盘用空格选上，然后按tab到ok确认即可；

6.esc退出，会提示你按ctl+alt+delete重启。

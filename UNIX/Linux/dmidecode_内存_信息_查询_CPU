Linux 查看内存的插槽数，已经使用多少插槽。每条内存多大，已使用内存多大
1.dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range
2.Size:2048MB
3.Size:2048MB
4.Size:NoModuleInstalled
5.Size:NoModuleInstalled
6.Size:NoModuleInstalled
7.Size:NoModuleInstalled
8.Size:NoModuleInstalled
9.Size:NoModuleInstalled2.Linux
查看内存支持的最大内存容量
1.dmidecode|grep -P 'Maximum\s+Capacity'
2.MaximumCapacity:64GB3.Linux
查看内存的频率
1.dmidecode|grep -A16 "Memory Device"
2.dmidecode|grep -A16 "Memory Device"|grep 'Speed'
3.Speed:667MHz（1.5ns）
4.Speed:667MHz（1.5ns）
5.Speed:667MHz（1.5ns）
6.Speed:667MHz（1.5ns）
7.Speed:667MHz（1.5ns）
8.Speed:667MHz（1.5ns）
9.Speed:667MHz（1.5ns）
10.Speed:667MHz（1.5ns）



查看CPU 
more /proc/cpuinfo | grep "model name" 
grep "model name" /proc/cpuinfo 
或
grep "model name" /proc/cpuinfo | cut -f2 -d: 

内存 
grep MemTotal /proc/meminfo 
grep MemTotal /proc/meminfo | cut -f2 -d: 
free -m |grep "Mem" | awk '{print $2}' 

Cpu x64 x86
查看CPU位数(32 or 64) 
#getconf LONG_BIT 
#echo $HOSTTYPE 
#uname -a 

查看当前linux的版本 
#more /etc/redhat-release 
 #cat /etc/redhat-release 

查看内核版本 
#uname -r 
#uname -a



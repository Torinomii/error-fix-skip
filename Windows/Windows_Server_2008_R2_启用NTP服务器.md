Server
1、查看服务器信息
w32tm /query /status
 
2、设置同步地址
w32tm /config /manualpeerlist:time.windows.com /syncfromflags:manual /reliable:yes /update
 
3、强制同步
w32tm /resync
 
4、修改注册表
开启NTP服务器（域控默认开启）：
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer内的[Enabled]修改为1。
宣布自身为可靠时间源，外部服务器改为a：HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Config\AnnounceFlags修改为5。
 
5、开启Windows Time服务
net start w32time
 
6、防火墙开启UDP 123端口
netsh firewall add portopening protocol = UDP port =123 name = NTPSERVER
 
Client
1、修改注册表
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClientSpecialPollInterval 　　　　 　　 #值修改为十进制43200，单位秒SpecialPollTimeRemaining  　　 #值修改为服务器IP
 
2、手动同步，可写入开机启动脚本
NET TIME /DOMAIN:域名 /SET /Y　　#需要管理员权限
NET TIME \\IP或主机名
 


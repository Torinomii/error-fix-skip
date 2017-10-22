# 本文档不完整,但可补全网络上的安装教程漏掉的部分设定

groupadd oinstall
groupadd dba
useradd -d /home/oracle -g oinstall -G dba oracle
passwd oracle


mkdir -p /_data/DBSoft/oracle/product/11.2.0/db_1
chown -R oracle:oinstall /_data/DBSoft/oracle
chmod -R 755 /_data/DBSoft/oracle

mkdir -p /_data/DBSoft/oraInventory
chown -R oracle:oinstall /_data/DBSoft/oraInventory
chmod -R 755 /_data/DBSoft/oraInventory

vi /etc/hosts 后输入
把127.0.0.1修改为本机的ip


vi /etc/sysctl.conf 后输入
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
fs.file-max = 6815744
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
fs.aio-max-nr = 1048576
//这里的可以在开始安装Oracle后到下面这里让系统自动生成.(生成后kernel.shmmni /kernel.sem 可能不会自动生成需手动添加)


# 量

vi /etc/security/limits.conf 后输入
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536

Vi /home/oracle/.bash_profile  后输入下面内容(请注意这行的.bash_profile前面有一点)

export ORACLE_BASE=/_data/DBSoft/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1
export PATH=$ORACLE_HOME/bin:$PATH


# 直接在命令行输入
source ~/.bash_profile
# 直接在命令行输入
export LANG=en_US
export LC_ALL=en_US


#用cd进入到光盘d
./runInstall
#进入到图形安装界面(请查看另一封邮件)

su root
vi /etc/oratab
#将末尾的N修改为Y
dbmaster:/_data/DBSoft/oracle/product/11.2.0/db_1:Y
#修改linux自启动文件
vi /etc/rc.d/rc.local
su oracle -lc "/_data/DBSoft/oracle/product/11.2.0/db_1/bin/lsnrctl start"
su oracle -lc "/_data/DBSoft/oracle/product/11.2.0/db_1/bin/dbstart"



参考值
(
//kernel.shmmax
 # 公式:2G*1024*1024*1024=2147483648(字节) 
 # 表示最大共享内存，如果小的话可以按实际情况而定，一般为物理内存的一半

//kernel.shmmni 
 # 内核参数是共享内存段的最大数量 缺省值 4096
//
//kernel.shmall
 # 共享内存页数 
 # 公式:4G*1024*1024/4K = 1048576(页) 
 # getconf PAGESIZE 
 
//kernel.sem=250 32000 100 128 
 # 4个参数依次是SEMMSL：每个用户拥有信号量最大数，SEMMNS：系统信号量最大数，//SEMOPM：每次semopm系统调用操作数，SEMMNI：系统辛苦量集数最大数。这4个参数为固定内容 
 
////fs.file-max 
 #  果too many file opened，就file-max 65536 
 
////net.ipv4.ip_local_port_range=1024 65000 
 # 端口的范围  
 
 
//kernel.sem：设置的信号量，这4个参数内容大小固定。
 
//net.core.rmem_default：接收套接字缓冲区大小的缺省值 
////net.core.rmem_max ：接收套接字缓冲区大小的最大值 
//net.core.wmem_default：发送套接字缓冲区大小的缺省值
//net.core.wmem_max：发送套接字缓冲区大小的最大值 
)

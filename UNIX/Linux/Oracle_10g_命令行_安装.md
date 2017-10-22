#安装例,错误自行搜索引擎.无法保证安装成功例.

在Linux命令行下安装Oracle 10g
 Oracle 10g支持在命令行下用静默模式(Silent)安装，给那些没有安装图形界面的Linux系统提供了极大的便利。
 下面以Fedora Core 6为例，介绍在命令行下安装OracleOracle 10g的方法。
 
 1 安装前的准备
 准备工作要用登录为root用户来进行。
 
 1.1 选择安装环境的语言
 Oracle安装时可以通过环境变量LANG指定安装语言，如果Linux命令行不能显示中文，就要将语言环境设置为英语。
 例如：export LANG=en_US.UTF-8
 
 1.2 修改gennttab
 Oracle 10g在一些Linux系统下安装可能会被中断，在安装日志文件
 $ORACLE_HOME/install/make.log
 里可以看见以下错误信息
 /bin/sed: -e exdivssion #1, char 7: unterminated `s' command
 要解决这个问题就必须编辑文件 gennttab。
 先解压Oracle安装目录下的 stage/Components/oracle.network.rsf/10.2.0.1.0/1/DataFiles/filegroup6.jar，可以用以下方法之一进行解压
 用jar解压：jar -xf filegroup6.jar bin/gennttab
 用unzip解压：unzip filegroup6.jar bin/gennttab
 再用文本编辑器（例如vi）打开解压出来的 gennttab，将以下内容
 LIB=`$ECHO ${TtoLIB} | $SED 's/ /\\
 /g' | $GREP '^${T}:' | $AWK -F: '{print $2}'`
 INI=`$ECHO ${TtoINI} | $SED 's/ /\\
 /g' | $GREP '^${T}:' | $AWK -F: '{print $2}'`
 BAS=`$ECHO ${TtoBAS} | $SED 's/ /\\
 /g' | $GREP '^${T}:' | $AWK -F: '{print $2}'`
 改为
 LIB=`$ECHO ${TtoLIB} | $SED 's/ /\n/g' | $GREP '^${T}:' | $AWK -F:
 '{print $2}'`
 INI=`$ECHO ${TtoINI} | $SED 's/ /\n/g' | $GREP '^${T}:' | $AWK -F:
 '{print $2}'`
 BAS=`$ECHO ${TtoBAS} | $SED 's/ /\n/g' | $GREP '^${T}:' | $AWK -F:
 '{print $2}'`
 保存后再用将gennttab更新到filegroup6.jar里面，可以用以下方法之一进行更新
 用jar更新：jar -uvf filegroup6.jar bin/gennttab
 用zip更新：zip -vu filegroup6.jar bin/gennttab
 
 1.3 修改内核参数
 编辑文件 /etc/sysctl.conf，修改以下项目，如果没有可以自己添加。
 kernel.shmall = 2097152 # 可以使用的共享内存的总量。
 kernel.shmmax = 2147483648 # 最大共享内存段大小。
 kernel.shmmni = 4096 # 整个系统共享内存段的最大数目。
 kernel.sem = 250 32000 100 128 # 每个信号对象集的最大信号对象数；系统范围内最大信号对象数；每个信号对象支持的最大操作数；系统范围内最大信号对象集数。
 fs.file-max = 65536 # 系统中所允许的文件句柄最大数目。
 net.ipv4.ip_local_port_range = 1024 65000 # 应用程序可使用的IPv4端口范围。
 net.core.rmem_default = 1048576 # 套接字接收缓冲区大小的缺省值
 net.core.rmem_max =1048576 # 套接字接收缓冲区大小的最大值
 net.core.wmem_default = 262144 # 套接字发送缓冲区大小的缺省值
 net.core.wmem_max = 262144 # 套接字发送缓冲区大小的最大值
 注：内核参数并非必须修改，可以根据自己实际情况而定。
 
 1.4 为Oracle创建DBA组和用户
 安装Oracle必须指定拥有DBA权限的组和运行Oracle的用户。
 创建组：groupadd oradba
 创建用户：useradd -g oradba oracle
 注：组名和用户名可以任意指定，不一定要照搬本文。
 
 1.5 创建安装Oracle的目标目录
 创建Oracle系统目录：mkdir /oracle
 创建Oracle服务器主目录：mkdir /oracle/10g
 将该目录的所有者设置为oracle：chown oracle /oracle -R
 编辑 /etc/profile，在后面追加以下两行
 export ORACLE_BASE=/oracle
 export ORACLE_HOME=/oracle/10g
 注：安装Oracle的目标目录可以任意指定，但是安装和运行Oracle的用户必须有完全修改该目录的权限。
 
 2 安装
 2.1 编辑安装需要的应答文件
 静默模式(Silent)安装必须指定一个应答文件来完成安装过程所须的各类参数。
 在Oracle安装目录的response子目录里有enterprise.rsp有enterprise.rsp、standard.rsp和custom.rsp三个应答文件，分别对应企业版、标准版和定制的安装。
 以enterprise.rsp为例，用任意的文本编辑器打它，修改以下这些项目的值。
 ORACLE_HOME Oracle服务器的主目录位置，必须是绝对路径。
 ORACLE_HOME_NAME Oracle服务器的名称，必须以字母开头。
 COMPONENT_LANGUAGES Oracle服务器支持的语言，默认只有英语，可以添加多个语言。
 s_nameForDBAGrp 用于Oracle系统管理的linux用户组名，该组的用户拥有管理Oracle服务器的权限，在本例中设置为 oradba。
 s_nameForOPERGrp 用于Oracle数据库常规操作的linux用户组名，该组的用户拥有常规操作Oracle数据库的权限，在本例中设置为 oracle。
 n_configurationOption 安装类型（1为在安装后创建数据库，2为安装后创建一个自动存储管理实例，3为只安装服务器软件），在本例中选择3。
 其它项目用默认值即可，也可以根据自己的须要进行修改。
 注：如果Oracle从光盘安装，必须先将应答文件复制到硬盘上，才能修改。
 
 2.2 开始安装
 现在万事具备，可以安装了。
 用oracle用户登录，然后在Oracle安装目录里执行
 ./runInstaller -ignoreSysPrereqs -silent -responseFile <应答文件的绝对路径>
 接下来就是等待安装结束了。
 各安装参数的含义如下
 ignoreSysPrereqs 让Oracle忽略系统检查，因为Oracle官方声明只支持Linux服务器产品，所以要在非服务器产品的Linux上安装就必须指定此参数。
 silent 让安装程序以静默模式运行。
 responseFile 指定一个应答文件。
 
 3 安装后要做的工作
 3.1 Oracle系统初始化
 用root用户登录，然后运行$ORACLE_HOME/root.sh进行Oracle的系统初始化工作，通常一路按回车用默认值即可。
 
 3.2 安装网络监听器
 没有网络监听器，客户端就无法通过网络连接Oralce服务器。要在命令行安装网络监听器，也只能使用静默模式。
 编辑Oracle安装目录里response子目录下的应答文件 netca.rsp，修改以下项目。
 INSTALL_TYPE=''custom'' 安装的类型
 LISTENER_NUMBER=1 监听器数量
 LISTENER_NAMES={'LISTENER'} 监听器的名称列表
 LISTENER_PROTOCOLS={'TCP;1521'} 监听器使用的通讯协议列表
 LISTENER_START=''LISTENER'' 监听器启动的名称
 然后运行
 $ORACLE_HOME/bin/netca /silent /responseFile <应答文件的绝对路径>
 
 3.3 修改dbstart
 用任意的文本编辑器打开 $ORACLE_HOME/bin/dbstart，将
 ORACLE_HOME_LISTNER=/ade/vikrkuma_new/oracle
 改为
 ORACLE_HOME_LISTNER=$ORACLE_HOME
 否则网络监听器可能无法自动启动。
 
 3.4 安装数据库实例
 编辑Oracle安装目录里response子目录下的应答文件 dbca.rsp，修改以下项目。
 GDBNAME 数据库全局名称
 SID 数据库的SID
 SYSPASSWORD SYS用户的初始密码
 SYSTEMPASSWORD SYSTEM用户的初始密码
 CHARACTERSET 数据库字符集（中文为 ZHS16GBK）
 NATIONALCHARACTERSET 数据库国家字符集
 然后运行
 $ORACLE_HOME/bin/dbca -silent -responseFile <应答文件的绝对路径> -cloneTemplate
 数据库创建成功后须要注册一些信息，运行
 $ORACLE_BASE/oraInventory/orainstRoot.sh
 然后编辑 /etc/oratab
 将
 <Oracle的SID>:<Oracle的主目录>:N
 修改为
 <Oracle的SID>:<Oracle的主目录>:Y
 使数据库实例能够自动启动。
 
 3.5 让Oracle运行为服务
 创建文件 /etc/init.d/oracle，输入下列内容
 #!/bin/sh
 #
 export ORACLE_HOME=<Oracle服务器主目录的绝对路径>
 export ORACLE_HOME_LISTNER=$ORACLE_HOME
 export ORACLE=oracle
 . /etc/init.d/functions
 export PATH=${PATH}:$ORACLE_HOME/bin
 start()
 {
 daemon --user $ORACLE $ORACLE_HOME/bin/dbstart
 daemon --user $ORACLE '$ORACLE_HOME_LISTNER/bin/lsnrctl start'
 }
 stop()
 {
 daemon --user $ORACLE '$ORACLE_HOME_LISTNER/bin/lsnrctl stop'
 daemon --user $ORACLE $ORACLE_HOME/bin/dbshut
 }
 case $1 in
 'start')
 start
 RETVAL=$?
 ;;
 'stop')
 stop
 RETVAL=$?
 ;;
 'restart')
 stop
 start
 RETVAL=$?
 ;;
 *)
 echo 'usage: $0 {start|stop|restart}'
 exit
 ;;
 esac
 #
 exit
 
 然后将这个文件赋予可执行的权限，运行
 chmod a+x /etc/init.d/oracle
 让Oracle的服务在Linux启动时自动运行
 ln -s /etc/init.d/orac

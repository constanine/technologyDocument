# `Linux`下`Mysql5.x`的安装

### 数据服务器环境的部署
#### 1. 用户准备
##### 1.1 请在用户root的环境下，可以使用下面的命令,进入root角色
```shell
	sudo su -
```
	这个命令输入后,会需求当前用户的密码,输入即可
##### 1.2 创建一个数据服务的用户,`mysql`
```shell
	useradd mysql;
```
##### 1.3 添加运维用户包含了运维组
```shell
	useradd mysql;
```
##### 1.4 将`mysql`用户扔到运维组
```shell
	gpasswd -a mysql devops;
```
##### 1.5 创建一个运维目录，并赋权给运维组
```shell
	mkdir -pv /data/devops;
	chown devops:devops -R /data/devops;
```
#### 2 mysql的安装
##### 2.1 请在用户root的环境下，可以使用下面的命令,进入root角色
```shell
	sudo su -
```
	这个命令输入后,会需求当前用户的密码,输入即可

##### 2.2 准备mysql数据的存放地址
```shell
	mkdir -pv /data/mysqldata;
	chown mysql:mysql -R /data/mysqldata;
```
##### 2.3 到`/usr/lib`下,下载并解压mysql5.5安装包
```shell
	cd /usr/lib
	wget https://dev.bokesoft.com/public/ecomm/downloads/mysql-5.5.53-linux2.6-x86_64.tar.gz;
	tar -zxvf ./mysql-5.5.53-linux2.6-x86_64.tar.gz;
	rm -rf ./mysql-5.5.53-linux2.6-x86_64.tar.gz
```
##### 2.4 准备mysql的服务初始化
```shell
	cd ./mysql-5.5.53-linux2.6-x86_64/scripts/;
	./mysql_install_db --user=mysql --basedir=/home/mysql/mysql-5.5.53-linux2.6-x86_64 --datadir=/data/mysqldata;
```
  - **注意**，这个命令在运行结束的末尾处,会显示root用户的随机登入密码，请记录下来
	![](./imgs/mysql初始化结果及root的初始密码.png)

##### 2.5 准备mysql服务的配置文件
```shell
	cp my-default.cnf /etc/my.cnf;
```

##### 2.6 准备mysql服务的启动脚本
```shell
	cp mysql.server /etc/init.d/mysql;
```

##### 2.7 修改mysql服务的启动脚本
```shell
	vim /etc/init.d/mysql;
```

##### 2.8 修改文件中的两个变量值,是basedir指向mysql服务的所在地址,datadir指向前面预览的数据存放地址
```shell
	basedir=/home/mysql/mysql-5.5.53-linux2.6-x86_64
	datadir=/data/mysqldata
```

##### 2.9 保存修改并推出
```shell
	#按下ESC键
	:wq
	#并回车
```

##### 2.10 添加mysql操作命令地址,编辑`/etc/profile`文件
```shell
	vim /etc/profile
```

##### 2.11 在文件**末尾**添加如下内容
```shell
	export MYSQL_HOME="/software/mysql-5.6.21"
	export PATH="$PATH:$MYSQL_HOME/bin"
```

##### 2.12 保存修改并推出
```shell
	#按下ESC键
	:wq
	#并回车
```
**附**:以上文件编辑使用了`linux`-`vim`操作,如有不懂请自行百度学习

### 3 mysql的启用
##### 3.1 启动mysql-server，并设置启动启动
```shell
  systemctl  enable mysqld
  systemctl  start mysqld
```
##### 3.2 登入mysql
```shell
  mysql -u root -p
```
  输入1.4mysql初始化时生成的root随机密码
##### 3.3 登入mysql后,修改root密码
```sql      
  alter user 'root'@'localhost' identified by 'root'; #root为你想定义的密码,请牢记
  #刷新权限
  flush privileges;
```
##### 3.4 登入mysql后,创建一个应用的数据用户zszg,并赋权
```sql
  CREATE USER 'zszg'@'%' IDENTIFIED BY 'zszg111' #zszg111,为mysql用户zszg的登入密码   
  GRANT ALL PRIVILEGES ON *.* TO 'zszg'@'%';
  #刷新权限
  flush privileges;   
```
##### 3.5 登入mysql后,准备一个数据库实例给应用
```sql
  CREATE SCHEMA `yigo2erp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
```
# `nfs-client`的安装和配置
### 1.请在用户`root`的环境下，可以使用下面的命令,进入`root`角色
```shell
	sudo su -
```
### 2.安装`nfs-utils`等相应软件
```shell
yum  install  nfs-utils  rpcbind;
```
### 3.准备共享地址,并赋权给用户`boke`
```shell
mkdir /mnt/sharedata;
chown boke:boke /mnt/sharedata;
```
**注意**:用户`boke`,为启动`yigo`应用的用户

### 4.使用`showmount -e`查看是否有可用的`nfs-server`共享目录
```shell
showmount -e xxx.xxx.xxx.xxx
```
资料[https://www.linuxidc.com/Linux/2013-03/81895.htm]

### 5.修改/etc/fstab,使其开机自动mount共享文件夹
```shell
vi /etc/fstab;
```
### 6.修改内容,在末尾添加下列内容
```shell
xxx.xxx.xxx.xxx:/xxx /mnt/sharedata nfs  rw,tcp,intr  0 1;
```
**注意**:`xxx.xxx.xxx.xxx:/xxx`本质就是`nfs-server`的共享服务器`ip`:nfs-server`的共享服务暴露的目录地址
例如:
```shell
172.19.20.127:/data/sharedata /mnt/sharedata nfs  rw,tcp,intr  0 1;
```

### 7.保存编辑并推出
```shell
#按下ESC键
:wq
#并回车
```
### 8.使用`mount -a`,连接共享盘,并用`mount`查看连接结果
```shell
mount -a;
mount;
```
### 9.可以看到`mount`的检验结果包含如下内容
```shell
172.19.20.127:/data/sharedata on /mnt/sharedata type nfs4 (rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=172.19.20.124,local_lock=none,addr=172.19.20.127)
```
# NFS-SERVER的安装教程

### 1 用户准备
##### 1.1 请在用户root的环境下，可以使用下面的命令,进入root角色
```shell
  sudo su -    
```
##### 1.2 添加运维用户包含了运维组
```shell
  useradd devops;
```
##### 1.3 创建一个运维目录，并赋权给运维组
```shell
  mkdir -pv /data/devops;
  chown devops:devops -R /data/devops;
```

### 2. nfs-server的安装和启动
##### 2.1 请在用户root的环境下，可以使用下面的命令,进入root角色
```shell
	sudo su -
```
##### 2.2 安装nfs-server等相应软件
```shell
  yum  install  nfs-utils  rpcbind;
```
##### 2.3 准备共享目录
```shell
  mkdir /data/sharedata;
```
##### 2.4 配置nfs-server服务
```shell
  vim  /etc/exports;
```
##### 2.5 添加内容
```shell
  /data/sharedata xxx.xxx.xxx.*/24(rw,sync,all_squash)
```
**注意**,`xxx.xxx.xxx.*`,为`ipv4`的地址,最后一段建议使用`*/24`,表示同一网段都可以使用`nfs-server`

##### 2.6 保存编辑并推出
```shell
  #按下ESC键
  :wq
  #并回车
```
##### 2.7 将共享内容固化导出
```shell
  exportfs -a;
```

##### 2.8 如果存在`SELinux=enforcing`为情况,需要设置安全过滤
```shell
  semanage fcontext -a -t httpd_use_nfs " /data/sharedata(/.*)?"
  restorecon -R -v /data/sharedata 
```
##### 2.9 定义`nfs`,`rpcbind`开机启动,并立即启动
```shell
  chkconfig nfs on;
  chkconfig rpcbind on;
  systemctl enable nfs.service;
  systemctl enable nfs.service;
  systemctl start nfs.service;
  systemctl start rpcbind;
```
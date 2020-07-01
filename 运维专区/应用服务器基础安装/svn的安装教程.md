# svn的安装
### 1.添加svn1.9的安装源
```shell
  yum-config-manager --add-repo=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/;
```
### 2.修改新添加的repo文件
```shell
  vi /etc/yum.repos.d/opensource.wandisco.com_centos_7_svn-1.9_RPMS_.repo
```
### 3.在文件末尾添加`gpgcheck`属性,改为0,使其可用
```shell
  gpgcheck=0
```
### 4.保存编辑并推出
```shell
  #按下ESC键
  :wq
  #并回车
```
### 5.整个文件内容如下
```shell
  name=added from: http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/
  baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/
  enabled=1
  gpgcheck=0
```
### 6.使用获取安装资源
```shell
  yum makecache;
```
### 7.安装svn
```shell
  yum install subversion;
```
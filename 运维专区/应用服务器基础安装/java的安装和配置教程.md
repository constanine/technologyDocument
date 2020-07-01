# `JDK`的安装和配置
### 1.请在用户`root`的环境下，可以使用下面的命令,进入`root`角色
```shell
   sudo su -
```
#### 2.进入`/usr/lib`下,下载安装jdk环境
```shell
   cd /usr/lib/;
   wget https://dev.bokesoft.com/public/ecomm/downloads/jdk-8u181-linux-x64.tar.gz;
   tar -zxvf jdk-8u181-linux-x64.tar.gz;
   rm -f jdk-8u181-linux-x64.tar.gz;
```
### 3.修改`/etc/profile`,添加基础的`JAVA_HOME`的环境变量
```shell
   vi /etc/profile
```
### 4.修改内容,在文件末尾,添加下列内容
```shell
   export JAVA_HOME=/usr/lib/jdk-8u181-linux-x64
```
### 5.保存编辑并推出
```shell
   #按下ESC键
   :wq
   #并回车
```
### 6.加载环境变量,并验证`JDK`有效性
```shell
   source /etc/profile
   ${JAVA_HOME}/bin/java -version
```
可以看到返回`java version`的结果即为安装配置成功
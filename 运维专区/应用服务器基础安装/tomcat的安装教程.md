# `Tomcat`的安装和配置
### 1.请在用户`root`的环境下，可以使用下面的命令,进入`root`角色
```shell
   sudo su -
```
#### 2.进入`/usr/lib`下,下载安装jdk环境
```shell
   cd /usr/lib/;
   wget https://dev.bokesoft.com/public/ecomm/downloads/apache-tomcat-9.0.30.tar.gz;
   tar -zxvf apache-tomcat-9.0.30.tar.gz;
   rm -f apache-tomcat-9.0.30.tar.gz;
```
### 3.修改`/etc/profile`,添加基础的`JAVA_HOME`的环境变量
```shell
   vi /etc/profile
```
### 4.修改内容,在文件末尾,添加下列内容
```shell
   export CATALINA_HOME=/usr/lib/apache-tomcat-9.0.30
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
   ${CATALINA_HOME}/bin/startup.sh
```
访问对应8080服务,应该有`tomcat`的`helloworld`
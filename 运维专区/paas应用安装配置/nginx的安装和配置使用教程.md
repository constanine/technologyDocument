# nginx安装和配置

### 1. nginx的安装
##### 1.1 请在用户`root`的环境下，可以使用下面的命令,进入`root`角色
```shell
sudo su -
```
	这个命令输入后,会需求当前用户的密码,输入即可
##### 1.2 添加`nginx`安装源
```shell
  yum-config-manager --add-repo=http://nginx.org/packages/centos/7/x86_64
```
##### 1.3 修改`/etc/yum.repos.d/nginx.org_packages_centos_7_.repo`文件,使其通过验证
```shell
vi /etc/yum.repos.d/nginx.org_packages_centos_7_.repo
```
##### 1.4 修改内容为,在文件末尾添加下列内容
```shell
gpgcheck=0
```
##### 1.5 保存编辑并推出
```shell
  #按下ESC键
  :wq
  #并回车
```
##### 1.6 获取安装源
```shell
  yum mackcache
```
##### 1.7 安装nginx
```shell
  yum install nginx
```
### 2 nginx的配置
##### 2.1 在`/etc/nginx/conf.d`添加一个`yigo`系统应用的路由配置
```shell
vi /etc/nginx/conf.d/spring-boot-yigo-app.conf
```
##### 2.2 其内容为:
```shell
upstream yigo_server {
	server xxx.xxx.xxx.aaa:8089;
	server xxx.xxx.xxx.bbb:8089;
	keepalive 1024;
}

server {
	listen 8089 default_server;
	location /yigo {
		proxy_read_timeout 120s;
		proxy_pass http://yigo_server/yigo;
		proxy_set_header Host $Host:$server_port;
		proxy_set_header X-Real-Ip $remote_addr;
		proxy_cookie_path  /yigo/ /;
	}
}
```
**注意**:`xxx.xxx.xxx.aaa`,`xxx.xxx.xxx.bbb`为`Yigo`服务应用的`IP`地址

###### 3.2.3 保存编辑并推出
```shell
  #按下ESC键
  :wq
  #并回车
```
##### 3.3 nginx的启动
###### 3.3.1 设置nginx自动启动
```shell
systemctl enable nginx
```
###### 3.3.2 启动nginx
```shell
systemctl start nginx
```
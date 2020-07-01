# redis的安装和启动
### 1.请在用户root的环境下，可以使用下面的命令,进入root角色
```shell
	sudo su -
```
### 2.下载并解压
```shell
  #准备下载在/usr/lib下
  cd /usr/lib/
  #下载redis服务
  wget http://download.redis.io/releases/redis-5.0.5.tar.gz;
  #解压
  tar -zxvf redis-5.0.5.tar.gz;
  rm redis-5.0.5.tar.gz;
```
### 3.安装
```shell
  cd /usr/lib/redis-5.0.5/;
  make;
```
### 4.将redis相关命令输出到`/usr/local/bin`下,变得可用
```shell
  ln -s /usr/lib/redis-5.0.5/src/redis-* /usr/local/bin/;
```
### 5.准备redis的启动配置
```shell
  cp redis.conf /etc/redis_6379.conf;
```
### 6.查看当前网卡地址
```
ip addr;
```
### 7.修改redis服务配置参数
```shell
  vi /etc/redis_6379.conf;
```

### 8.修改参数如下
	- 将bind 追加所有网卡地址,如网卡地址为:172.19.20.127,那么bind为`127.0.0.1 172.19.20.127`
	- 将databases 16 改为 databases 999
	- 将daemonize 设为 yes
	- 将dir 设为 /data/data/devops/redis-data
#### 8.1 启动redis服务-模式1
```shell
  nohup redis-server /etc/redis_6379.conf &
```
#### 8.2 启动redis服务-模式2,使用运维脚本,`redis-server-controll.sh`
```shell
  ./redis-server-controll.sh start
```
### 附录
- `redis-server-controll.sh`
```shell
#!/bin/bash
if [ $# < 2 ];then
	echo "shell args is not correct!please give operator and port number,like:"
	echo "./redis-server-controll start 6379"
	echo "now try again!"
	exit -1;
fi
REDISPORT=$2
EXEC=redis-server 
REDIS_CLI=redis-cli
 
PIDFILE=/var/run/redis_$2.pid
CONF="/etc/redis_$$2.conf"  

case "$1" in 
        start)   
                if [ -f $PIDFILE ]   
                then   
                        echo "$PIDFILE exists, process is already running or crashed."  
                else  
                        echo "Starting Redis server..."  
                        $EXEC $CONF   
                fi   
                if [ "$?"="0" ]   
                then   
                        echo "Redis is running..."  
                fi   
                ;;   
        stop)   
                if [ ! -f $PIDFILE ]   
                then   
                        echo "$PIDFILE exists, process is not running."  
                else  
                        PID=$(cat $PIDFILE)   
                        echo "Stopping..."  
                       $REDIS_CLI -p $REDISPORT  SHUTDOWN    
                        sleep 2  
                       while [ -x $PIDFILE ]   
                       do  
                                echo "Waiting for Redis to shutdown..."  
                               sleep 1  
                        done   
                        echo "Redis stopped"  
                fi   
                ;;   
        restart|force-reload)   
                ${0} stop   
                ${0} start   
                ;;   
        *)   
               echo "Usage: /etc/init.d/redis {start|stop|restart|force-reload}" >&2  
                exit 1  
esac
```
`centos7` 请使用`nmcli`命令指定`ipv4`相关地址
nmcli con mod eth0 ipv4.method manual ipv4.addresses 172.25.0.11/24 ipv4.gateway 172.25.0.254 ipv4.dns 172.25.254.254 +ipv4.dns 114.114.114.114
`etcd` 需要用 `etcdctl mk` 添加 协议配置,以及子网络得网段,所以不应该和主网端重复,并不是过滤条件!!!
`etcdctl ls` 可以查看协议设置,包含了配置/`config`,
etcd 得配置中由于 本地访问会默认使用127.0.0.1 所以ETCD_LISTEN_CLIENT_URLS的变量应该为
```shell
ETCD_LISTEN_CLIENT_URLS="http://192.168.9.101:2379,http://127.0.0.1:2379"
```
注意末尾的`http://127.0.0.1:2379`,即客户端地址有2个值
再使用`flanneld`之后,`firewall`会生效,所以记得先用`firewall-cmd`去开通`tcp`端口

有时`flanneld`无法启动,可能因为`ip`冲突
```shell
Jan 20 13:54:13 localhost.localdomain flanneld-start[20497]: E0120 13:54:13.415991   20497 network.go:102] failed to register network: failed to acquire lease: out of subnets
Jan 20 13:54:14 localhost.localdomain flanneld-start[20497]: I0120 13:54:14.418581   20497 local_manager.go:179] Picking subnet in range 10.3.0.128 ... 10.3.0.128
Jan 20 13:54:14 localhost.localdomain flanneld-start[20497]: E0120 13:54:14.418597   20497 network.go:102] failed to register network: failed to acquire lease: out of subnets
```
上述启动日志表明分配的`IP`地址与其他机器冲突,属于K8S集群部署flannel分配IP冲突,
检查etcd发现subnets下仅有一个IP段：
[root@localhost ~]# etcdctl get /flannel/network/config
{"Network":"173.28.0.0/24"}
[root@localhost ~]# etcdctl ls /flannel/network/subnets/
/flannel/network/subnets/172.18.0.128-25
其解决方法
`etcdctl mk config`的参数调整为{"Network":"10.3.0.0
/16"}而不是{"Network":"10.3.0.0/24"}
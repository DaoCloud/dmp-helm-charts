# management Chart 使用说明
management 需要链接 Mysql,Redis,Elasticsearch 中间件，因此须确保 DMP management 所需中间件均已安装且使用正常。
如果你才用的是 `base chart` 安装的 DMP 中间件，你可以在 `helm install`安装的时候查看控制台输出，得到链接信息，如下所示：

```console
···
1. Mysql  can be accessed on the following DNS names from within your cluster:
    test-base-dmp-mysql.testns.svc.cluster.local for read/write operations (port 3306)

    Administrator credentials:

    echo Username: root
    echo Password : dangerous


2. Redis(TM) can be accessed on the following DNS names from within your cluster:

    test-base-dmp-redis.testns.svc.cluster.local for read/write operations (port 6379)

    Administrator credentials:
    echo Password : redispass
    You can copy and using like: redispass@test-base-dmp-redis.testns.svc.cluster.local:6379
···
```

## 安装 management

注意：拷贝 [values.yaml](./values.yaml) 配置文件并指定配置文件。

```bash
$ pwd
dmp-helm-charts/charts/management/
cp values.yaml values-myrelease.yaml
```

#### 使用默认配置安装
```bash
$ pwd
dmp-helm-charts/charts/
$ kubectl create ns dmp
$ helm install dmp-management-release management -n dmp -f values.yaml
```

## 卸载
```bash
$ pwd
dmp-helm-charts/charts/
$ helm uninstall my-dmp-management-release -n <namespace>
```


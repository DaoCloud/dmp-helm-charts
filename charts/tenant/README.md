# tenant Chart 使用
tenant 需要链接 Elasticsearch 中间件与 management 相关组件，因此须确保 DMP 中间件 与 management 均已安装且使用正常。
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

## 安装 tenant

注意：拷贝 [values.yaml](./values.yaml) 配置文件并指定配置文件。

```bash
$ pwd
dmp-helm-charts/charts/tenant/
cp values.yaml values-myrelease.yaml
```

```bash
$ pwd
dmp-helm-charts/charts/
$ helm install my-dmp-tenant-release tenant -n <namespace> -f values-myrelease.yaml
```

## 卸载
```bash
$ pwd
dmp-helm-charts/charts/
$ helm uninstall my-dmp-tenant-release -n <namespace>
```



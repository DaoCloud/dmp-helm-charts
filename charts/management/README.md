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
## 组件配置说明  
### twice
| 环境变量 | 说明 | 默认值 | 备注 |
| :-----| :----- | :----- | :----- |
| `K8S_SERVER` | k8s api server 地址 | - | - |
| `K8S_TOKEN` | token | - | - |
| `MANAGEMENT_NAMESPACE` | dmp 系统组件部署的租户 | `{{.Release.Namespace}}` | 用于获取系统组件健康状态 |
| `TENANT_LABEL_NAME` | 网关deployment envcode的标签 | `dmp.daocloud.io/gateway` | 用于获取网关组件健康状态 |
| `SERVICE_LABEL_NAME` | 网关svc的标签 | `dmp.daocloud.io/app` | 用于获取网关svc的nodePort |
| `GATEWAY_ENVOY_PORT` | 网关envoy端口 | `9901` | - |
| `GATEWAY_THOR_PORT` | 网关thor端口 | `9876` | - |


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


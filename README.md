# Helm Chart For DMP (DaoCloud MicroService Platform)

该 Chart 主要用于快速部署 DMP。
## 项目构成：
```text
├── charts
    ├── base       # 用于部署 DMP 所需的中间件
    ├── management # 用于部署 DMP 管理段组件
    └── tenant     # 用于部署 DMP 租户端组件
```

分为 **base** , **dmp-management**  和 **dmp-tenant** 三个 Chart, 你可以在部署的时候分开选择性的部署。

## 前置条件(Prerequisites)
- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure

## 获取 DMP Charts 并添加依赖仓库
```bash
$ git clone  https://github.com/DaoCloud/dmp-helm-charts.git
$ cd dmp-helm-charts/
$ helm repo add elastic https://helm.elastic.co
```

### base Chart 安装 DMP 中间件请参考[charts/base](charts/base/README.md)[如果中间件已经安装好，可以跳过此步骤]

### management Chart 使用请参考：[charts/management](charts/management/README.md)

### tenant Chart 使用请参考：[charts/management](charts/management/README.md)


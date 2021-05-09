# DMP BASE Chart

# base Chart 安装 DMP 中间件[如果中间件已经安装好，可以跳过此步骤]

- 更新依赖项
```bash
$ helm dep up charts/base
```
会看到如下输出内容：

```text
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "loki" chart repository
...Successfully got an update from the "elastic" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
Saving 5 charts
Downloading elasticsearch from repo https://helm.elastic.co/
Downloading mysql from repo https://charts.bitnami.com/bitnami
Already downloaded elasticsearch from repo https://helm.elastic.co/
Downloading redis from repo https://charts.bitnami.com/bitnami
Deleting outdated charts
```
- 安装中间件，默认会安装 Mysql、Elasticsearch、Redis. 更多使用请参考[chart/base使用指南](charts/base/README.md)
```bash
$ helm install dmp-base -n testdb  charts/base
###
```

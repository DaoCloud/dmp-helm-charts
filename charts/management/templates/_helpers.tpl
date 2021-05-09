{{/*
Expand the name of the chart.
*/}}
{{- define "dmp-management.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dmp-management.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dmp-management.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dmp-management.labels" -}}
helm.sh/chart: {{ include "dmp-management.chart" . }}
{{ include "dmp-management.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dmp-management.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dmp-management.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dmp-management.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dmp-management.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
wait for elasticsearch is ready to connect.
*/}}
{{- define "skywalking.containers.wait-for-es" -}}
- name: wait-for-elasticsearch
  image: {{ .Values.initContainer.image }}:{{ .Values.initContainer.tag }}
  imagePullPolicy: IfNotPresent
{{- if .Values.elasticsearch.enabled }}
  command: ['sh', '-c', 'for i in $(seq 1 60); do nc -z -w3 {{ .Values.elasticsearch.clusterName }}-{{ .Values.elasticsearch.nodeGroup }} {{ .Values.elasticsearch.httpPort }} && exit 0 || sleep 5; done; exit 1']
{{- else }}
  command: ['sh', '-c', 'for i in $(seq 1 60); do nc -z -w3 {{ .Values.elasticsearch.config.host }} {{ .Values.elasticsearch.config.port.http }} && exit 0 || sleep 5; done; exit 1']
{{- end }}
{{- end -}}

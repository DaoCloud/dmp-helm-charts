{{/*
Expand the name of the chart.
*/}}
{{- define "daoshop.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "daoshop.fullname" -}}
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
{{- define "daoshop.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "daoshop.labels" -}}
helm.sh/chart: {{ include "daoshop.chart" . }}
{{ include "daoshop.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "daoshop.selectorLabels" -}}
app.kubernetes.io/name: {{ include "daoshop.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "daoshop.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "daoshop.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
monitor sidecar.
*/}}
{{- define "daoshop.initContainer" -}}
- name: dx-monitor-agent-sidecar
  image: registry.dx.io/dx-pilot/dx-monitor-agent-sidecar:2.5.0
  imagePullPolicy: Always
  command: ['sh', '-c', 'mv /sidecar/skywalking/agent/optional-plugins/apm-trace-ignore-plugin-8.4.0.DMP.jar /sidecar/skywalking/agent/plugins; echo trace.ignore_path=${TRACE_IGNORE_PATH} >> /sidecar/skywalking/agent/config/apm-trace-ignore-plugin.config;cp -r /sidecar /target;']
  volumeMounts:
    - name: sidecar
      mountPath: /target
{{- end }}

{{/*
active monitor sidecar.
*/}}
{{- define "daoshop.javaagent" -}}
- name: DX_SERVICE_NAME
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: 'metadata.labels[''dx.daocloud.io/service-name'']'
- name: DX_ENV_ID
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: 'metadata.labels[''dx.daocloud.io/env-id'']'
- name: SW_AGENT_KUBE_NS
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.namespace
{{- end }}


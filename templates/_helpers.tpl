{{/*
Unique DataSource names referenced by VMs (root disks and additional disks that clone).
*/}}
{{- define "edge-gitops-vms.dataSourceNames" -}}
{{- $datasources := dict -}}
{{- $def := .Values.vmDefaults -}}
{{- range $_, $vmr := .Values.vms -}}
  {{- if $vmr -}}
    {{- $ds := coalesce $vmr.dataVolume $def.dataVolume $vmr.os $def.os -}}
    {{- if $ds -}}
      {{- $_ := set $datasources $ds "true" -}}
    {{- end -}}
    {{- range $disk := (coalesce $vmr.additionalDisks $def.additionalDisks (list)) -}}
      {{- if and $disk $disk.dataVolume -}}
        {{- $_ := set $datasources $disk.dataVolume "true" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- keys $datasources | sortAlpha | join " " -}}
{{- end -}}

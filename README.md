<div align="center">

<img src="https://raw.githubusercontent.com/cncf/artwork/refs/heads/main/projects/k3s/icon/color/k3s-icon-color.svg" align="center" width="175px" height="175px"/>

## My HomeLab Cluster <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/2604_fe0f/512.gif" alt="☄" width="32" height="32">

... managed with Flux and Renovate <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f916/512.gif" alt="🤖" width="16" height="16">

</div>

<div align="center">

[![k3s](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fk3s_version&style=for-the-badge&logo=k3s&logoColor=white&color=blue)](https://k3s.io/)&nbsp;&nbsp;
[![Flux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fflux_version&style=for-the-badge&logo=flux&logoColor=white&color=blue&label=Flux)](https://fluxcd.io)&nbsp;&nbsp;
[![Linux](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Flinux_version&style=for-the-badge&logo=linux&logoColor=white&color=blue&label=Linux)](https://kernel.org/)

</div>

<div align="center">

[![Age-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_age_days&style=flat-square&label=Age)](https://github.com/kashalls/kromgo/)&nbsp;
[![Uptime-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_uptime_days&style=flat-square&label=Uptime)](https://github.com/kashalls/kromgo/)&nbsp;
[![Node-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_node_count&style=flat-square&label=Nodes)](https://github.com/kashalls/kromgo/)&nbsp;
[![Pod-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_pod_count&style=flat-square&label=Pods)](https://github.com/kashalls/kromgo/)&nbsp;
[![CPU-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_cpu_usage&style=flat-square&label=CPU)](https://github.com/kashalls/kromgo/)&nbsp;
[![Memory-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_memory_usage&style=flat-square&label=Memory)](https://github.com/kashalls/kromgo/)&nbsp;
[![Alerts](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.popov.wtf%2Fcluster_alert_count&style=flat-square&label=Alerts)](https://github.com/kashalls/kromgo)

</div>

</div>

## Overview

This repository is my home Kubernetes cluster in a declarative state. [Flux](https://github.com/fluxcd/flux2) watches the [kubernetes](./kubernetes/) folder and will make the changes to the cluster based on the YAML manifests.

### <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f4a1/512.gif" alt="💡" width="16" height="16"> Core Components

Core components that form the foundation of the cluster:

- [cilium/cilium](https://github.com/cilium/cilium): Kubernetes CNI.
- [jetstack/cert-manager](https://cert-manager.io/docs/): Creates SSL certificates for services in my Kubernetes cluster.
- [kubernetes-sigs/external-dns](https://github.com/kubernetes-sigs/external-dns): Automatically manages DNS records from my cluster in CloudFlare.
- [rancher/system-upgrade-controller](https://github.com/rancher/system-upgrade-controller): Handles k3s upgrades automatically.
- [kubereboot/kured](https://github.com/kubereboot/kured): Kubernetes reboot daemon that performs safe automatic node reboots when needed.

### <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f6a8/512.gif" alt="🚨" width="16" height="16"> Observability

For observability and monitoring of the cluster the following software is used:

- [VictoriaMetrics/VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics): Time series database, drop-in replacement for Prometheus.

### <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f916/512.gif" alt="🤖" width="16" height="16"> Automation

- [Github Actions](https://docs.github.com/en/actions) for checking code formatting and running periodic jobs
- [Renovate](https://github.com/renovatebot/renovate) keeps the application charts and container images up-to-date

## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/270f_fe0f/512.gif" alt="✏" width="16" height="16"> License

See [LICENSE](./LICENSE)

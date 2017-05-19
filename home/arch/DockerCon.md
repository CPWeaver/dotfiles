#What's new in Docker
---
##Release Schedule
  - Edge: Monthly
  - Stable: Quarterly

---
## Features (available in 17.05-rc1)
  - Multi-Stage builds
    - More like a tree than a list
    - Split build tools from runtime deps
  - Specify target on build with `--target`
  - Build arguments (for parameterized version)
    - e.g.
    `docker build --build-arg GO_VERSION=latest`
    `docker build --build-arg GO_VERSION=1.7`
    FROM golang:${GO_VERSION}
  - Data management commands
    - docker system df
    - docker system prune
  - Docker plugins
    - now managed by daemon and run as containers
      - (deep dive into plugins Wed 1:30)
  - Swarm Mode
    - Synchronous service commands
      - watch swarm commands in action
    - Service rollback on failure
      - rollback action added to --update-failure-action
    - Topology-aware scheduling
      - placement preferences
    - Service logs
      - docker service logs
    - Deep dive (Tuesday 2pm)
  - Compose
    - now possible to deploy services using compose files directly from docker
    - Compose format v3
      - remove non-portable options like volume-from and build
      - deploy params in compose file
        - placement, replicats, parallelism, restarts, etc etc
      - long syntax for ports in compose file, more verbose but a little easier to remember
        - new options for swarm
      - long syntax for volumes as well

# LinuxKit
---
  - immutable deliery
  - docker whale on mac starts up a distro
  - secure, portable, lean, built for containers
  - interesting project, seems like it's not ready for prime time yet? needs AWS support
# Infrakit
  - managing declarative, self-healing infrastructure


# Docker Networking Deep Dive
---
  - Bring networking closer to apps and apps closer to networking
## Network Layers, Planes, and Dimensions
  - App Dimension - OSI
    - App
    - Transport
    - Network
    - Data Link
  - Infrastructure Dimension
    - Management Plane
      - User/Operator/Tools managing netowrk infrastructure
        - ux, cli, rest-api, snmp
    - Control Plane
      - signaling between network entities to exchange reachability states
      - distributed (ospf, bgp, gossip-based), centralized (openflow)
    - Data plane
      - Actual movement of application data packets
        - iptables, ipvs, routing tables
  - Docker networking
    - Application services
      - service-discovery
      - load-balancing
    - Built in and pluggable netwrok drivers
      - overlay ,bridge, macvlan
      - remote drivers/plugins
    - built in management plane
      - api, cli
      - docker stack, compose
    - built in distributed control plane
      - gossip based

    - github.com/nicolaka/netshoot
  - ingress networking
  - @madhu
  - goo.gl/d90dDl

- Questions:
  - Difference between using subnets and infrastructure level networks vs docker overlay networks
  - how to horizontally scale a set of containers together


## Turbocharged Docker Compose
  - scheduler
    - start workloads/stop workloads
  - autopilot pattern
    - press a button, hands off
    - program behavior into container
    - github.com/autopilotpattern/mysql
  - containerpilot
  - bit.ly/ap-webapp
  - go clusterless

## Monitoring with Prometheus
  - monitoring system and tsdb
    - instrumentation
    - metrics collection/storage
    - querying, alert, dashboard
    - for all levels fo the stack
  - does NOT
    - logging/tracing
    - automatic anomaly detection
    - scalable or durable storage
  - hard to monitor with statsd/graphite/etc
    - not built for dynamic cloud
  - arch
    - reads from web app, api server
    - exporter side car for processes like kernel, mysql w/o built in reporting
    - alert manager
    - reads from service discovery

  - features
    - data model, each data point has multiple labels
    - much easier to select data
    - promQL - new query language
    - (grafana has native prometheus support)
    - operational simplicity
      - static go binary
      - local storage
      - ha by running two
      - decoupled remote storage
    - use service discovery to know what should be there, where to pull, add dimensional metadata
      - talks to kub, dns, zookeeper, consul, aws, google
      - p.s. docker service discovery doesn't include port info, no task/service metadta
      - docker engine will provide metrics to prometheus
      - github.com/juliusv/prometheus_docker_demo

## Metlife 0-60 talk

## Container performance analysis
  - brendan gregg
  - Titus (containers at netflix)
    - cloud runtime platform
    - manages scheduling and container execution
    - docker and aws ec2 integration
    - adds vpc, sg, ec2 metadata, iam roles, s3 logs
    - current scale: multiple regions
    - 2500 instances, millions of deploys
    - services, batch, queued worker model (encoding)
  - scale adn balance workloads
  - Container background and strategy
    - namespaces - restrict visibility
      - cgroup, ipc, mnt net, pid, user, uts
    - control groups - restruct usage
      - blkio, cpu, memory, pids, net, etc
      - cpu usage, cpu shares
      - memory limits
      - blkio weights, iops
    - cpu shares: your value out of busy shares
      - can burst when neighbors are idle
    - cgroup v2
      - better organization, nested groups, etc
      - WIP
    - container os configuration
      - fs
        - aufs/overlay on another fs
      - net
        - overlay netwroks
  - Analysis strategy
    - one kernel, two perspectives: host/guest
    - namespaces/cgroups
    - methodoligies
      - use method
        - for every resource (use functional diagram) check utilization, saturation, errors
        - example cpus: time busy, rune queue length or latency, ecc errors
        - can be applied to hw and sw
  - Host Tools
    - challenges:
      - pids don't match, symbols aren't where they are expected, kernel missing container id
    - host physical resources: containers are often not the problem
    - linux performance analysis in 60 seconds
    - use method: (see photos)
    - event tracing: e.g. iosnoop
    - check namespaces config
      - github.com/docker/docker/issues/32501
    - look at cgroups: systemd-cgtop, docker stats
    - ...need these slides fo the nbr of tools
  - flame graphs
    - http://blog.alicegoldfuss.com/making-flamegraphs-with-containerized-java/
    - http:/batey.info/docker-jvm-flamegraphs.html
  - per cgroup metrics in /sys/fs/cgroups
    - show cgroup metrics in monitoring tool
    - github.com/Netflix/vector <== maybe like cadvisor?
  - linux tracers
    - https://github.com/brendangregg/perf-tools
    - perf_events
    - ebpf

## Docker networking in prod at visa
  - challenging landscape:
    - security landscape
    - infrastructure: physical servers (private cloud)
    - tools in sdlc ecosystem: dev env, ci, versioning
    - operational tools
  - goals:
    - load balancer-less
      - want to avoid managing configuring lbs!
    - dynamic scalability
    - migration to microservices arch
    - operational simplicity
  - 1st gen container networking:
    - scheduling -> service registration -> srevic discovery -> load balancing -> connectivity
    - ucp 1.0 -> registrator/consul -> conusl dns -> consul r-r, dns & health checking -> docker/bridge/driver
    - registration
      - services and location are registered centrally
      - 1st gen: handled by registrator/consul
    - problems
      - many components to manage
      - maintaining HA for all components
        - how to 4x9, 5x9? what if reg/consul drops out
      - many integrations to manage
      - difficulty in troubleshooting
      - maintainability: custom glue-code to manage
      - LB: replaced by consul, registrator, server
  - reg/discovery are fundamental to any app, so docker networking added those features into engine
    - using dns
      - maybe ports aren't dynamic?
    - network control plane is automatically created for a swarm
      - every service container gets its own dns entry
      - built in health checking
  - 2nd gen container networking:
    - scheduling -> service registration -> srevic discovery -> load balancing -> connectivity
    - ucp 2.0 -> docker engine -> docker engine dns -> swarm VIP LB and health checking -> docker overlay driver
    - service definitions in docker
    - docker overlay NW
    - VIP for services
    - lb and lifecycle management
      - transparent to applications
      - use VIPs
        - app2 (lb to app2 containers on nodes 1 & 2)
        - https://app2
        - integrated health check, self heal container instances
  - connectivity
    - 1 gen: bridge + nat, random port, so you need service disco
    - 2 gen: overlay simplifies it, now you have the fixed port you need
  - summary:
    - fewer components
      - easier to understand and troubleshoot
      - better visibility
    - less glue
      - less maintenance
      - fewer integrations and bugs
    - enhanced features
      - integrated vip load balancing
      - self-healing applications
    - services outside of swarm, typical SOA setup,

## overlay deep dive
  - https://github.com/lbernail/dockercon2017
  - @lbernail

## bpf talk
  - berkeley packet filtering
  - revolutionizing trafing/profiling
  - networking
  - security
  - network security has not evolved to match microservice architecture
    - iptables rules, ip and port
  - e.g. by exposing one api endpoint you expose them all
    - cilium/bpf can do layer 7 filtering
    - protect API endpoints, methods, etc
  - BPF: transparent redirection into proxy
  - XDP/BPF - the software loadbalancer of the future
    - ipvs is used by swarm, xdp allows for 10x performance
    - fb moves to bpf/xdp from ipvs
    - XDP - run bpf program in the network driver with dma access
      - very close to the H/W
  - how to use bpf with Docker
    - cilium
      - has an agent, runs on every compute node
      - bunch of plugins (docker, kube)
      - generates bpf, loads into kernel, attaches to container
  - least privilege network requires http/api/function awareness
  - bpf/xdp will drive the future of software based networking on linux
  - look at slides

## Image2Docker
  - existing vm app, auto create Dockerfile
  - "lift and shift" has its own problems
    - wouldn't learning docker be easier?
    - container best practices?
    - what are the use-cases?
  - really hard
    - Security - are theer secrets in the vm?
    - Contant - do we need to lift *everything*?
    - Config explosion - how many init systems?
    - Validation - can we automate the testing?
  - discovery, extraction, provisioning, generation
    - linux: uses detectives to scan a vm for things like apt packages
    - provisioners: translate config files, etc into image layers
  - Here are the tools, please don't use them

## Namespaces deep dive
  - restrict What you can see
    - properties of the process as it's created
      - unix timesharing, process ids, mounts, network, user ids, ipc

## Effective images
  -- check ONBUILD directive for dockerfile
  -- FROM scratch - empty Dockerfile

## Conference takeaways
  - bpf/xdp
    - use proxies to inject test/canary environments?
  - infrakit
  - linuxkit
  - overlay networks
    - swarm mode, overlays approach to service discovery (vs dynamic ports)
    - how to do media ports?
  - FaaS
    - using container std/stdout with web proxy to run tiny jobs?
    - lambdas w/o aws dependency

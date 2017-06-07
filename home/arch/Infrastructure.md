
Concerns:
  - We're likely going to standardize on Kubernetes
    - Compatibility with PGi (or beyond) systems and ops teams
  - Need to keep Foxden independent from cloud provider be it aws/compute/openstack/whatever

Goals:
  - Make service development easy and fast to enable flexible design and rapid development

Constraints:
  - We don't have a kubernetes cluster ready for Foxden, yet

Goals:
  1) keep foxden independent from cloud provider
  2) don't get coupled to the hashi toolset

Approach:

  - Hashi stack can provide that the quickest although it is likely not the ultimate solution
  - Don't write anything stack-specific into the services
  - Approach:
    - Scheduler: Services should have zero knowledge here
    - Load balancing: Services should have zero knowledge here either
    - Discovery: Inject into containers via ENV rather than query.





- Would like to split cluster basically in the way described in coreos architecture docs...
  - Central Services: core machines running consul/nomad
  - Workers: large number of workers running agents only


  - Need to bootstrap central services. Currently running in EBS (!) Options:
    - ELB
      - currently working
      - have auto container restart (could we get this from systemd?)
      - have auto node rebuild
    - ECS
      - would have to create task definitions
        - have to terraform an ASG, use ecs agent
        - using a scheduler to start our scheduler is a bit odd
        - closely coupled to provider
    - Plain ASG
      - have healthchecks on core services
      - use systemd to add consul service
      - could use latest ubuntu ami
      - could get us auto-restart, node replacement wtihout using ecs
      - less coupled to provider
    - plain old ec2 instances
      - could get us service level restart
      - no node-level replacement (do we need this?)
      - use systemd

  - TODO in all this: how to get ecr auth?


  - Options:
    - Stick with ebs
      - no progress towards microservices
      - static environments
      - lack of flexibility
      - constant difficulty to setup qa/dev/special purpose envs
      - 0 weeks now, but 1-2 weeks for every future deployment change
    - k8s
      - most complex
      - comes with:
        - nothing
      - have to setup:
        - dns
        - cross-host networking
        - ingress
        - scheduler
      - have to learn:
        - management, rolling deploys of workers, etc.
      - new yaml config files for deploy, service, ingress, each daemon
      - 4 weeks now, 1 day for future deployment changes
      - we will get completely tied to this;q;
    - docker swarm
      - medium complex
      - comes with:
        - dns
        - cross-host networking
        - basic scheduler
      - setup:
        - ingress
      - some limitations, scheduling is basic
      - uses compose files which we already have
      - 2 weeks now, 1 day for future deployment changes
    - hashi
      - simplest conceptually
      - comes with:
        - scheduler
      - setup:
        - ingress
      - "piecemeal"
        - get a scheduler without SDN/dns/etc
      - new yaml config for jobs
      - 1-2 weeks now, 1 day for future deployment changes


  - k8s stories
    - 1223 Standup initial k8s cluster
    - 1312 cluster dns
    - 1225 verify worker rolling deploys
    - 1305 verify master rolling deploys
    - 1306 test a blue green failover
    - dev experience
    - 1307 add dns
    - 1308 add ingress
    - 1309 add dashboard
    - 1310 add logging
    - 1311 add metrics
    - 1227 port ionic apps
    - spike: how to handle pods/consul
    - 1228 port meeting router
    - 1229 update pods

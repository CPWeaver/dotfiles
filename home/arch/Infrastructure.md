
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

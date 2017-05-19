- 1) What do we want to achieve?
  - What makes an API awesome to use?
  - Awesome to work on?
- 2) What do we know?
- 2.1) What don't we know?
- 3) Lessons learned from Video in Core?
  - examples of systems that do similar things
    - video in core?
    - youtube live?
    - auth0/callstats -- js SAAS
    - pros/cons
    - api contracts from buy now?

    - questions to talk about:
      - how do you integrate with it?
      - how is it deployed?
      - how does it scale?
      - how do they approach security?
    - eat our own dogfood with contracts?
- 4) How do we want to approach the work?
  - philosophy?
  - pipeline first?
  - prototype?
  - ???




otalk/talky

- Authorization/Authentication
  - n/a
- Deprecations?
- Documentation
  - github, spotty
  - demo page
- Delivery Method/Updates
  - npm, semver releases
- Client Stuff?
  - n/a
- Communication?
  - github
- Failure Modes
  - ?? not an integrated system
- Open Source
  - 100%
- Community Contributions
  - gh
- Likes/Dislikes
  - like: modular, versioned components, good structure
  - dislike: most else -


evc
- Authorization/Authentication
  - embedded private key (!)
- Deprecations
- Documentation
- Delivery Method/Updates
  - browser URL
- Client Stuff?
- Communication?
- Failure Modes
- Open Source
- Community Contributions
- Likes/Dislikes
  - coupled
  - dislike: most else -


NOTES
-----
- recurly
  - auth: tokens
  - deprecation: ??
    - webpack will error with a message "you called foo but now you need to call bar"
  - version in URL
  - docs
    - don't show structure of nested objects
    - right side is inconsistent for showing success vs errors
  - delivery method
    - recurly.js can only be added with a script tag
    - major version only
  - failure modes
  - like
    - examples in different languages
    - client facing error messages
  - dislike
    - client token, how to test
      - BillingInfo token, can't just make a random one for testing

- auth0
  - versions

- opentok
  - auth

- twilio
  - when you sign up they give you live and test credentials
    - rooms, identity, etc all in the token
  - communication: blog
  - 3 9's, automated failover and zero maintenance windows
  - server side log aggregation, debugger within client portal




-----
  Most important aspects:
    - Split concerns
      - modular
      - compoments/microservices
    - confidence testing
      - one component
      - combinations of components
      - validation of contracts
      - app built on platform
    - As easy as plugging in a TV
    - Documentation

  Use case:
    - Screenshare
    - *DX*
    - What steps do I take as a dev to build with Foxden?

-----
  - room overview
    - angular 2 app
    - uapi - rest
    - brandx will be built on the bones of globalmeet
    - kevin osborne

##API
- "apis" should be in once place, dev dashboard, documentation etc.
  - rolls up into one view
  - SDK, js library, cocoa-pod, jar, etc.
- video or screenshare first decision pending?
  - 100s of thousands
    - if it is pixellated, laggy, etc. looks bad on us

- what are the quality params

  - avoid "can you see what I'm sharing"
    - avoid "wait we can't see that"
    - misdirected our testing early on, conentrated on FPS
      - most users are sharing PPT or word, talking 30s->5min
        - prioritize high quality over FPS
      - biggest
  - risks
    - installation
    - viewers who would see 30s or a min and then stop
      - don't realize they weren't seeing what others were seeing
    - don't crash
    - latency
    - quality degredation
    - general support, e.g. browser support
    - logging/metrics/analytics
    - framework *detection* of quality issues
  - client or server,
    - tell you to change your screenshare quality
    - QOS, prioritize audio, etc.
    - network connectivity on fortune 100 style networks

-----
infrastructure:
  - using kops, ec2, lb, dns
  - can do public lb
    - master ec2 instance in each az, kube api server and other services
      - own subnet, own asg, sg
    - kops has an instance group, ec2 inst in an az with an lc, asg, sg, ami
      - group for each type of node that you want
        - e.g. high network, high storage
        - also bootstraps the cluster,
      - pod is typically a single service
      - overlay is cluster level, not app level
      - each pod gets an ip in the network
    - ingress controller is your vhost/port LB in the controller

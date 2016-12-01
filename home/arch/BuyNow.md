Buy Now architecture

* Requirements:
    * Billing page
    * Describe plan
    * Fill credit card form
    * Future:
        * team management
        * Multple plans
        * invoices

* Functional
    * separate app, build, pipeline
    * TBD: interfaces/api?
      * URI (no query params)
      * TBD: Integration points into existing apps
      * auth
      * close button
    * TBD: Do we need a server-side component?

* Information
    * recurly as truth data?
    * Changes to auth0 (account id)
    * TBD: flow on purchase (profile reload?)
    * define data ownership, truth
    * TBD: when to expand to team model?

* Development
    * TBD: Tech stack!
    * Pipeline
    * Test coverage
    * Unit/E2Es

* Deployment
    * How bundled/packaged
    * TBD: separate container?

* Operational
    * TBD: workflow for product/sales

Tech Goals
* 100% automated tests. (mostly unit, +e2e)
* Independent from my.foxden.io, *minimize* integration
  * Avoid coupling and cross dependencies
  * new code repository
  * separate build process and artifacts
* Secure, future-compatible data flow/ownership
  * Server if necessary. No client-side hacks.
* Build and deploy pipeline in jenkins
* Use Best practices
  * Code coverage, linting, etc
* Deliver m1 fast
  * small MVP, 1-1 map login to payment
* Plan for future features
  * Don't prevent adding more
  * maybe: team management, multiple plans, more settings, account "admin" concept, combine accounts, etc.
* Great UX
  * data flow/experience upon purchase, expiration


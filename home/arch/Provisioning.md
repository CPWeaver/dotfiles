
- Talked to ZD, need a solution for the "provisioning" problem
- Currently connect team is building a service: with teh goal of registering deviceId->customer
  - Goal is to store deviceId -> customer so that we can tell who to call when an update fails
  - Was going to add rest endpoint, called during box startup, to capture device hash to beaconid (I think?)
  - basically need to tie that in to provisioning system

  - gather input from tim/taylor/(leigh?) regarding the provisioning process:
    - How do then envision this should work?
      - Assign a device to a company/account?
      - Change a device to a different account?
      - self service purchasing of a device?
      - invalidate a device (if not paid?)
      - flagging a device as "belonging" to a certain company, restrict usage to that account's members?
      - feature flags?
      - How does this tie to provisioning users?
    - What about for users?
      - AM/sales creation of accounts (ugh)
      - creation of free trials?
      - IT/admin user creation/mod/mgmt of users

    - authentication/authorization of devices for public services
        - use a JWT?
        - devices use auth0?
        - research: how does ioT handle this?
        - zd: device uses hardcoded token on board from provisioning?
    - How does this tie into the process of flashing/shipping a device?
    - How does this tie into the account management app?

  - Need to create:
    - What are immediate needs re: provisioning?
    - What's the medium/long term vision for this?
    - Setup discovery meeting, figure out vision
    - Then setup meeting with team to device how to execute on this

  - Next steps:
    - gather input from tim/taylor/etc re: provisioning process
      - devices
      - users
    x research: recurly data model
    - need to do arch. work for data flow/ownership
    - talk with: connect team regarding device provisioning
      - What are *their* goals
      - how do we uniquely identify a device
      - how to we authenticate/authorize devices
    x talk with girard: re arch options



*Functional Requirements*
  - Manage accounts
    - Create/Update/List on behalf (admin)
    - Move users/devices between accounts
    - Merge accounts
      - Self serve?
  - Manage users
    - Create/Remove/Update/List
    - change settings
  - Manage devices
    - Update/List
    - Add/Remove (???)
    - Troubleshoot
    - Track/Notify upon usage
    - Restart
    - Change settings
      - TBD: storage
    - Associate to account
    - Closed vs Open management model (shared workspace mgmt)
  - Authentication
    - Users (provided by auth0)
    - Devices (unique identification???)
      - to listen to pubsub nodes
      - to prevent malicious registration w/mtg router
  - Authorization
    - Users for usage
    - Users for features
      - upsell premium
    - Users to manage device/account
    - Device for usage
    - Users for device access (incl. x-account)
    - notification of usage
    - "provisonal" access
    - approve or deny future usage
    - list of users per device
    - time-based auth (booking/shared/etc?)
    - Expiration
  - Billing
    - View Invoices
    - Create/Update billing Info
    - Plans:
      - Free Trial
        - Do not require CC
      - Self service
      - Strategic "free indefinitely" accounts
      - Coupons "Beer Fest 2016"
      - ReferralCandy, "refer 3 friends for a free month"
      - Premium features for conversion
      - Recurring subscription based
      - possibly a device add-on sub?
        - e.g. "I want to pay to use industry's devices"
    - Usage-based billing
      - there be dragons here
    - Taxes?
    - Basic auditing for consistency between auth0 and recurly
  - Provisioning
    - Buy from sales automation tool
    - Off-prem provisioning of connects
  - Sub-accounts (e.g. deptartment level feature/user inheritance?)
    - does shared workspace strategy play here?

- non-functional
  -Consistency
  -Uptime
  - *Auditability*


*Components*
 1  - User
      - API
        - Needed for any modifications to users
      - Auth0
        - Create, update, list, delete
        - Associate user to account
        - Move user between accounts
      - Store
        - TBD: Per-user features?
        - Settings
        - Availability
 2  - Account
      - API
        - Needed for buy now v1
      - Recurly
        - Create, Update, List, delete (must be paid through recurly)
        - Subscriptions
        - Coupons
        - account-level features (tracked as subscription)
        - View invoices
      - Store
        - Free trial without CC
        - "Strategic" accounts
        - Accounts without billing
 3  - Device
      - ???
      - Store
 4  - Authorization
      - Store
        - user-level features
        - users to device
          - management
          - usage
        - approve or deny future usage
      - time-based auth
 5  - Coordination/Sync
      - Audit recurly vs auth0
      - Buy/Provision outside foxden
 6  - Internal API
 7  - Management API (external)


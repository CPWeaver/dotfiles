
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



*Requirements*
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
    - Associate to account
    - Closed vs Open management model (shared workspace mgmt)
  - Authentication
    - Users (provided by auth0)
    - Devices (unique identification???)
  - Authorization
    - Users for usage
    - Users for features
      - upsell premium
    - Users to manage device/account
    - Device for usage
    - Users for device access (incl. x-account)
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
    - Usage-based billing
      - there be dragons here
    - Taxes?
  - Provisioning
    - Buy from sales automation tool
    - Off-prem provisioning of connects
  - Sub-accounts (e.g. deptartment level feature/user inheritance?)
    - does shared workspace strategy play here?
  - non-functional
    -Consistency
    -Uptime
    - *Auditability*



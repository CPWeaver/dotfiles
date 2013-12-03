#!/bin/sh

# Log into the billing server and save your session ID to billing.cookies
wget --debug --keep-session-cookies --save-cookies billing.cookies --header="Host: vlax5:8080" --header="Content-Type: text/xml" --header="Content-Length: 187" --post-data="<?xml version="1.0" encoding="UTF-8"?><methodCall><methodName>login.login</methodName><params><param><value>usage</value></param><param><value>secret</value></param></params></methodCall>" vlax5:8080/billing/xmlrpc

# Get number of reports
wget --debug --load-cookies billing.cookies --header="Host: vlax5:8080" --header="Content-Type: text/xml" --header="Content-Length: 208" --post-data="<?xml version="1.0" encoding="UTF-8"?><methodCall><methodName>broker.getConferenceNumber</methodName><params><param><value>8667401260</value></param><param><value>4645951</value></param></params></methodCall>" vlax5:8080/billing/xmlrpc

# Get report details -- NOTE: need to get subscriptionID from previous call's response then edit this call
#wget --debug --load-cookies billing.cookies --header="Host: vlax5:8080" --header="Content-Type: text/xml" --post-data="<?xml version="1.0" encoding="UTF-8"?><methodCall><methodName>broker.getConferences</methodName><params><param><value><int>81767</int></value></param><param><value><int>4</int></value></param><param><value><int>1</int></value></param></params></methodCall>" vlax5:8080/billing/xmlrpc

# be nice and logout
wget --debug --load-cookies billing.cookies --header="Host: vlax5:8080" --header="Content-Type: text/xml" --header="Content-Length: 109" --post-data="<?xml version="1.0" encoding="UTF-8"?><methodCall><methodName>login.logout</methodName><params/></methodCall>" vlax5:8080/billing/xmlrpc

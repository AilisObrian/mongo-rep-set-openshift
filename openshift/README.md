# MongoDB Replica Set on OpenShift

This guideline is intended to be used to set up a 3 nodes replica set on OpenShift.

Mongo version:  **latest**

#### Create a template

For non persistent mongodb node
```sh
oc create -f openshift/openshift.template.yaml
```

For persistent mongodb node
```sh
oc create -f openshift/openshift.persistent.template.yaml
```

## Launch on OpenPaas Using the templates

1. Run 2 "secondary" (MONGODB_ROLE)
    * with the same KEY_REP_SET and REP_SET.
    * AUTH yes

2. Run 1 "primary" (MONGODB_ROLE)
    * with the same KEY_REP_SET and REP_SET as secondaries
    * AUTH yes
    * with MONGODB_ROOT_USER and MONGODB_ROOT_PASSWORD specified
    * with MONGODB_CONF_REPSET specified
        * {_id:'rs0',members:[{_id:1,host:'[primary_service]'},{_id:2,host:'[secondary_service_1'},{_id:3,host:'[secondary_service_2]'}]}

3. Once RepSet is fully setup and working
    * SCALE DOWN primary
    * Modify MONGODB_ROLE to secondary
    * Redeploy

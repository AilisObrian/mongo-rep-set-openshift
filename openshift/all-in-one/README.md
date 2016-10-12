# MongoDB Replica Set on OpenShift

This guideline is intended to be used to set up a 3 nodes replica set on OpenShift.

Mongo version:  **latest**

#### Create a template

For non persistent mongodb node
```sh
oc create -f openshift.template.yaml
```

For persistent mongodb node
```sh
oc create -f openshift.persistent.template.yaml
```

## Launch on OpenPaas Using the templates

1. Fill the information

3. Once RepSet is fully setup and working
    * SCALE DOWN primary (node 1)
    * Modify MONGODB_ROLE to secondary
    * Redeploy

VERSION=7.24.0

docker build -t 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/support:kie-server-${VERSION} ./kie-server/showcase-test/

docker build -t 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/support:drools-${VERSION} ./drools-wb/base/

docker push 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/support:drools-${VERSION}

docker push 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/support:kie-server-${VERSION}

oc delete configmaps  --all -n okd4-training
oc delete svc  --all -n okd4-training
oc delete dc --all -n okd4-training
oc delete routes --all -n okd4-training
oc delete pvc --all -n okd4-training

oc delete template dedalus-drools-kie

oc create -f dedalus.div.template.yml -n okd4-training

oc process -f dedalus.div.template.yml | oc create -f -

#oc scale --replicas=0 dc kie-server

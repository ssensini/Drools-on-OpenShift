##!/bin/sh
#
## ***********************************************
## KIE Server Showcase - Docker image start script
## ************************************************
#
## Program arguments
##
## -c | --container-name:    The name for the created container.
##                           If not specified, defaults to "kie-server-showcase"
## -h | --help;              Show the script usage
##
#
#CONTAINER_NAME="kie-server-showcase"
#IMAGE_NAME="jboss/kie-server-showcase"
#IMAGE_TAG="latest"
#
#
#function usage
#{
#     echo "usage: start.sh [ [-c <container_name> ] ] [-h]]"
#}
#
#while [ "$1" != "" ]; do
#    case $1 in
#        -c | --container-name ) shift
#                                CONTAINER_NAME=$1
#                                ;;
#        -h | --help )           usage
#                                exit
#                                ;;
#        * )                     usage
#                                exit 1
#    esac
#    shift
#done
#
## Check if container is already started
#if [ -f docker.pid ]; then
#    echo "Container already started"
#    container_id=$(cat docker.pid)
#    echo "Stopping container $container_id..."
#    docker stop $container_id
#    rm -f docker.pid
#fi
#
## Start the docker container
#echo "Starting $CONTAINER_NAME docker container using:"
#echo "** Container name: $CONTAINER_NAME"
#image_kie_server_workbench=$(docker run -P -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
#ip_kie_server_workbench=$(docker inspect $image_kie_server_workbench | grep \"IPAddress\" | awk '{print $2}' | tr -d '",')
#echo $image_kie_server_workbench > docker.pid
#
## End
#echo ""
#echo "Server starting in $ip_kie_server_workbench"
#echo "You can access the server root context in http://$ip_kie_server_workbench:8080"
#echo "JBoss KIE Server is running at http://$ip_kie_server_workbench:8080/kie-server"
#
#exit 0

echo "###############################"
echo "Stopping previous containers.."
echo "###############################"
docker stop $(docker ps -aq)

echo "###############################"
echo "Removing old containers..."
echo "###############################"
docker rm $(docker ps -aq)

echo "###############################"
echo "Building Drools Workbench again..."
echo "###############################"
#../../drools-wb/base-test/base/build.sh
./build.sh

echo "###############################"
echo "Starting containers..."
echo "###############################"
docker stop kie-server
docker rm kie-server
docker run -p 8080:8080 -p 8001:8001 -d --name drools-wb jboss/drools-workbench-test
docker run -p 8180:8080 -d --name kie-server --link drools-wb:kie-wb jboss/kie-server-test:latest

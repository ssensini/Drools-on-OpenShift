#################################################################################
# Dockerfile that provides the image for JBoss KIE Server 7.18.0.Final
#################################################################################

####### BASE ############
FROM 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/dedalus-s2i-ubi7-wildfly-openjdk8-jdk:14.0-3

####### MAINTAINER ############
MAINTAINER "Serena Sensini" "@TeamEA"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 7.18.0.Final
ENV KIE_CLASSIFIER ee7
ENV KIE_CONTEXT_PATH kie-server
ENV JAVA_OPTS -Xms256m -Xmx1024m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

## TEST
# ENV KIE_SERVER_ID kie-server
#ENV KIE_SERVER_LOCATION http://localhost:8180/kie-server/services/rest/server
ENV KIE_SERVER_USER kieserver
ENV KIE_SERVER_PWD kieserver1!
# When using this image against jboss/jbpm-workbench-showcase use /jbpm-console/rest/controller
# ENV KIE_SERVER_CONTROLLER http://localhost:8080/kie-wb/rest/controller
ENV KIE_SERVER_CONTROLLER_USER admin
ENV KIE_SERVER_CONTROLLER_PWD admin
#ENV KIE_MAVEN_REPO http://localhost:8180/kie-wb/maven2
ENV KIE_MAVEN_REPO_USER admin
ENV KIE_MAVEN_REPO_PASSWORD admin
ENV HOME /opt/jboss

WORKDIR $HOME

## TEST

######## KIE-SERVER ############
RUN set -eux; \
    curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/server/kie-server/$KIE_VERSION/kie-server-$KIE_VERSION-$KIE_CLASSIFIER.war && \
    unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
    touch $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
    rm -rf $HOME/$KIE_CONTEXT_PATH.war

RUN set -eux; \
    chown -R 1001:0 ${WILDFLY_HOME}; \
    chmod -R ug+rwX ${WILDFLY_HOME};
####### Drools KIE Server CUSTOM CONFIGURATION ############
#RUN mkdir -p $HOME/.m2
ADD etc/standalone-full-kie-server.xml $WILDFLY_HOME/standalone/configuration/standalone-full-kie-server.xml
ADD etc/kie-server-users.properties $WILDFLY_HOME/standalone/configuration/kie-server-users.properties
ADD etc/kie-server-roles.properties $WILDFLY_HOME/standalone/configuration/kie-server-roles.properties
ADD etc/start_kie-server.sh $WILDFLY_HOME/bin/start_kie-server.sh
ADD etc/start_kie-wb.sh $WILDFLY_HOME/bin/start_kie-wb.sh
ADD etc/settings.xml $HOME/.m2/settings.xml

## TO FIX
# Added files are chowned to root user, change it to the jboss one.
#USER root
#RUN set -eux; \
#    chown -R 1001:0 ${HOME} && \
#    chmod -R ug+rwX ${WILDFLY_HOME}/bin/;
#    chown -R 1001:0 $WILDFLY_HOME/standalone/configuration/standalone-full-kie-server.xml && \
#    chown -R 1001:0 $WILDFLY_HOME/standalone/configuration/kie-server-users.properties && \
#    chown -R 1001:0 $WILDFLY_HOME/standalone/configuration/kie-server-roles.properties && \
#    chown -R 1001:0 $WILDFLY_HOME/bin/start_kie-server.sh;
#    chown -R 1001:0 ${HOME}/.m2/settings.xml;
#
####### INSTALL PACKAGES ######
#RUN set -eux; \
#    yum install -y net-tools
#
###### SWITCH BACK TO jboss ####
##USER jboss
#
######## SCRIPTS ############
##USER root


#RUN set -eux; \
#    chown -R 1001:0 ${WILDFLY_HOME}/bin/start_kie-wb.sh; \
#    chmod -R ug+rwX ${WILDFLY_HOME}/bin/start_kie-wb.sh;
#RUN chown jboss:jboss $JBOSS_HOME/bin/start_kie-wb.sh

####### CUSTOM JBOSS USER ############
# Switchback to jboss user
#USER jboss
USER 1001

EXPOSE 8080

####### RUNNING DROOLS-WB ############
WORKDIR $WILDFLY_HOME/bin/
ENTRYPOINT ["./start_kie-server.sh"]

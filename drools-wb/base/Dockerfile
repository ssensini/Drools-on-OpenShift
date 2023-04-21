###########################################################################
# Dockerfile that provides the image for JBoss Drools Workbench 7.24.0.Final
###########################################################################

####### BASE ############
# FROM jboss/wildfly:14.0.1.Final
FROM 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/dedalus-s2i-ubi8-wildfly-openjdk8-jdk:14.0-9

####### MAINTAINER ############
MAINTAINER "Serena Sensini" "@TeamEA"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 7.24.0.Final
ENV KIE_CLASSIFIER wildfly14
ENV KIE_CONTEXT_PATH business-central
ENV JAVA_OPTS -Xms256m -Xmx2048m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8
ENV HOME /opt/jboss
ENV KIE_DEMO false

## TOBE: CHANGES NEEDED TO HAVE A SHOWCASE
# Use demo and examples by default in this showcase image (internet connection required).
ENV KIE_SERVER_PROFILE standalone-full-drools

WORKDIR $HOME

####### DROOLS-WB ############
RUN curl -o /tmp/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/business-central/$KIE_VERSION/business-central-$KIE_VERSION-$KIE_CLASSIFIER.war && \
    unzip -q /tmp/$KIE_CONTEXT_PATH.war -d $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war && \
    touch $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
    rm -rf /tmp/$KIE_CONTEXT_PATH.war;

####### SCRIPTS ############
RUN set -eux; \
    chown -R 1001:0 ${WILDFLY_HOME}; \
    chmod -R ug+rwX ${WILDFLY_HOME};

COPY etc/start_drools-wb.sh $WILDFLY_HOME/bin/start_drools-wb.sh

## TOBE: CHANGES NEEDED TO HAVE A SHOWCASE
####### Drools Workbench CUSTOM CONFIGURATION ############
COPY etc/standalone-full-drools.xml $WILDFLY_HOME/standalone/configuration/standalone-full-drools.xml
COPY etc/drools-users.properties $WILDFLY_HOME/standalone/configuration/drools-users.properties
COPY etc/drools-roles.properties $WILDFLY_HOME/standalone/configuration/drools-roles.properties

COPY etc/ErraiService.properties $WILDFLY_HOME/standalone/deployments/business-central.war/WEB-INF/classes/ErraiService.properties

COPY templates/dedalus.template.yml /opt/dedalus/templates/dedalus.template.yml

####### CUSTOM JBOSS USER ############
USER 1001

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING DROOLS-WB ############
WORKDIR $WILDFLY_HOME/bin/

ENTRYPOINT ["./start_drools-wb.sh"]

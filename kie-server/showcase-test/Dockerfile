#################################################################################
# Dockerfile that provides the image for JBoss KIE Server 7.24.0.Final
#################################################################################

####### BASE ############
FROM 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/dedalus-s2i-ubi8-wildfly-openjdk8-jdk:14.0-9

####### MAINTAINER ############
MAINTAINER "Serena Sensini" "@TeamEA"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 7.24.0.Final
ENV KIE_CLASSIFIER ee8
ENV KIE_CONTEXT_PATH kie-server
ENV JAVA_OPTS -Xms256m -Xmx1024m -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8

ENV KIE_SERVER_USER kieserver
ENV KIE_SERVER_PWD kieserver1!
ENV KIE_SERVER_CONTROLLER_USER admin
ENV KIE_SERVER_CONTROLLER_PWD admin
ENV KIE_MAVEN_REPO_USER admin
ENV KIE_MAVEN_REPO_PASSWORD admin
ENV HOME /opt/jboss

WORKDIR $HOME

## TEST

######## KIE-SERVER ############
RUN set -eux; \
    curl -o /tmp/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/server/kie-server/$KIE_VERSION/kie-server-$KIE_VERSION-$KIE_CLASSIFIER.war && \
    unzip -q /tmp/$KIE_CONTEXT_PATH.war -d $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
    touch $WILDFLY_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
    rm -rf /tmp/$KIE_CONTEXT_PATH.war

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

####### CUSTOM JBOSS USER ############
USER 1001

EXPOSE 8080

####### RUNNING DROOLS-WB ############
WORKDIR $WILDFLY_HOME/bin/
ENTRYPOINT ["./start_kie-server.sh"]

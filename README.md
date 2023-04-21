Drools Workbench and KIE Server - Docker images
===============================================

JBoss Drools Workbench and KIE Server [Docker](http://docker.io/) images.

Table of contents
------------------

* Introduction
* Drools Workbench
    * Usage
        * Docker or Podman
        * Docker Compose
        * OpenShift
* KIE Server description
    * Usage
        * Docker or Podman
        * Docker Compose
        * OpenShift
 
Introduction
===============
These images use UBI7 base image provided by EA Team @ Dedalus, that meet all the OpenShift requirements. Both images are showcase use cases; check the Dockerfiles for further information.

The repository has intended to be used with Docker, Podman (for containerization or podification), Docker Compose (see the docker-compose.yml file), K8S or OpenShift and it has been tested for all these platforms.

> To enable *persistence*, use a volume previously created called drools-git that needs to be mounted on `/wildfly/bin/.niogit` path.

Drools Workbench
================

Officially, there are two available images:                

**Drools Workbench**

It's the base Docker image for Drools Workbench. Its purpose is to be used as base for extending and creating your own images that uses Drools Workbench.                      
 
**Drools Workbench showcase**

It inherits from Drools Workbench image and provides a **ready to run Docker image for Drools Workbench**.                 
It provides some custom configurations and default users and roles to try and test the workbench.           

## Usage

### Docker or Podman

Check internal README.md.

### Docker Compose
Drools Workbench is represented by *business-central* service and can run as standalone service. To test it without the KIE server, just comment the *kie-server* service and run

`docker-compose up --build`

KIE Server
==========

Officially, KIE Server provides a standalone Drools execution environment to execute your Drools rules.                        

There are two available images:                

**KIE Server**

It's the base Docker image for KIE Server. Its purpose is to be used as base for extending and creating your own images that uses KIE Server runtime environment.                      
 
**KIE Server showcase**

It inherits from KIE Server Workbench image and provides a **ready to run Docker image for KIE Server**.                 
It provides a default users and role to try and test the KIE server.             

## Usage

### Docker or Podman

Check internal README.md.

### Docker Compose
KIE server is represented by *kie-server* service and cannot run as standalone service. To test it with the KIE server, run

`docker-compose up --build`

### OpenShift
Import _dedalus.template.yaml_ template in the OpenShift Web Console and start it through the Catalog.

While Drools can run as standalone, KIE Server can't, so using the single templates will start them in OpenShift, but won't make them able to connect to each other. This is due the environment configuration of the following variables that are required to make the websocket work.

```
- KIE_SERVER_LOCATION (i.e.: http://kie-server:8080/kie-server/services/rest/server)
- KIE_MAVEN_REPO (i.e.: http://business-central:8080/business-central/maven2)
- KIE_SERVER_CONTROLLER (i.e.: http://business-central:8080/business-central/rest/controller)

```

> The workbench stores its data, by default in the directory $WILDFLY_HOME=/wildfly/.niogit , for example /wildfly/bin/.
> gitnio

# Changelog 
- 7.24.0 with UBI8 working correctly
- 7.18.0 with UBI7 reported a bug on session, deprecated due to UBI7 EOL


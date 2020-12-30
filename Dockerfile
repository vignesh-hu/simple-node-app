# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && mkdir /opt/connectleader/ \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && yum install -y tar* \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R root:root ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}


# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

#RUN yum install epel-release -y
#RUN yum install jq -y

ARG APP_FILE=/tmp/appfile.war
# Add your application to the deployment folder
COPY ${APP_FILE} /opt/connectleader/wildfly/standalone/deployments/${APP_FILE}

USER root

# Expose the ports we're interested in
EXPOSE 80
EXPOSE 8080

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/connectleader/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]

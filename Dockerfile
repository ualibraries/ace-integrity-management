FROM payara/server-full:5.181

ENV ACE_V=1.11 ACE_AUDIT_TAR=ace-am-1.11-RELEASE MAVEN_V=3.5.3 MAVEN=apache-maven-3.5.3 MYSQL_JCONNECT_V=5.1.46 MYSQL_JCONNECT=mysql-connector-java-5.1.46

RUN \
mkdir -p build && cd build && \
curl -kL https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JCONNECT_V.tar.gz | tar xz && \
cp $MYSQL_JCONNECT/$MYSQL_JCONNECT-bin.jar ../glassfish/domains/domain1/lib && \
curl -kL http://apache.claz.org/maven/maven-3/$MAVEN_V/binaries/$MAVEN-bin.tar.gz | tar xz && \
git clone https://gitlab.umiacs.umd.edu/adapt/ace.git && \
cd ace && ../$MAVEN/bin/mvn package && \
cp ace-ims-ear/target/ace-ims.ear ../../glassfish/domains/domain1/autodeploy && \
cd ../.. && rm -fr build && rm -fr .m2

COPY docker/opt.payara5.glassfish.domains.domain1.config.domain.xml \
glassfish/domains/domain1/config/domain.xml

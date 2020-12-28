mvn package
mkdir release
cp target/minimal-1.war release
java -jar tomcat.jar --port 4300 --temp-directory /tmp release/minimal-1.war

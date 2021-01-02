# minimal

โครงการนี้มีชื่อว่า minimal เป็นการสร้างระบบพัฒนา 
Software ตามแนวคิด Software Engineering 
รองรับ Software ทุกชนิด เริ่มตั้งแต่ Fundamental Activity 
เช่น Software Specification มีระบบการเขียน 
Requirement แบบ XML แสดงผลเข้าใจได้ง่าย ปรับแก้ข้อมูลแล้ว 
Push ลง Git หรือ Version Control ได้ทันที

Web Service เขียนด้วย Java 15 ใหม่ล่าสุด 
มี Single Page Web Application 
เขียนด้วย Vanilla JavaScript ตอนนี้ใช้ 
Bootstrap 5 Beta 1 
มี Light Mode และ Dark Mode เปลี่ยนตามเวลาของผู้ใช้

ใช้ได้บนอุปกรณ์ทุกชนิด ทั้ง iPhone, iPad และ Computer ทุกระบบ 
ผู้ใช้ไม่ต้องติดตั้งอะไรทั้งสิ้น ใช้ Web Browser ทั่วไป 
Build Project ที่ต้องการได้ทันที

ลองไป Clone และสร้าง Pull Request กันได้ที่นี่ 
https://github.com/kookiatsuetrong/minimal

The project “minimal” is an integrated development environment 
that follows software engineering process. It supports all type 
of software, starting from software specification. 
It accepts requirements in XML format so all requirements can 
store in Git or any version control system.

The web service written in Java 15, with a single page web 
application written in Vanilla JavaScript. Currently it uses 
Bootstrap 5 Beta 1 with light and dark mode depends on the 
timezone of user.

It can run on any modern web browser, on iPhone, iPad and a 
computer. No additional software to download, just open the web 
browser and build any project from minimal.

Try to clone and create a pull request from here: 
https://github.com/kookiatsuetrong/minimal


## Installation

Download JDK 15, e.g. SapMachine
```
wget https://github.com/SAP/SapMachine/releases/download\
/sapmachine-15.0.1/sapmachine-jdk-15.0.1_linux-x64_bin.tar.gz
```

Extract and move to any directory
```
tar -xf sapmachine-jdk-15.0.1_linux-x64_bin.tar.gz
sudo mv sapmachine-jdk-15.0.1 /var
```

Export the directory to everyone
```
export PATH=/var/sapmachine-jdk-15.0.1/bin:$PATH
```

Download Tomcat latest version, and start it up
```
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.zip
unzip apache-tomcat-9.0.41.zip
mv apache-tomcat-9.0.41 tomcat
chmod +x tomcat/bin/*.sh
tomcat/bin/startup.sh
```

Download and deploy
```
wget https://codestar.work/minimal.war
mv tomcat/webapps/ROOT tomcat/webapps/ROOT-ORIGINAL
cp minimal.war tomcat/webapps/ROOT.war
```

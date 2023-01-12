FROM redhat/ubi8

RUN yum update -y && yum install -y httpd

EXPOSE 8081

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

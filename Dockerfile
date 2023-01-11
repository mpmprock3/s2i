FROM redhat/ubi8

RUN yum update -y && yum install -y httpd

USER 0:0

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

FROM redhat/ubi8

RUN yum update -y && yum install -y httpd

RUN adduser -D -u 1000 httpd

USER httpd

EXPOSE 8081

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

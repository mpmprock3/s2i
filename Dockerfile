FROM redhat/ubi8

RUN yum update -y && yum install -y httpd

# Add a user and group for running httpd
RUN groupadd -g 1000700001 -r httpd && \
    useradd -u 1000700001 -r -g httpd -s /sbin/nologin -c "Apache HTTP Server" httpd

# Update ownership and permissions for the run directory
RUN chown -R httpd:httpd /run/httpd && \
    chmod 755 /run/httpd

# Update ownership and permissions for the httpd config file
RUN chown -R httpd:httpd /etc/httpd && \
    chmod 644 /etc/httpd/conf/httpd.conf

# Update permissions for the httpd binary
RUN chmod 755 /usr/sbin/httpd

# Run the httpd server as the httpd user

USER httpd

EXPOSE 8081

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

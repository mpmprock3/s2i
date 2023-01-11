FROM redhat/ubi8

# Update packages and install httpd
RUN yum update -y && yum install -y httpd

# Add a user and group for running httpd
RUN groupadd -g 99 -r httpd && \
    useradd -u 99 -r -g httpd -s /sbin/nologin -c "Apache HTTP Server" httpd

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
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
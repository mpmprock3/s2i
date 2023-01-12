## Dockerfile Explanation

Run httpd user with non-root privilege.

- UID and GID in container is 1000700001 

```
# Add a user and group for running httpd
RUN groupadd -g 1000700001 -r httpd && \
useradd -u 1000700001 -r -g httpd -s /sbin/nologin -c "Apache HTTP Server" httpd
```

## Build docker image using dockerfile locally and running locally

```
#ls
dockerfile

# docker build -t my-rhel8-httpd .

# docker images
REPOSITORY            TAG         IMAGE ID      CREATED       SIZE
my-rhel8-httpd          latest       849e5bb328b6    14 seconds ago   232 MB

# docker tag my-rhel8-httpd quay.io/mapandey/my-rhel8-httpd:latest

# docker push quay.io/mapandey/my-rhel8-httpd:latest

# docker run -p 8081:80 my-rhel8-httpd

```


## Deployment yaml file explanation

Create serviceAccount with anyuid scc otherwise OpenShift will overwrite with runAsUser specified in project

```bash
$ oc create sa httpd
$oc adm policy add-scc-to-user anyuid -z httpd
```

- Add serviceAccount to deployment.yaml file

```
spec:
  containers:
    serviceAccountName: httpd
    serviceAccount: httpd
```

- It need CAP_NET_BIND_SERVICE capability otherwise container will fail to bind lower than 1024 port number.

```
(13)Permission denied: AH00072: make_sock: could not bind to address [::]:80
(13)Permission denied: AH00072: make_sock: could not bind to address 0.0.0.0:80
```

- Add these capabilites in deployment.yaml file.

```
spec:
  containers:
    securityContext:
      capabilities:
        add:
        - CAP_NET_BIND_SERVICE
      privileged: true
```


## Contributors

- [Manish Pandey](@mpmprock3)


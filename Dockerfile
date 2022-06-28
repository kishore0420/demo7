FROM ubuntu:latest
ENV http_proxy http://host.docker.internal:3128
ENV https_proxy http://host.docker.internal:3128
RUN apt-get update && apt-get install nginx -y
RUN rm -rf /var/www/html/
COPY ./index.html /var/www/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

FROM nginx:alpine
LABEL maintainer="duvan.ballen@gmail.com"
ADD index.html /usr/share/nginx/html/

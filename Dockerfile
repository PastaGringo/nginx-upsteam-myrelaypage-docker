FROM nginx:stable-alpine
RUN apk add iputils-ping
COPY default.conf.template /etc/nginx/templates/default.conf.template
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
EXPOSE 80/tcp
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

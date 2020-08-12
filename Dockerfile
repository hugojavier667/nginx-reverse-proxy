FROM nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=CL/ST=Warwickshire/L=Leamington/O=Chattigo/OU=IT Department/CN=chattigo.com"

RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

ADD ./conf /etc/nginx/conf.d

EXPOSE 80

EXPOSE 443
# PROXY REVERSO CON SSL

## Pasos para levantar local con docker-compose

1- Definir las reglas de redirección para las diferentes apps. Ya sea local o remoto a un ambiente qa.

2- Definir un host en el sistema que traduzca un subdominio xxxxx.chattigo.com a localhost, para que trabaje con el mismo dominio con el que se configuran las cookies en el bff portal login.

3- Levantar el docker-compose y acceder por el navegador al dominio xxxxx.chattigo.com.

4- Todos los fronts que se levanten deben ser accedidos desde el dominio xxxxx.chattigo.com usando https para que las cookies que llevan el flag Secure funcionen.

Para probar con Postman se debe deshabilitar la verificación del certificado ssl

## Ejemplos

### Para consumir un servicio que está en qa

La siguiente regla:
```nginx
location /bff-qa/ {
    proxy_pass https://generic-qa.chattigo.com/;
}
```
traduce la url https://localhost/bff-qa/bff-portal-login/auth/user-info 

a https://generic-qa.chattigo.com/bff-portal-login/auth/user-info

### Para consumir un servicio local

La siguiente regla:
```nginx
location / {
    proxy_pass http://localhost:4201/;
}
```
traduce la url https://localhost/ 

a http://localhost:4201/

La siguiente regla:
```nginx
location /bff-local/ {
    proxy_pass http://localhost:3000/;
}
```
traduce la url https://localhost/bff-local/path/servicio 

a http://localhost:3000/path/servicio

### Para levantar un bff de websocket

```nginx
location /bff-qa-ws/ {
    proxy_pass https://generic-qa.chattigo.com/;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";
    proxy_set_header Host $host;
}
```

## Enlaces revisados
- Pa generar el certificado ssl autofirmado [link](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7)

- Definición de hosts localmente [link](https://www.liquidweb.com/kb/edit-host-file-windows-10/)

- Websocket con NGINX [link](https://www.nginx.com/blog/websocket-nginx/)
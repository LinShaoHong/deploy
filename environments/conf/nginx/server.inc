resolver nameserver valid=10s;

server {
    listen       80;
    server_name  localhost;

    location /image/ {
        add_header Cache-Control no-cache;
        alias /data/static/image/;
    }

    location /sun-console/ {
        try_files $uri $uri/ @router;
        index  index.html index.htm;
        alias /data/web/sun_console/;
    }

    location /meizi/ {
        try_files $uri $uri/ @router;
        index  index.html index.htm;
        alias /data/web/meizi/;
    }

    location @router {
        rewrite ^.*$ /index.html last;
    }

    location /api/ {
        proxy_pass "http://rest-server:9729";
    }
}

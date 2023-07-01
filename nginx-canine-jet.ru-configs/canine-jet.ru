server {
        root /var/www/canine-jet.ru/html;
        index index.html index.htm index.nginx-debian.html;

        server_name canine-jet.ru www.canine-jet.ru;

        location / {
                try_files $uri $uri/ =404;
        }

    	listen [::]:443 ssl; # managed by Certbot
    	listen 443 ssl; # managed by Certbot
    	ssl_certificate /etc/letsencrypt/live/canine-jet.ru-0001/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/canine-jet.ru-0001/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


	location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
}

server {
    	if ($host = www.canine-jet.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot

    	if ($host = canine-jet.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot


        listen 80;

        server_name canine-jet.ru www.canine-jet.ru;
	return 404; # managed by Certbot
}

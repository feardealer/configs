map $http_upgrade $connection_upgrade {
  default upgrade;
  '' close;
}

server {
  	listen 443 ssl;

  	server_name rss.canine-jet.ru;
	
	location / {
		return 301 /tt-rss/;
	}

        location /tt-rss/ {
		proxy_set_header Host $http_host;
	   	proxy_set_header X-Forwarded-Proto $scheme;
		proxy_pass http://localhost:8280;
        }
    	ssl_certificate /etc/letsencrypt/live/canine-jet.ru-0001/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/canine-jet.ru-0001/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

	location /api/live {
        	proxy_http_version 1.1;
        	proxy_set_header Upgrade $http_upgrade;
          	proxy_set_header Connection $connection_upgrade;
          	proxy_set_header Host $http_host;
           	proxy_pass http://localhost:8280;
	}





}


server {
   	if ($host = rss.canine-jet.ru) {
        	return 301 https://$host$request_uri;
    	} # managed by Certbot


  	listen 80;

  	server_name rss.canine-jet.ru;
    	return 404; # managed by Certbot


}

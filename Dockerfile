FROM phpmyadmin:latest

LABEL maintainer="devpandai <you@example.com>"

# Optional: konfigurasi default
ENV PMA_ARBITRARY=1
ENV PMA_HOST=mysql
ENV PMA_USER=root
ENV PMA_PASSWORD=rootpassword

EXPOSE 80
CMD ["apache2-foreground"]

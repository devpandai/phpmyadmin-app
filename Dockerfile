FROM phpmyadmin:latest

LABEL maintainer="devpandai <you@example.com>"

EXPOSE 80
CMD ["apache2-foreground"]

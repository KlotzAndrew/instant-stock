FROM nginx

RUN rm /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD service nginx start

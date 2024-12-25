# Menggunakan base image resmi RStudio
FROM rocker/rstudio:latest

# Memasang Nginx untuk proxy
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Mengatur environment variables untuk RStudio Server
ENV PASSWORD=12345
ENV USER=rstudio

# Membuka port 80 untuk Railway
EXPOSE 80

# Menambahkan file konfigurasi default RStudio Server
RUN echo "www-address=0.0.0.0" >> /etc/rstudio/rserver.conf

# Menambahkan konfigurasi Nginx untuk proxy
RUN echo 'server { \
    listen 80; \
    location / { \
        proxy_pass http://127.0.0.1:8787; \
        proxy_set_header Host $host; \
        proxy_set_header X-Real-IP $remote_addr; \
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \
    } \
}' > /etc/nginx/sites-available/default

# Menjalankan Nginx dan RStudio Server bersamaan
CMD service nginx start && rserver --server-user rstudio

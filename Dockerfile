# Menggunakan base image resmi RStudio
FROM rocker/rstudio:latest

# Mengatur environment variables untuk RStudio Server
ENV PASSWORD=12345  # Ganti dengan password sesuai kebutuhan Anda
ENV USER=rstudio    # Username default

# Memasang dependencies tambahan (opsional, jika dibutuhkan)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && apt-get clean

# Membuka port yang digunakan RStudio Server
EXPOSE 8787

# Menambahkan file konfigurasi default RStudio Server (opsional)
RUN echo "www-address=0.0.0.0" >> /etc/rstudio/rserver.conf

# Menjalankan RStudio Server
CMD ["rserver", "--server-user", "rstudio"]

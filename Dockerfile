# Use the official Nginx image as the base image
FROM nginx:latest

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom Nginx configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set up PHP-FPM and PHP extensions required by Lumen
RUN apt-get update && apt-get install -y \
    sqlite3 \
    php8.2 \
    php8.2-sqlite3 \
    php8.2-fpm \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Copy the Laravel application into the container
COPY . /var/www/html

# Allow writing to the SQLite database file
RUN chmod -R 755 /var/www/html/database/skimpy.sqlite

# Set Laravel/Lumen storage permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html/storage

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx
CMD service php8.2-fpm start && nginx -g "daemon off;"
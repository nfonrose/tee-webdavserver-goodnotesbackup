FROM httpd:2.4

# Install necessary packages
RUN apt-get update && \
    apt-get install -y apache2-utils curl gnupg lsb-release && \
    rm -rf /var/lib/apt/lists/*

    # Create log directory for Apache
RUN mkdir -p /var/log/apache2 && \
    chown www-data:www-data /var/log/apache2 && \
    chmod 755 /var/log/apache2

# Set global ServerName to suppress FQDN warning
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf

# Integrate the Apache configuration file
COPY ./conf/apache-static-content.conf /usr/local/apache2/conf/extra/apache-static-content.conf

# Include the custom configuration in the main Apache configuration
RUN echo "Include /usr/local/apache2/conf/extra/apache-static-content.conf" >> /usr/local/apache2/conf/httpd.conf

# Copy the wwwroot content to the Apache document root
COPY ./wwwroot /usr/local/apache2/htdocs

# Expose standard Apache port (internal, behind nginx)
EXPOSE 80
CMD ["httpd-foreground"]

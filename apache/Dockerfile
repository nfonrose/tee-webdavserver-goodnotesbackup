FROM httpd:2.4

# Install necessary packages
RUN apt-get update && \
    apt-get install -y apache2-utils cron && \
    rm -rf /var/lib/apt/lists/*

# Enable WebDAV modules
RUN a2enmod dav dav_fs auth_digest auth_basic

# Copy custom WebDAV config
COPY conf/extra/webdav.conf /usr/local/apache2/conf/extra/webdav.conf

# Include WebDAV config in main Apache config
RUN echo "Include conf/extra/webdav.conf" >> /usr/local/apache2/conf/httpd.conf

# Create scripts directory
COPY scripts /usr/local/bin/scripts
RUN chmod +x /usr/local/bin/scripts/*.sh

# Expose standard Apache port (internal, behind nginx)
EXPOSE 80
CMD ["httpd-foreground"]

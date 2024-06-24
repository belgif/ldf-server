FROM node:18-slim

# Install the node module
RUN apt-get update && \
    apt-get -y install g++ make python3 && \
    npm install -g @ldf/server @ldf/datasource-hdt hdt && \
    apt-get remove -y g++ make python && apt-get autoremove -y && \
    rm -rf /var/cache/apt/archives

# Expose the default port
EXPOSE 3000

# Run base binary
WORKDIR /var/www

COPY config.json datagovbe.hdt /var/www

RUN chown -R www-data:www-data /var/www

USER www-data

# Default command
CMD ["ldf-server", "/var/www/config.json"]

# Start with a Debian base image
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip lib32gcc-s1 procps && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /terraria-server

# Download and extract the Terraria server files
RUN wget -q https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip && \
    unzip terraria-server-1449.zip -d /terraria-server && \
    rm terraria-server-1449.zip && \
    chmod +x /terraria-server/1449/Linux/TerrariaServer.bin.x86_64

# Expose port
EXPOSE 7777

# Persistent data
VOLUME ["/terraria-server/1449/Linux/worlds"]

# Copy server startup script if needed
COPY start-server.sh /terraria-server/start-server.sh
RUN chmod +x /terraria-server/start-server.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD pgrep TerrariaServer || exit 1

# Start the server
ENTRYPOINT ["/terraria-server/start-server.sh"]

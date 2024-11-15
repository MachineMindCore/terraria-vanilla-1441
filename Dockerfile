# Start with a Debian base image
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget zip unzip lib32gcc-s1 procps ssh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /terraria-server

# Download and extract the Terraria server files
RUN wget -q https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
RUN unzip terraria-server-1449.zip -d /terraria-server
RUN rm terraria-server-1449.zip

# Add worlds backup folder
RUN mkdir /terraria-server/worlds

RUN mv /terraria-server/1449/Linux/* /terraria-server/
RUN rm -rf /terraria-server/1449
RUN chmod +x /terraria-server/TerrariaServer 
RUN chmod +x /terraria-server/TerrariaServer.exe 
RUN chmod +x /terraria-server/TerrariaServer.bin.x86_64

# Expose port
EXPOSE 7777

# Copy server startup script if needed
COPY start-server.sh /terraria-server/start-server.sh
COPY backup.sh /terraria-server/backup.sh
RUN chmod +x /terraria-server/backup.sh
RUN chmod +x /terraria-server/start-server.sh

VOLUME [ "/root/.local/share/Terraria/" ]

# Start the server
ENTRYPOINT ["/terraria-server/start-server.sh"]

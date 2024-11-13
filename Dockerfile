# Start with a Debian base image
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip lib32gcc-s1 procps ssh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /terraria-server

# Download and extract the Terraria server files
RUN wget -q https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip
RUN unzip terraria-server-1449.zip -d /terraria-server
RUN rm terraria-server-1449.zip

RUN mv /terrraia-server/1449/Linux/* /terraria-server/
RUN rm -rf /terraria-server/1449
RUN chmod +x /terraria-server/TerrariaServer 
RUN chmod +x /terraria-server/TerrariaServer.exe 
RUN chmod +x /terraria-server/TerrariaServer.bin.x86_64

# Expose port
EXPOSE 7777

# Persistent data
VOLUME ["/terraria-server/1449/Linux/worlds"]

# Copy server startup script if needed
COPY start-server.sh /terraria-server/start-server.sh
RUN chmod +x /terraria-server/start-server.sh

# Start the server
ENTRYPOINT ["/terraria-server/start-server.sh"]

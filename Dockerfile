# Start with a Debian base image
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip lib32gcc-s1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /terraria-server

# Download and extract the Terraria server files
RUN wget -q https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip && \
    unzip terraria-server-1449.zip -d /terraria-server && \
    rm terraria-server-1449.zip

# Expose port
EXPOSE 7777

# Persisten data
VOLUME ["/terraria-server/1449/Linux/worlds"]

# Ban pipipi and marlon
ENTRYPOINT ["/bin/bash"]

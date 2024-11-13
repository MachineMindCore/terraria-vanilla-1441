FROM debian:bullseye AS base

# Install necessary libraries for compatibility
RUN apt-get update && apt-get install -y unzip wget libgdiplus

# Set environment variable to disable Windows Forms
ENV MONO_MWF_USE_WINDOWS_FALSE=1

# Download and set up Terraria server
ENV DL_LINK=https://terraria.org/api/download/pc-dedicated-server/terraria-server-1441.zip
ENV DL_VERSION=1441
ENV DL_FILE=terraria-server-1441.zip

ADD $DL_LINK /$DL_FILE

RUN unzip /$DL_FILE -d /terraria
RUN ls /terraria/$DL_VERSION/Linux
RUN mv /terraria/$DL_VERSION/Linux/* /terraria-server


# Copy bootstrap script
COPY bootstrap.sh /terraria-server/bootstrap.sh

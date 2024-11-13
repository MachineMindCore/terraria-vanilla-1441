#!/bin/bash

# Run the Terraria server in a screen session
screen -dmS terraria ./1449/Linux/TerrariaServer.bin.x86_64 -config /terraria-server/serverconfig.txt

# Keep the container running
tail -f /dev/null

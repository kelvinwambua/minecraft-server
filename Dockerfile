FROM openjdk:17-slim

WORKDIR /minecraft

# Download Minecraft server (using 1.20.4 as example - change version as needed)
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar -O minecraft_server.jar && \
    apt-get clean

# Accept EULA
RUN echo "eula=true" > eula.txt

# Expose Minecraft port
EXPOSE 25565

# Start server with memory settings
CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "minecraft_server.jar", "nogui"]

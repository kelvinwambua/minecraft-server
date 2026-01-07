FROM eclipse-temurin:17-jre-jammy

WORKDIR /minecraft

# Install wget
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Download Minecraft server (1.20.4 - change version if needed)
RUN wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar -O minecraft_server.jar

# Accept EULA
RUN echo "eula=true" > eula.txt

# Expose Minecraft port
EXPOSE 25565

# Start server with memory settings
CMD ["java", "-Xmx3G", "-Xms3G", "-jar", "minecraft_server.jar", "nogui"]

FROM eclipse-temurin:17-jre-jammy

WORKDIR /minecraft

# Install wget
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Download Minecraft server
RUN wget -O server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

# Accept EULA
RUN echo "eula=true" > eula.txt

# Create server.properties to point world to /data
RUN echo "level-name=/data/world" > server.properties

EXPOSE 25565

# Start server
CMD ["java", "-Xmx3G", "-Xms3G", "-jar", "server.jar", "nogui"]

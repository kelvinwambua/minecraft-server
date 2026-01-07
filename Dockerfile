FROM eclipse-temurin:17-jre-jammy

# Install wget
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean

# Create minecraft directory and set as workdir
WORKDIR /minecraft

# Download Minecraft server jar
RUN wget -O minecraft_server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

# Accept EULA
RUN echo "eula=true" > eula.txt

# Create a startup script to ensure files exist
RUN echo '#!/bin/bash\n\
if [ ! -f minecraft_server.jar ]; then\n\
    echo "Downloading Minecraft server..."\n\
    wget -O minecraft_server.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar\n\
fi\n\
if [ ! -f eula.txt ]; then\n\
    echo "eula=true" > eula.txt\n\
fi\n\
exec java -Xmx3G -Xms3G -jar minecraft_server.jar nogui' > /start.sh && \
    chmod +x /start.sh

# Expose Minecraft port
EXPOSE 25565

# Use the startup script
CMD ["/start.sh"]
```

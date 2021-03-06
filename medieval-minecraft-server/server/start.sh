#!/usr/bin/env bash
# Start script generated by ServerPackCreator.
# This script checks for the Minecraft and Forge JAR-Files, and if they are not found, they are downloaded and installed.
# If everything is in order, the server is started.

JAVA="java"
MINECRAFT="1.18.2"
FABRIC="0.14.6"
INSTALLER="0.11.0"
ARGS=""
OTHERARGS="-Dlog4j2.formatMsgNoLookups=true"

if [[ ! -s "fabric-server-launch.jar" ]];then

  echo "Fabric Server JAR-file not found. Downloading installer...";
  curl https://maven.fabricmc.net/net/fabricmc/fabric-installer/$INSTALLER/fabric-installer-$INSTALLER.jar --output fabric-installer.jar ;

  if [[ -s "fabric-installer.jar" ]];then

    echo "Installer downloaded. Installing...";
    java -jar fabric-installer.jar server -mcversion $MINECRAFT -loader $FABRIC -downloadMinecraft;

    if [[ -s "fabric-server-launch.jar" ]];then
      rm -rf .fabric-installer;
      rm -f fabric-installer.jar;
      echo "Installation complete. fabric-installer.jar deleted.";
    fi

  else
    echo "fabric-installer.jar not found. Maybe the Fabric server are having trouble.";
    echo "Please try again in a couple of minutes.";
  fi
else
  echo "fabric-server-launch.jar present. Moving on...";
fi

if [[ ! -s "server.jar" ]];then
  echo "Minecraft Server JAR-file not found. Downloading...";
  curl https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar --output server.jar ;
else
  echo "server.jar present. Moving on...";
fi

if [[ ! -s "eula.txt" ]];then
  echo "Mojang's EULA has not yet been accepted. In order to run a Minecraft server, you must accept Mojang's EULA."
  echo "Mojang's EULA is available to read at https://account.mojang.com/documents/minecraft_eula"
  echo "If you agree to Mojang's EULA then type 'I agree'"
  read ANSWER
  if [[ "$ANSWER" = "I agree" ]]; then
    echo "User agreed to Mojang's EULA."
    echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)." > eula.txt;
    echo "eula=true" >> eula.txt;
  else
    echo "User did not agree to Mojang's EULA."
  fi
else
  echo "eula.txt present. Moving on...";
fi

echo "Starting server...";
echo "Minecraft version: $MINECRAFT";
echo "Fabric version: $FABRIC";
echo "Java version:"
$JAVA -version
echo "Java args: $ARGS";

$JAVA $OTHERARGS $ARGS -jar fabric-server-launch.jar nogui
#!/bin/bash

# Define the URL for JDK download
jdk_url="https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb"

# Define the installation directory
install_dir="/opt/jdk"

# Download JDK
echo "Downloading JDK..."
wget --quiet --show-progress --progress=bar:force:noscroll -O /tmp/jdk.deb "$jdk_url"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download JDK."
    exit 1
fi

# Install JDK
echo "Installing JDK..."
sudo dpkg -i /tmp/jdk.deb
sudo apt-get install -f

# Check if the installation was successful
if [ $? -ne 0 ]; then
    echo "Failed to install JDK."
    exit 1
fi

# Set JAVA_HOME
echo "export JAVA_HOME=$install_dir" | sudo tee -a /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" | sudo tee -a /etc/profile
sudo update-alternatives --install "/usr/bin/java" "java" "$install_dir/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "$install_dir/bin/javac" 1
sudo update-alternatives --set java "$install_dir/bin/java"
sudo update-alternatives --set javac "$install_dir/bin/javac"

# Print success message
echo "Java JDK installed successfully."

# Clean up
rm /tmp/jdk.deb

#!/usr/bin/zsh

##############################################################
# - This script automate all the things you will need to do 
#   manually to test/run/write a simple .cpp file. After 
#   the setup, it automatically launch vim in main.cpp, 
#   with boilerplate ready.
# - Run this command from anywhere: 
#       `simplecpp.sh -n 'PROJECT_NAME' -e 'EXECUTABLE_NAME'`
# - Use this script for a first-time setup of a very simple 
#   cpp file/env.
# - Arguments: 
#    1. n, project name
#    2. e, executable name
# - NOTE: If it's a big project with libraries and stuffs, 
#   use the script `projectcpp.sh` instead (still a TODO).
##############################################################

# --------------------------
# Storing Arguments...
# --------------------------
echo "Parsing project name and executable name ..."

while getopts "n:e:" arg; do
  case $arg in
    n) PROJECT_NAME=$OPTARG;;
    e) EXECUTABLE_NAME=$OPTARG;;
  esac
done

# --------------------------
# Creating project folder...
# --------------------------
echo "Creating project folder and other files..."
echo "Project name: $PROJECT_NAME | Executable name: $EXECUTABLE_NAME"

mkdir $PROJECT_NAME
cd $PROJECT_NAME
mkdir build
touch main.cpp
echo "
#include <iostream>
#include <string>

int main() {
    std::cout << std::endl;
    std::cout << \"All done!\" << std::endl;
    std::cout << \"NOTE: Please change minimum required CMake version (if you want) in CMakeLists.txt\" << std::endl;
    return 0;
}
" >> main.cpp
sed -i '1d' main.cpp # Delete first skipped line

# --------------------------
# Creating CMakeLists.txt...
# --------------------------
echo "Configuring CMake..."

touch CMakeLists.txt
echo "cmake_minimum_required(VERSION 3.12)" >> CMakeLists.txt
echo "project($PROJECT_NAME)" >> CMakeLists.txt
echo "add_executable($EXECUTABLE_NAME main.cpp)" >> CMakeLists.txt

# --------------------------
# Finishing up setup...
# --------------------------
cd build
cmake ..
cmake --build .
./$EXECUTABLE_NAME
echo ""
echo "Launching Vim (Neovim) ..."
sleep 1 # wait one second
cd ..
vim main.cpp

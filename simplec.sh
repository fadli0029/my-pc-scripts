#!/usr/bin/zsh

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
touch main.c
echo "
#include <stdio.h>

int main() {
    printf(\"Done!\");
    return 0;
}
" >> main.c
sed -i '1d' main.c # Delete first skipped line

# --------------------------
# Creating CMakeLists.txt...
# --------------------------
echo "Configuring CMake..."

touch CMakeLists.txt
echo "cmake_minimum_required(VERSION 2.6.0)" >> CMakeLists.txt
echo "project($PROJECT_NAME C)" >> CMakeLists.txt
echo "add_executable($EXECUTABLE_NAME main.c)" >> CMakeLists.txt

# --------------------------
# Finishing up setup...
# --------------------------
cd build
cmake .. -DCMAKE_C_COMPILER=gcc
make
./$EXECUTABLE_NAME
echo ""
echo "Launching Vim (Neovim) ..."
sleep 1 # wait one second
cd ..
vim main.c

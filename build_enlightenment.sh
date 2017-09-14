#!/bin/bash
 
set -e
# Target directory
PREFIX="/usr/local"
 
# List of the needed packages
# https://git.enlightenment.org/
PROJECTS_CORE="efl enlightenment"
PROJECTS_APPS="ephoto extra terminology"
 
# Download url
SITE="http://git.enlightenment.org"
OPT="--prefix=$PREFIX"
 
PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
PATH="$PREFIX/bin:$PATH"
LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
LOG="installe.log"
rm -f $LOG      # Delete precedent log file
touch $LOG      # Create a log file
date >> $LOG    # Add current date
 
# Download and compile each core module
for PROJ in $PROJECTS_CORE; do
    # Cloning
    echo
    echo "[INFO] downloading $PROJ"
    if [ ! -d $PROJ ]; then
        git clone $SITE/core/$PROJ.git $PROJ
	cd $PROJ*
    else
	cd $PROJ*
	git pull
    fi
    # Go building and installing
    echo
    echo "[INFO] building $PROJ"
    make clean distclean || true
    ./autogen.sh $OPT
    make
    sudo make install
    cd ..
    sudo ldconfig
    echo $PROJ" is installed" >> $LOG
done

# Download and compile each app module
for PROJ in $PROJECTS_APPS; do
    # Cloning
    echo
    echo "[INFO] downloading $PROJ"
    if [ ! -d $PROJ ]; then
        git clone $SITE/apps/$PROJ.git $PROJ
	cd $PROJ*
    else
	cd $PROJ*
	git pull
    fi
    # Go building and installing
    echo
    echo "[INFO] building $PROJ"
    make clean distclean || true
    ./autogen.sh $OPT
    make
    sudo make install
    cd ..
    sudo ldconfig
    echo $PROJ" is installed" >> $LOG
done

echo
echo "[INFO] done"
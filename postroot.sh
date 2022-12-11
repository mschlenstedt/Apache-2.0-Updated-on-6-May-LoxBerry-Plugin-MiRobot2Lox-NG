#!/bin/bash

# Shell script which is executed by bash *BEFORE* installation is started
# (*BEFORE* preinstall and *BEFORE* preupdate). Use with caution and remember,
# that all systems may be different!
#
# Exit code must be 0 if executed successfull. 
# Exit code 1 gives a warning but continues installation.
# Exit code 2 cancels installation.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Will be executed as user "root".
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# You can use all vars from /etc/environment in this script.
#
# We add 5 additional arguments when executing this script:
# command <TEMPFOLDER> <NAME> <FOLDER> <VERSION> <BASEFOLDER>
#
# For logging, print to STDOUT. You can use the following tags for showing
# different colorized information during plugin installation:
#
# <OK> This was ok!"
# <INFO> This is just for your information."
# <WARNING> This is a warning!"
# <ERROR> This is an error!"
# <FAIL> This is a fail!"

# To use important variables from command line use the following code:
COMMAND=$0    # Zero argument is shell command
PTEMPDIR=$1   # First argument is temp folder during install
PSHNAME=$2    # Second argument is Plugin-Name for scipts etc.
PDIR=$3       # Third argument is Plugin installation folder
PVERSION=$4   # Forth argument is Plugin version
#LBHOMEDIR=$5 # Comes from /etc/environment now. Fifth argument is
              # Base folder of LoxBerry
PTEMPPATH=$6  # Sixth argument is full temp path during install (see also $1)

# Combine them with /etc/environment
PCGI=$LBPCGI/$PDIR
PHTML=$LBPHTML/$PDIR
PTEMPL=$LBPTEMPL/$PDIR
PDATA=$LBPDATA/$PDIR
PLOG=$LBPLOG/$PDIR # Note! This is stored on a Ramdisk now!
PCONFIG=$LBPCONFIG/$PDIR
PSBIN=$LBPSBIN/$PDIR
PBIN=$LBPBIN/$PDIR

#. $LBHOMEDIR/libs/bashlib/loxberry_log.sh
#PACKAGE=${PSHNAME}
#NAME=preroot_install
#FILENAME=${LBPLOG}/${PSHNAME}/preroot_install.log
#APPEND=1
#STDERR=1
  
echo "<INFO> Installation as root user started."

echo "<INFO> Start installing Rust Toolchain..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
if [ $? -ne "0" ]; then
	echo "<WARNING> Rust Toolchain installation failed! There might be a problem compiling some Python Modules. We will continue anyway."
else
	echo "<OK> Rust Toolchain installed successfully."
fi 

echo "<INFO> Start installing pip3..."
yes | python3 -m pip install --upgrade pip
INSTALLED=$(pip3 list --format=columns | grep "pip" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Pip installed successfully."
else
	echo "<WARNING> Python Pip installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 

echo "<INFO> Start installing Python Wheel..."
yes | pip3 install wheel
INSTALLED=$(pip3 list --format=columns | grep "wheel" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Setuptools installed successfully."
else
	echo "<WARNING> Python Setuptools installation failed! We will continue anyway."
fi 

echo "<INFO> Start installing Python Setuptools..."
yes | pip3 install setuptools 
INSTALLED=$(pip3 list --format=columns | grep "setuptools" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Setuptools installed successfully."
else
	echo "<WARNING> Python Setuptools installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 

echo "<INFO> Start installing Python YAML..."
yes | pip3 install -U pyyaml
INSTALLED=$(pip3 list --format=columns | grep "PyYAML" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python YAML installed successfully."
else
	echo "<WARNING> Python YAML installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 

echo "<INFO> Start installing Python Cryptography tools..."
yes | pip3 install -U cryptography 
INSTALLED=$(pip3 list --format=columns | grep "cryptography" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Cryptography tools installed successfully."
else
	echo "<WARNING> Python Cryptography tools installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 

echo "<INFO> Start installing Python Appdirs tools..."
yes | pip3 install appdirs 
INSTALLED=$(pip3 list --format=columns | grep "appdirs" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Appdirs tools installed successfully."
else
	echo "<WARNING> Python Appdirs tools installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 

echo "<INFO> Start installing Python GoogleTTS Module..."
yes | pip3 install gTTS 
INSTALLED=$(pip3 list --format=columns | grep "gTTS" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python GoogleTTS Module installed successfully."
else
	echo "<WARNING> Python GoogleTTS Module installation failed! We will continue anyway."
fi 

echo "<INFO> Start installing Python NetIfaces Module..."
yes | pip3 install netifaces
INSTALLED=$(pip3 list --format=columns | grep "netifaces" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Netifaces Module installed successfully."
else
	echo "<WARNING> Python Netifaces Module installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi

echo "<INFO> Start installing Python Requests..."
yes | pip3 install requests
INSTALLED=$(pip3 list --format=columns | grep "requests" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Requests installed successfully."
else
	echo "<WARNING> Python Requests installation failed! We will continue anyway."
fi 

echo "<INFO> Start installing Python Android Backup..."
yes | pip3 install android_backup
INSTALLED=$(pip3 list --format=columns | grep "android-backup" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Android Backup installed successfully."
else
	echo "<WARNING> Python Android Backup installation failed! We will continue anyway."
fi 

echo "<INFO> Start installing Python Construct..."
yes | pip3 install construct
INSTALLED=$(pip3 list --format=columns | grep "construct" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python Construct installed successfully."
else
	echo "<WARNING> Python Construct installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
        exit 2;

fi 

echo "<INFO> Start installing Python MIIO tools..."
yes | pip3 install -U python-miio 
INSTALLED=$(pip3 list --format=columns | grep "python-miio" | grep -v grep | wc -l)
if [ ${INSTALLED} -ne "0" ]; then
	echo "<OK> Python MIIO tools installed successfully."
else
	echo "<WARNING> Python MIIO tools installation failed! The plugin will not work without."
	echo "<WARNING> Giving up."
	exit 2;
fi 


echo "<INFO> Start installing Token Extractor..."
#wget -O ${PBIN}/token_extractor.py https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor/raw/master/token_extractor.py
#if [ -e ${PBIN}/token_extractor.py ]; then
#	echo "<OK> Token Extractor installed successfully."
#	chown loxberry:loxberry ${PBIN}/token_extractor.py
#	chmod +x ${PBIN}/token_extractor.py
#else
#	echo "<WARNING> Tokenextractor installation failed! We will continue anyway."
#fi
echo "bash <(curl -L https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor/raw/master/run.sh)" > ${PBIN}/token_extractor.sh
chown loxberry:loxberry ${PBIN}/token_extractor.sh
chmod +x ${PBIN}/token_extractor.sh

echo "<INFO> Chown all files in ~/log to loxberry:loxberry (fix bug in older versions)..."
chown -R loxberry:loxberry $PLOG/*

exit 0

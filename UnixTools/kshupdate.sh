#!/bin/sh
startdir=$pwd
cd ~/ksh
echo 'ksh update tool!'
input=$1
if [ $# -eq 0 ];
then
    echo 'Please run again with following flags:'
    echo '-f : Fetch and compile the newest version'
    echo '-i : Install (root permission required)'
else
    if [ $1 = '-f' ];
    then
        gitoutput=$(git pull|wc -m)
        if (( $gitoutput==20 ));
        then
	   echo 'It is already up to date if it was installed correctly.'
        else
	   echo 'Fetching updates...'
	   wait
    	   rm -rf ~/ksh/arch
    	   echo 'Compiling...'
    	   bin/package make
    	   wait
    	   echo 'Compiling has been completed. Please change shell by using "chsh -s"'
    	   echo 'command to change the shall to other shall than ksh before instalation'
        fi
    elif [ $1 = '-i' ];
    then
	if [ $SHELL = '/usr/local/bin/ksh' ];
	then
	    echo 'Change shell running "chsh -s" and end the process of ksh'
	else
	    wait
	    echo 'Installing...'
	    sudo cp arch/*/bin/ksh /usr/local/bin/ksh
	    sudo cp src/cmd/ksh93/sh.1 /usr/local/share/man/man1/ksh.1
	    wait
	    echo 'Instalation complete. Please run "chsh -s /usr/local/bin/ksh" to change the shell to ksh.'
	fi
    fi
fi
cd $startdir

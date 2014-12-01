#!/bin/sh

install_ext() {
    if [ -e ~/work/$2 ]
    then
        cd ~/work/$2
        git pull
        cpanm --installdeps .
        cpanm .
    else
        git clone $1 ~/work/$2
        cd ~/work/$2
        cpanm --installdeps .
        cpanm .
    fi
}

cpanm Module::Install
cpanm Module::Install::Repository

install_ext git://github.com/tomyhero/p5-App-Home.git p5-App-Home
install_ext git://github.com/tomyhero/Ze.git Ze
install_ext git://github.com/tomyhero/p5-Aplon.git p5-Aplon
install_ext git://github.com/kazeburo/Cache-Memcached-IronPlate.git Cache-Memcached-IronPlate
install_ext git://github.com/onishi/perl5-devel-kytprof.git Devel-KYTProf


cpanm --installdeps .

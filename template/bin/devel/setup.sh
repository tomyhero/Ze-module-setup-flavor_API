#!/bin/sh

ln -s ./../../../asset/lib/<+ dist +>X/Overwrite lib/<+ dist +>X/
ln -s ./../asset/config .
ln -s ./../asset/data .

ln -s ./../../po ./t/root/
ln -s ./../../psgi ./t/root/
ln -s ./../../router ./t/root/ 
ln -s ./../../view-include ./t/root/ 
ln -s ./../../view-op ./t/root/

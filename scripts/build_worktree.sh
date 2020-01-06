#!/bin/bash
#some packages are for ubuntu 18

#got to the workstaion directory
cd ../

#update git submodule
echo "initializing indivual ros packages..."
git submodule update --init src/*
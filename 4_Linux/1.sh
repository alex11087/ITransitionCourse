#!/bin/bash
if ! [ $(id -u) = 0 ]; then
   echo "I am not root!"
   exit 1
fi

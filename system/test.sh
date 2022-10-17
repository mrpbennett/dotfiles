#!/bin/bash

if [[ $(svr-os) == 1 ]]; then
    echo "this is a ubuntu server"
else
    echo "this is a centois server"
fi
#!/bin/bash
ulimit -c unlimited
while true; do ./crystalserver 2>&1 | awk '{ print strftime("%F %T - "), 
$0; fflush(); }' | tee "logs/$(date +"%F %H-%M-%S.log")"; done

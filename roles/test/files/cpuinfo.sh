#!/bin/bash

touch cpuinfo.tmp
touch cpuinfo

cat /proc/cpuinfo >> cpuinfo.tmp

sed -n '/processor/p' cpuinfo.tmp >> cpuinfo

rm -f cpuinfo.tmp

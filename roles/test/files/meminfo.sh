#!/bin/bash

touch meminfo.tmp
touch meminfo

cat /proc/meminfo >> meminfo.tmp

sed -n '/MemTotal/p' meminfo.tmp >> meminfo
sed -n '/MemFree/p' meminfo.tmp >> meminfo

rm -f meminfo.tmp

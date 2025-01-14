#!/bin/bash

cat /proc/cpuinfo | grep name | tail -1 | cut -d':' -f2




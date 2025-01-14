#!/bin/bash

ip link show enp2s0 | grep link | tr -s ' ' |  cut -d' ' -f3



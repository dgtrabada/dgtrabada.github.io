#!/bin/bash

df -h | grep home | tr -s ' '| cut -d' ' -f5-


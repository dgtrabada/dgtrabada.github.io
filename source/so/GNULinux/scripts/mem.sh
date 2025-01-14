#!/bin/bash

free -h | grep Mem | tr -s ' ' | cut -d' ' -f4 >> free.log




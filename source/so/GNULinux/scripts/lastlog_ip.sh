#!/bin/bash
last -w | tr -s ' ' | cut -d' ' -f3 | grep '\.' | sort | uniq -c | sort -rn

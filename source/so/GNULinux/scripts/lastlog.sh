#!/bin/bash
last -w | cut -d' ' -f1 | grep -v -e reboot -e wtmp -e '^$' | sort | uniq -c | sort -rn

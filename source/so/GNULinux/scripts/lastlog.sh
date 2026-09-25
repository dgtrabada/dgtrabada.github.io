#!/bin/bash
lista=$(last -w | cut -d' ' -f1 | grep -v -e reboot -e wtmp -e '^$' | sort | uniq -c | sort -rn | tr -s ' ' | cut -d' ' -f2,3)
paste -d' ' <(echo "$lista") <(groups $(echo "$lista" | cut -d' ' -f2) | cut -d':' -f2 | cut -c2-)

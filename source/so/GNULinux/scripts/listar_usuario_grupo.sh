#!/bin/bash
groups $(grep bash /etc/passwd | cut -d':' -f1)

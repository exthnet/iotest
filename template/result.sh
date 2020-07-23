#!/bin/bash

# usage
#  ./result.sh resultfile(STDOUT_of_Job)
grep sec $1 | awk '{print $3,$6,$9}'

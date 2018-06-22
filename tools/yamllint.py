#!/usr/bin/env python

import sys
from yaml import safe_load, dump

if __name__ == "__main__":
    if len(sys.argv) > 1:
        f_in = open(sys.argv[1])
    else:
        f_in = sys.stdin
    a = safe_load(f_in.read())
    print(dump(a))

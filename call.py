#!/usr/bin/env python
import sys

import call


def main():
    instance = call.Call()
    print instance.fn(int(sys.argv[1]))


if __name__ == '__main__':
    main()

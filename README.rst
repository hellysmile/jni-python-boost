jni-python-boost
================

:info: Jni Python Boost Example

Usage
*****

Factorial Calculator written in Java with C++ JNI binding to Python via Boost::

    make all

    java Call 10
    # 3628800

    # export LD_LIBRARY_PATH=$(JDK)/Contents/Home/jre/lib/server/

    ./call 10 # standalone C++ binary
    # 3628800

    ./call.py 10 # Python boost bindings
    # 3628800

`Make file designed for MacOS X, can be easily adjusted to any Linux`

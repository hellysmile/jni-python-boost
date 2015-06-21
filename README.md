# jni-python-boost
Jni Python Boost Example

Factorial Calculator written in Java with C++ JNI binding to Python via Boost::

    make all

    java Call 10
    # 3628800

    ./call 10 # standalone C++ binary
    # 3628800

    ./call.py 10 # Python boost bindings
    # 3628800

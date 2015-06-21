PYTHON_VERSION = 2.7
PYTHON_VERSION_FULL = $(PYTHON_VERSION).10
PYTHON_INCLUDE = /usr/local/Cellar/python/$(PYTHON_VERSION_FULL)/Frameworks/Python.framework/Versions/$(PYTHON_VERSION)/include/python$(PYTHON_VERSION)

BOOST_INC = /usr/local/include
BOOST_LIB = /usr/local/lib

JDK_VERSION = 1.8.0_20
JDK = /Library/Java/JavaVirtualMachines/jdk$(JDK_VERSION).jdk

TARGET = call

JAVA_TARGET = Call

clean:
	rm -f $(TARGET).o $(TARGET).so $(JAVA_TARGET).class $(TARGET) hs_err*

class:
	javac $(JAVA_TARGET).java

o:
	g++ \
	-I$(JDK)/Contents/Home/include \
	-I$(JDK)/Contents/Home/include/darwin \
	-I$(PYTHON_INCLUDE) \
	-I$(BOOST_INC) \
	-fPIC \
	-c $(TARGET).cpp

so:
	g++ -ljvm -shared -Wl $(TARGET).o \
	-L$(JDK)/Contents/Home/jre/lib/server/ \
	-L$(BOOST_LIB) \
	-lboost_python \
	-L/usr/local/Cellar/python/$(PYTHON_VERSION_FULL)/Frameworks/Python.framework/Versions/$(PYTHON_VERSION)/lib/python$(PYTHON_VERSION)/config \
	-lpython$(PYTHON_VERSION) \
	-o $(TARGET).so

exec: class
	g++ -o $(TARGET) \
	-I$(JDK)/Contents/Home/include \
	-I$(JDK)/Contents/Home/include/darwin \
	-L$(JDK)/Contents/Home/jre/lib/server/ \
	-I$(PYTHON_INCLUDE) \
	-L$(BOOST_LIB) \
	-lboost_python \
	-L/usr/local/Cellar/python/$(PYTHON_VERSION_FULL)/Frameworks/Python.framework/Versions/$(PYTHON_VERSION)/lib/python$(PYTHON_VERSION)/config \
	-lpython$(PYTHON_VERSION) \
	$(TARGET).cpp \
	-ljvm

	LD_LIBRARY_PATH=$(JDK)/Contents/Home/jre/lib/server/ ./$(TARGET) 10

lib: class o so
	LD_LIBRARY_PATH=$(JDK)/Contents/Home/jre/lib/server/ python -c "import call; c = call.Call(); print(c.fn(10))"

all: clean exec lib

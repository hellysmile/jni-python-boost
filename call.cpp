#include <iostream>
#include <cstdlib>
#include <cstring>
#include <boost/python.hpp>
#include <jni.h>

class Call {
    JNIEnv *env;
    JavaVM *jvm;
    jclass cls;
    jobject JCall;
    jmethodID jfn;

public:
    Call() {
        JavaVMOption options[1];

        JavaVMInitArgs vm_args;

        jmethodID constructor;

        options[0].optionString = (char *)"-Djava.class.path=.:./";

        memset(&vm_args, 0, sizeof(vm_args));
        vm_args.version = JNI_VERSION_1_8;
        vm_args.nOptions = 1;
        vm_args.options = options;
        long status = JNI_CreateJavaVM(&jvm, (void **)&env, &vm_args);

        cls = env->FindClass("Call");

        constructor = env->GetMethodID(cls, "<init>", "()V");

        JCall = env->NewObject(cls, constructor);

        jfn = env->GetMethodID(cls, "fn", "(I)J");
    }

    ~Call() {
        jvm->DestroyJavaVM();
    }

    unsigned long long fn(int value) {
        return (unsigned long long)env->CallIntMethod(JCall, jfn, (jint)value);
    }
};

int main(int argc, char *argv[]) {
    Call call;
    std::cout << call.fn(atoi(argv[1])) << std::endl;
    return 0;
}

BOOST_PYTHON_MODULE(call) {
    using namespace boost::python;
    class_<Call>("Call").def("fn", &Call::fn);
}

export ANDROID_NDK_ROOT=/Users/thomashoffmann/AndroidDEV/ndk
export ANDROID_SDK_ROOT=/Users/thomashoffmann/AndroidDEV/sdk
export PATH=$PATH:/Users/thomashoffmann/AndroidDEV/sdk/tools/:/Users/thomashoffmann/AndroidDEV/sdk/platform-tools/:/Users/thomashoffmann/Qt5.3.0/5.3/ios/bin
qmake
make install INSTALL_ROOT=clang-build/
make clean
./clang-build/opt/tualo-Leistungserfassung/bin/tualo-Leistungserfassung.app/Contents/MacOS/tualo-Leistungserfassung
export ANDROID_NDK_ROOT=/Users/thomashoffmann/AndroidDEV/ndk
export ANDROID_SDK_ROOT=/Users/thomashoffmann/AndroidDEV/sdk
export PATH=$PATH:/Users/thomashoffmann/AndroidDEV/sdk/tools/:/Users/thomashoffmann/AndroidDEV/sdk/platform-tools/:/Users/thomashoffmann/Qt5.2.1/5.2.1/android_armv7/bin
qmake
make install INSTALL_ROOT=android-build
#mv android-libqtquick-pos.so-deployment-settings.json android-libtualo-Leistungserfassung.so-deployment-settings.json
androiddeployqt --output android-build/ --release --sign /Users/thomashoffmann/androidworkspace/tualo-keystore2 tualo
make clean
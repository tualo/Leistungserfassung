TEMPLATE = app

QT += qml quick
QT += sql
SOURCES += main.cpp

RESOURCES += qml.qrc

ICON = image_resources/osx_icon.icns
 
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android



OTHER_FILES += \
    android/AndroidManifest.xml \
    android/res/drawable-xxhdpi/icon.png \
    android/res/drawable-xhdpi/icon.png \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/values/strings.xml \
    resource.rc



win32:RC_FILE = resource.rc

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "qzxing/qzxing.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //qmlRegisterType<zbar::QZBar>("CustomComponents", 1, 0, "Line");

    qmlRegisterType<QZXing>("QZXing",  1,  0, "CodeReader");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

    return app.exec();
}

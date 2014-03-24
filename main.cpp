#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QCoreApplication::setApplicationName(APPLICATION_NAME);
    QCoreApplication::setOrganizationName(ORGANIZATION_NAME);

    QtQuick2ApplicationViewer viewer;

    viewer.setTitle(APPLICATION_NAME);
    viewer.setMainQmlFile(QStringLiteral("qml/qtquick-pos/main.qml"));
    viewer.showExpanded();

    return app.exec();
}

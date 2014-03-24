import QtQuick 2.0
import "../Controls"

Rectangle {
    x: 0
    y: topToolBar.height
    width: 300
    height: parent.height - topToolBar.height
    border.color: "darkgray"

    id: westPanel

    property int inputTextPadding: 5
    property int inputTextHeight: 50

    property variant locale: Qt.locale("de_DE")


    property alias list: slist
    property alias model: slist.model


    RegionListView {
        id: slist
        clip: true
        locale: locale
        height: parent.height-10
        border.color: "navy"
        width: westPanel.width
    }


}

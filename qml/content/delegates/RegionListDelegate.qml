import QtQuick 2.1

Item {
    id: root
    width: parent.width
    height: 88

    FontLoader { id: fontAwesome; source: "../../resources/fontawesome-webfont.ttf" }
    signal clicked
    
    property int borderWidth: 2

    Component.onCompleted: {
        
    }

    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouse.pressed
    }

    Rectangle{
        height: parent.height
        color: "#212126"
        opacity: __selected?1:0
        border.color: "#09c"
        border.width: borderWidth
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Rectangle{
        height: parent.height - borderWidth*2
        color: "#212126"
        border.width: 0
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Text {
        id: textitem
        color: "white"
        font.pixelSize: 24
        text: name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    
    
    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        height: 1
        color: "#424246"
    }

    Image {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        //source: "../images/navigation_next_item.png"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()

    }
}

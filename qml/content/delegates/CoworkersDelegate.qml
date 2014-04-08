import QtQuick 2.1

Item {
    id: root
    width: parent.width
    height: 88

    FontLoader { id: fontAwesome; source: "../../resources/fontawesome-webfont.ttf" }


    
    signal clicked

    Component.onCompleted: {
        
    }

    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouse.pressed
    }

    Text {
        id: texticon
        color: "white"
        font.pixelSize: 32
        text: ""
        font.family: fontAwesome.name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Text {
        id: textitem
        color: "white"
        font.pixelSize: 32
        text: name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 90
    }

    Text {
        id: textamount
        color: "white"
        font.pixelSize: 32
        text: amount
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 90
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

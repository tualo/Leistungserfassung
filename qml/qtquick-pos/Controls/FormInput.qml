import QtQuick 2.0
import ".."
Rectangle {
    //width: parent.width
    //height: 30
    /*
    gradient: Gradient {
        GradientStop { position: 0.1; color: "#cFcFd3" }
        GradientStop { position: 0.5; color: "#d8d8dF" }
        GradientStop { position: 0.8; color: "#dAdBe1" }
        GradientStop { position: 1.0; color: "#d5d5dA" }
    }
    */

    property alias label: title.text
    property alias labelWidth: title.width
    property alias text: textInput.text
    property alias echoMode: textInput.echoMode


    color: Style.backgroundColor

    Rectangle {
        x: textInput.x - Style.padding*1
        y: textInput.y - Style.padding*1
        width: textInput.width + Style.padding*2
        height: textInput.height + Style.padding*2
        color: Style.backgroundColor
        border.color: Style.textColor
        radius: Style.radius
    }

    Text {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        color: Style.textColor
        font.pointSize: Style.textSize
    }

    TextInput {
        id: textInput
        anchors.left: title.right
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        focus: true
        color: Style.textColor
        font.pointSize: Style.textSize
    }
}

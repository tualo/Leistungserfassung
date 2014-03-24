import QtQuick 2.0
import QtQuick.Layouts 1.0
import ".."
Rectangle {
    id: rect
    width: 100
    height: 100
    smooth: true

    radius: Style.radius
    color: Style.tootlbarButtonColor

    property alias buttonText: text
    property bool animationEnabled: true

    property int buttonId: 0

    signal btnClicked(int buttonId)

    FontLoader { id: fontAwesome; source: "../icons/fontawesome-webfont.ttf" }


    ColumnLayout{
        anchors.centerIn: parent


        Text {
            id: text
            text: qsTr("1")

        }
    }




    Timer {
     id: buttonPressedTimer
     interval: 50; running: false; repeat: false
     onTriggered: btnClicked(buttonId)
 }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {

             if (animationEnabled && !anim.running) {
                 anim.restart()
             }
             buttonPressedTimer.restart()

        }
    }

    SequentialAnimation {
         id: toggleIn
         PropertyAction  { target: rect; property: "scale"; value:"0.8"}
         PauseAnimation { duration: 100 }
     }

    SequentialAnimation {
         id: toggleOut
         PropertyAction  { target: rect; property: "scale"; value:"1.0"}
         PauseAnimation { duration: 100 }
     }

    SequentialAnimation {
         id:anim
         PropertyAction  { target: rect; property: "scale"; value:"0.8"}
         PauseAnimation { duration: 100 }
         PropertyAction  { target: rect; property: "scale"; value:"1.0"}
     }
}

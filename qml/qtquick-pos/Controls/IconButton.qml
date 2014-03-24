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


    border.width: 1

    property bool animationEnabled: true
    //property double mouseOverOpacity: 0.8

    property int buttonId: 0
    property bool toogle: false
    property bool toogled: false
    property string icon: ""
    property color textColor: "black"
    property int iconSize: 16
    signal btnClicked(int buttonId)

    FontLoader { id: fontAwesome; source: "../icons/fontawesome-webfont.ttf" }

    //opacity: mouseArea.containsMouse?mouseOverOpacity:1

    ColumnLayout{
        anchors.centerIn: parent

        Text {
            id: iconId
            text: icon
            width: parent.width
            color: textColor
            font.pixelSize: iconSize
            font.family: fontAwesome.name
            horizontalAlignment: Text.AlignHCenter
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
            if (toogle===true){
                if (toogled===true){
                    if (animationEnabled && !toggleOut.running) {
                        toggleOut.restart()
                    }
                    toogled=false
                }else{
                    if (animationEnabled && !toggleIn.running) {
                        toggleIn.restart()
                    }
                    toogled=true
                }

            }else{
                 if (animationEnabled && !anim.running) {
                     anim.restart()
                 }
                 buttonPressedTimer.restart()
            }
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

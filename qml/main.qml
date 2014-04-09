import QtQuick 2.2
import QtQuick.Controls 1.1
import "controls"
import "content"
import "singleton"

ApplicationWindow {
    visible: true
    width: 1280
    height: 800

    title: "MyWindow"
    id: mainWindow
    //property string title: "Leistungserfassung"
    
    FontLoader { id: fontAwesome; source: "./resources/fontawesome-webfont.ttf" }

    
    Component.onCompleted: {
         App.loadSettings();
        
    } 

    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }

    toolBar: Rectangle {

        color: "#111116"
        height: 100
        width: parent.width



        Rectangle {
            id: backButton
            width: opacity ? 60 : 0

            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
            Text{
                text: "\uf053"
                color: "white"
                width: backButton.width
                height: backButton.height
                font.pixelSize: 42
                font.family: fontAwesome.name
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }

        Text {
            font.pixelSize: 34
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: backButton.opacity ? title : "Leistungserfassung am "+App.getShortDateString()
        }
        
        
        Rectangle {
            id: doneButton
            width: opacity ? 180 : 0

            anchors.right: parent.right
            anchors.rightMargin: 20
            opacity: ( (stackView.currentItem!==null) && (typeof stackView.currentItem.doneText==="string") && (stackView.currentItem.doneText!=="") ) ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
            Text{
                text: ( (stackView.currentItem!==null)  && (typeof stackView.currentItem.doneText==="string"))?stackView.currentItem.doneText.substring(0,stackView.currentItem.doneText.length-1):""
                color: "white"
                width: doneButton.width  - 34
                height: doneButton.height
                font.pixelSize: 34
                //font.family: fontAwesome.name
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }
            Text{
                text: ( (stackView.currentItem!==null)  && (typeof stackView.currentItem.doneText==="string"))?stackView.currentItem.doneText.substring(stackView.currentItem.doneText.length-1):""
                color: "white"
                width: doneButton.width
                height: doneButton.height
                font.pixelSize: 34
                font.family: fontAwesome.name
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                id: donemouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    if (typeof stackView.currentItem.onDoneClicked === "function"){
                        stackView.currentItem.onDoneClicked();
                    }
                    //stackView.pop()
                }
            }
        }
        
    }
    
    ListModel {
        id: pageModel
        
        ListElement {
            iconText: "\uf0c0"
            title: "Mitarbeiter erfassen"
            doneText: ""
            page: "content/Coworkers.qml"
        }
        
        ListElement {
            iconText: "\uf073"
            title: "Kalender"
            doneText: ""
            page: "content/Calendar.qml"
        }
        
        ListElement {
            iconText: "\uf085"
            title: "Settings"
            doneText: "\uf00c Fertig"
            page: "content/Settings.qml"
        }
        
        ListElement {
            iconText: "\uf0f6"
            title: "Über"
            doneText: ""
            page: "content/About.qml"
        }
        
        ListElement {
            iconText: "\uf08b"
            title: "Beenden"
            doneText: ""
            page: "content/Exit.qml"
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased:{ 
            if (event.key === Qt.Key_Back && stackView.depth > 1) {
                stackView.pop();
                event.accepted = true;
            }
        }
        
        
         
        initialItem: TualoWindow {
            
            width: parent.width
            height: parent.height
            ListView {
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: title
                    icon: iconText
                    onClicked: stackView.push(Qt.resolvedUrl(page))
                }
            }
        }
    }

}

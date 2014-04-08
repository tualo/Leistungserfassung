import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../singleton"

GridLayout {
    id: root
    columns: 3
    rowSpacing: 2
    columnSpacing: 2
    
    property var buttons: [
        '7','8','9',
        '4','5','6',
        '1','2','3',
        '-','0','+'
    ];
    
    
    function refresh(){
    
        infoText.text = App.receiptInfoText();
        
        
        
    }
    
    Rectangle {
        id: infoRectangle
        Layout.columnSpan: 3
        height: 24*5
        
        Text{
            id: infoText
            width: parent.width
            x: root.width
            font.pixelSize: 24
            color: "white"
            text: ""
            horizontalAlignment: Text.AlignRight
        }
        
    }
    
    Rectangle {
        id: numberRectangle
        Layout.columnSpan: 3
        height: 60
        
        Text{
            id: numberText
            width: parent.width
            x: root.width
            font.pixelSize: 32
            color: "white"
            text: ""
            horizontalAlignment: Text.AlignRight
        }
        
    }
    
    Repeater {
        id: repeater
        model: buttons.length
        Button{
            width: parent.width / parent.columns - parent.columnSpacing*1
            height: (parent.height - infoRectangle.height - numberRectangle.height) / (buttons.length/parent.columns) - parent.rowSpacing*1
            style: touchStyle
            text: buttons[index];
        }
    }
    
    Component {
        id: touchStyle
        ButtonStyle {
            background: Rectangle{
                implicitWidth: control.width
                implicitHeight: control.height
                border.color: false?(control.pressed ? "#d55" : "#d66"):(control.pressed ? "#555" : "#666")
                border.width: 1
                radius: 5
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.checked?(control.pressed ? "#00a" : "#11a"):(control.pressed ? "#000" : "#111") }
                    GradientStop { position: 1 ; color: control.checked?(control.pressed ? "#11a" : "#22a"):(control.pressed ? "#111" : "#222") }
                }
            }
            label: Text {
                clip: true
                text: control.text
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 23
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }
    }
}
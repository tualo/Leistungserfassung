pragma Singleton
import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

QtObject{
    property Component buttonStyle: ButtonStyle {
            background: Rectangle{
                implicitWidth: control.width
                implicitHeight: control.height
                //border.color: current?(control.pressed ? "#d55" : "#d66"):(control.pressed ? "#555" : "#666")
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
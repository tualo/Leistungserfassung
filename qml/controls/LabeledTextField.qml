import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

Rectangle {
    property int labelWidth: 100
    property alias label: label.text
    property alias text: textFld.text
    property alias echoMode: textFld.echoMode
    property alias style: textFld.style
    property alias labelLeftSpace: label.x
    property color labelColor: "white"
    property int labelFontPixelSize: 28

    signal changed(string content)
    
    
    Label {
        id: label
        opacity: 0.5
        text: "LBL"
        width: labelWidth
        height: textFld.height
        verticalAlignment: Text.AlignVCenter
        color: labelColor
        font.pixelSize: labelFontPixelSize
    }

    TextField {
        x: labelWidth + label.x
        id: textFld
        width: parent.width - labelWidth - 2*label.x
        text: "Text input"
        onTextChanged: {
           //changed(text);
        }
    }

}

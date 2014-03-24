import QtQuick 2.0
import "../Controls"
import ".."

Rectangle {
    x: parent.width - width
    y: topToolBar.height
    width: 400
    height: parent.height - topToolBar.height

    id: eastPanel


    color: Style.backgroundColor

    property int inputTextPadding: 5
    property int inputTextHeight: 50

    property variant locale: Qt.locale("de_DE")
    property alias inputPanel: inputPanel
    property alias displayText: nameText.text
    property alias displayNumberText: numberText.text
    property alias displayDateText: dateText.text

    signal contentEnteredInPanel(string content)
    signal contentEnteredInPrice(string content)


    Rectangle{
        id: inputView
        height: inputTextHeight * 3
        width: eastPanel.width - Style.padding
        Text{
           clip: true
           id: nameText
           font.pixelSize: Style.textSize
           color: Style.invertedTextColor
           text: 'TEST'
           x: Style.padding
           y: Style.padding + (Style.textSize+Style.padding)*0
           width: inputView.width-2*Style.padding
           height: Style.textSize+2*Style.padding
           horizontalAlignment: Text.AlignRight
        }

        Text{
           clip: true
           id: numberText
           font.pixelSize: Style.textSize
           color: Style.invertedTextColor
           text: 'neuer Beleg'
           x: Style.padding
           y: Style.padding + (Style.textSize+Style.padding)*1
           width: inputView.width-2*Style.padding
           height: Style.textSize+2*Style.padding
           horizontalAlignment: Text.AlignRight
        }
        Text{
           clip: true
           id: dateText
           font.pixelSize: Style.textSize
           color: Style.invertedTextColor
           text: '21.03.2014'
           x: Style.padding
           y: Style.padding + (Style.textSize+Style.padding)*2
           width: inputView.width-2*Style.padding
           height: Style.textSize+2*Style.padding
           horizontalAlignment: Text.AlignRight
        }
        color: Style.backgroundColor
        border.color: Style.invertedTextColor
        radius: 5
    }




    InputPanel{
        id: inputPanel
        clip: true
        y: inputView.height
        width: eastPanel.width - Style.padding
        height: eastPanel.width - Style.padding

        onContentEntered: {
            if (inputPanel.buttonPanel.priceButton.toogled===true){
                contentEnteredInPrice(content)
            }else{
                contentEnteredInPanel(content)
            }
        }
        onResetAll: {
            //itemsPanel.removeAll()
        }
        onResetPosition: {
            //itemsPanel.removePosition()
        }

    }
}

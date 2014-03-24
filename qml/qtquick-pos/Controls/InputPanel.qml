import QtQuick 2.0
import QtQuick.Layouts 1.1
import ".."
ColumnLayout {
    //columns: 1
    id: cc
    spacing: 1
    property string value: "0"
    property int decimalPrecision: 2

    signal contentEntered(string content)
    signal resetPosition( )
    signal resetAll( )


    property alias buttonPanel: bb

    Rectangle{
        id: rect
        Layout.fillWidth: true
        Layout.minimumHeight: inputTextHeight
        Layout.maximumHeight: inputTextHeight
        Text{
           clip: true
           id: inputText
           font.pixelSize: Style.textSize
           color: Style.invertedTextColor
           font.bold: true
           //anchors.fill: parent
           x: Style.padding
           y: Style.padding
           width: rect.width-2*Style.padding
           height: rect.height-2*Style.padding
           horizontalAlignment: Text.AlignRight
        }
        color: Style.backgroundColor
        border.color: Style.invertedTextColor
        border.width: 2
        radius: Style.radius
    }



    ButtonPanel{
        id: bb

        //width: Style.tootlbarButtonSize * 3 - Style.padding

        onBtnClicked: {
//            console.log(buttonId);
            buttonInput (buttonId)
        }
    }
    SequentialAnimation {
         id: errorAnim
         PropertyAction  { target: inputText; property: "color"; value:"red"}
         PauseAnimation { duration: 200 }
         PropertyAction  { target: inputText; property: "color"; value:"black"}
     }


    function buttonInput(buttonId){
            //console.log("buttonInput: " + buttonId)
            try{
                switch (buttonId){
                    case -11:

                        break;
                    case -12:
                        resetPosition()
                        break;
                    case -18:
                        value = ("0");
                        break;
                    case -5:
                        break;
                    case -4:
                        break;
                    case -3:
                        value = "0";
                        break;
                    case -2:
                        posPanel.setAmount(value);
                        break;
                    case -1:
                        //contentEntered(value)
                        value = ("0");
                        break;
                    default:
                        // Normal Numeric Input
                        if ( (buttonId>=48) && (buttonId<=57) ){
                            if (value.indexOf(".")===-1){
                                var v = value*1
                                v*=10
                                v+=(buttonId-48)
                                value = (v+"");
                            }else{
                                var fraction = value.substring(value.indexOf(".")+1)
                                var int_fraction = fraction*1;
                                var exponent = (int_fraction===0)?0:(int_fraction+"").length
                                var multiplier = Math.pow(10,exponent+1)
                                var fv = value*1
                                fv*=multiplier
                                fv+=( buttonId - 48)
                                fv/=multiplier
                                if ((multiplier+"").length-1>decimalPrecision){
                                    throw new Error("to much decimals")
                                }
                                value = (fv+"");
                            }
                        }
                        break;
                }
                inputText.text = value
            }catch(e){
                console.log(e);
                errorAnim.restart()
            }
    }
}

import QtQuick 2.0
import QtQuick.Layouts 1.0
import ".."

GridLayout {
        id: panel
        columns: 3
        rowSpacing: 2
        columnSpacing: 2
        property bool priceToogled: false
        signal btnClicked(int buttonId)



        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+7
            buttonText.text: "7"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+8
            buttonText.text: "8"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+9
            buttonText.text: "9"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }




        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+4
            buttonText.text: "4"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+5
            buttonText.text: "5"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+6
            buttonText.text: "6"
            onBtnClicked:  {
                panel.btnClicked(buttonId);

            }
        }



        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+1
            buttonText.text: "1"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+2
            buttonText.text: "2"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+3
            buttonText.text: "3"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }


        IconButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: -3
            icon: "\uf111"
            iconSize: Style.tootlbarButtonSize
            textColor: Style.declineButtonTextColor
                //buttonText.text: "CE"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: 48+0
            buttonText.text: "0"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }
        IconButton {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumWidth: 30
            Layout.minimumHeight: 30
            buttonId: -2
            icon: "\uf00c"
            iconSize: Style.tootlbarButtonSize
            textColor: Style.acceptButtonTextColor
            //buttonText.text: "OK"
            onBtnClicked:  {
                panel.btnClicked(buttonId);
            }
        }


}

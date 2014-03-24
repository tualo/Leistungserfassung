import QtQuick 2.0
import ".."

Rectangle {

    id: list
    property bool animationEnabled: true


    color: Style.backgroundColor


    property int selectedIndex: -1
    property variant locale: Qt.locale("de_DE")


    property alias model: storeListModel


    property var reportStore: null

    signal itemSelected(int index)
    signal totalChanged(double total)





    function getCurrent(){
        if (selectedIndex!==-1){
            return model.get(selectedIndex);
        }else{
            return null;
        }
    }

    function removeAll(){
        while(selectedIndex!=-1){
            removePosition()
        }
    }

    function removePosition(){
        if(selectedIndex!==-1){
            model.remove(selectedIndex)
        }
        if (model.count>0){
            selectedIndex=model.count-1;
            model.setProperty(selectedIndex,'_selected',true)
        }else{
         selectedIndex=-1
        }
        return selectedIndex;
    }

    Component.onCompleted: {
        //StoreListViewData.setModel(storeListModel);
    }
    Component {
        id: contactDelegate
        Item {


            anchors.left: parent.left
            anchors.right: parent.right
            height: Style.textSize*2  + Style.padding

            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            clip: true


            Row {
                spacing: 3
                Rectangle {
                    width: listView.width
                    height: Style.textSize*2  + Style.padding
                    color: "#00000000"
                    radius: 0
                    clip: true
                    antialiasing: true
                    border.width: 0

                    Rectangle {
                        id: rectangle1
                        x: Style.radius * -1
                        y: 2
                        width: listView.width + Style.radius - Style.padding
                        height: Style.textSize*2  + Style.padding
                        color: (_selected)?Style.selectedItemBackgroundColor:Style.itemBackgroundColor
                        radius: Style.radius
                    }

                    Text {
                        text: artikel.replace('Zustellung - ','')
                        y: rectangle1.height/2 - Style.textSize/2
                        x: Style.padding
                        font.pixelSize: Style.textSize
                        color: Style.textColor
                    }

                    Text {
                        text: Math.round(anzahl)
                        width: Style.textSize*6
                        horizontalAlignment: Text.AlignRight
                        y: rectangle1.height/2 - Style.textSize/2
                        x: listView.width - Style.padding - Style.padding - Style.textSize*6
                        font.pixelSize: Style.textSize
                        color: Style.textColor
                    }

                }

            }

            Timer {
             id: buttonPressedTimer
             interval: 300; running: false; repeat: false
             onTriggered: {

                 storeListModel.setProperty(selectedIndex,'_selected',false);
                 storeListModel.setProperty(index,'_selected',true)
                 selectedIndex = index

                 itemSelected(selectedIndex)
                 refreshList();
             }
            }
            SequentialAnimation {
                 id:anim
                 //PropertyAction  { target: rect; property: "color"; value:(_selected)?selectedItemColor:unselectedItemColor}
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    buttonPressedTimer.restart()
                }
                onPressedChanged: {

                }
            }

        }
    }

    ListModel{
        id:  storeListModel
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: storeListModel
        delegate: contactDelegate
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }
}

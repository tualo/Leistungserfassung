import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "../../controls"
import "../../content/delegates"
import "../../singleton"
 

Item {
    id: root
    property alias listModel: listModel
    property var lastSelectedIndex: null
    signal itemSelected( var item )
    
    Component.onCompleted: {
        //load();
    }

    ListModel{
        id:  listModel
    }

    ScrollView {
        width: parent.width
        height: parent.height
        flickableItem.interactive: true
        ListView {
            anchors.fill: parent
            model: listModel
            delegate: CoworkersArticleListDelegate {
                onClicked: {
                    if (index!==-1){
                        if (lastSelectedIndex!==null){
                            listModel.setProperty(lastSelectedIndex,'__selected',false);
                        }
                        lastSelectedIndex = index;
                        
                        listModel.setProperty(index,'__selected',true);
                        itemSelected(listModel.get(index));
                    }
                }
            }
            
        }

        style: ScrollViewStyle {
            transientScrollBars: true
            handle: Item {
                implicitWidth: 14
                implicitHeight: 26
                Rectangle {
                    color: "#424246"
                    anchors.fill: parent
                    anchors.topMargin: 6
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.bottomMargin: 6
                }
            }
            scrollBarBackground: Item {
                implicitWidth: 14
                implicitHeight: 26
            }
        }
    }
    
    
    
    
    
    
    

}
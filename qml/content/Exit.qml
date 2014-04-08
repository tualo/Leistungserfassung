import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1


import "../controls"
import "../singleton"
    
TualoWindow {
    id: root
    title: "Beenden"

    
    Component.onCompleted: {
        App.logout(function(){
            Qt.quit();
        });
    }
    ScrollView {
        anchors.fill: parent
        //flickableItem.flickingVertically: true
        flickableItem.interactive: true

        contentItem : Rectangle {
        }
    }
}
import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../singleton"
import "../controls"
import "../controls/calendar"

TualoWindow {
    id: root
    title: "Kalender"
    doneText: "Ok \uf00c"
    
    function onDoneClicked(){
        App.setDate( cal.date);
        stackView.pop()
    }
    
    Calendar {
        id: cal
        anchors.fill: parent
    }     
}
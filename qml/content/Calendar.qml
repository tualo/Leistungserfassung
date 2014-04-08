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
        //App.debug('Calendar','onDoneClicked',cal.date)
        App.use_date = cal.date;
        App.saveSettings();
        stackView.pop()
    }
    
    Calendar {
        id: cal
        anchors.fill: parent
    }     
}
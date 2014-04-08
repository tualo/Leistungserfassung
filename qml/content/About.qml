import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../controls/"
TualoWindow {
    id: root
    title: "Über"
   
    
    ScrollView {
        anchors.fill: parent
        
        flickableItem.interactive: true

        contentItem :    Text {
            x: 100
            width: root.width - 200
            font.pixelSize: 28
            color: "white"
            wrapMode: Text.WordWrap
            text: [
                "tualo solutions GmbH",
                "Im Maierhof 19",
                "72379 Hechingen",
                "",
                "http://tualo.de",
                "",
                "Lizenz",
                "======",
                "Dieses Programm ist unter GPLv3 lizensiert. Es darf weitergeben und verändert werden, solange jedem neuen Nutzer das gleiche Recht, bzw. die gleiche Lizenz, eingräumt wird.",
                "",
                "Mehr zu dieser Lizenz erfahren Sie unter:",
                "",
                " * http://www.gnu.org/licenses/gpl.html",
                "",
                "Quellcode",
                "======",
                "Den Quellcode zu dieser Anwendung erhalten Sie unter:",
                "",
                " * https://github.com/tualo/Leistungserfassung",
                "",
                "",
                "Datenschutz",
                "======",
                "Dieses Programm verarbeitet und übermittelt Daten, die gegebenenfalls personenbezogene Daten enthalten. Diese Daten werden nur während der Verarbeitung erhoben und an die angegebene URL übermittelt. Die Daten werden nicht in diesem Programm gespeichert. Der weitere Datenschutz obliegt somit beim Betreiber der URL.",
                "",
                "",
                ""
            ].join("\n")
    }
    }
}
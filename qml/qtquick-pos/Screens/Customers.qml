import QtQuick 2.0
import ".."
Rectangle {

    clip: true

    anchors.fill: parent

    id: list

    property bool animationEnabled: true


    color: Style.backgroundColor

    property int selectedIndex: 0
    property variant locale: Qt.locale("de_DE")

    property alias model: storeListModel

    signal itemSelected(int index)

    Component.onCompleted: {
    }

    /**
    * Verarbeiten des Resultats.
    * Falls das Resultat eine Liste "data" enthält wird die Liste mit den Einträgen befüllt.
    * Es werden nur einträge ergänzt, bei denen die Geschäftsstelle zu der Geschäftsstelle in den
    * Einstellungen passt.
    */
    function result( err, res ){
        if ( res !== null){
            var liste = res.result.data;
            for(var i =0; i < liste.length; i++){
                try{
//                    console.log('Ergebnis',loadingMask.jsonDebug(liste[i]));
                    var id  = liste[i].angestelltennummer;
                    var vorname  = liste[i].vorname;
                    var nachname  = liste[i].nachname;
                    var geschaeftsstelle  = liste[i].geschaeftsstelle;
                    if (geschaeftsstelle === settings.geschaeftsstelle){
                        storeListModel.append({
                             id: id,
                             name: nachname+', '+vorname,
                             vorname: vorname,
                             nachame: nachname,
                             _selected: (i===0)?true:false
                        });
                    }
                }catch(e){
                    console.log('err',e);
                }
            }
        }
    }

    /**
    * Abfragen aller Mitarbeiter.
    */
    function load(){

        page.state = "Customers";
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: settings.beleg,
            sid: loadingMask.sessionID,
            extMethod: 'getCourierList',
            extTID: '1',
            extAction: 'report'
        }
        loadingMask.post(settings.url,post,result);
    }

    Component {
        id: contactDelegate
        Item {




            x: Style.padding
            width: parent.width - Style.padding *2
            height: Style.textSize + Style.padding*2.5

            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            clip: true

            property int btnState: 0

            Row {
                spacing: 5
                Rectangle{
                    id: rect
                    width: listView.width - Style.padding*2
                    height: Style.textSize + Style.padding*2
                    color: (_selected)?Style.selectedItemBackgroundColor:Style.itemBackgroundColor
                    radius: Style.radius

                    Text {
                        text: name
                        y: (rect.height)/2 - Style.textSize/2
                        x: Style.padding
                        color: Style.textColor
                        width: rect.width - Style.padding*2
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: Style.textSize
                    }
                }
            }


            Timer {
             id: buttonPressedTimer
             interval: 300; running: false; repeat: false
             onTriggered: {
                 storeListModel.setProperty(list.selectedIndex,'_selected',false);
                 storeListModel.setProperty(index,'_selected',true)
                 list.selectedIndex = index
                 itemSelected(list.selectedIndex)
             }
            }
            SequentialAnimation {
                 id:anim
                 PropertyAction  { target: rect; property: "scale"; value:"0.9"}
                 PauseAnimation { duration: 100 }
             }
            SequentialAnimation {
                 id:anim_stop
                 PropertyAction  { target: rect; property: "scale"; value:"1"}
                 PauseAnimation { duration: 100 }
             }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    //_selected=!_selected
                    if (animationEnabled && !anim.running) {
                        anim.restart()
                    }
                    btnState=0;
                    buttonPressedTimer.restart()
                }
                onPressedChanged: {
                    btnState++;
                    if (btnState==2){
                        if (animationEnabled && !anim_stop.running) {
                            anim_stop.restart()
                        }
                         btnState=0;
                        buttonPressedTimer.stop()
                    }
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
        focus: true
    }
}

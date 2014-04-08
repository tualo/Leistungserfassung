import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "../controls"
import "../content/delegates"
import "../singleton"
 

TualoWindow {
    id: root
    title: "Mitarbeiter am "+App.getShortDateString()

    Component.onCompleted: {
        load();
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
            delegate: CoworkersDelegate {
                onClicked: {
                    if (index!==-1){
                        App.useReference = listModel.get(index);
                        App.use_name = App.useReference.name;
                        stackView.push(Qt.resolvedUrl("../content/CoworkerInput.qml"));
                    }
                    
                    
                }//stackView.push(Qt.resolvedUrl("../content/Calendar.qml"))
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
    
    
    
    
    
    
    
    
   
    /**
    * Abfragen aller Mitarbeiter.
    */
    function load(){

       
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: App.receipt,
            sid: App.sessionID,
            extMethod: 'getCourierList',
            extTID: '1',
            extAction: 'report'
        }
        App.post(App.url,post,result);
    }
    
     /**
    * Verarbeiten des Resultats.
    * Falls das Resultat eine Liste "data" enthält wird die Liste mit den Einträgen befüllt.
    * Es werden nur einträge ergänzt, bei denen die Geschäftsstelle zu der Geschäftsstelle in den
    * Einstellungen passt.
    */
    function result( err, res ){
        
        //App.debug('Coworkers','result',App.jsonDebug(res));
        
        if ( res !== null){
            
            
            listModel.clear();

            var liste = res.result.data;
            for(var i =0; i < liste.length; i++){
                try{
                    var id  = liste[i].angestelltennummer;
                    var vorname  = liste[i].vorname;
                    var nachname  = liste[i].nachname;
                    var amount  = (liste[i].amount)?liste[i].amount:0;
                    var geschaeftsstelle  = liste[i].geschaeftsstelle;
                    if (geschaeftsstelle === App.department){
                        listModel.append({
                             id: id,
                             name: nachname+', '+vorname,
                             amount: amount,
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

}
import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "../../controls"
import "../../content/delegates"
import "../../singleton"
 

Item {
    id: root
    property var lastSelectedIndex: null
    signal itemSelected( var item )
    
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
            delegate: RegionListDelegate {
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
    
    
    
    
    
    
    function load(){
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: App.receipt,
            sid: App.sessionID,
            extMethod: 'getRegionsList',
            extTID: '1',
            extAction: 'report',
            kundennummer: App.useReference.id,
            belegnummer: -1,
            kostenstelle: 0,
            pno: App.useReference.id
        }

        
        App.post(App.url,post,processResult);
    }
    
    function processResult( err, res ){
        // App.debug('RegionList','processResult',App.jsonDebug(res));
        // App.debug('RegionList','processResult', App.department);
        if ( res !== null){
            var grid = res.result.data;
            listModel.clear();
            for(var i =0; i < grid.length; i++){
                
                if (grid[i].geschaeftsstelle === App.department){
                    grid[i].name = grid[i].tour;
                    grid[i].amount = 0;
                    grid[i].__selected=false;
                    listModel.append(grid[i]);
                    
                }
            }
        }else{
         console.log("ERROR",err);
        }
    }


    

}
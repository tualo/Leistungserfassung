import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "../controls"
import "../content/delegates"
import "../content/parts"
import "../singleton"
 

TualoWindow {
    id: root
    title: App.use_name + " am "+App.getShortDateString()
    doneText: "Speichern \uf00c"
    
    function onDoneClicked(){
        stackView.pop();
    }
    
    Timer {
        id: fadeoutTimer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
           coworkerArticleList.opacity = 1;
        }
    }
    Timer {
        id: fadeoutCoworkerReceiptInputTimer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
           coworkerReceiptInput.opacity = 1;
           coworkerReceiptInput.refresh();
        }
    }
    
    
    Component.onCompleted: {
        App.loadNewReceipt(function(){
            var articleHash = {},
                i,
                itemList = [],
                row;
            
            for(i in App.receiptStore.grid){
                row = App.receiptStore.grid[i];
                if (typeof articleHash[row.artikel] === 'undefined'){
                    itemList.push( {
                        name: row.artikel,
                        amount: row.anzahl*1,
                        __selected: false
                    }); 
                }
            }
            App.debug('CoworkerInput','onCompleted',App.jsonDebug(itemList))
            coworkerArticleList.listModel.clear();
            for(i in itemList){
                coworkerArticleList.listModel.append(itemList[i]);
            }
            regionList.opacity = 1;
        });
    }

    Rectangle{
        id: grid
        width: parent.width
        height: parent.height
        color: "#21212f"
        
        
        RegionList {
            id: regionList
            width: parent.width / 3
            height: parent.height
            opacity: 0
            Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
            onItemSelected: {
                App.currentRegion = item;
                if (coworkerArticleList.opacity === 0){
                    coworkerArticleList.opacity = 1;
                }else{
                    coworkerArticleList.opacity = 0;
                    coworkerReceiptInput.opacity = 0;
                    fadeoutTimer.start();
                }
                //App.debug('CoworkerInput','onItemSelected',item.name);    
                
            }
        }
        
        
        CoworkerArticleList {
            id: coworkerArticleList
            x: regionList.x + regionList.width
            width: parent.width / 3
            height: parent.height
            opacity: 0
            Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
            onItemSelected: {
                App.currentArticle = item;
                if (coworkerReceiptInput.opacity === 0){
                    coworkerReceiptInput.opacity = 1;
                    coworkerReceiptInput.refresh();
                }else{
                    coworkerReceiptInput.opacity = 0;
                    fadeoutCoworkerReceiptInputTimer.start()
                }
            }
        }
        
        ReceiptInput{
            id: coworkerReceiptInput
            x: coworkerArticleList.x + coworkerArticleList.width
            opacity: 0
            width: parent.width / 3 - 10
            height: parent.height - 10
            Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
        }
        
    }
    


}
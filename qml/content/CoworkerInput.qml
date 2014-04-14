import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1


import QtMultimedia 5.0
import QZXing 1.0

import "../controls"
import "../content/delegates"
import "../content/parts"
import "../singleton"


TualoWindow {
    id: root
    title: App.use_name + " am "+App.getShortDateString()
    doneText: "Speichern \uf00c"
    property bool enabledSave: true
    
    function onDoneClicked(){
        if (enabledSave === true){
            enabledSave = false;
            
            App.saveReceipt(function(){
                stackView.pop();
            });
        }
    }

    
    
    Timer {
        id: fadeoutTimer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            coworkerArticleList.opacity = 1;
            root.refresh();
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

    function refresh(){
        var articleHash = {},
            i,
            j,
            itemList = [],
            row,
            amount = 0,
            selected = false,
            grid = App.getCurrentGrid(),
            article = "";

        //App.debug('CoworkerInput','refresh grid',App.jsonDebug(grid));
        //App.debug('CoworkerInput','Grid length',grid.length);
        for(i in grid){
            row = grid[i];
            if (typeof articleHash[row.artikel] === 'undefined'){
                amount = 0;
                selected = false;
                articleHash[row.artikel] = true;




                itemList.push( {
                    name: row.artikel,
                    amount: amount,
                    __selected: selected
                }); 
            }
        }

        if ( App.currentRegion!==null){
            //App.debug('CoworkerInput','currentRegion name',App.currentRegion.name);
            for(j in itemList){
                article = itemList[j].name;
                for(i in grid){
                    row = grid[i];
                    if ( (row.bereich === App.currentRegion.name) ){
                        if ( (row.artikel) && (row.artikel === article) ){
                            //App.debug('CoworkerInput','currentRegion row',App.jsonDebug(row));
                            itemList[j].amount = row.anzahl*1;
                            //itemList[j].__selected = true;
                        }
                    }
                }
            }
        }

        //App.debug('CoworkerInput','onCompleted',App.jsonDebug(itemList))
        coworkerArticleList.listModel.clear();
        for(i in itemList){
            coworkerArticleList.listModel.append(itemList[i]);
        }
        coworkerArticleList.selectIndex(0);
    }

    

    Component.onCompleted: {
        enabledSave = true;    
        title = App.use_name + " am "+App.getShortDateString();
        var tempDate = App.use_date;
        App.loadNewReceipt(function(){
             App.use_date = tempDate;
            App.loadSingleDayReceipt(function(){
                refresh();
                regionList.opacity = 1;
            });
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
                    root.refresh();
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
            onRefreshed:{
                coworkerArticleList.listModel.setProperty(coworkerArticleList.lastSelectedIndex,'amount',amount);
                //root.refresh();
            }
        }

    }



}

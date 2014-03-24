import QtQuick 2.0
import QtQuick.Layouts 1.1
import "../Main"
import ".."

Rectangle {
    id: posPanel
    anchors.fill: parent
    clip: true

    property alias eastPanel: eastPanel
    property alias regionPanel: regionPanel
    property alias itemsPanel: itemsPanel


    property var reportStore: null

    color: Style.backgroundColor

    function refreshList(){
        var article = itemsPanel.getCurrent().artikel;
        var region = regionPanel.getCurrent().region;
        var model = itemsPanel.model;
        //console.log('refreshList',loadingMask.jsonDebug(reportStore));
        //console.log('refreshList',model.count)
        for(var i = 0; i < model.count ; i++  ){
            var amount = getAmount(model.get(i).artikel,region);
            //console.log('refreshList',model.get(i).artikel,region,amount)
            model.setProperty(i,'anzahl',amount );
        }

        eastPanel.inputPanel.value = Math.round( getAmount(itemsPanel.getCurrent().artikel,regionPanel.getCurrent().region) );
        eastPanel.inputPanel.buttonInput(-11);
    }

    function setAmount(amount){
        //console.log('setAmount',amount,itemsPanel.model.get(itemsPanel.selectedIndex).artikel);

        var article = itemsPanel.getCurrent().artikel;
        var region = regionPanel.getCurrent().region;
        //console.log('SET',amount);
        var appendId =true;
        for(var i in reportStore.grid){
            if (reportStore.grid[i].artikel === article ){
                if (reportStore.grid[i].bereich === region ){
                    reportStore.grid[i].anzahl = amount * 1;
                    console.log('SET IT TO',amount);
                    appendId = false;
                }
            }
        }
        // to position was not found, so we have to add it
        if (appendId===true){
            var item = {
                id: 'NEW_'+ (10000+ reportStore.grid.length),
                artikel: article,
                anzahl: amount,
                bereich: region,
                steuer: 0,
                steuersatz: 0,
                epreis: 0,
                netto: 0,
                brutto: 0,
                bemerkung: '',
                referenz: '',
                zusatztext: '',
                vdatum: '1970-01-01'
            }
            reportStore.grid.push(item);
           // console.log('ADD IT',reportStore.grid.length,amount);
        }

        refreshList();
    }

    function getAmount(article,region){
        if (article === null){
            article = itemsPanel.getCurrent().artikel;
        }

        for(var i in reportStore.grid){
            if (reportStore.grid[i].artikel === article ){
                if (reportStore.grid[i].bereich === region ){
                    return reportStore.grid[i].anzahl * 1;
                }
            }
        }
        return 0;
    }

    /**
    * Ergebniss des Laden eines Beleges verarbeiten!
    */
    function processResult( err, res ){
        if ( res !== null){
            //console.log(res.result.head.belegnummer);
            //console.log(loadingMask.jsonDebug(res.result.grid));
            itemsPanel.removeAll()
            var grid = res.result.grid;
            var articleHash = {};
            var index = 0;
            reportStore = res.result;

            for(var i =0; i<grid.length; i++){

                //console.log(loadingMask.jsonDebug(grid[i]));
                if (typeof articleHash[grid[i].gruppe] === 'undefined'){
                    var item = {
                       _selected: (index===0)?true:false,
                        artikel: grid[i].artikel,
                        anzahl: grid[i].anzahl *1
                    };
                    itemsPanel.model.append(item);
                    articleHash[grid[i].artikel] = index;
                    index++;
                }
            }
            if (res.result.head.belegnummer !== -1){

            }else{

            }
            itemsPanel.selectedIndex = 0;


            loadLastReport(-2,res.result.head.kundennummer,0);
            refreshList();

        }else{
         console.log("ERROR",err);
        }
    }

    function loadReport(reportNo,receiverNo,receiverCst){

        //StoreListViewData.getReport(reportNo,receiverNo,receiverCst);
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: settings.beleg,
            sid: loadingMask.sessionID,
            extMethod: 'getReport',
            extTID: '1',
            extAction: 'report',
            kundennummer: receiverNo,
            belegnummer: reportNo,
            kostenstelle: receiverCst
        }
        //console.log(settings.url);
        loadingMask.post(settings.url,post,processResult);
    }


    /**
    * Ergebniss des Laden eines Beleges verarbeiten!
    */
    function processLastReportResult( err, res ){
        //console.log(loadingMask.jsonDebug(err));
        //console.log(loadingMask.jsonDebug(res));
        if ( res !== null){
            //console.log();
            //console.log(loadingMask.jsonDebug(res.result.grid));

            var grid = res.result.grid;


            var articleHash = {};
            var index = 0;
            reportStore = res.result;

            if (res.result.head.belegnummer === -1){
                eastPanel.displayNumberText = 'neuer Beleg';
            }else{
                eastPanel.displayNumberText = res.result.head.belegnummer;
            }

            eastPanel.displayDateText = res.result.head.datum;

            refreshList();
        }else{
         console.log("ERROR",err);
        }
    }

    function loadLastReport(reportNo,receiverNo,receiverCst){

        //StoreListViewData.getReport(reportNo,receiverNo,receiverCst);
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: settings.beleg,
            sid: loadingMask.sessionID,
            extMethod: 'getReport',
            extTID: '1',
            extAction: 'report',
            kundennummer: receiverNo,
            belegnummer: reportNo,
            kostenstelle: receiverCst
        }
        console.log(settings.url);
        loadingMask.post(settings.url,post,processLastReportResult);
    }



    function save(){

        //StoreListViewData.getReport(reportNo,receiverNo,receiverCst);
        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: settings.beleg,
            sid: loadingMask.sessionID,
            extMethod: 'save',
            extTID: '1',
            extAction: 'report'
        }

        for(var i in reportStore.head){
            post[i] = reportStore.head[i];
        }
        var liste = [];
        for( var i in reportStore.grid){
            if (reportStore.grid[i].anzahl * 1 !== 0){
                liste.push(reportStore.grid[i]);
            }
        }
        post.liste = encodeURIComponent(JSON.stringify(liste));
        //console.log(post.liste);
        page.state = "Wait";
        loadingMask.post(settings.url,post,processSaveResult);
    }

    function processSaveResult(err,res){
        page.state = "Customers";
    }

    Top{
        id: topToolBar
    }


    East{
        id: eastPanel
    }

    Items{
        id: itemsPanel
        x: -1* regionPanel.width
        y: topToolBar.height
        width: parent.width - regionPanel.width - eastPanel.width
        height: parent.height - topToolBar.height

        Behavior on x {
            SequentialAnimation {
             NumberAnimation {
                 easing {
                     type: Easing.OutElastic
                     amplitude: 1.5
                     period: 3
                 }
                 property: "x"; to: 0;
             }
             NumberAnimation {
                 easing {
                     type: Easing.OutElastic
                     amplitude: 1.5
                     period: 3
                 }
             }
            }
         }

        onItemSelected: {
            //console.log('Items','onItemSelected',index,itemsPanel.getCurrent().artikel);

            eastPanel.inputPanel.value = Math.round( getAmount(itemsPanel.getCurrent().artikel,regionPanel.getCurrent().region) );
            eastPanel.inputPanel.buttonInput(-11);
        }

    }

    Region{
        id: regionPanel
        x: 0
        y: topToolBar.height
        width: 400
        height: parent.height - topToolBar.height
        onItemSelected: {
            itemsPanel.x = 0;
            itemsPanel.x = regionPanel.width;
            refreshList()
            eastPanel.inputPanel.value = Math.round( getAmount(itemsPanel.getCurrent().artikel,regionPanel.getCurrent().region) );
            eastPanel.inputPanel.buttonInput(-11);
        }
    }



}

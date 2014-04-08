pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0

//OtherType.qml
Item {
    property string sessionID: ""
    property string url: ""
    property string username: ""
    property string password: ""
    property string client: ""
    property string receipt: ""
    property string department: ""
    property string reference_number: ""
    property string items_group: ""
    
    
    property string use_receipt_text: "neuer Beleg"
    property var use_date: null
    property var useReference: null
    property var receiptStore: null
    
    property var currentRegion: null
    property var currentArticle: null
    
    property string use_name: "" // contains the current selected customer/ coworker ... 
                                 // for displaying in title bars
    
    
    property var __callback : null

    Timer {
        id: timeoutTimer
        interval: 10000
        running: false
        repeat: false
        onTriggered: {
            __callback({response: "not connected"},null);
        }
    }
    
    
    Component.onCompleted: {
        use_date = new Date();
    }
    
    function getShortDateString(){
        var str = use_date.toISOString().substring(0,10).split('-').reverse().join('.');
        return str;
    }
    
    function debug(QMLFile,Tag,o){
        console.debug(QMLFile,Tag,o);
    }
    
    function loadSettings(){

        var db = LocalStorage.openDatabaseSync("tualo-lpos", "1.0", "Tualo-LPOS Database", 1024*1024*10); // 10 - MB
        db.transaction(
            function(tx) {

                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings( key varchar(10), key_value varchar(255) )');

                var rs = tx.executeSql('SELECT * FROM settings');
                for(var i = 0; i < rs.rows.length; i++) {
                    if (rs.rows.item(i).key==='url'){ url = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='mandant'){ client = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='username'){ username = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='password'){ password = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='kasse'){ reference_number = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='beleg'){ receipt = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='department'){ department = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='items_group'){ items_group = rs.rows.item(i).key_value; }
                    
                }
               
                login();
            }
        )

    }

    function saveSettings(){

        var db = LocalStorage.openDatabaseSync("tualo-lpos", "1.0", "Tualo-LPOS Database", 1024*1024*10); // 10 - MB
        db.transaction(
            function(tx) {
                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings( key varchar(10), key_value varchar(255) )');


                tx.executeSql('delete from settings where key = ?',['url']);
                tx.executeSql('delete from settings where key = ?',['mandant']);
                tx.executeSql('delete from settings where key = ?',['username']);
                tx.executeSql('delete from settings where key = ?',['password']);
                tx.executeSql('delete from settings where key = ?',['kasse']);
                tx.executeSql('delete from settings where key = ?',['beleg']);

                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'url', url  ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'mandant', client  ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'username', username ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'password', password ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'kasse', reference_number  ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'beleg', receipt  ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'department', department  ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'items_group', items_group  ]);

            }
        )

    }

    
    function login(){
        post(url, {
            username: username,
            mandant: client,
            password: password,
            "return": "json"
        },function(err,res){
            if (err){
                debug('App','login - ERROR',jsonDebug(err));
            }else if (res.success){
                //debug('App','login',jsonDebug(res));
                sessionID = res.sid;
            }
        });
    }
    
    function logout(cb){
        post(url, {
            TEMPLATE: 'NO',
            cmp: 'cmp_logout',
            sid: sessionID
        },function(err,res){
            cb()
        },false);
    }
    
    
    /**
    * formating objects for console logging
    */
    function jsonDebug(res,intend){
        var s = '';
        if (typeof intend === 'undefined'){
            intend = '   ';
        }
        for(var i in res){
            s+=intend;
            if (typeof res[i]==='object'){
                s+=i+': '+ jsonDebug(res[i],intend+'   ');
            }else if (typeof res[i]==='function'){
                s+=i+': '+ '[function]';
            }else{
                s+=i+': '+ res[i];
            }
            s+="\n";
        }
        return "{\n"+s+"\n"+intend+"}";
    }
    
    
    
    
    function post(url,data,callback,parse) {

        if (typeof parse==='undefined'){
            parse = true;
        }
        var xhr = new XMLHttpRequest();
        var send_data = "";
        for(var i in data){
            send_data +=i+"="+escape(data[i])+"&";
        }

        var http_result = "";

        __callback = callback;
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                timeoutTimer.stop()
                if(xhr.status === 200) {
                    http_result = xhr.responseText;
                    if (typeof callback!=='undefined'){
                        try{
                            if (parse===true){
                                var result = JSON.parse(http_result);
                                result._responseText = http_result;
                            }else{
                                result = http_result;
                            }
                            callback(null,result)
                        }catch(e){
                            console.log(e);
                            callback({
                                 error: e,
                                 status: xhr.status,
                                 response: xhr.responseText
                             },null);
                        }
                    }
                } else {
                    callback({
                        status: xhr.status,
                        response: xhr.responseText
                    },null)
                }
            } else if (xhr.readyState === 3){
            } if( xhr.readyState === 1 ) {
                timeoutTimer.start()
            }
        }
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", send_data.length);
        xhr.setRequestHeader("Connection", "close");
        xhr.send(send_data);
    }
    
    
    
    
    function receiptInfoText(){
        var text = [];
        
        if (receiptStore.head.belegnummer*1 === -1){
            text.push('neuer Beleg');
        }else{
            text.push('Nr.: '+receiptStore.head.belegnummer);
        }
        text.push('Datum: '+getShortDateString());
        
        if (currentRegion !== null){
            text.push('SF/SG: '+currentRegion.name);
        }
        if (currentArticle !== null){
            text.push('Artikel: '+currentArticle.name);
        }
        
        
        return text.join("\n");
    
    }
    

    function loadNewReceipt(callback){
        var receiptNo = -1,
            receiverNo = useReference.id,
            receiverCst = (useReference.kostenstelle)?useReference.kostenstelle:0,
            postArg = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: receipt,
            sid: sessionID,
            extMethod: 'getReport',
            extTID: '1',
            extAction: 'report',
            kundennummer: receiverNo,
            belegnummer: receiptNo,
            kostenstelle: receiverCst
        };
        debug('App','loadNewReceipt',jsonDebug(post));
        try{
            post(url,postArg, function( err, res ){


                if ( res !== null){
                    var dateParts = res.result.head.datum.split('-');
                    
                    use_date = new Date();
                    use_date.setMonth(dateParts[1]);
                    use_date.setYear(dateParts[0]);
                    use_date.setDate(dateParts[2]);
                    //debug('App','loadNewReceipt',use_date);
                    
                    receiptStore = res.result;
                    if (typeof callback==='function'){
                        callback();
                    }
                }else{
                    debug('App','loadNewReceipt - ERROR',jsonDebug(err));
                }

            } );
        }catch(e){
            console.log(e)
            console.log(e.stack);
        }
    }

    
    
    
}

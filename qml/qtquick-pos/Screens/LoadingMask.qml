import QtQuick 2.0
import ".."
Rectangle {
    width: parent.width
    height: parent.height

    property string sessionID: 'macc_b07f1a6ecff66bdd3fd0187c1'

    color: Style.backgroundColor
FontLoader { id: fontAwesome; source: "../icons/fontawesome-webfont.ttf" }
    Rectangle {
        width: 400
        height: 300
        x: parent.width/2 - width/2
        y: parent.height/2 - height/2
        border.color: Style.textColor
        border.width: 3
        radius: Style.radius
        color: Style.backgroundColor
        Text {
            id: iconId
            text: "\uf021"
            width: parent.width
            y: 0
            color: Style.textColor
            font.pixelSize: parent.height * 0.5
            font.family: fontAwesome.name
            horizontalAlignment: Text.AlignHCenter
        }

        Text{

            x: parent.width/2 - width/2
            y: parent.height/1.5

            color: Style.textColor
            id: waitText
            text: "Bitte warten ..."

        }
        Text{
            x: parent.width/2 - width/2
            y: waitText.y + waitText.height
            id: statusText
            text: ""
            color: Style.declineButtonTextColor
        }
    }




    Timer {
     id: switchState
     interval: 2000; running: false; repeat: false
     onTriggered: {
         customers.load();
         switchState.stop();
     }
    }

    function login(){
        if (
                (settings.username==='') ||
                (settings.mandant==='') ||
                (settings.password==='')
        ){
            page.state="Settings";
        }else{
            page.state="Wait";
            post(settings.url, {
                     username: settings.username,
                     mandant: settings.mandant,
                     password: settings.password,
                     "return": "json"
                 },processLogin);

        }
    }



    function processLogin(err,res){
        if (err){
            statusText.text = err.response;
            page.state =  "Settings";
        }else if (res.success){
            sessionID = res.sid;
            switchState.start()
        }
    }

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

    function post(url,data,callback) {

        statusText.text = "";
        var xhr = new XMLHttpRequest();
        var send_data = "";
        for(var i in data){
            send_data +=i+"="+escape(data[i])+"&";
        }

        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                if(xhr.status === 200) {
                    if (typeof callback!=='undefined'){
                        try{
                            var result = JSON.parse(xhr.responseText);
                            result._responseText = xhr.responseText;
                            callback(null,result)
                        }catch(e){
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
            } else {
              //  console.log("POST STATE", xhr.readyState)
            }/* if( xhr.readyState === 1 ) {
                callback(new Error("not connected"),null);

            }*/
        }
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("Content-length", send_data.length);
        xhr.setRequestHeader("Connection", "close");
        //if(cookie !== "") {
        //    xhr.setRequestHeader('Cookie', cookie)
        //}
        xhr.send(send_data);
        //console.log(send_data);
    }


}

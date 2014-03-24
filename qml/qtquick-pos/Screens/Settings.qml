import QtQuick 2.0
import QtQuick.Controls 1.1
import "../Controls"
import ".."
import QtQuick.LocalStorage 2.0



Rectangle{

    anchors.fill: parent

    signal settingsDone(bool saved)

    property alias url: url.text
    property alias mandant: mandant.text
    property alias username: username.text
    property alias password: password.text
    property alias kasse: kasse.text
    property alias warengruppe: warengruppe.text
    property alias geschaeftsstelle: kasse.text
    property alias beleg: beleg.text
    color: Style.backgroundColor

    function load(){

        var db = LocalStorage.openDatabaseSync("tualo-lpos", "1.0", "Tualo-LPOS Database", 1024*1024*10); // 10 - MB
        db.transaction(
            function(tx) {
                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS settings( key varchar(10), key_value varchar(255) )');

                var rs = tx.executeSql('SELECT * FROM settings');
                for(var i = 0; i < rs.rows.length; i++) {
                    if (rs.rows.item(i).key==='url'){ url.text = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='mandant'){ mandant.text = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='username'){ username.text = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='password'){ password.text = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='kasse'){ kasse.text = rs.rows.item(i).key_value; }
                    if (rs.rows.item(i).key==='beleg'){ beleg.text = rs.rows.item(i).key_value; }
                }

                loadingMask.login();
            }
        )

    }

    function save(){

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

                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'url', url.text ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'mandant', mandant.text ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'username', username.text ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'password', password.text ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'kasse', kasse.text ]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', [ 'beleg', beleg.text ]);

                settingsDone(true)

            }
        )


    }

    function cancle(){
        settingsDone(false);

    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 8


        Text {
            height: Style.textSize + Style.padding
            text: "Einstellungen"
            color: Style.textColor
            font.pointSize: Style.textSize
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: errMsg
            width: parent.width
            font.pointSize: 12
            color: "red"
            text: " "
        }
        FormInput {
            id: url
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: "http://192.0.0.1/macc/index.php"
            label: "Server:"
            focus: true
        }

        FormInput {
            id: mandant
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: ''
            label: "Mandant:"
        }
        FormInput {
            id: username
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: ''
            label: "Login:"
        }
        FormInput {
            id: password
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: ''
            echoMode: TextInput.Password
            label: "Kennwort:"
        }
        FormInput {
            id: kasse
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: ""
            label: "Geschäftsstelle:"
        }
        FormInput {
            id: warengruppe
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: "Mitarbeiter"
            label: "Warengruppe:"
        }
        FormInput {
            id: beleg
            width: parent.width
            labelWidth: parent.width*0.3
            height: 35
            text: "6"
            label: "Belegart:"
        }

        Row {
            id: btnRow
            width: parent.width
            spacing: 5

            IconButton{
                width: 50
                height: 50
                icon: "\uf00d"
                color: "red"
                onBtnClicked: {
                    Qt.quit()
                    //cancle()
                }
            }

            Rectangle{
             width: parent.width - 110
             height: 50
             color: "transparent"
            }

            IconButton{
                //anchors.right: btnRow.right
                width: 50
                height: 50
                icon: "\uf00c"
                color: "green"
                onBtnClicked: {
                    save()
                }
            }

        }
    }
}

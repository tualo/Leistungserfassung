import QtQuick 2.0
import "Screens"

Rectangle {
    id: page
    width: 1024
    height: 700
    state: "Wait"
    Component.onCompleted: {
        settings.load();
        //loadingMask.login();
        // console.log("loadPage");
        // pageLoader.source = ".qml"
        // page.state="Settings"
    }

    function globalKeyReceiver(str){
        switch (str){
        case 'CUSTOMERS':
            state = "Customers"
            break;
        case 'SETTINGS':
            state = "Settings"
            break;
        case 'QUIT':
            Qt.quit();
            break;
        }

    }

    LoadingMask{
        id: loadingMask
        visible: false
    }

    Settings{
        id: settings
        visible: false
        onSettingsDone: {
            settings.load()
        }
    }

    Customers{
        id: customers
        visible: false
        onItemSelected:{
            var item = customers.model.get(index);
            // laden des letzten Belegs (am akt. Tag) des Mitarbeiters, oder einen leeren Beleg.
            //mainInput.centerPanel.regionList.load( item.id );

            mainInput.regionPanel.load( item.id );
            mainInput.loadReport(-1,item.id,0);
            mainInput.eastPanel.displayText = item.name;

            //console.log('customers',item.id);



            //mainInput.westPanel.store.loadReport(-2,item.id,0);
            page.state="MainUI"


        }
    }

    POS{
        id: mainInput
        visible: false
    }


    states: [
        State {
            name: "Settings"
            PropertyChanges {
                target: settings;
                state: "focused"
                visible: true
            }
            PropertyChanges {
                target: customers;
                visible: false
            }
            PropertyChanges {
                target: mainInput;
                visible: false
            }
            PropertyChanges {
                target: loadingMask;
                visible: false
            }
        },
        State {
            name: "Customers"
            PropertyChanges {
                target: customers;
                state: "focused"
                visible: true
            }
            PropertyChanges {
                target: settings;
                visible: false
            }
            PropertyChanges {
                target: mainInput;
                visible: false
            }
            PropertyChanges {
                target: loadingMask;
                visible: false
            }
        },
        State {
            name: "MainUI"
            PropertyChanges {
                target: mainInput;
                state: "focused"
                visible: true
            }
            PropertyChanges {
                target: settings;
                visible: false
            }
            PropertyChanges {
                target: customers;
                visible: false
            }
            PropertyChanges {
                target: loadingMask;
                visible: false
            }
        },
        State {
            name: "Wait"
            PropertyChanges {
                target: loadingMask;
                state: "focused"
                visible: true
            }
            PropertyChanges {
                target: settings;
                visible: false
            }
            PropertyChanges {
                target: customers;
                visible: false
            }
            PropertyChanges {
                target: mainInput;
                visible: false
            }
        }
      ]
/*
    Loader{
     id: pageLoader
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }
    */
}

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../singleton"

GridLayout {
    id: root
    columns: 3
    rowSpacing: 2
    columnSpacing: 2
    
    property int gridIndex: -1
    
    
    signal refreshed( int amount )
    
    
    FontLoader { id: fontAwesome; source: "../resources/fontawesome-webfont.ttf" }
    
    property var buttons: [
        '7','8','9',
        '4','5','6',
        '1','2','3',
        '\uf00d','0',''
    ];
    
    
    function refresh(){
        var i,
            grid = App.getCurrentGrid(),
            amount = 0;
        
        infoText.text = App.receiptInfoText();
        
        gridIndex = -1;
        for(i in grid){
            if (App.currentArticle !== null){
                if (grid[i].artikel === App.currentArticle.name){
                    if (App.currentRegion !== null){
                        if (grid[i].bereich === App.currentRegion.name){
                            amount = grid[i].anzahl;
                            gridIndex = i;
                        }
                    }
                }
            }
        }
        if (App.currentArticle!==null){
            if (App.currentRegion!==null){
                if (gridIndex === -1){
                    gridIndex = grid.length;

                    gridIndex = App.addToGrid({
                        id: 'NEW_'+ (10000+ gridIndex),
                        artikel: App.currentArticle.name,
                        anzahl: amount,
                        bereich: App.currentRegion.name,
                        steuer: 0,
                        steuersatz: 0,
                        epreis: 0,
                        netto: 0,
                        brutto: 0,
                        bemerkung: '',
                        referenz: '',
                        zusatztext: '',
                        vdatum: App.use_date.toISOString().substring(0,10)
                    })
                }
            }
        }
        numberText.text = amount;
        
    }
    
    
    
    Rectangle {
        id: infoRectangle
        Layout.columnSpan: 3
        height: 24*5
        
        Text{
            id: infoText
            width: parent.width
            x: root.width
            font.pixelSize: 24
            color: "white"
            text: ""
            horizontalAlignment: Text.AlignRight
        }
        
    }
    
    Rectangle {
        id: numberRectangle
        Layout.columnSpan: 3
        height: 60
        
        Text{
            id: numberText
            width: parent.width
            x: root.width
            font.pixelSize: 32
            color: "white"
            text: ""
            horizontalAlignment: Text.AlignRight
        }
        
    }
    
    Repeater {
        id: repeater
        model: buttons.length
        Button{
            width: parent.width / parent.columns - parent.columnSpacing*1
            height: (parent.height - infoRectangle.height - numberRectangle.height) / (buttons.length/parent.columns) - parent.rowSpacing*1
            style: touchStyle
            text: buttons[index]
            
            onClicked: {
                switch(text){
                    case '0':
                    case '1':
                    case '2':
                    case '3':
                    case '4':
                    case '5':
                    case '6':
                    case '7':
                    case '8':
                    case '9':
                        
                        var v = App.getGridProperty(gridIndex,'anzahl');
                        v *= 10;
                        v += (text*1);
                        App.setGridProperty(gridIndex,'anzahl', v );
                        
                        break;
                    case '\uf00d':
                        App.setGridProperty(gridIndex,'anzahl', 0 );
                        //refreshed( App.getGridProperty(gridIndex,'anzahl') );
                        break;
                }
                refreshed( App.getGridProperty(gridIndex,'anzahl') );
                
                refresh();
            }
        }
    }
    
    Component {
        id: touchStyle
        ButtonStyle {
            background: Rectangle{
                implicitWidth: control.width
                implicitHeight: control.height
                border.color: false?(control.pressed ? "#d55" : "#d66"):(control.pressed ? "#555" : "#666")
                border.width: 1
                radius: 5
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.checked?(control.pressed ? "#00a" : "#11a"):(control.pressed ? "#000" : "#111") }
                    GradientStop { position: 1 ; color: control.checked?(control.pressed ? "#11a" : "#22a"):(control.pressed ? "#111" : "#222") }
                }
            }
            label: Text {
                clip: true
                text: control.text
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 23
                font.family: fontAwesome.name
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

        }
    }
}
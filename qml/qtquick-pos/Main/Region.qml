import QtQuick 2.0
import ".."
Rectangle {

    clip: true

    id: list
    property bool animationEnabled: true

    color: Style.backgroundColor



    property int selectedIndex: 0
    property variant locale: Qt.locale("de_DE")

    property alias model: articleModel

    signal itemSelected(int index)

    Component.onCompleted: {
       //load()
    }

    function load(pno){
        //console.log('customers',pno);

        var post = {
            TEMPLATE: 'NO',
            cmp: 'cmp_belege',
            page: 'ajax/api/router',
            b: settings.beleg,
            sid: loadingMask.sessionID,
            extMethod: 'getRegionsList',
            extTID: '1',
            extAction: 'report',
            kundennummer: 100,
            belegnummer: -1,
            kostenstelle: 0
        }

        if (typeof pno !== 'undefined'){
            post.pno = pno;
        }
        //console.log('Region',loadingMask.jsonDebug(post));
        loadingMask.post(settings.url,post,processArtListResult);
    }

    function getCurrent(){
        if (selectedIndex!==-1){
            return model.get(selectedIndex);
        }else{
            return null;
        }
    }

    /**
    * Ergebniss des Laden der Artikel verarbeiten!
    */
    function processArtListResult( err, res ){
        //console.log(err);
        //console.log(loadingMask.jsonDebug(res));
        if ( res !== null){
            var grid = res.result.data;
            removeAll();
            for(var i =0; i < grid.length; i++){
                if (grid[i].geschaeftsstelle === settings.geschaeftsstelle){
                    //console.log(loadingMask.jsonDebug(grid[i]));
                    grid[i]._selected = false;
                    grid[i].region = grid[i].tour;
                    grid[i].anzahl = 0;
                    model.append(grid[i]);
                }
            }
        }else{
         console.log("ERROR",err);
        }
    }


    function removeAll(){
        articleModel.clear();
        /*
        while(selectedIndex!=-1){
            removePosition()
        }
        */
    }


    function removePosition(){
        if(selectedIndex!==-1){
            articleModel.remove(selectedIndex)
        }
        if (articleModel.count>0){
            selectedIndex=articleModel.count-1;
            articleModel.setProperty(selectedIndex,'_selected',true)
        }else{
         selectedIndex=-1
        }
        //calc()
        return selectedIndex;
    }


    Component {
        id: contactDelegate
        Item {


            anchors.left: parent.left
            anchors.right: parent.right
            height: Style.textSize*2  + Style.padding

            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            clip: true


            Row {
                spacing: 3

                Rectangle {
                    width: listView.width
                    height: Style.textSize*2  + Style.padding
                    color: Style.backgroundColor
                    radius: 0
                    clip: true
                    antialiasing: true
                    border.width: 0

                    Rectangle {
                        id: rectangle1
                        x: Style.radius * 1 + Style.padding
                        y: 2
                        width: listView.width + Style.radius
                        height: Style.textSize*2  + Style.padding
                        color: (_selected)?Style.selectedItemBackgroundColor:Style.itemBackgroundColor
                        radius: Style.radius
                    }

                    Text {
                        text: region
                        y: rectangle1.height/2 - Style.textSize/2
                        x: Style.radius * 1 + Style.padding + Style.padding
                        font.pixelSize: Style.textSize
                        color: Style.textColor
                    }
                }
            }

            Timer {
             id: buttonPressedTimer
             interval: 300; running: false; repeat: false
             onTriggered: {


                 //itemSelected(list.selectedIndex)

                 articleModel.setProperty(selectedIndex,'_selected',false);
                 articleModel.setProperty(index,'_selected',true);
                 selectedIndex = index

                 //console.log(index);
                 itemSelected(selectedIndex);
                 //refreshList();
             }
            }
            SequentialAnimation {
                 id:anim
                 //PropertyAction  { target: rect; property: "color"; value:(_selected)?selectedItemColor:unselectedItemColor}
            }
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onPressed: {
                    //console.log(index)

                    //_selected=!_selected
                    //if (animationEnabled && !anim.running) {
                    //    anim.restart()
                    //}
                    buttonPressedTimer.restart()
                }
                onPressedChanged: {

                }
            }

        }
    }

    ListModel{
        id:  articleModel
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: articleModel
        delegate: contactDelegate
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
    }
}

import QtQuick 2.1
import QtQuick.Controls 1.1
import "../singleton"

Item{
    id: root
    property Component buttonBar: null
    property Component content: null
    property string title: ""
    property string doneText: ""
  
    function onDoneClicked(){
    
    }
    
    Component.onCompleted: {
         //mainWindow.title = title
    }    

    Stack.onStatusChanged: {
        
        if (Stack.status == Stack.Activating  ) {
            
            mainWindow.title = title
            /*
            if (item.numPage !== undefined)
                item.numPage = Stack.index + 1

                if (item.totalPages !== undefined)
                    item.totalPages = stackView.pages.length

                    item.state = ""
           */
        }
        
    }
    
    
    Rectangle {
        color: "#21212f"
        anchors.fill: parent
    }
    
}
import QtQuick 2.0
import "../Controls";

import "..";

Rectangle {
    width: parent.width
    height: Style.tootlbarButtonSize + Style.padding +Style.padding


    color: Style.backgroundColor

    IconButton{
        x:  Style.padding
        y:  Style.padding
        width: Style.tootlbarButtonSize
        height: Style.tootlbarButtonSize
        icon: "\uf00c"
        iconSize: Style.tootlbarButtonSize
        color: Style.tootlbarButtonColor
        onBtnClicked: {
            posPanel.save();
         //Qt.quit()
        }
    }

    IconButton{
        y: Style.padding
        x: parent.width - (Style.tootlbarButtonSize + Style.padding)*2
        width: Style.tootlbarButtonSize
        height: Style.tootlbarButtonSize
        icon: "\uf0c0"
        iconSize: Style.tootlbarButtonSize
        color: Style.tootlbarButtonColor
        onBtnClicked: {
         //Qt.quit()
            page.globalKeyReceiver('CUSTOMERS');
        }
    }



    IconButton{
        y: Style.padding
        x: parent.width  - (Style.tootlbarButtonSize + Style.padding)*1
        width: Style.tootlbarButtonSize
        height: Style.tootlbarButtonSize
        icon: "\uf085"
        iconSize: Style.tootlbarButtonSize
        color: Style.tootlbarButtonColor
        onBtnClicked: {
            page.globalKeyReceiver('SETTINGS');
        }
    }
}

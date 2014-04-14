import QtQuick 2.0
import QtMultimedia 5.0
import QZXing 1.0
Item {

    Component.onCompleted: {
        scanTimer.start();
    }

    property string lastCapturedImage: ""
    Camera {
        id: camera

        exposure.exposureCompensation: 3.0
        exposure.exposureMode: Camera.ExposurePortrait


        CameraCapture{
            id: cc

        }
        imageCapture {
            onImageCaptured: {

                reader.setDecoder( reader.DecoderFormat_QR_CODE );
                lastCapturedImage = camera.imageCapture.capturedImagePath;

                reader.decodeImageFromFile(lastCapturedImage,-1,-1,false )
            }
            onImageSaved: {
                //text.text = qsTr("Last Captured Image (%1):").arg(camera.imageCapture.capturedImagePath)
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "black"
        CodeReader{
            id: reader
            onTagFound: {
                 text.text = tag
            }
            onDecodingStarted: {
                text.text = ".... scanning";

                //text.opacity = 1
                scanTimer.stop();
            }

            onDecodingError:{
             text.text = errorMessage;
            }

            onDecodingFinished: {
                //text.text = "Fin";
                //camera.imageCapture.capturedImagePath

                //QFile::remove(lastCapturedImage);


                if (!succeeded){
                    //text.text = "Error";
                    text.color = "red";
                    scanTimer.interval = 100;
                    scanTimer.start();
                }else{
                    text.color = "green";
                    scanTimer.interval = 3000;
                    scanTimer.start();
                }

                //text.opacity = 0
            }
        }
        Timer {
            id: scanTimer
            interval: 100
            running: false
            repeat: false
            onTriggered: {
                camera.imageCapture.capture()
            }
        }
        VideoOutput {
            source: camera
            focus: visible // To receive focus and capture key events when visible
            anchors.fill: parent
            MouseArea {
                anchors.fill: parent
                onClicked: camera.imageCapture.capture()
            }
        }




        Text {
            id: text
            height: 45
            font.pixelSize: 32
            color: "white"
            text: ""
            //opacity: 1
            //Behavior on opacity { NumberAnimation{  easing.type: Easing.InCubic } }
        }
/*
        Image {
            id: photoPreview
            source: "qrc:../images/qr.png"
            width: 10; height: 10
        }*/
    }
}

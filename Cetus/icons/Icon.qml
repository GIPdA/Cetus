import QtQuick 2.0

Item {
    id: root
    width: 32
    height: 32
    implicitHeight: image.implicitHeight
    implicitWidth: image.implicitWidth

    property string icon: ""
    //property color color: "white"
    property bool disabled: false
    property real margins: 0
    property alias mirror: image.mirror

    property string iconPath: "../icons/xhdpi/"

    /*Image {
        id: image
        anchors.fill: parent
        sourceSize.height: 50
        sourceSize.width: 50
        fillMode: Image.PreserveAspectFit
        //source: "../icons/xhdpi/clean.png"
        source: "../icons/xhdpi/home.png"
    }//*/

    Image {
        id: image
        anchors.fill: parent
        anchors.margins: root.margins
        fillMode: Image.PreserveAspectFit
        sourceSize.width: width
        sourceSize.height: height
        opacity: root.disabled ? 0.1 : 1
        source: {
            switch (root.icon) {
            case "pause" : return iconPath+"pause"
            case "play" : return iconPath+"play"
            case "reload" : return iconPath+"reload"
            case "stop" : return iconPath+"stop"
            case "home" : return iconPath+"home"
            default: return "";
            }
        }
    }

}

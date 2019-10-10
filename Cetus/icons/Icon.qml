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
            case "3d-coordinates-perspective" : return iconPath+"3d-coordinates-perspective"
            case "3d-coordinates-x-color" : return iconPath+"3d-coordinates-x-color"
            case "3d-coordinates-x" : return iconPath+"3d-coordinates-x"
            case "3d-coordinates-y-color" : return iconPath+"3d-coordinates-y-color"
            case "3d-coordinates-y-r-color" : return iconPath+"3d-coordinates-y-r-color"
            case "3d-coordinates-y-r" : return iconPath+"3d-coordinates-y-r"
            case "3d-coordinates-y" : return iconPath+"3d-coordinates-y"
            case "3d-coordinates-z-color" : return iconPath+"3d-coordinates-z-color"
            case "3d-coordinates-z" : return iconPath+"3d-coordinates-z"
            case "clean" : return iconPath+"clean"
            case "edit-gcode-file" : return iconPath+"edit-gcode-file"
            case "open-gcode" : return iconPath+"open-gcode"
            case "pause" : return iconPath+"pause"
            case "play" : return iconPath+"play"
            case "power-off" : return iconPath+"power-off"
            case "power-on" : return iconPath+"power-on"
            case "reload" : return iconPath+"reload"
            case "resume" : return iconPath+"resume"
            case "stop-sign" : return iconPath+"stop-sign"
            case "stop" : return iconPath+"stop"
            case "zoom-in" : return iconPath+"zoom-in"
            case "zoom-out" : return iconPath+"zoom-out"
            case "home" : return iconPath+"home"
            default: return "";
            }
        }
    }

}

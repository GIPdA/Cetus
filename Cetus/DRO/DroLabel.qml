import QtQuick 2.12

Item {
    property string text: ""
    property bool rotated: false
    property int margin: 2
    property color textColor: "white"
    property alias font: label.font

    id: root
    implicitWidth: (root.rotated ? label_size.implicitHeight : label_size.implicitWidth) + margin * 2
    implicitHeight: (root.rotated ? label_size.implicitWidth : label_size.implicitHeight) + margin * 2
    visible: text.length > 0

    Item { // To get fit size with rotated text
        width: (root.rotated ? label.height : label.width)
        height: (root.rotated ? label.width : label.height)
        opacity: 0

        Text {
            id: label_size
            anchors.fill: parent
            anchors.margins: 2
            text: root.text
            fontSizeMode: Text.Fit
            minimumPixelSize: 10
            font.pixelSize: 18
        }
    }

    Text {
        id: label
        anchors.fill: parent
        anchors.margins: 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        rotation: root.rotated ? -90 : 0
        text: root.text
        color: root.textColor
        font.pixelSize: label_size.fontInfo.pixelSize
    }
}

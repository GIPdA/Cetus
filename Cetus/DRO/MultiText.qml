import QtQuick 2.0

Item {
    id: root

    property int decimals: 3
    property int digits: 4
    property double value: 12.2349
    property color activeColor: "white"
    property color inactiveColor: "#BBBBBB"
    property real signWidth: signText.width

    QtObject {
        id: d
        readonly property double absolute: Math.abs(value)
        readonly property string restValue: absolute.toFixed(root.decimals)
        readonly property int leftOver: root.digits - decimalsText.text.length + root.decimals + 1
        readonly property string leftOverText: (leftOver <= 0) ? "" : "000000000".slice(-leftOver)
        readonly property bool sign: Number(value.toFixed(decimals)) < 0
    }

    Row {
        id: container
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: signText
            anchors.verticalCenter: parent.verticalCenter
            visible: true
            opacity: d.sign ? 1.0 : 0.0
            color: root.activeColor
            font: digitsText.font
            text: "-"
        }

        Text {
            id: digitsText
            anchors.verticalCenter: parent.verticalCenter
            color: root.inactiveColor
            text: d.leftOverText
            font.family: "Monospace"
            font.pixelSize: Math.min(root.height*0.7, root.width / 5.7)
        }

        Text {
            id: decimalsText
            anchors.verticalCenter: parent.verticalCenter
            font: digitsText.font
            color: root.activeColor
            text: d.restValue
        }
    }
}

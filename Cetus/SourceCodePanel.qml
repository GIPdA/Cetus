import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application 1.0
import Machinekit.PathView 1.0

import "CetusStyle"
import "items"

Item {
    id: root
    property bool reduced: true
    property alias programLoaded: sourceView.programLoaded
    property alias headerHeight: header.height

    Rectangle {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 25
        color: "#585858"

        Text {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: 25
            }
            verticalAlignment: Text.AlignVCenter
            text: qsTr("G-Code View") + " - "+ (!programLoaded ? qsTr("No program loaded") : "")
            color: "white"
        }

        Button {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                margins: 0
            }
            enabled: programLoaded
            width: height
            opacity: hovered ? 1 : 0.3
            hoverEnabled: true
            padding: 0
            text: root.reduced ? "▲" : "▼"
            font.pixelSize: height*0.8

            background: Item {}

            onClicked: {
                root.reduced = !root.reduced
            }

            Component.onCompleted: {
                contentItem.color = "white"
            }
        }
    }

    SourceView {
        id: sourceView
        anchors {
            top: header.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        visible: height > 0
        enabled: visible
        clip: true
    }

}

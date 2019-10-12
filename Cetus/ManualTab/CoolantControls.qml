import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../Controls"
import "../DRO"
import "../CetusStyle"
import "../items"
import "../icons"

ColumnLayout {
    id: root
    spacing: 1
    visible: d.mistVisible || d.floodVisible

    ApplicationObject {
        id: d
        readonly property bool mistVisible: status.synced && status.ui.coolantMistVisible
        readonly property bool floodVisible: status.synced && status.ui.coolantFloodVisible
    }

    Item {
        //visible: false
        DroLabel {
            x: -width+2
            y: (root.height-height)/2
            text: qsTr("Coolant")
            rotated: true
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.preferredHeight: 50
        Layout.maximumHeight: 50
        spacing: 1

        function update() {
            RoundedRectangleHelper.updateRowRadiusStyle(this, true, true)
        }

        RoundedButton {
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: MistAction { }
            visible: d.mistVisible
            onVisibleChanged: parent.update()
            font.pixelSize: height*0.55
        }

        RoundedButton {
            Layout.fillWidth: true
            Layout.fillHeight: true
            action: FloodAction { }
            visible: d.floodVisible
            onVisibleChanged: parent.update()
            font.pixelSize: height*0.55
        }

        Item {
            Layout.fillWidth: true
        }
    }
}

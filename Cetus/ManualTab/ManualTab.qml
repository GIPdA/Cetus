import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../ConfigurationPanel"

Tab {
    title: qsTr("Manual") + " [" + manualShortcut.sequence + "]"

    Item {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 5

            AxisControls {}

            CoolantControls {}

            SpindleControls {}

            ConfigurationPanel {
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

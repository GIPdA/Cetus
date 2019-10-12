import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "../ConfigurationPanel"

Item {
    //title: qsTr("Manual") + " [" + manualShortcut.sequence + "]"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        anchors.leftMargin: 10
        spacing: 5

        AxisControls {}

        SpeedsControls {}

        //CoolantControls {}

        SpindleControls {}

        //GantryConfigControl {}

        Item {
            Layout.fillHeight: true
        }
    }
}

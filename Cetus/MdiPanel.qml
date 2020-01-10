import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "CetusStyle"

FocusScope {
    //title: qsTr("MDI") //+ " [" + mdiShortcut.sequence + "]"
    // TODO: title bar + auto reduce

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        MdiHistoryTable {
            id: mdiHistoryTable
            Layout.fillWidth: true
            Layout.fillHeight: true
            onCommandSelected: {
                mdiCommandEdit.text = command
            }

            onCommandTriggered: {
                mdiCommandEdit.text = command
                mdiCommandEdit.action.trigger()
            }
        }

        MdiCommandEdit {
            id: mdiCommandEdit
            Layout.fillWidth: true
            focus: true
        }

        Label {
            text: qsTr("Active GCodes")
            color: CetusStyle.control.foreground.color
        }

        GCodeLabel {
            Layout.fillWidth: true
            height: 100
            wrapMode: Text.Wrap
            color: CetusStyle.control.foreground.color
        }
    }
}

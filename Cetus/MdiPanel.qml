import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0

import "CetusStyle"

FocusScope {
    //title: qsTr("MDI") //+ " [" + mdiShortcut.sequence + "]"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        MdiHistoryTable {
            id: mdiHistoryTable
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
        }

        Label {
            text: qsTr("Active GCodes")
            color: CetusStyle.control.foreground.color
        }

        GCodeLabel {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            color: CetusStyle.control.foreground.color
        }
    }



}

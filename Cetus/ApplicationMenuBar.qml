import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.Application.Controls 1.0
import Machinekit.PathView 1.0

MenuBar {
    Menu {
        title: qsTr("&File")
        MenuItem { action: OpenAction { fileDialog: applicationFileDialog } }
        MenuItem {
            action: OpenAction {
                fileDialog: remoteFileDialog
                remote: true
            }
        }
        // Recent files
        MenuItem { action: EditWithSystemEditorAction {} }
        MenuItem { action: ReopenAction { } }
        // Save GCode
        // Properties
        MenuSeparator {}
        MenuItem {
            action: EditToolTableAction {
                editorDialog: toolTableEditorDialog
            }
        }
        // Ladder editor

        MenuItem {
            text: qsTr("&Disconnect from Session")
            icon.name: "network-disconnect"
            onTriggered: window.disconnect()
        }

        MenuItem {
            text: qsTr("Sh&utdown Session")
            action: ShutdownAction {}
            onTriggered: window.shutdown()
        }

        MenuItem {
            text: qsTr("E&xit User Interface")
            icon.name: "application-exit"
            action: Action { shortcut: "Ctrl+Q" }
            onTriggered: Qt.quit()
        }
    }
    Menu {
        title: qsTr("&Machine")

        MenuItem { action: EstopAction { } }
        MenuItem { action: PowerAction { } }
        MenuSeparator {}
        MenuItem { action: RunProgramAction { } }
        // run from line
        MenuItem { action: StepProgramAction { } }
        MenuItem { action: PauseResumeProgramAction { } }
        MenuItem { action: StopProgramAction { } }
        MenuItem { action: OptionalStopAction {} }
        // skip lines with /
        // mdi
        // homing
        // unhoming
        // touch off
        // calibration, status, ...
        // tool touch off to workpiece
        // tool touch off to fixture
    }
    Menu {
        title: qsTr("&View")
        MenuItem { action: enablePreviewAction }
        MenuItem { action: showProgramAction }
        MenuItem { action: showProgramRapidsAction }
        MenuItem { action: showProgramExtentsAction }
        MenuItem { action: alphaBlendProgramAction }
        MenuItem { action: showLivePlotAction }
        MenuItem { action: showMachineLimitsAction }
        MenuItem { action: showToolAction }
        MenuItem { action: showCoordinateAction }
        MenuItem { action: showOffsetsAction }
        MenuItem { action: showVelocityAction }
        MenuItem { action: showDistanceToGoAction }
        MenuItem { action: showSpindleSpeedAction }

        ToggleSettingAction {
            id: showOffsetsAction
            groupName: "dro"
            valueName: "showOffsets"
            text: qsTr("Show o&ffsets")
        }

        ToggleSettingAction {
            id: showVelocityAction
            groupName: "dro"
            valueName: "showVelocity"
            text: qsTr("Show v&elocity")
        }

        ToggleSettingAction {
            id: showDistanceToGoAction
            groupName: "dro"
            valueName: "showDistanceToGo"
            text: qsTr("Show &distance to go")
        }

        ToggleSettingAction {
            id: showSpindleSpeedAction
            groupName: "dro"
            valueName: "showSpindleSpeed"
            text: qsTr("Show &spindle speed")
        }

        ToggleSettingAction {
            id: enablePreviewAction
            groupName: "preview"
            valueName: "enable"
            text: qsTr("Enable &preview")
        }

        ToggleSettingAction {
            id: showMachineLimitsAction
            groupName: "preview"
            valueName: "showMachineLimits"
            text: qsTr("Sh&ow machine limits")
        }

        ToggleSettingAction {
            id: showProgramAction
            groupName: "preview"
            valueName: "showProgram"
            text: qsTr("S&how program")
        }

        ToggleSettingAction {
            id: showProgramExtentsAction
            groupName: "preview"
            valueName: "showProgramExtents"
            text: qsTr("Show program e&xtents")
        }

        ToggleSettingAction {
            id: showProgramRapidsAction
            groupName: "preview"
            valueName: "showProgramRapids"
            text: qsTr("Show program r&apids")
        }

        ToggleSettingAction {
            id: alphaBlendProgramAction
            groupName: "preview"
            valueName: "alphaBlendProgram"
            text: qsTr("Alpha-&blend program")
        }

        ToggleSettingAction {
            id: showLivePlotAction
            groupName: "preview"
            valueName: "showLivePlot"
            text: qsTr("Sho&w live plot")
        }

        ToggleSettingAction {
            id: showToolAction
            groupName: "preview"
            valueName: "showTool"
            text: qsTr("Sho&w tool")
        }

        ToggleSettingAction {
            id: showCoordinateAction
            groupName: "preview"
            valueName: "showCoordinate"
            text: qsTr("Show &coordinate")
        }

        MenuItem { action: ClearBackplotAction { } }
    }

    Menu {
        title: qsTr("&Help")
        MenuItem {
            text: qsTr("About &Cetus")
            onTriggered: aboutDialog.open()
        }
    }
}

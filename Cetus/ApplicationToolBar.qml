import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application 1.0
import Machinekit.Application.Controls 1.0
import Machinekit.PathView 1.0
import Machinekit.Controls 1.0
import "./Controls"
//import "actions"
import "items"

ToolBar {
    id: root
    implicitHeight: rowLayout.implicitHeight
    background: Rectangle {
        color: "#343434"
    }

    QtObject {
        id: d
        property var runAction: RunProgramAction { }
        property var pauseAction: PauseProgramAction { }
        property var resumeAction: ResumeProgramAction { }
        property var stepAction: StepProgramAction { }
    }

    RowLayout {
        id: rowLayout
        //anchors.fill: parent

        FlatToolButton {
            action: EstopAction { shortcut: "" }
            Rectangle {
                anchors.fill: parent
                visible: parent.action.checked_synced
                color: "red"
                opacity: parent.down ? 0.8 : 1
                radius: 3
            }
        }
        FlatToolButton {
            action: PowerAction { shortcut: ""; }
            icon.source: action.icon.source // For icon updates
            Rectangle {
                anchors.fill: parent
                visible: parent.action.checked_synced
                color: "darkgreen"
                opacity: parent.down ? 0.2 : 0.5
                radius: 3
            }
        }

        Spacer {}

        FlatToolButton { action: OpenAction { fileDialog: applicationFileDialog; shortcut: "" } }
        FlatToolButton { action: OpenAction { fileDialog: remoteFileDialog; remote: true; shortcut: "" } }
        FlatToolButton { action: ReopenAction { shortcut: "" } }

        Spacer {}
        // default -> Run + Step (grayed) + Stop (grayed)
        // runnning -> Pause + Step (grayed) + Stop
        // paused -> Resume + Step + Stop
        // stepping -> Resume + Pause + Stop
        FlatToolButton {
            id: runButton
            action: {
                if (d.resumeAction.enabled)
                    return d.resumeAction
                if (d.pauseAction.enabled)
                    return d.pauseAction
                return d.runAction
            }
            icon.source: action.icon.source // For icon updates
        }

        FlatToolButton { // Step / pause
            action: {
                if (d.stepAction.enabled)
                    return d.stepAction
                if (d.pauseAction.enabled && runButton.action === d.resumeAction)
                    return d.pauseAction
                return d.stepAction
            }
            icon.source: action.icon.source // For icon updates
            //hideIfDisabled:true
        }
        FlatToolButton { action: StopProgramAction { } }

        Spacer {}
        FlatToolButton { action: ZoomOutAction { view: pathViewConfig } }
        FlatToolButton { action: ZoomInAction { view: pathViewConfig } }
        FlatToolButton { action: ZoomOriginalAction { view: pathViewConfig } }
        FlatToolButton { action: ViewModeAction { view: pathViewConfig; viewMode: "Top" } visible: action.visible }
        FlatToolButton { action: ViewModeAction { view: pathViewConfig; viewMode: "RotatedTop" } visible: action.visible }
        FlatToolButton { action: ViewModeAction { view: pathViewConfig; viewMode: "Front" } visible: action.visible }
        FlatToolButton { action: ViewModeAction { view: pathViewConfig; viewMode: "Side" } visible: action.visible }
        FlatToolButton { action: ViewModeAction { view: pathViewConfig; viewMode: "Perspective" } visible: action.visible }
        //*/
        Spacer {}
        FlatToolButton { action: ClearBackplotAction { shortcut: "" } }
    }
}

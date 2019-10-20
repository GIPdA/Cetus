import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0
import Machinekit.PathView 1.0
import Machinekit.Controls 1.0
import "./Controls"
//import "actions"
import "items"

ToolBar {
    implicitHeight: rowLayout.implicitHeight
    background: Rectangle {
        color: "#343434"
    }

    RowLayout {
        id: rowLayout
        //anchors.fill: parent

        FlatToolButton { action: EstopAction {  shortcut: "" } }
        FlatToolButton { action: PowerAction { shortcut: "" } }
        Spacer {}
        FlatToolButton { action: OpenAction { fileDialog: applicationFileDialog; shortcut: "" } }
        FlatToolButton { action: OpenAction { fileDialog: remoteFileDialog; remote: true; shortcut: "" } }
        FlatToolButton { action: ReopenAction { shortcut: "" } }
        Spacer {}
        FlatToolButton { action: RunProgramAction { shortcut: "" } }
        FlatToolButton { action: StepProgramAction { shortcut: "" } }
        FlatToolButton { action: PauseResumeProgramAction { shortcut: "" } }
        FlatToolButton { action: StopProgramAction { shortcut: "" } }

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

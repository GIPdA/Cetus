import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Machinekit.Application.Controls 1.0
import Machinekit.PathView 1.0
import Machinekit.Controls 1.0
import "./Controls"

ToolBar {
    implicitHeight: Screen.pixelDensity * 7.5
    RowLayout {
        anchors.fill: parent
        TouchButton {
            Layout.fillHeight: true
            action: EstopAction { }
        }
        TouchButton {
            Layout.fillHeight: true
            action: PowerAction { }
        }
        Spacer {}
        TouchButton {
            Layout.fillHeight: true
            action: OpenAction { fileDialog: applicationFileDialog }
        }
        TouchButton {
            Layout.fillHeight: true
            action: OpenAction { fileDialog: remoteFileDialog; remote: true }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ReopenAction { }
        }
        Spacer {}
        TouchButton {
            Layout.fillHeight: true
            action: RunProgramAction { }
        }
        TouchButton {
            Layout.fillHeight: true
            action: StepProgramAction { }
        }
        TouchButton {
            Layout.fillHeight: true
            action: PauseResumeProgramAction { }
        }
        TouchButton {
            Layout.fillHeight: true
            action: StopProgramAction { }
        }
        Spacer {}
        TouchButton {
            Layout.fillHeight: true
            action: ZoomOutAction { view: pathView3D }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ZoomInAction { view: pathView3D }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ZoomOriginalAction { view: pathView3D }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ViewModeAction { view: pathView3D; viewMode: "Top" }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ViewModeAction { view: pathView3D; viewMode: "RotatedTop" }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ViewModeAction { view: pathView3D; viewMode: "Front" }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ViewModeAction { view: pathView3D; viewMode: "Side" }
        }
        TouchButton {
            Layout.fillHeight: true
            action: ViewModeAction { view: pathView3D; viewMode: "Perspective" }
        }
        Spacer {}
        TouchButton {
            Layout.fillHeight: true
            action: ClearBackplotAction {}
        }
        Item {
            Layout.fillWidth: true
        }
    }

    ApplicationFileDialog {
        id: applicationFileDialog
    }
}

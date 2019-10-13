import QtQuick 2.12
import QtQuick.Controls 2.12
import Machinekit.PathView 1.0
import Machinekit.Application.Controls 1.0
import QtQuick.Window 2.0

Item {
    PathView3D {
        id: pathView
        anchors.fill: parent

        onViewModeChanged: {
            cameraZoom = 0.95
            cameraOffset = Qt.vector3d(0,0,0)
            cameraPitch = 60
            cameraHeading = -135
        }

        Binding {
            target: pathView; property: "cameraZoom"; value: pathViewConfig.cameraZoom
        }
        Binding {
            target: pathViewConfig; property: "cameraZoom"; value: pathView.cameraZoom
        }
        Binding {
            target: pathView; property: "viewMode"; value: pathViewConfig.viewMode
        }
    }

    CheckBox {
        id: enablePreviewCheck
        anchors.centerIn: parent
        visible: !pathView.visible
        text: enablePreviewAction.text
        onClicked: enablePreviewAction.trigger()

        Binding { target: enablePreviewCheck; property: "checked"; value: enablePreviewAction.checked }

        ToggleSettingAction {
            id: enablePreviewAction
            groupName: "preview"
            valueName: "enable"
            text: qsTr("Enable preview")
        }
    }
}

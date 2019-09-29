import QtQuick 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls 1.4 as QQ1
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtQuick.Window 2.12
import Machinekit.HalRemote 1.0
import Machinekit.Application 1.0
import Machinekit.Service 1.0
import Machinekit.Application.Controls 1.0
import Machinekit.PathView 1.0
import Machinekit.VideoView 1.0
import "./StatusBar"
import "./ManualTab"
import "./ConfigurationPanel"
import "./style"

ServiceWindow {
    id: window
    visible: true
    width: 700
    height: 900
    title: applicationCore.applicationName + (d.machineName === "" ? "" :" - " +  d.machineName)

    statusBar:applicationStatusBar
    toolBar: applicationToolBarMobile.active ? applicationToolBarMobile : applicationToolBar
    menuBar: applicationMenuBar

    color: CetusStyle.control.background.color

    /*property bool __synced: applicationCore.status.synced
    on__SyncedChanged: {
        function printMap(tab, map) {
            for (var key in map) {
                if (map[key] instanceof Function) {
                    //print(tab, key, "(function)")
                }
                else if (map[key] instanceof Object) {
                    print(tab, key, "(object)")
                    printMap(tab+"  ", map[key])
                }
                else if (map[key] instanceof Array) {
                    print(tab, key)
                    printMap(tab+"  ", map[key])
                }
                else {
                    print(tab, key, " : ", map[key])
                }
            }
        }

        print("CONFIG:")
        if (__synced)
            printMap(" ", applicationCore.status.config)
    }//*/

    Item {
        id: d
        readonly property string machineName: applicationCore.status.config.name
    }

    ApplicationStatusBar { id: applicationStatusBar }
    ApplicationMenuBar { id: applicationMenuBar }

    Loader {
        id: applicationToolBar
        source: "ApplicationToolBar.qml"
        active: !applicationToolBarMobile.active
    }
    Loader {
        id: applicationToolBarMobile
        source: "ApplicationToolBarMobile.qml"
        active: (Qt.platform.os == "android")
    }

    Service {
        id: halrcompService
        type: "halrcomp"
    }

    Service {
        id: halrcmdService
        type: "halrcmd"
    }

    ApplicationCore {
        id: applicationCore
        notifications: applicationNotifications
        applicationName: "Cetus"
    }

    PathViewCore {
        id: pathViewCore
    }

    ApplicationItem {
        id: pathViewConfig
        property double cameraZoom: 0.95
        property string viewMode: status.synced && status.config.lathe ? "Lathe" : "Perspective"
    }

    SourceView {
        id: sourceView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.25
    }


    RowLayout {
        anchors.fill: parent

        Item {
            width: 500
            Layout.preferredWidth: 500
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent

                DroPanel {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    //anchors.fill: parent
                }

                /*/JogStick {
                    id: jogStick
                }//*/

                /*Item {
                    Layout.fillHeight: true
                }//*/
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Preview
            Rectangle {
                anchors.fill: parent
                color: "steelblue"
            }
            /*PreviewPanel {
                anchors.fill: parent
            }//*/
        }

        Item {
            id: toto
            width: 200
            Layout.margins: 5
            Layout.preferredWidth: 200
            Layout.maximumWidth: 200
            Layout.fillHeight: true

            AxisControls {
                anchors.fill: parent
            }

            /*ColumnLayout {
                anchors.fill: parent
                anchors.margins: 5

                AxisControls {}

                /*CoolantControls {}

                SpindleControls {}

                ConfigurationPanel {
                }// * /

                Item {
                    Layout.fillHeight: true
                }
            }//*/

            /*QQ1.TabView {
                id: leftTabView
                anchors.fill: parent

                ManualTab { }

                MdiTab { }

                Shortcut {
                    id: mdiShortcut
                    sequence: "F5"
                    onActivated: leftTabView.currentIndex = 1
                }
                Shortcut {
                    id: manualShortcut
                    sequence: "F3"
                    onActivated: leftTabView.currentIndex = 0
                }
            }//*/
        }


    }






    /*TabView {
        id: centerTabView
        anchors.left: leftTabView.right
        anchors.right: rightTabView.left
        anchors.top: parent.top
        anchors.bottom: sourceView.top

        property bool active: droTab.status === Loader.Ready
        property bool loaded: false

        Tab {
            id: droTab
            title: qsTr("DRO")
            DroPanel {}
        }
        Tab {
            id: previewTab
            title: qsTr("Preview")
            PreviewPanel { }
        }

    }//*/

    /*DisplayPanel {
        id: rightTabView
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: sourceView.top
        width: parent.width * 0.25
    }//*/

    ApplicationNotifications {
        id: applicationNotifications
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: Screen.pixelDensity
        messageWidth: parent.width * 0.15
    }

    ApplicationFileDialog {
        id: applicationFileDialog
    }

    ApplicationRemoteFileDialog {
        id: remoteFileDialog
        width: window.width
        height: window.height
        fileDialog: applicationFileDialog
    }

    ToolTableEditorDialog {
        id: toolTableEditorDialog
        width: window.width
        height: window.height
    }

    AboutDialog {
        id: aboutDialog
    }
}

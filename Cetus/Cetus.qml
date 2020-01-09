import QtQuick 2.12
import QtQuick.Controls 2.13
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

//import CetusStyle 1.0
import "CetusStyle"

import "./StatusBar"
import "./ManualTab"
import "./ConfigurationPanel"
import "items"

ServiceWindow {
    id: window
    visible: true
    width: 700
    height: 900
    title: applicationCore.applicationName + (d.machineName === "" ? "" :" - " +  d.machineName)

    statusBar:applicationStatusBar
    toolBar: applicationToolBarMobile.active ? applicationToolBarMobile : applicationToolBar
    menuBar: applicationMenuBar

    color: "#343434"

    property bool g_mdiOverride: false // When true, MDI overrides Manual controls

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

    SplitView {
        id: splitView
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: manualView.left
        }
        orientation: Qt.Vertical

        handle: Rectangle {
            implicitHeight: 5
            color: "#707070"
        }

        RowLayout {
            SplitView.fillWidth: true
            SplitView.fillHeight: true

            Item { // DRO
                implicitWidth: 500
                Layout.preferredWidth: 500
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent

                    DroPanel {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    /*/JogStick {
                        id: jogStick
                    }//*/
                    /*Item {
                        Layout.fillHeight: true
                    }//*/
                }
            }

            Item { // 3D Preview
                Layout.fillWidth: true
                Layout.fillHeight: true

                PreviewPanel {
                    anchors.fill: parent
                }
            }
        }

        SourceCodePanel { // G-Code program view
            id: sourceView
            SplitView.fillWidth: true
            SplitView.minimumHeight: headerHeight
            SplitView.preferredHeight: preferredHeight
            property int preferredHeight: deployedHeight
            property int deployedHeight: programLoaded ? window.height * 0.3 : headerHeight

            Connections {
                // Change reduced state if reduced or expanded manually via the split view
                target: splitView
                onResizingChanged: {
                    if (sourceView.reduced && sourceView.height > sourceView.headerHeight)
                        sourceView.reduced = false
                    else if (!sourceView.reduced && sourceView.height <= sourceView.headerHeight)
                            sourceView.reduced = true
                }
            }

            SmoothedAnimation {
                id: reduceAnimation
                target: sourceView
                property: "preferredHeight"
                velocity: 500
            }
            onReducedChanged: {
                if (reduced) {
                    deployedHeight = height // Save current height
                    reduceAnimation.from = deployedHeight
                    reduceAnimation.to = headerHeight
                    reduceAnimation.start()
                } else {
                    reduceAnimation.from = headerHeight
                    reduceAnimation.to = deployedHeight
                    reduceAnimation.start()
                }
            }
        }
    } // SplitView

    Item { // Manual & MDI
        id: manualView
        anchors {
            top: parent.top
            bottom: parent.bottom
            //left: parent.left
            right: parent.right
        }
        width: 220
        implicitWidth: 220

        ManualTab {
            anchors.fill: parent
        }

        //MdiTab { }

        Shortcut {
            id: manualShortcut
            sequence: "F3"
            onActivated: leftTabView.currentIndex = 0
        }
        /*Shortcut {
            id: mdiShortcut
            sequence: "F5"
            onActivated: leftTabView.currentIndex = 1
        }//*/
    }


    MouseArea { // FloatingPanel focus leave
        anchors.fill: parent
        enabled: mdiPanel.focus
        propagateComposedEvents: true
        onPressed: {
            mouse.accepted = false
            window.focus = true
        }
    }
    FloatingPanel {
        id: mdiPanel
        onFocusChanged: {
            //print("FOCUS!", focus)
            g_mdiOverride = focus
        }

        MdiPanel {
            anchors.fill: parent
        }
    }



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

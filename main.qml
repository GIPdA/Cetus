import QtQuick 2.0
import QtQuick.Controls 2.4

ApplicationWindow {
    id: applicationWindow

    visibility: (Qt.platform.os === "android") ? ApplicationWindow.FullScreen: ApplicationWindow.AutomaticVisibility
    visible: true
    width: 1200
    height: 1000
    title: connectionWindow.title
    // TODO
    //toolBar: connectionWindow.toolBar
    //statusBar: connectionWindow.statusBar
    menuBar: connectionWindow.menuBar

    Init {
        id: connectionWindow
        anchors.fill: parent
    }
}

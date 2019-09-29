import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import Machinekit.Controls 1.0
import Machinekit.HalRemote 1.0
import Machinekit.HalRemote.Controls 1.0
import Machinekit.Application.Controls 1.0
import Machinekit.Service 1.0
import "./ConfigurationPanel"

TabView {
    width: 100
    height: 62

    Tab {
        title: qsTr("Configuration")
        active: true

       Item {
            ConfigurationPanel {
                anchors.fill: parent
            }
        }
    }
}

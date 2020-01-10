import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "items"

Pane {
    id: root
    default property alias content: container.data

    width: 400
    height: 600
    visible: false

    topInset: -3
    leftInset: -3
    rightInset: -3
    bottomInset: -3

    background: Rectangle {
        radius: 5
        color: "#303030"
        border.color: "#505050"
        border.width: 2
    }


    function show() {
        visible = true
    }
    function hide() {
        visible = false
    }


    Item {
        id: container
        z: 1
        anchors.fill: parent
    }

    data: [
        DragItem {
            //parent: root
            anchors.fill: parent
            hoverEnabled: false
            onMoved: {
                root.x += dx
                root.y += dy

                // Do not go too far!
                root.x = Math.min(root.x, root.parent.width-15)
                root.y = Math.min(root.y, root.parent.height-15)
                root.x = Math.max(root.x, -root.width+15)
                root.y = Math.max(root.y, -root.height+15)
            }
        }
    ]
}

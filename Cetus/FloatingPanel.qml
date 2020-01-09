import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "items"

Pane {
    id: root
    default property alias content: container.data

    width: 400
    height: 600

    onFocusChanged: {
        if (focus)
            opacity = 1
    }

    OpacityAnimator {
        target: root
        from: 1;
        to: 0.1;
        duration: 1000
        running: !focus
    }


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
                parent.x += dx
                parent.y += dy
            }
        }
    ]
}

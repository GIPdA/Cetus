import QtQuick 2.7
//import MouseArea2 1.0

Item {
    id: root
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    width: 10//Math.min(10, parent.width)

    signal moved(real dx, real dy)

    readonly property bool moving: dragArea.drag.active

    readonly property alias mouseX: dragArea.mouseX
    readonly property alias mouseY: dragArea.mouseY

    readonly property alias pressed: dragArea.pressed

    property bool inverted: false
    property bool followMouse: true
    property int dragThreshold: dragArea.drag.threshold

    property alias mouseAreaObjectName: dragArea.objectName
    property alias propagateComposedEvents: dragArea.propagateComposedEvents
    property alias hoverEnabled: dragArea.hoverEnabled

    //property alias mouseArea: dragArea

    property alias cursorShape: dragArea.cursorShape

    property bool debug_showArea: false

    Rectangle {
        anchors.fill: parent
        visible: debug_showArea

        color: "blue"
        opacity: 0.4
    }

    function grabMouse() {
        dragArea.grabMouse()
    }
    function ungrabMouse() {
        dragArea.ungrabMouse()
        //Drag.active = false
    }

    MouseArea { // MouseArea2
        id: dragArea
        anchors.fill: parent
        scrollGestureEnabled : false
        propagateComposedEvents: true
        hoverEnabled: true
        preventStealing: true

        drag.target: parent
        drag.threshold: 4
        drag.smoothed: true

        property real initialX: 0
        property real initialY: 0

        property bool dragging: drag.active
        onDraggingChanged: {
            if (!dragging)
                return

            if (followMouse) {
                initialX = mouseX
                initialY = mouseY
            } else if (inverted) {
                initialX = width
                initialY = height
            } else {
                initialX = 0
                initialY = 0
            }
        }

        onPressed: {
            // Eat event
        }
        onReleased: {
            // Eat event
        }

        onPositionChanged: {
            //print("ma " + objectName + " moved at " + mouse.x + ";" + mouse.y)
            if (dragging) {
                //print(initialX + " / " + mouse.x + " / " + (mouseX - initialX))
                moved(mouseX - initialX, mouseY - initialY)
            }
        }
    }
}

/*!
 * A rectangle with optional corner radiuses
 */

import QtQuick 2.0

Item {
    id: root

    enum RadiusStyle {
        NoRadius = 0,
        TopRadius = 1,
        BottomRadius = 2,
        LeftRadius = 4,
        RightRadius = 8,
        AllRadius = 0xF
    }
    property int radiusStyle: RoundedRectangle.NoRadius

    property alias radius: d.radius
    property color color

    antialiasing: !d.noRadius && radius > 0

    QtObject {
        id: d

        property real halfHeight: root.height/2
        property int radius: 0

        property bool noRadius: root.radiusStyle === RoundedRectangle.NoRadius
        property bool allRadius: root.radiusStyle === RoundedRectangle.AllRadius

        property bool topLeftRadius: {
            if (root.radiusStyle === RoundedRectangle.TopRadius) return true
            if (root.radiusStyle === RoundedRectangle.LeftRadius) return true
            return root.radiusStyle == (RoundedRectangle.TopRadius | RoundedRectangle.LeftRadius)
        }
        property bool topRightRadius: {
            if (root.radiusStyle === RoundedRectangle.TopRadius) return true
            if (root.radiusStyle === RoundedRectangle.RightRadius) return true
            return root.radiusStyle == (RoundedRectangle.TopRadius | RoundedRectangle.RightRadius)
        }
        property bool bottomLeftRadius: {
            if (root.radiusStyle === RoundedRectangle.BottomRadius) return true
            if (root.radiusStyle === RoundedRectangle.LeftRadius) return true
            return root.radiusStyle == (RoundedRectangle.BottomRadius | RoundedRectangle.LeftRadius)
        }
        property bool bottomRightRadius: {
            if (root.radiusStyle === RoundedRectangle.BottomRadius) return true
            if (root.radiusStyle === RoundedRectangle.RightRadius) return true
            return root.radiusStyle == (RoundedRectangle.BottomRadius | RoundedRectangle.RightRadius)
        }
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.leftMargin: root.radius
        anchors.rightMargin: root.radius
        color: parent.color
        radius: 0
    }

    // Corners, show either a rounded or square corner by clipping a larger rectangle
    Item {
        anchors {
            top: parent.top
            left: parent.left
        }
        height: d.halfHeight
        width: d.radius
        clip: true

        property bool showRadius: !d.noRadius && (d.allRadius || d.topLeftRadius)

        Rectangle { // Show when no radius
            anchors.fill: parent
            visible: !parent.showRadius
            radius: 0
            color: root.color
            antialiasing: root.antialiasing
        }
        Rectangle { // Show when radius (clip unwanted sides)
            anchors.fill: parent
            anchors.rightMargin: -d.radius-1
            anchors.bottomMargin: -d.radius-1
            visible: parent.showRadius
            radius: d.radius
            color: root.color
            antialiasing: root.antialiasing
        }
    }

    Item {
        anchors {
            top: parent.top
            right: parent.right
        }
        height: d.halfHeight
        width: d.radius
        clip: true

        property bool showRadius: !d.noRadius && (d.allRadius || d.topRightRadius)

        Rectangle {
            anchors.fill: parent
            visible: !parent.showRadius
            radius: 0
            color: root.color
            antialiasing: root.antialiasing
        }
        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: -d.radius-1
            anchors.bottomMargin: -d.radius-1
            visible: parent.showRadius
            radius: d.radius
            color: root.color
            antialiasing: root.antialiasing
        }
    }

    Item {
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        height: d.halfHeight
        width: d.radius
        clip: true

        property bool showRadius: !d.noRadius && (d.allRadius || d.bottomLeftRadius)

        Rectangle {
            anchors.fill: parent
            visible: !parent.showRadius
            radius: 0
            color: root.color
            antialiasing: root.antialiasing
        }
        Rectangle {
            anchors.fill: parent
            anchors.rightMargin: -d.radius-1
            anchors.topMargin: -d.radius-1
            visible: parent.showRadius
            radius: d.radius
            color: root.color
            antialiasing: root.antialiasing
        }
    }

    Item {
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        height: d.halfHeight
        width: d.radius
        clip: true

        property bool showRadius: !d.noRadius && (d.allRadius || d.bottomRightRadius)

        Rectangle {
            anchors.fill: parent
            visible: !parent.showRadius
            radius: 0
            color: root.color
            antialiasing: root.antialiasing
        }
        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: -d.radius-1
            anchors.topMargin: -d.radius-1
            visible: parent.showRadius
            radius: d.radius
            color: root.color
            antialiasing: root.antialiasing
        }
    }
}

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
        radius: d.radius
        antialiasing: root.antialiasing
    }

    // Corners, show either a rounded or square corner by clipping a larger rectangle
    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
        }
        visible: !d.allRadius && (d.noRadius || !d.topLeftRadius)
        height: d.radius
        width: d.radius
        radius: 0
    }

    Rectangle {
        anchors {
            top: parent.top
            right: parent.right
        }
        visible: !d.allRadius && (d.noRadius || !d.topRightRadius)
        height: d.radius
        width: d.radius
        radius: 0
    }

    Rectangle {
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        visible: !d.allRadius && (d.noRadius || !d.bottomLeftRadius)
        height: d.radius
        width: d.radius
        radius: 0
    }

    Rectangle {
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        visible: !d.allRadius && (d.noRadius || !d.bottomRightRadius)
        height: d.radius
        width: d.radius
        radius: 0
    }
}

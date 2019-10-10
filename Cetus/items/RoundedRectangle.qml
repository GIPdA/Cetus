import QtQuick 2.0

Rectangle {
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

    QtObject {
        id: d
        property bool noRadius: root.radiusStyle === RoundedRectangle.NoRadius
        property bool allRadius: root.radiusStyle === RoundedRectangle.AllRadius

        function topLeftRadius() {
            if (root.radiusStyle === RoundedRectangle.TopRadius) return true
            if (root.radiusStyle === RoundedRectangle.LeftRadius) return true
            return root.radiusStyle == (RoundedRectangle.TopRadius | RoundedRectangle.LeftRadius)
        }
        function topRightRadius() {
            if (root.radiusStyle === RoundedRectangle.TopRadius) return true
            if (root.radiusStyle === RoundedRectangle.RightRadius) return true
            return root.radiusStyle == (RoundedRectangle.TopRadius | RoundedRectangle.RightRadius)
        }
        function bottomLeftRadius() {
            if (root.radiusStyle === RoundedRectangle.BottomRadius) return true
            if (root.radiusStyle === RoundedRectangle.LeftRadius) return true
            return root.radiusStyle == (RoundedRectangle.BottomRadius | RoundedRectangle.LeftRadius)
        }
        function bottomRightRadius() {
            if (root.radiusStyle === RoundedRectangle.BottomRadius) return true
            if (root.radiusStyle === RoundedRectangle.RightRadius) return true
            return root.radiusStyle == (RoundedRectangle.BottomRadius | RoundedRectangle.RightRadius)
        }
    }

    // Corners hiding rectangles
    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
        }
        visible: !d.allRadius && (d.noRadius || !d.topLeftRadius())
        height: parent.radius
        width: height
        color: parent.color
        antialiasing: parent.antialiasing
    }
    Rectangle {
        anchors {
            top: parent.top
            right: parent.right
        }
        visible: !d.allRadius && (d.noRadius || !d.topRightRadius())
        height: parent.radius
        width: height
        color: parent.color
        antialiasing: parent.antialiasing
    }

    Rectangle {
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        visible: !d.allRadius && (d.noRadius || !d.bottomLeftRadius())
        height: parent.radius
        width: height
        color: parent.color
        antialiasing: parent.antialiasing
    }
    Rectangle {
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        visible: !d.allRadius && (d.noRadius || !d.bottomRightRadius())
        height: parent.radius
        width: height
        color: parent.color
        antialiasing: parent.antialiasing
    }
}

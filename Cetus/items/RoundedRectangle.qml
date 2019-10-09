import QtQuick 2.0

Rectangle {
    id: root

    enum RadiusStyle {
        NoRadius,
        TopRadius,
        BottomRadius,
        LeftRadius,
        RightRadius
    }
    property int radiusStyle: RoundedRectangle.RadiusStyle.NoRadius

    QtObject {
        id: d
        property bool noRadius: root.radiusStyle === RoundedRectangle.RadiusStyle.NoRadius

        function topLeftRadius() {
            return root.radiusStyle === RoundedRectangle.RadiusStyle.TopRadius
                || root.radiusStyle === RoundedRectangle.RadiusStyle.LeftRadius;
        }
        function topRightRadius() {
            return root.radiusStyle === RoundedRectangle.RadiusStyle.TopRadius
                || root.radiusStyle === RoundedRectangle.RadiusStyle.RightRadius;
        }
        function bottomLeftRadius() {
            return root.radiusStyle === RoundedRectangle.RadiusStyle.BottomRadius
                || root.radiusStyle === RoundedRectangle.RadiusStyle.LeftRadius;
        }
        function bottomRightRadius() {
            return root.radiusStyle === RoundedRectangle.RadiusStyle.BottomRadius
                || root.radiusStyle === RoundedRectangle.RadiusStyle.RightRadius;
        }
    }

    // Corners hiding rectangles
    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
        }
        visible: d.noRadius || !d.topLeftRadius()
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
        visible: d.noRadius || !d.topRightRadius()
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
        visible: d.noRadius || !d.bottomLeftRadius()
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
        visible: d.noRadius || !d.bottomRightRadius()
        height: parent.radius
        width: height
        color: parent.color
        antialiasing: parent.antialiasing
    }
}

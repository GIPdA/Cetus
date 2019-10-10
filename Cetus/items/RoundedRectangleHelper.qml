pragma Singleton
import QtQuick 2.0
import QtQuick.Layouts 1.12

Item {

    function updateRadiusStyle(item) {
        var list = []
        for (var i = 0; i < item.children.length; i++) {
            var itemChildren = item.children[i]
            if (itemChildren.radiusStyle !== undefined) {
                itemChildren.radiusStyle = RoundedRectangle.NoRadius
                if (itemChildren.visible)
                    list.push(itemChildren)
            }
        }

        if (list.length === 1) {
            list[0].radiusStyle = RoundedRectangle.AllRadius
        } else if (list.length > 1) {
            if (item instanceof ColumnLayout) {
                list[0].radiusStyle = RoundedRectangle.TopRadius
                list[list.length-1].radiusStyle = RoundedRectangle.BottomRadius
            } else if (item instanceof RowLayout) {
                list[0].radiusStyle = RoundedRectangle.LeftRadius
                list[list.length-1].radiusStyle = RoundedRectangle.RightRadius
            }

        }
    }
}
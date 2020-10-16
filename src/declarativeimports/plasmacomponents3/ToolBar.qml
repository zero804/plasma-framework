/*
    SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.6
import QtQuick.Templates @QQC2_VERSION@ as T
import org.kde.plasma.core 2.0 as PlasmaCore

T.ToolBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    leftPadding: background.leftMargin
    topPadding: background.topMargin
    rightPadding: background.rightMargin
    bottomPadding: background.bottomMargin

    contentItem: Item { }

    background: PlasmaCore.FrameSvgItem {
        implicitHeight: 40 // TODO: Find a good way to sync this with the size of (Button or ToolButton) + padding
        imagePath: "widgets/toolbar"
        colorGroup: PlasmaCore.ColorScope.colorGroup
        enabledBorders: control.position == T.ToolBar.Header ?  PlasmaCore.FrameSvgItem.BottomBorder : PlasmaCore.FrameSvgItem.TopBorder
        PlasmaCore.SvgItem {
            svg: PlasmaCore.Svg {
                imagePath: "widgets/listitem"
            }
            elementId: "separator"
            anchors {
                left: parent.left
                right: parent.right
                top: control.position == T.ToolBar.Footer || (control.parent.footer && control.parent.footer == control) ? parent.top : undefined
                bottom: control.position == T.ToolBar.Footer || (control.parent.footer && control.parent.footer == control) ? undefined : parent.bottom
            }
        }
    }
}

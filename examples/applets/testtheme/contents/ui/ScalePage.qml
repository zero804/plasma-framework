/*
    SPDX-FileCopyrightText: 2014 Sebastian Kügler <sebas@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddons

Item {

    property int cheight: 48
    property int cwidth: themePage.width / 1.2
    property int _m: units.gridUnit / 2 * units.devicePixelRatio

    anchors {
        margins: units.largeSpacing
    }
    Column {
        id: col
        spacing: _m

        anchors {
            margins: _m
            top: parent.top
            left: parent.left
            right: parent.right
        }

        PlasmaExtras.Heading {
            width: parent.width
            elide: Text.ElideRight
            level: 1
            text: "Scaling Test"
            font.pointSize: cheatLabel.font.pointSize * 2
        }
    }
    PlasmaComponents.Label {
        id: cheatLabel
        text: "Cheating with the font size. This label scales with the devicePixelRatio <b>on top of</b> font rendering. Just to show how text scaling can work dynamically. Normal labels scale with the font size. For demonstration purposes we're faking scaled fonts here, to show how layouts' flows change."
        font.pointSize: theme.defaultFont.pointSize * units.devicePixelRatio / 1.8
        wrapMode: Text.WordWrap
        anchors {
            margins: _m
            top: col.bottom
            left: parent.left
            right: apeImage.left
        }
    }
    Image {
        id: apeImage
        objectName: "apeImage"
        height: parent.height / 6 * units.devicePixelRatio
        //width: height
        anchors {
            top: cheatLabel.top
            right: parent.right
            rightMargin: _m
        }
        fillMode: Image.PreserveAspectFit
        source: "../images/orangutan.jpg"
    }
    Flow {
        anchors {
            left: parent.left
            top: cheatLabel.height > apeImage.height ?  cheatLabel.bottom : apeImage.bottom
            topMargin: units.largeSpacing
            right: parent.right
        }
        //height: _h
        //width: parent.width
        spacing: units.smallSpacing

        PlasmaCore.IconItem {
            source: "configure"
            width: units.iconSizes.small
            height: width
        }
        PlasmaCore.IconItem {
            source: "dialog-ok"
            width: units.iconSizes.smallMedium
            height: width
        }
        PlasmaCore.IconItem {
            source: "resize-tr2bl"
            width: units.iconSizes.medium
            height: width
        }
        PlasmaCore.IconItem {
            source: "akonadi"
            width: units.iconSizes.large
            height: width
        }
        PlasmaCore.IconItem {
            source: "clock"
            width: units.iconSizes.huge
            height: width
        }
//         KQuickControlsAddons.QIconItem {
//             icon: "preferences-desktop-icons"
//             width: units.iconSizes.enormous
//             height: width
//         }

    }
}

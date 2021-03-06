/*
    SPDX-FileCopyrightText: 2015 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

pragma Singleton

import QtQuick 2.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.2 as Kirigami

QtObject {
    property color textColor: theme.textColor
    property color disabledTextColor: Qt.rgba(theme.textColor.r, theme.textColor.g, theme.textColor.b, 0.6)

    property color highlightColor: theme.highlightColor
    property color highlightedTextColor: theme.highlightedTextColor
    property color backgroundColor: theme.backgroundColor
    property color alternateBackgroundColor: Qt.darker(theme.backgroundColor, 1.05)
    //TODO: don't make this invisible
    property color activeTextColor: theme.highlightColor
    property color linkColor: theme.linkColor
    property color visitedLinkColor: theme.visitedLinkColor
    property color negativeTextColor: theme.negativeTextColor
    property color neutralTextColor: theme.neutralTextColor
    property color positiveTextColor: theme.positiveTextColor

    property color buttonTextColor: theme.buttonTextColor
    property color buttonBackgroundColor: theme.buttonBackgroundColor
    property color buttonAlternateBackgroundColor: Qt.darker(theme.buttonBackgroundColor, 1.05)
    property color buttonHoverColor: theme.buttonHoverColor
    property color buttonFocusColor: theme.buttonFocusColor

    property color viewTextColor: theme.viewTextColor
    property color viewBackgroundColor: theme.viewBackgroundColor
    property color viewAlternateBackgroundColor: Qt.darker(theme.viewBackgroundColor, 1.05)
    property color viewHoverColor: theme.viewHoverColor
    property color viewFocusColor: theme.viewFocusColor

    property color selectionTextColor: theme.highlightedTextColor
    property color selectionBackgroundColor: theme.highlightColor
    property color selectionAlternateBackgroundColor: Qt.darker(theme.highlightColor, 1.05)
    property color selectionHoverColor: theme.buttonHoverColor
    property color selectionFocusColor: theme.buttonFocusColor

    property color tooltipTextColor: theme.complementaryTextColor
    property color tooltipBackgroundColor: theme.complementaryBackgroundColor
    property color tooltipAlternateBackgroundColor: Qt.darker(theme.complementaryBackgroundColor, 1.05)
    property color tooltipHoverColor: theme.complementaryHoverColor
    property color tooltipFocusColor: theme.complementaryFocusColor

    property color complementaryTextColor: theme.complementaryTextColor
    property color complementaryBackgroundColor: theme.complementaryBackgroundColor
    property color complementaryAlternateBackgroundColor: Qt.darker(theme.complementaryBackgroundColor, 1.05)
    property color complementaryHoverColor: theme.complementaryHoverColor
    property color complementaryFocusColor: theme.complementaryFocusColor

    property color headerTextColor: theme.headerTextColor
    property color headerBackgroundColor: theme.headerBackgroundColor
    property color headerAlternateBackgroundColor: Qt.darker(theme.headerBackgroundColor, 1.05)
    property color headerHoverColor: theme.headerHoverColor
    property color headerFocusColor: theme.headerFocusColor

    property variant defaultFont: theme.defaultFont
    property variant smallFont: theme.smallestFont

    function __propagateColorSet(object, context) {
        object.PlasmaCore.ColorScope.inherit = false;
        switch(context) {
        case Kirigami.Theme.Window:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.NormalColorGroup;
            break;
        case Kirigami.Theme.Button:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.ButtonColorGroup;
            break;
        case Kirigami.Theme.View:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.ViewColorGroup;
            break;
        case Kirigami.Theme.Selection:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.NormalColorGroup;
            break;
        case Kirigami.Theme.Tooltip:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.ComplementaryColorGroup;
            break;
        case Kirigami.Theme.Complementary:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.ComplementaryColorGroup;
            break;
        case Kirigami.Theme.Header:
            object.PlasmaCore.ColorScope.colorGroup = PlasmaCore.Theme.HeaderColorGroup;
            break;
        }
    }
    function __propagateTextColor(object, color) {}
    function __propagateBackgroundColor(object, color) {}
    function __propagatePrimaryColor(object, color) {}
    function __propagateAccentColor(object, color) {}
}

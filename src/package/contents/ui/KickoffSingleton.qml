/* SPDX-FileCopyrightText: 2021 Noah Davis <noahadvs@gmail.com>
 * SPDX-License-Identifier: LGPL-2.0-or-later
 */

pragma ComponentBehavior: Bound
pragma Singleton // NOTE: Singletons are shared between all instances of a plasmoid

import QtQml.Models
import QtQuick
import QtQuick.Templates as T
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg
import org.kde.plasma.plasma5support as P5Support
import org.kde.plasma.components as PC3

// Using Item because it has a default property.
// Trying to create a default property for a QtObject seems to cause segfaults.
Item {
    id: root

    visible: false

    //BEGIN Models and Data Sources
    readonly property P5Support.DataSource powerManagement: P5Support.DataSource {
        engine: "powermanagement"
        connectedSources: ["PowerDevil"]
        // For some reason, these signal handlers need to be here for `data` to actually contain data.
        onSourceAdded: source => {
            disconnectSource(source);
            connectSource(source);
        }
        onSourceRemoved: source => disconnectSource(source);
    }
    //END

    //BEGIN Reusable Objects
    readonly property KSvg.Svg lineSvg: KSvg.Svg {
        imagePath: "widgets/line"
        property int horLineHeight: lineSvg.elementSize("horizontal-line").height
        property int vertLineWidth: lineSvg.elementSize("vertical-line").width
    }
    //END

    //BEGIN Metrics
    readonly property KSvg.FrameSvgItem listItemMetrics: KSvg.FrameSvgItem {
        visible: false
        imagePath: "widgets/listitem"
        prefix: "normal"
    }

    readonly property FontMetrics fontMetrics: FontMetrics {
        id: fontMetrics
        font: Kirigami.Theme.defaultFont
    }

    readonly property real compactListDelegateHeight: compactListDelegate.implicitHeight
    readonly property real compactListDelegateContentHeight: compactListDelegate.implicitContentHeight
    //END

    //BEGIN Private
    KickoffListDelegate {
        id: compactListDelegate
        visible: false
        enabled: false
        compact: true
        model: null
        index: -1
        text: "asdf"
        url: ""
        decoration: "start-here-kde"
        PC3.ToolTip.text: ""
        description: "asdf"
        action: null
        indicator: null
        isMultilineText: false
    }
    //END
}

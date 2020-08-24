import QtQuick 2.0
import QtQuick.Layouts 1.12
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

ComponentBase {
    id: root
    title: "Plasma Components 3 ProgressBar"
    property int progressBarWidth: testProgressBar.width

    PlasmaComponents.ProgressBar {
        id: testProgressBar
        visible: false
    }

    contentItem: GridLayout {
        columns: 6
        columnSpacing: PlasmaCore.Units.largeSpacing
        rowSpacing: PlasmaCore.Units.largeSpacing

        ColumnLayout {
            PlasmaComponents.Label {
                text: "0%"
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 100
                value: 0
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "50%"
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 100
                value: 50
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "100%"
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 100
                value: 100
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                id: progressBarAndSliderLabel
                text: "The progress bar and slider grooves should have the same visual width."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            GridLayout {
                id: progressBarAndSliderGrid
                columns: 1
                rows: 2
                PlasmaComponents.ProgressBar {
                    id: progressBar
                    from: 0
                    to: 100
                    value: 50
                }
                PlasmaComponents.Slider {
                    Layout.preferredWidth: progressBar.width
                     Layout.preferredHeight: progressBar.height
                    from: 0
                    to: 100
                    value: 50
                }
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "Min: 0; Max: 200; Value: 1\nMake sure the bar does not leak outside."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 200
                value: 1
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "Min: 0; Max: 100; Value: 110\nThe progress bar should look like it is at 100%."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 100
                value: 110
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "Min: -100; Max: 100; Value: 0\nThe progress bar should look like it is at 50%."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.ProgressBar {
                from: -100
                to: 100
                value: 0
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "Min: 0; Max: 100; Value: -10\nThe progress bar should look like it is at 0%."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.ProgressBar {
                from: 0
                to: 100
                value: -10
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "This should have a continuous movement from one end to the other and back."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.ProgressBar {
                indeterminate: indeterminateCheckBox.checked
                value: 0.5
            }
        }

        ColumnLayout {
            PlasmaComponents.Label {
                text: "Checking and unchecking should not break the layout. The progress bar should look like it is at 50% if unchecked."
                wrapMode: Text.WordWrap
                Layout.preferredWidth: progressBarWidth
            }
            PlasmaComponents.CheckBox {
                id: indeterminateCheckBox
                text: "Indeterminate"
                checked: true
            }
        }

    }
}

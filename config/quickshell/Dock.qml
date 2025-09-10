// Dock.qml
import Quickshell
import QtQuick

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      color: "transparent"

      Rectangle {
        anchors.fill: parent
        color: "black"
        radius: 10
      }
      anchors {
        bottom: true
        left: true
        right: true
      }

      margins {
        bottom: 5
        left: 700
        right: 700
      }

      implicitHeight: 50
    }
  }
}

// Bar.qml
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
        radius: 15
        //border.width: 1
        //border.color: "grey"
      }

      margins {
        top: 4
        right: 4
        left:4
      }

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      // Workspace indicator on the left
      WorkspaceIndicator {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
      }

      // Clock in the center
      ClockWidget {
        anchors.centerIn: parent
      }

      SystemTrayWidget {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
      }
    }
  }
}

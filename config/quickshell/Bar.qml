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
        border.width: 2
        border.color: "#444444"
      }

      margins {
        top: 4
        right: 18
        left: 18
      }

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      // Workspace indicator on the left
      WorkspaceIndicator {
        id: wsIndicator
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
      }

      SystemMonitor {
        anchors.left: wsIndicator.right
        anchors.leftMargin: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 6
      }

      //Row {
      //    anchors.left: parent.left
      //    //anchors.verticalCenter: parent.verticalCenter
      //    spacing: 12
      //    Layout.alignment: Qt.AlignVCenter   // ensures children are vertically centered
      //
      //    WorkspaceIndicator {}
      //    SystemMonitor {}
      //}

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

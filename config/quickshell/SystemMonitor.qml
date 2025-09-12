// SystemMonitor.qml
import QtQuick
import QtQuick.Layouts

RowLayout {
    spacing: 12

    Text {
        text: `CPU: ${SystemStats.cpu}%`
        font.family: "JetBrainsMono Nerd Font"
        color: "white"        // monochrome
    }

    Text {
        text: `Mem: ${SystemStats.mem}%`
        font.family: "JetBrainsMono Nerd Font"
        color: "white"        // monochrome
    }

    Text {
        text: `Disk: ${SystemStats.disk}%`
        font.family: "JetBrainsMono Nerd Font"
        color: "white"        // monochrome
    }
}

// SystemStats.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int cpu: 0
    property int mem: 0
    property int disk: 0

    // CPU
    Process {
        id: cpuProc
        command: ["bash", "-c", "grep 'cpu ' /proc/stat"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = text.trim().split(/\s+/).slice(1).map(Number)
                let idle = parts[3]
                let total = parts.reduce((a, b) => a + b, 0)

                if (root._prevTotal !== undefined) {
                    let idleDiff = idle - root._prevIdle
                    let totalDiff = total - root._prevTotal
                    root.cpu = Math.round(100 * (1 - idleDiff / totalDiff))
                }
                root._prevIdle = idle
                root._prevTotal = total
            }
        }
    }
    property int _prevIdle: 0
    property int _prevTotal: 0

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: cpuProc.running = true
    }

    // Memory
    Process {
        id: memProc
        command: ["bash", "-c", "free | awk '/Mem:/ {print int(100*$3/$2)}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.mem = parseInt(text)
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: memProc.running = true
    }

    // Disk
    Process {
        id: diskProc
        command: ["bash", "-c", "df -h / | awk 'NR==2 {gsub(/%/,\"\",$5); print $5}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.disk = parseInt(text)
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: diskProc.running = true
    }
}

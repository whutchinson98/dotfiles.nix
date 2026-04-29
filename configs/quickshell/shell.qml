import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    Variants {
        model: {
            var external = Quickshell.screens.filter(s => s.model?.includes("VG27AQ1A"));
            return external.length > 0 ? external : [Quickshell.screens[0]];
        }

    PanelWindow {
        id: root
        screen: modelData

        // Everforest Dark (Medium) palette
        readonly property color colBg:      "#2d353b"
        readonly property color colBgHard:  "#232a2e"
        readonly property color colBg1:     "#343f44"
        readonly property color colBg2:     "#3d484d"
        readonly property color colBg4:     "#56635f"
        readonly property color colFg:      "#d3c6aa"
        readonly property color colFg2:     "#d3c6aa"
        readonly property color colFg4:     "#9da9a0"
        readonly property color colRed:     "#e67e80"
        readonly property color colGreen:   "#a7c080"
        readonly property color colYellow:  "#dbbc7f"
        readonly property color colBlue:    "#7fbbb3"
        readonly property color colPurple:  "#d699b6"
        readonly property color colAqua:    "#83c092"
        readonly property color colOrange:  "#e69875"

        readonly property string fontFamily: "SpaceMono Nerd Font"
        readonly property int fontSize: 14

        // Nerd Font icons
        // VPN
        readonly property string iconVpn: "\uf132"
        // Volume
        readonly property string iconVolHigh: "\uf028"
        readonly property string iconVolLow:  "\uf027"
        readonly property string iconVolMute: "\uf6a9"
        // Network
        readonly property string iconWifi:     "\uf1eb"
        readonly property string iconEthernet: "\udb80\ude00"
        // CPU
        readonly property string iconCpu: "\uf2db"
        // Memory
        readonly property string iconMem: "\uefc5"
        // Backlight
        readonly property string iconSun: "\uf185"
        // Battery
        readonly property string iconBatEmpty:   "\uf244"
        readonly property string iconBatQuarter: "\uf243"
        readonly property string iconBatHalf:    "\uf242"
        readonly property string iconBatThreeQ:  "\uf241"
        readonly property string iconBatFull:    "\uf240"
        readonly property string iconBatCharge:  "\uf0e7"
        // System data
        property int cpuUsage: 0
        property int memUsage: 0
        property var lastCpuIdle: 0
        property var lastCpuTotal: 0
        property string networkName: ""
        property int networkStrength: 0
        property bool networkConnected: false
        property bool networkIsEthernet: false
        property int volume: 0
        property bool volumeMuted: false
        property int brightness: 0
        property int batteryPercent: 0
        property string batteryStatus: ""
        property bool vpnConnected: false
        property string vpnServer: ""

        anchors {
            top: true
            left: true
            right: true
        }
        margins.top: 0
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
        implicitHeight: 36
        color: "transparent"

        // CPU process
        Process {
            id: cpuProc
            command: ["sh", "-c", "head -1 /proc/stat"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    var p = data.trim().split(/\s+/)
                    if (p.length < 8) return
                    var idle = parseInt(p[4]) + parseInt(p[5])
                    var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                    if (root.lastCpuTotal > 0 && (total - root.lastCpuTotal) > 0) {
                        root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)))
                    }
                    root.lastCpuTotal = total
                    root.lastCpuIdle = idle
                }
            }
            Component.onCompleted: running = true
        }

        // Memory process
        Process {
            id: memProc
            command: ["sh", "-c", "free | grep Mem"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    var parts = data.trim().split(/\s+/)
                    var total = parseInt(parts[1]) || 1
                    var used = parseInt(parts[2]) || 0
                    root.memUsage = Math.round(100 * used / total)
                }
            }
            Component.onCompleted: running = true
        }

        // Network - check ethernet first, then wifi
        Process {
            id: netProc
            command: ["sh", "-c", "eth=$(nmcli -t -f TYPE,STATE,CONNECTION dev | grep '^ethernet:connected:' | head -1); if [ -n \"$eth\" ]; then echo \"ethernet:$(echo $eth | cut -d: -f3)\"; else nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi | grep '^yes' | head -1; fi"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data || data.trim() === "") {
                        root.networkConnected = false
                        root.networkIsEthernet = false
                        root.networkName = "Disconnected"
                        root.networkStrength = 0
                        return
                    }
                    var trimmed = data.trim()
                    if (trimmed.startsWith("ethernet:")) {
                        root.networkConnected = true
                        root.networkIsEthernet = true
                        root.networkName = trimmed.split(":")[1] || "Ethernet"
                        root.networkStrength = 100
                    } else {
                        var parts = trimmed.split(":")
                        root.networkConnected = true
                        root.networkIsEthernet = false
                        root.networkName = parts[1] || ""
                        root.networkStrength = parseInt(parts[2]) || 0
                    }
                }
            }
            Component.onCompleted: running = true
        }

        // Volume
        Process {
            id: volProc
            command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    root.volumeMuted = data.indexOf("[MUTED]") !== -1
                    var match = data.match(/Volume:\s+([\d.]+)/)
                    if (match) {
                        root.volume = Math.round(parseFloat(match[1]) * 100)
                    }
                }
            }
            Component.onCompleted: running = true
        }

        // Brightness
        Process {
            id: brightProc
            command: ["sh", "-c", "brightnessctl -m | cut -d, -f4 | tr -d '%'"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    root.brightness = parseInt(data.trim()) || 0
                }
            }
            Component.onCompleted: running = true
        }

        // Battery
        Process {
            id: batProc
            command: ["sh", "-c", "cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo 0"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    root.batteryPercent = parseInt(data.trim()) || 0
                }
            }
            Component.onCompleted: running = true
        }

        Process {
            id: batStatusProc
            command: ["sh", "-c", "cat /sys/class/power_supply/BAT1/status 2>/dev/null || echo Unknown"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    root.batteryStatus = data.trim()
                }
            }
            Component.onCompleted: running = true
        }

        // ProtonVPN status (parses proton0 device from nmcli, extracts server name)
        Process {
            id: vpnProc
            command: ["sh", "-c", "nmcli -t -f DEVICE,STATE,CONNECTION device status 2>/dev/null | awk -F: 'BEGIN{r=\"0:\"} $1==\"proton0\"{r=($2==\"connected\"?\"1\":\"0\") \":\" $3} END{print r}'"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data || data.trim() === "") {
                        root.vpnConnected = false
                        root.vpnServer = ""
                        return
                    }
                    var parts = data.trim().split(":")
                    root.vpnConnected = parts[0] === "1"
                    var connName = parts.slice(1).join(":")
                    root.vpnServer = connName.replace(/^ProtonVPN\s+/, "")
                }
            }
            Component.onCompleted: running = true
        }

        Process {
            id: vpnConnectProc
            command: ["protonvpn", "connect"]
            onExited: (code, status) => vpnProc.running = true
        }

        Process {
            id: vpnDisconnectProc
            command: ["protonvpn", "disconnect"]
            onExited: (code, status) => vpnProc.running = true
        }

        // System stats timer (every 2 seconds)
        Timer {
            interval: 2000
            running: true
            repeat: true
            onTriggered: {
                cpuProc.running = true
                memProc.running = true
                netProc.running = true
                volProc.running = true
                brightProc.running = true
                batProc.running = true
                batStatusProc.running = true
                vpnProc.running = true
            }
        }

        // Left pill - date + VPN
        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            color: Qt.rgba(0.137, 0.165, 0.180, 0.85)
            radius: 10
            border.width: 1
            border.color: root.colBg2
            width: leftRow.width + 24
            height: 28

            RowLayout {
                id: leftRow
                anchors.centerIn: parent
                spacing: 10

                Text {
                    id: dateText
                    color: root.colBlue
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                    Timer {
                        interval: 60000
                        running: true
                        repeat: true
                        onTriggered: dateText.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                    }
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                Text {
                    color: root.vpnConnected ? root.colGreen : root.colBg4
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: (root.vpnConnected ? (root.vpnServer !== "" ? root.vpnServer : "VPN") : "VPN") + " " + root.iconVpn
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: {
                            if (mouse.button === Qt.RightButton) {
                                if (root.vpnConnected) vpnDisconnectProc.running = true
                            } else {
                                if (root.vpnConnected) vpnDisconnectProc.running = true
                                else vpnConnectProc.running = true
                            }
                        }
                    }
                }
            }
        }

        // Center pill - time
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: Qt.rgba(0.137, 0.165, 0.180, 0.85)
            radius: 10
            border.width: 1
            border.color: root.colBg2
            width: centerRow.width + 24
            height: 28

            RowLayout {
                id: centerRow
                anchors.centerIn: parent

                Text {
                    id: clockText
                    color: root.colFg
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: Qt.formatDateTime(new Date(), "HH:mm")
                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: clockText.text = Qt.formatDateTime(new Date(), "HH:mm")
                    }
                }
            }
        }

        // Right pill - system stats
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            color: Qt.rgba(0.137, 0.165, 0.180, 0.85)
            radius: 10
            border.width: 1
            border.color: root.colBg2
            width: rightRow.width + 24
            height: 28

            RowLayout {
                id: rightRow
                anchors.centerIn: parent
                spacing: 10

                // Volume
                Text {
                    color: root.colOrange
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: root.volume + "% " + (root.volumeMuted ? root.iconVolMute : (root.volume > 50 ? root.iconVolHigh : root.iconVolLow))
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: volClickProc.running = true
                    }
                }

                Process {
                    id: volClickProc
                    command: ["pavucontrol"]
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // Network (icon only)
                Text {
                    color: root.networkConnected ? root.colGreen : root.colRed
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: {
                        if (!root.networkConnected) return "\u26a0"
                        if (root.networkIsEthernet) return root.iconEthernet
                        return root.iconWifi
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: netClickProc.running = true
                    }
                }

                Process {
                    id: netClickProc
                    command: ["sh", "-c", "$HOME/scripts/wifi-picker"]
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // CPU
                Text {
                    color: root.colYellow
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: root.cpuUsage + "% " + root.iconCpu
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // Memory
                Text {
                    color: root.colPurple
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: root.memUsage + "% " + root.iconMem
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // Backlight
                Text {
                    color: root.colYellow
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: root.brightness + "% " + root.iconSun
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // Battery
                Text {
                    color: {
                        if (root.batteryStatus === "Charging") return root.colGreen
                        if (root.batteryPercent <= 15) return root.colRed
                        if (root.batteryPercent <= 30) return root.colOrange
                        return root.colGreen
                    }
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: {
                        var icon
                        if (root.batteryStatus === "Charging") {
                            icon = root.iconBatCharge
                        } else {
                            var icons = [root.iconBatEmpty, root.iconBatQuarter, root.iconBatHalf, root.iconBatThreeQ, root.iconBatFull]
                            var idx = Math.min(Math.floor(root.batteryPercent / 25), 4)
                            icon = icons[idx]
                        }
                        return root.batteryPercent + "% " + icon
                    }
                }

                Rectangle { width: 1; height: 14; color: root.colBg4 }

                // Power button
                Text {
                    color: root.colRed
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                    text: "\uf011"
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: poweroffProc.running = true
                    }
                }

                Process {
                    id: poweroffProc
                    command: ["systemctl", "poweroff"]
                }
            }
        }
    }
    }
}

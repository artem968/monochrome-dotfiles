pragma Singleton

import Quickshell
import QtQuick

Singleton {
	property Palette palette: Palette {}
	property variant font: ({
			family: "Inter",
			monoFamily: "Adwaita Mono",
			pointSize: 10
		})

	component Palette: QtObject {
		property color bg0: "#0A0A0A"
		property color bg1: "#1D1D11"
		property color bg2: "#1D1D11"
		property color bg3: "#1D1D11"
		property color bg4: "#1D1D11"
		property color fg0: "#DDD5D0"
		property color fg1: "#CFC0BD"
		property color fg2: "#B8B8AA"
		property color fg3: "#7F9183"

		property color red: "#DB677C"
	}
}

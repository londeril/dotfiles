import Quickshell
import QtQuick

PanelWindow {
  id: toplevel

  anchors {
    bottom: true
    left: true
    right: true
  }
  implicitHeight: 10
  
  MouseArea {
      anchors.fill: parent
      hoverEnabled: true
      onEntered: test.visible = true
      onExited: test.visible = false
    }

  PopupWindow {
    id: test
    anchor.window: toplevel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    implicitWidth: 500
    implicitHeight: 300
    visible: false
    color: "#FFFFFF"

    Text {
      text: "test"
    }
  }
}

import bb.cascades 1.2

Container {
    property alias mlabelName: mlabelName.text
    layout: DockLayout {
    }
    background: Color.create("#6121be")
    horizontalAlignment: HorizontalAlignment.Center
    preferredHeight: 100
    preferredWidth: 700
    rightPadding: 10
    leftPadding: 10
    
    Label {
        id: mlabelName
        text: "Dialog title"
        verticalAlignment: VerticalAlignment.Center
    
    }
    
    ImageView {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Right
        imageSource: "asset:///images/note2.png"
        onTouch: {
        }
    }

}

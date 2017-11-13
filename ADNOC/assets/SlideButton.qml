import bb.cascades 1.0

Container {
    id: mContainerSlideView
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Top
    preferredHeight: 140
    leftPadding: 25
    signal openSlidePane() 
    layout: DockLayout {
    }
    ImageButton {
        defaultImageSource: "asset:///images/common/imgLeftPanel@2x.png"
        pressedImageSource: "asset:///images/common/imgLeftPanel@2x.png"
        verticalAlignment: VerticalAlignment.Center
        onClicked: {
            openSlidePane()
        }
    }

}

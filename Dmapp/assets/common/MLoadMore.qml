import bb.cascades 1.3

Container {
    property string mvaluelabel
    preferredHeight: 100
    layout: DockLayout {

    }
    horizontalAlignment: HorizontalAlignment.Fill
    background: Color.Black
    Label {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        text:mvaluelabel
        textStyle.color: Color.White
        textStyle.fontSize: FontSize.Large
    }

}

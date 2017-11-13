import bb.cascades 1.2

Container {
    topPadding: 25
    bottomPadding: 25
    background: mImagePaintDefinitionTopbar.imagePaint
    horizontalAlignment: HorizontalAlignment.Fill
    property alias mText : mLabelTitle.text
    layout: DockLayout {
    }
    Label {
        id : mLabelTitle
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle.fontSizeValue: FontSize.Large
        textStyle.color: Color.create("#004A65")
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopbar
            imageSource: "asset:///images/favourites/bg_text.png"
        }
    ]
}

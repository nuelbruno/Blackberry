import bb.cascades 1.0

Container {
    id: cntTopBar
    topPadding: 10.0
    rightPadding: 10.0
    bottomPadding: 10.0
    leftPadding: 10.0
    property alias mTitleValue: mTitle.text

    horizontalAlignment: HorizontalAlignment.Fill
    preferredHeight: 100
    minHeight: 100
    
//    background: Color.create("#b8860b")
//    background: Color.create("#7595AA")
    background: mImagePaintDefinitionTitle.imagePaint
    
    layout: DockLayout {
    }
    Label {
        id: mTitle
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        //        text: qsTr("About") + Retranslate.onLanguageChanged
        textStyle {
            base: SystemDefaults.TextStyles.TitleText
            color: Color.White
        }
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintDefinitionTitle
            repeatPattern: RepeatPattern.XY
            imageSource: "asset:///images/bg_titlebar.png"

        }
    ]
}

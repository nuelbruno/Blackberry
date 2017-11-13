import bb.cascades 1.0


Container {
    id: mMainContainer
    preferredHeight: 80
    preferredWidth: 250
    verticalAlignment: VerticalAlignment.Center
    background: mImagePaintBgButton.imagePaint
    property alias mButtonTitle: mButtonTitle.text
    //property alias mMainContainerLayout: mMainContainer.layoutProperties
    property bool isClicked: false
    signal click()
    
    layout: DockLayout {
    }
    Label {
        id: mButtonTitle
        textStyle.color: Color.White
        preferredHeight: 60
        maxHeight: 80
        preferredWidth: 250
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        textStyle.textAlign: TextAlign.Center
        textStyle.base: SystemDefaults.TextStyles.SubtitleText
        textStyle.fontWeight: FontWeight.Bold
        onTouch: {
            if (event.isDown()) {
                mButtonTitle.textStyle.color = Color.Black
            } else if (event.isUp() && isClicked == false) {
                mButtonTitle.textStyle.color = Color.White
                isClicked = true;
                
                click()
            } else if (event.isCancel()) {
                mButtonTitle.textStyle.color = Color.White
            }
        }
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintBgButton
            imageSource: "asset:///images/common/button_grey.png"
        }
    ]

}
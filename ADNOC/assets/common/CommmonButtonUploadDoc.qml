import bb.cascades 1.2


Container {
    id: mMainContainer
    preferredHeight: 80
    preferredWidth: 250
    verticalAlignment: VerticalAlignment.Center
    background: mImagePaintBgButton.imagePaint
    property alias mButtonTitle: mButtonTitle.text
    property bool isClicked: false
    signal click()
    
    layout: DockLayout {
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        leftMargin: 20.0
        leftPadding: 20.0
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        ImageView {
            imageSource: "asset:///images/common/icon_upload.png"
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            preferredHeight: 40
            preferredWidth: 40
        }    
        Label {
            id: mButtonTitle
            textStyle.color: Color.White
            preferredHeight: 80
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
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintBgButton
            imageSource: "asset:///images/common/button_greyDark.png"
        }
    ]

}
import bb.cascades 1.0
import my.timer 1.0
Container {
    id: mMainContainer
    background: mImagePaintDefinitionBG.imagePaint
    property alias mImageSource: mImageViewIcon.imageSource
    property alias mTextValue: mLabelText.text
    property bool isClicked: false
    property bool isDown: false
    signal click()
    layout: DockLayout {
    }
    preferredWidth: 200
    preferredHeight: 225
    topPadding: 30
    bottomPadding: 30
    onTouch: {
        if (event.isDown()) {
            //            mLabelText.textStyle.color = Color.Gray
            mImagePaintDefinitionBG.imageSource = "asset:///images/more/bg_more_hover.png"
            isDown = true;
        } else if (event.isUp()) {
            //            mLabelText.textStyle.color = Color.Black
            if (isClicked == false && isDown) {
                isClicked = true;
                isDown = false;
                mTimer.start();
                click()
            }
            mImagePaintDefinitionBG.imageSource = "asset:///images/more/bg_more_blue.png"
        } else if (event.isCancel()) {
            isDown = false;
            mImagePaintDefinitionBG.imageSource = "asset:///images/more/bg_more_blue.png"
            //            mLabelText.textStyle.color = Color.Black
        }
    }
    ImageView {
        id: mImageViewIcon
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Top
    }
    Label {
        id: mLabelText
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Bottom
        multiline: true
        textStyle {
            base: SystemDefaults.TextStyles.TitleText
            color: Color.White
            fontSize: FontSize.Small
            textAlign: TextAlign.Center

        }
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintDefinitionBG
            imageSource: "asset:///images/more/bg_more_blue.png"
        },
        QTimer {
            id: mTimer
            interval: 1000
            onTimeout: {
                isClicked = false
            }
        }
    ]
}
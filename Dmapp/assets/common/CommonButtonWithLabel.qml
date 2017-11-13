import bb.cascades 1.0
import my.timer 1.0
Container {
    id: list_container
    
    property alias mLableText: mLabelTitle.text
    property alias mWidth: list_container.preferredWidth
    property alias mBackgroundSource: mainBackground.imageSource
    property bool isClicked: false
    property alias mTextColor : mTextStyleTitle.color
    property alias mFontSize : mTextStyleTitle.fontSize
    background: mainBackground.imagePaint
    signal myClick()
    
    topPadding: 15
    bottomPadding: 15
    
    onCreationCompleted: {
    }

    onTouch: {
        if (event.isDown()) {
           //mLabelTitle.textStyle.color = Color.create("#FFA500")
            //mImageViewIcon.imageSource = mSelectedImageSource
        } else if (event.isUp() && isClicked == false) {

           // list_container.background = mainBackground.imagePaint
           // mLabelTitle.textStyle.color = Color.White
            //mImageViewIcon.imageSource = defaultImageSource
            isClicked = true;
            mTimer.start();

            myClick();
        } else if (event.isCancel()) {
           // list_container.background = mainBackground.imagePaint
          //  mLabelTitle.textStyle.color = Color.White
            //mImageViewIcon.imageSource = defaultImageSource
        }

    }
    layout: StackLayout {
    }
    Container {
        layout: DockLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        Label {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            id: mLabelTitle
            text: qsTr("Makani")
            textStyle {
                base: mTextStyleTitle.style
//                fontSize: FontSize.Large
            }
        }
    }

    attachedObjects: [
        ImagePaintDefinition {
            id: mainBackground
        },
        TextStyleDefinition {
            id: mTextStyleTitle
            color: Color.DarkBlue
            base: SystemDefaults.TextStyles.SubtitleText
            textAlign: TextAlign.Center
        },

        QTimer {
            id: mTimer
            interval: 500
            onTimeout: {
                isClicked = false
            }
        }
    ]
}

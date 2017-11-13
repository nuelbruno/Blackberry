import bb.cascades 1.0
import my.timer 1.0
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
//    preferredWidth: 550
    id: list_container
    property alias mLableText: mLabelTitle.text
    property alias mImageSource: mImageViewIcon.imageSource
    property bool isClicked: false
    property alias mContainerBg : mContainer.background
    property alias mLabelTitle: mLabelTitle
    topMargin: 20
    signal myClick()
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainer.layout.orientation = LayoutOrientation.LeftToRight
        } else {
            mContainer.layout.orientation = LayoutOrientation.RightToLeft
        }
    }
    
    onCreationCompleted: {
    }
    onTouch: {
        if (event.isDown()) {
            // list_container.background = Color.create("#597189")
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

    layout: DockLayout {

    }
    Container {
        id: mContainer
        background: mainBackground.imagePaint
        
        leftPadding: 30
        topPadding: 20
        bottomPadding: 20
        rightPadding: 30
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }

        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Top
        ImageView {
            id: mImageViewIcon
            leftMargin: 30
            verticalAlignment: VerticalAlignment.Center
            imageSource: "asset:///images/note2.png"
        }

        Label {
            verticalAlignment: VerticalAlignment.Center
            id: mLabelTitle
            text: qsTr("Makani")
            textStyle {
                base: mTextStyleTitle.style
            }

        }
    }

    attachedObjects: [
        ImagePaintDefinition {
            id: mainBackground
            imageSource: "asset:///images/info_list/bg_text.png"
        },
        TextStyleDefinition {
            id: mTextStyleTitle
            color: Color.DarkBlue
            base: SystemDefaults.TextStyles.SubtitleText
            textAlign: TextAlign.Center
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

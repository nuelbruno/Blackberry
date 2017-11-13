import bb.cascades 1.0
import my.timer 1.0

Container {
    preferredWidth: 325
    preferredHeight: 230
    id: list_container
    property alias mLableText: mLabelTitle.text
    property alias mLableTextObject :mLabelTitle.objectName
    property alias mImageSource: mImageViewIcon.imageSource
    property string mSelectedImageSource
    property string defaultImageSource
    property bool isClicked: false
    property bool isDown:false
    background: mainBackground.imagePaint
    
    signal myClick()
    onCreationCompleted: {
    }
    layout: DockLayout {
    }
    onTouch: {
        if (event.isDown()) {
            list_container.background =  Color.create("#F1EAD8")
            mLabelTitle.textStyle.color = Color.create("#FFFFFF")
            mImageViewIcon.imageSource = mSelectedImageSource
            isDown = true
            console.log("call down")
        } else if (event.isUp()) {
            console.log("call up")
            list_container.background = mainBackground.imagePaint
            mLabelTitle.textStyle.color = Color.create("#FFFFFF")
            mImageViewIcon.imageSource = defaultImageSource
            if (isClicked == false && isDown) {
                isClicked = true;
                mTimer.start();
                myClick();
                isDown = false
            }
        } else if (event.isCancel()) {
            isDown=false
            list_container.background = mainBackground.imagePaint
            mLabelTitle.textStyle.color = Color.create("#343434")
            mImageViewIcon.imageSource = defaultImageSource
        }
    
    }
    //    onTouch: {
    //        if (event.isDown()) {
    //            list_container.background = Color.create("#597189")
    //            mLabelTitle.textStyle.color = Color.create("#FFA500")
    //            mImageViewIcon.imageSource = mSelectedImageSource
    //        } else if (event.isUp() && isClicked == false) {
    //
    //            list_container.background = mainBackground.imagePaint
    //            mLabelTitle.textStyle.color = Color.White
    //            mImageViewIcon.imageSource = defaultImageSource
    //            isClicked = true;
    //            mTimer.start();
    //            myClick();
    //        } else if (event.isCancel()) {
    //            list_container.background = mainBackground.imagePaint
    //            mLabelTitle.textStyle.color = Color.White
    //            mImageViewIcon.imageSource = defaultImageSource
    //        }
    //
    //    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        topPadding: 10.0
        layout: StackLayout {
            id: mStackLayoutRow
            orientation: LayoutOrientation.TopToBottom
        
        }
        
        ImageView {
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            preferredHeight: 62
            preferredWidth: 52
            id: mImageViewIcon
        }
        
        Label {
            id: mLabelTitle
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Center
            
            multiline:  true
            textStyle {
                base: mTextStyleTitle.style
            }
        
        }
    
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mainBackground
            //            imageSource: "asset:///images/main/home_list_bg.png"
        },
        TextStyleDefinition {
            id: mTextStyleTitle
            // base: SystemDefaults.TextStyles.SubtitleText
            textAlign: TextAlign.Center
            color: Color.create("#FFFFFF")
            fontSize: FontSize.XXSmall
            
            //            lineHeight: 1.5
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

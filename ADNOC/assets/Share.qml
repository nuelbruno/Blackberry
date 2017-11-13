// ***********************************************************************************************************
//  COMMON SHARE CODE TO INCLUDE IN ALL PAGES
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {

    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Center
    property string mShareData
    property string mCopyData
    property string coordinateA
    property int selectedCount: 0
    property alias mBackVisible: mImageViewInfoBack.visible
    layout: DockLayout {
    }
    // LNAGAUGE ALIGNMENT CODE 
    function setAlignMent() {
        
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            background: mImagePaintDefinitionTopBG.imagePaint
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            preferredHeight: 100
            layout: DockLayout {
            }
            leftPadding: 50
            rightPadding: 50
            topPadding: 15
            Container {
                id: mContaineLeft
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                verticalAlignment: VerticalAlignment.Center
                ImageButton {
                    id: mImageViewInfoBack
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    defaultImageSource: "asset:///images/icon_arrow.png"
                    onClicked: {
                        mDialogShare.close();
                        backClick();
                    }
                }
                Label {
                    text: qsTr("Share") + Retranslate.onLanguageChanged
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/icon_close_white.png"
                onClicked: {
                    mDialogShare.close();
                }
            }
        } //top bar ends
        // FACEBOOK SHARE BUTTON
        Container {
            leftPadding: 50
            rightPadding: 50
            topPadding: 30
            bottomPadding: 80
            minHeight: 350
            horizontalAlignment: HorizontalAlignment.Fill
            background: mImagePaintDefinitionMainBG.imagePaint
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelFacebook
                mLableText: qsTr("Facebook") + Retranslate.onLanguageChanged
                mImageSource: "asset:///images/share/icon_fb.png"
                mBackgroundSource: "asset:///images/share/bg_fb.png"
                mTextColor: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                onMyClick: {
                    _ADNOC.shareOnFB(mShareData);
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelTwitter
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: qsTr("Twitter") + Retranslate.onLanguageChanged
                mImageSource: "asset:///images/share/icon_twit.png"
                mBackgroundSource: "asset:///images/share/bg_twit.png"
                mTextColor: Color.White
                onMyClick: {
                    console.log("twiiter share data cont" + mShareData.length);
                   

                    _ADNOC.shareOnTwitter(mShareData);
                    
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelEmail
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: qsTr("Email") + Retranslate.onLanguageChanged
                // mImageSource: "asset:///images/share/icon_email.png"
                mImageSource: "asset:///images/share/email.png"
                mBackgroundSource: "asset:///images/share/bg_email.png"
                mTextColor: Color.White
                onMyClick: {
                    _ADNOC.shareOnEmail(mShareData);
                }
            }
            
        }
    }
    attachedObjects: [
       
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopBG
            imageSource: "asset:///images/icon_bg_top.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionMainBG
            imageSource: "asset:///images/icon_bg_white_small.png"
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            //confirmButton.label: mAllStrings.mDialogOk
            onFinished: {
                if (mSystemDialog.result == SystemUiResult.ConfirmButtonSelection) {
                }
            }
        }
    ]
}

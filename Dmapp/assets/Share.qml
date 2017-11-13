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
    signal backClick()
    layout: DockLayout {
    }
    // LNAGAUGE ALIGNMENT CODE 
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow.png"
        } else {
            mContaineLeft.layout.orientation = LayoutOrientation.RightToLeft
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow_right.png"
        }
        mCommonButtonWithImageLabelCopy.setAlignMent();
        mCommonButtonWithImageLabelEmail.setAlignMent();
        mCommonButtonWithImageLabelFacebook.setAlignMent();
        mCommonButtonWithImageLabelSMS.setAlignMent();
        mCommonButtonWithImageLabelTwitter.setAlignMent();
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
                    defaultImageSource: "asset:///images/info/icon_arrow.png"
                    onClicked: {
                        mDialogShare.close();
                        backClick();
                    }
                }
                Label {
                    text: mAllStrings.mShare
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/info/icon_close_white.png"
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
                mLableText: mAllStrings.mShareonFacebook
                mImageSource: "asset:///images/share/icon_fb.png"
                mBackgroundSource: "asset:///images/share/bg_fb.png"
                mTextColor: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                onMyClick: {
                    _mAppParentObj.shareOnFB(mShareData);
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelTwitter
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: mAllStrings.mShareonTwitter
                mImageSource: "asset:///images/share/icon_twit.png"
                mBackgroundSource: "asset:///images/share/bg_twit.png"
                mTextColor: Color.White
                onMyClick: {
                    console.log("twiiter share data cont" + mShareData.length);
                    if (selectedCount > 1) {
                        mSystemDialog.body = mAllStrings.mOntwitterusercanshareonlyonemakaninumber
                        mSystemDialog.show()
                        selectedCount = 0
                    }
                    else if(coordinateA == 1 && mShareData.length > 135)
                    {
                        mSystemDialog.body = mAllStrings.mOntwitterusercanshareonlyonemakaninumber
                        mSystemDialog.show()
                        //mtwitterAlert.body = mAllStrings.mOntwitterusercanshareonlyonemakaninumber
                        //mtwitterAlert.show()  //coordinateA == 1 
                    }
                    else {

                        _mAppParentObj.shareOnTwitter(mShareData);
                    }
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelEmail
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: mAllStrings.mEmailToFriend
                // mImageSource: "asset:///images/share/icon_email.png"
                mImageSource: "asset:///images/share/email.png"
                mBackgroundSource: "asset:///images/share/bg_email.png"
                mTextColor: Color.White
                onMyClick: {
                    _mAppParentObj.shareOnEmail(mShareData);
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelSMS
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: mAllStrings.mSMSToFriend
                //    mImageSource: "asset:///images/share/icon_sms.png"
                mImageSource: "asset:///images/share/sms.png"
                mBackgroundSource: "asset:///images/share/bg_sms.png"
                mTextColor: Color.White
                onMyClick: {
                    _mAppParentObj.shareOnMessage(mShareData);
                }
            }
            CommonButtonWithImageLabel {
                id: mCommonButtonWithImageLabelCopy
                horizontalAlignment: HorizontalAlignment.Fill
                mLableText: mAllStrings.mCopyToClipboard
                mImageSource: "asset:///images/share/icon_copyclip.png"
                mBackgroundSource: "asset:///images/share/bg_copyclip.png"
                mTextColor: Color.White
                onMyClick: {
                    if (_mAppParentObj.copyDataToClipboard(mCopyData)) {
                        mSystemDialog.body = mAllStrings.mValidationCopyToClipboardSuccess
                        mSystemDialog.show();
                    }
                    mDialogShare.close();
                }
            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopBG
            imageSource: "asset:///images/info_list/icon_bg_top.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionMainBG
            imageSource: "asset:///images/info_list/icon_bg_white_small.png"
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
            onFinished: {
                if (mSystemDialog.result == SystemUiResult.ConfirmButtonSelection) {
                }
            }
        },
        SystemDialog {
            id: mtwitterAlert
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
            onFinished: {
                _mAppParentObj.shareOnTwitter(mShareData);
            }
        }
    ]
}

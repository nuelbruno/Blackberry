// ***********************************************************************************************************
//  LANGUAGE CHANGE SETUP FILE
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
Page {
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onCreationCompleted: {
            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                mButtonEnglish.mBackgroundSource = "asset:///images/lang/hover_lang.png"
                mButtonEnglish.mTextColor = Color.White
                mButtonArabic.mTextColor = Color.Black
                mButtonArabic.mBackgroundSource = "";
                mLableChangeLang.textStyle.textAlign = TextAlign.Left
                mContainerButton.layout.orientation = LayoutOrientation.LeftToRight
            } else {
                mButtonArabic.mBackgroundSource = "asset:///images/lang/hover_lang.png"
                mButtonArabic.mTextColor = Color.White
                mButtonEnglish.mTextColor = Color.Black
                mButtonEnglish.mBackgroundSource = "";
                mContainerLang.horizontalAlignment = HorizontalAlignment.Right
                mLableChangeLang.textStyle.textAlign = TextAlign.Right
                mContainerButton.layout.orientation = LayoutOrientation.RightToLeft
            }

        }
        layout: DockLayout {

        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonTopBar {
                id: mCommonBar
                mText: mAllString.mSettings
            }
            Container {
                id: mContainerLang
                layout: StackLayout {
                }
                topPadding: 50
                leftPadding: 30
                rightPadding: 30
                Label {
                    id: mLableChangeLang
                    text: mAllString.mTitleChangeLanguage
                    horizontalAlignment: HorizontalAlignment.Fill
                    textStyle.color: mAllString.lightBlueColor
                    multiline: true
                }
                Container {
                    id: mContainerButton
                    topMargin: 50
                    topPadding: 10
                    rightPadding: 10
                    leftPadding: 10
                    bottomPadding: 10
                    background: mImagePaintDefinitionBG.imagePaint
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    CommonButtonWithLabel {
                        id: mButtonEnglish
                        mWidth: 200
                        mLableText: mAllString.mEnglish
                        mBackgroundSource: "asset:///images/lang/hover_lang.png"
                        mTextColor: Color.White
                        mFontSize: FontSize.XSmall
                        onMyClick: {
                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") != "en") {
                                _mAppParentObj.updateLocale("en-US");
                                _mWebServiceinstance.saveValueFor("mLanguageCode", "en")
                                restartApp()
                            }
                        }
                    }
                    CommonButtonWithLabel {
                        leftMargin: 10
                        id: mButtonArabic
                        mWidth: 200
                        mLableText: mAllString.mArabic
                        mFontSize: FontSize.XSmall
                        mTextColor: Color.Black
                        onMyClick: {
                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                _mAppParentObj.updateLocale("ar");
                                _mWebServiceinstance.saveValueFor("mLanguageCode", "ar")
                                restartApp();
                            }
                        }
                    }
                }
            }
        }
    }
    // RESTART THE APP ON CHANGE OF LANGUAGE
    function restartApp() {
        _mWebServiceinstance.ClearMapdata();
        mNavigationPaneMain.pop();
        mainTabPaned.changeTab(0);
        mainTabPaned.changeAlignMent();

    }
    attachedObjects: [
        AllStrings {
            id: mAllString
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionBG
            imageSource: "asset:///images/lang/bg_lang.amd"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionHover
            imageSource: "asset:///images/lang/hover_lang.amd"
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: "Back"
            onTriggered: {
                mNavigationPaneMain.pop();
            }
        }
    }
}

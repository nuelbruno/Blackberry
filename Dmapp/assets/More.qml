// ***********************************************************************************************************
//  MORE PAGE CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
NavigationPane {
    id: mNavigationPaneMain
    peekEnabled: false
    // LANGAUGE ALIGNEMNT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerFirst.layout.orientation = LayoutOrientation.LeftToRight
            mContainerSecond.layout.orientation = LayoutOrientation.LeftToRight
            mContainerThird.layout.orientation = LayoutOrientation.LeftToRight
            //    mContainerPins.layout.orientation = LayoutOrientation.LeftToRight
            // mContainerUAENG.layout.objectName = LayoutOrientation.LeftToRight

            /* mButtonArabic.mBackgroundSource = "asset:///images/lang/hover_lang.png"
             * mButtonEnglish.mBackgroundSource = "";
             * mButtonArabic.mTextColor = Color.White
             mButtonEnglish.mTextColor = Color.Black*/
            mButtonArabic.mBackgroundSource = ""
            mButtonEnglish.mBackgroundSource = "asset:///images/lang/hover_lang.png";
            mButtonArabic.mTextColor = Color.Black
            mButtonEnglish.mTextColor = Color.White
//            mContainerButton.layout.orientation = LayoutOrientation.LeftToRight

        } else {
            mContainerFirst.layout.orientation = LayoutOrientation.RightToLeft
            mContainerSecond.layout.orientation = LayoutOrientation.RightToLeft
            mContainerThird.layout.orientation = LayoutOrientation.RightToLeft
            //  mContainerPins.layout.orientation = LayoutOrientation.RightToLeft
            // mContainerUAENG.layout.orientation = LayoutOrientation.RightToLeft
            /* mButtonEnglish.mBackgroundSource = "asset:///images/lang/hover_lang.png"
             * mButtonArabic.mBackgroundSource = "";
             * mButtonEnglish.mTextColor = Color.White
             mButtonArabic.mTextColor = Color.Black*/

            mButtonEnglish.mBackgroundSource = ""
            mButtonArabic.mBackgroundSource = "asset:///images/lang/hover_lang.png";
            mButtonEnglish.mTextColor = Color.Black
            mButtonArabic.mTextColor = Color.White
//            mContainerButton.layout.orientation = LayoutOrientation.RightToLeft
        }
    }
    // RESTART APP ON LANGUAGE CHANGE
    function restartApp() {
        _mWebServiceinstance.ClearMapdata();
        //mNavigationPaneMain.pop();
        mainTabPaned.changeTab(0);
        mainTabPaned.changeAlignMent();

    }
    onCreationCompleted: {
        setAlignMent();

    }
    Page {
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonTopBar {
                mText: mAllStrings.mMore
            }
            // ALL MORE ICONS AND OPTIONS
            Container {
                id: mContainerFirst
                topPadding: 10
                leftPadding: 20
                rightPadding: 20
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                /*CommmonMoreButton {
                 * mImageSource: "asset:///images/more/icon_changelanguage.png"
                 * mTextValue: mAllStrings.mTitleChangeLanguage
                 * layoutProperties: StackLayoutProperties {
                 * spaceQuota: 1
                 * }
                 * onClick: {
                 * var mPage = mComponentDefinitionCoordinateLang.createObject();
                 * mNavigationPaneMain.push(mPage);
                 * }
                 }*/
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/icon_coordinate_converter.png"
                    mTextValue: mAllStrings.mTitleCoordinateConverter
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionCoordinateConverter.createObject();
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/Map-Legend.png"
                    mTextValue: mAllStrings.mMapLegend
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionMapLegend.createObject();
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/button_tutorial.png"
                    // mTextValue: mAllStrings.mTutorial
                    mTextValue: mAllStrings.mTitleHelp
                    layoutProperties: StackLayoutProperties {

                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionTutorial.createObject();
                        //var mPage = mComponentDefinitionLayoutTuto.createObject()
                        //  mPage.isFromMore = true
                        mNavigationPaneMain.push(mPage);
                    }
                }

            }
            Container {
                id: mContainerSecond
                leftPadding: 20
                rightPadding: 20
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/icon_aboutus.png"
                    mTextValue: mAllStrings.mTitleAboutus
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionCoordinateAboutUs.createObject();
                        mPage.mTitle = mAllStrings.mTitleAboutus;
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en")
//                            mPage.mWebViewPath = "local:///assets/html/aboutus.html";
                            mPage.mWebViewPath = _mWebServiceinstance.getAboutUsHtml()
                        else
//                            mPage.mWebViewPath = "local:///assets/html/aboutus_ar.html"
                            mPage.mWebViewPath = _mWebServiceinstance.getAboutUsHtmlAR()
                        console.debug("ABout Us :", _mWebServiceinstance.getAboutUsHtml())
                        
                        
                        mPage.mNavigationPaneMain = mNavigationPaneMain
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/icon_disclaimer.png"
                    mTextValue: mAllStrings.mTitleDisclaimer
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionCoordinateAboutUs.createObject();
                        mPage.mTitle = mAllStrings.mTitleDisclaimer;
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en")
//                            mPage.mWebViewPath = "local:///assets/html/disclaimer.html";
                        mPage.mWebViewPath = _mWebServiceinstance.getDisclamerHtml()
                        else
//                            mPage.mWebViewPath = "local:///assets/html/disclaimer_ar.html"
                        mPage.mWebViewPath = _mWebServiceinstance.getDisclamerHtmlAR()
                        
                        
                        console.debug("getDisclamerHtml Us :", _mWebServiceinstance.getDisclamerHtml())
                        
                        mPage.mNavigationPaneMain = mNavigationPaneMain
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/icon_contactus.png"
                    mTextValue: mAllStrings.mTitleContactUs
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionCoordinateAboutUs.createObject();
                        mPage.mTitle = mAllStrings.mTitleContactUs;
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en")
//                            mPage.mWebViewPath = "local:///assets/html/contactus.html";
                        mPage.mWebViewPath = _mWebServiceinstance.getContactUsHtml()
                        else
//                            mPage.mWebViewPath = "local:///assets/html/contactus_ar.html"
                        mPage.mWebViewPath = _mWebServiceinstance.getContactUsHtmlAR()

                        console.debug("getContactUsHtml Us :", _mWebServiceinstance.getContactUsHtml())
                        
                        mPage.mNavigationPaneMain = mNavigationPaneMain
                        mNavigationPaneMain.push(mPage);
                    }
                }

            }
            Container {
                id: mContainerThird
                leftPadding: 20
                rightPadding: 20
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/Feedback.png"
                    mTextValue: mAllStrings.mTitleFeedBack
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionFeedBack.createObject();
                        mPage.mNavigationPaneFeedBack = mNavigationPaneMain
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/button_rating.png"
                    mTextValue: mAllStrings.mTitleRatingmore
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionRating.createObject();
                        mPage.mNavigationPaneRatings = mNavigationPaneMain
                        mNavigationPaneMain.push(mPage);
                    }
                }
                CommmonMoreButton {
                    mImageSource: "asset:///images/more/Scan.png"
                    mTextValue: mAllStrings.mTitleScan
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClick: {
                        var mPage = mComponentDefinitionScan.createObject();
                        mNavigationPaneMain.push(mPage);
                    }
                }

            }

            Container {
                id: mContainerButton
                topMargin: 50
                topPadding: 10
                rightPadding: 10
                leftPadding: 10
                bottomPadding: 10
                horizontalAlignment: HorizontalAlignment.Center
                background: mImagePaintDefinitionBG.imagePaint
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CommonButtonWithLabel {
                    id: mButtonEnglish
                    mWidth: 200
                    mLableText: mAllStrings.mEnglish
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
                    mLableText: mAllStrings.mArabic
                    mFontSize: FontSize.XSmall
                    mTextColor: Color.White
                    onMyClick: {
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                            _mAppParentObj.updateLocale("ar");
                            _mWebServiceinstance.saveValueFor("mLanguageCode", "ar")
                            restartApp();
                        }
                    }
                }

            }
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                text: mAllStrings.mAppName + " 1.0"
            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        ComponentDefinition {
            id: mComponentDefinitionCoordinateConverter
            source: "CoordinateConverter.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionCoordinateAboutUs
            source: "AboutUs.qml"
        },
        /*ComponentDefinition {
         * id: mComponentDefinitionCoordinateLang
         * source: "LanguageChange.qml"
         },*/
        ComponentDefinition {
            id: mComponentDefinitionFeedBack
            source: "FeedBack.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionTutorial
            source: "tutorial3.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionRating
            source: "Rating.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionScan
            source: "Scan.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionMapLegend
            source: "Maplegend.qml"
        },
        ComponentDefinition {
            id: mComponentDefinitionLayoutTuto
            source: "LayoutTutorial.qml"
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
}

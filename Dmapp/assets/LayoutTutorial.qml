// ***********************************************************************************************************
//  GETTING IMAGES  AND SHOWING THAT IN TUTORIAL PAGE
//
//
// ***********************************************************************************************************

import bb.cascades 1.3
import "common"
import bb.system 1.2
import WebImageView 1.0

Container {
    id: mpage
    property string mCheck
    property NavigationPane mNavigationPaneTutorial
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill

    property variant mListGalleryHandler
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    // ########################  CALL WEB SERVICE FOR IMAGES IN TUTORIAL PAGE  #######################  //
    function checkInternetConnection() {
        _mWebServiceinstance.tutorialDone.connect(dataConnected)
        if (_mAppParentObj.isNetworkAvailable()) {
            _mWebServiceinstance.callTUTORIAL()
        } else {
            mSystemDialog.body = mAllString.mNetworkCheck
            mSystemDialog.show()
        }
    }
    onCreationCompleted: {
        //        _mWebServiceinstance.tutorialDone.connect(dataConnected)

        //        if (_mAppParentObj.isNetworkAvailable()) {
        //            _mWebServiceinstance.callTUTORIAL()
        //        } else {
        //            mSystemDialog.body = mAllString.mNetworkCheck
        //            mSystemDialog.show()
        //        }
        // ######################## LANGAUGE CHANGE ALIGNMENT   #######################  //    
        setAlignment()
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerArabic.visible = false
            mContainerEnglish.visible = true
        } else {
            mContainerArabic.visible = true
            mContainerEnglish.visible = false
        }
        //  _mWebServiceinstance.callTUTORIAL()

        if (_mAppParentObj.getValueFor("mcheckboxSkipTu", "false") == "true") {
            mCheckBox.checked = true

        } else {
            mCheckBox.checked = false
        }
    }
    function imageLoadedCompleted() {
        mActivityIndicator.stop()
    }
    // ########################  GET ALL IAMGES AND STORING  #######################  //
    function dataConnected() {
        var mImages = new Array()
        mImages = _mWebServiceinstance.getImages()
        mGroupDataModelImages.clear()
        for (var i = 0; i < mImages.length; i ++) {
            mGroupDataModelImages.insert({
                    "my_images": mImages[i].my_images
                });
            console.debug("image url test:", mImages[i].my_images) 
        }

    }
    // ########################  LANGUAGE CHANGE ALIGNMENT  #######################  //
    function setAlignment() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mcontainerbelowTop.layout.orientation = LayoutOrientation.LeftToRight
            mStackLayout.orientation = LayoutOrientation.LeftToRight
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Left
        } else {
            mcontainerbelowTop.layout.orientation = LayoutOrientation.RightToLeft
            mStackLayout.orientation = LayoutOrientation.RightToLeft
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Right
        }
    }
    // CLOSE BUTTON ON TOP
    CommonTopBar {
        id: mCommonBar
        mText: mAllString.mTitleHelp
        Container {
            id: mContainerHome
            leftPadding: ui.du(3)
            rightPadding: ui.du(3)
            layout: DockLayout {

            }
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center

            ImageButton {
                //                preferredHeight: ui.du(5.0)
                //                preferredWidth: ui.du(5.0)
                preferredHeight: 45
                preferredWidth: 45
                horizontalAlignment: HorizontalAlignment.Fill
                defaultImageSource: "asset:///images/tutorial/closeButton_64.png"
                disabledImageSource: "asset:///images/tutorial/closeButton_64.png"
                pressedImageSource: "asset:///images/tutorial/closeButton_64.png"
                //  visible: isFromMore == true ? true : false
                onClicked: {
                    mDialog.close()
                }
            }
        }
    }
    // TAB FOR ALL TUTORIAL , FAQ , QUICK TUROL ETC
    Container {
        id: mcontainerbelowTop
        horizontalAlignment: HorizontalAlignment.Fill
        // verticalAlignment: VerticalAlignment.Fill
        preferredHeight: 90
        background: Color.Gray
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }

        Container {
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {

            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Label {
                topMargin: ui.du(5)
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                textStyle.fontSize: FontSize.XSmall
                text: mAllString.mFAQ
            }

            ImageView {
                id: mImageViewFaqTab
                visible: false
                verticalAlignment: VerticalAlignment.Bottom
                imageSource: "asset:///images/directions/tab_hover.png"
            }

            onTouch: {
                if (event.touchType == TouchType.Up) {
                    mImageViewVideoTab.visible = false
                    mImageViewQucikTab.visible = false
                    mImageViewFaqTab.visible = true
                    mImageViewquickguideTab.visible = false

                    mContainerFAQ.visible = true
                    mContainetQuickTutorial.visible = false
                    mContainerVideo.visible = false
                    mContainerquickguide.visible = false

                    console.debug("faq")

                }
            }
        }
        Container {
            preferredHeight: 90
            preferredWidth: 2
            background: Color.Black
        }
        Container {
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {

            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Label {
                topMargin: ui.du(5)
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: mAllString.mQuickTutorial
                textStyle.fontSize: FontSize.XSmall
            }

            ImageView {
                id: mImageViewQucikTab
                visible: true
                verticalAlignment: VerticalAlignment.Bottom
                imageSource: "asset:///images/directions/tab_hover.png"
            }

            onTouch: {
                if (event.touchType == TouchType.Up) {
                    mImageViewVideoTab.visible = false
                    mImageViewQucikTab.visible = true
                    mImageViewFaqTab.visible = false
                    mImageViewquickguideTab.visible = false

                    mContainerFAQ.visible = false
                    mContainetQuickTutorial.visible = true
                    mContainerVideo.visible = false
                    mContainerquickguide.visible = false
                    console.debug("quick")

                    // _mWebServiceinstance.callTUTORIAL()
                }
            }
        }
        Container {
            preferredHeight: 90
            preferredWidth: 2
            background: Color.Black
            visible: false
        }
        Container {
            visible: false
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {

            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: mAllString.mVideoTutorial
                textStyle.fontSize: FontSize.XSmall
            }

            ImageView {
                id: mImageViewVideoTab
                visible: false
                verticalAlignment: VerticalAlignment.Bottom
                imageSource: "asset:///images/directions/tab_hover.png"
            }

            onTouch: {
                if (event.touchType == TouchType.Up) {
                    mContainerVideo.visible = true
                    mContainetQuickTutorial.visible = false
                    mContainerFAQ.visible = false
                    mContainerquickguide.visible = false

                    mImageViewVideoTab.visible = true
                    mImageViewQucikTab.visible = false
                    mImageViewFaqTab.visible = false
                    mImageViewquickguideTab.visible = false

                    console.debug("video")
                }
            }
        }
        Container {
            preferredHeight: 90
            preferredWidth: 2
            background: Color.Black
        }
        Container {
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {

            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                text: mAllString.mQuickUserGuideTutorial
                // text: "Quick Guide"
                textStyle.fontSize: FontSize.XSmall
            }

            ImageView {
                id: mImageViewquickguideTab
                visible: false
                verticalAlignment: VerticalAlignment.Bottom
                imageSource: "asset:///images/directions/tab_hover.png"
            }

            onTouch: {
                if (event.touchType == TouchType.Up) {
                    mContainerVideo.visible = false
                    mContainetQuickTutorial.visible = false
                    mContainerFAQ.visible = false
                    mContainerquickguide.visible = true

                    mImageViewVideoTab.visible = false
                    mImageViewQucikTab.visible = false
                    mImageViewFaqTab.visible = false
                    mImageViewquickguideTab.visible = true
//                    mWebView.url = "http://demoserver.tacme.net:4040/makani/public/uploads/6055_Makani%20User%20Guide.pdf"
                    mWebView.url = _mWebServiceinstance.setQuickGuideUrl()
                    console.debug("quickguide")
                }
            }
        }
        Container {
            preferredHeight: 90
            preferredWidth: 2
            background: Color.Black
        }
    }
    // QUICK QUIDE CONTAINER 
    Container {
        id: mContainerquickguide
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        visible: false
        layout: DockLayout {

        }
        preferredHeight: 990
        verticalAlignment: VerticalAlignment.Fill
        WebView {
            id: mWebView
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            // mWebView.url= "http://demoserver.tacme.net:4040/makani/public/uploads/6055_Makani%20User%20Guide.pdf"
            onLoadingChanged: {

                if (loadRequest.status == WebLoadStatus.Started) {
                    //                                    console.debug("onLoadingChanged loadRequest :", mWebImageViewIndoor.url)
                    mActivityIndicatorwebview.start()

                } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                    mActivityIndicatorwebview.stop()

                } else if (loadRequest.status == WebLoadStatus.Failed) {
                    mActivityIndicatorwebview.stop()
                }
            }
        }
        ActivityIndicator {
            id: mActivityIndicatorwebview
            preferredHeight: 250
            preferredWidth: 250
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center

        }
    }
    // FAQ CONTAINER
    Container {
        id: mContainerFAQ
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        visible: false
        preferredHeight: 990
        //        verticalAlignment: VerticalAlignment.Fill
        Container {
            id: mContainerEnglish
            horizontalAlignment: HorizontalAlignment.Fill
            function getWSInstance() {
                return _mWebServiceinstance
            }
            ListView {
                id: mListView
                horizontalAlignment: HorizontalAlignment.Center
                dataModel: _mWebServiceinstance.mymodelTutorial
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Faq {
                            id: mExpandableMainServices
                            horizontalAlignment: HorizontalAlignment.Fill
                            expandImage: "asset:///images/tutorial/open.png"
                            collapseImage: "asset:///images/tutorial/close.png"
                            mLableAnswerValue: ListItemData.ans
                            mLableQuationValue: ListItemData.question
                        }

                    }
                ]

            }

        }
        Container {
            id: mContainerArabic
            visible: false
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 990
            ListView {
                id: mListViewArabic
                horizontalAlignment: HorizontalAlignment.Center
                dataModel: _mWebServiceinstance.mymodelTutorial
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Faq2 {
                            id: mExpandableMainServicesArabic
                            horizontalAlignment: HorizontalAlignment.Fill
                            expandImage: "asset:///images/tutorial/open.png"
                            collapseImage: "asset:///images/tutorial/close.png"
                            mLableAnswerValue: ListItemData.ans
                            mLableQuationValue: ListItemData.question
                        }

                    }
                ]

            }

        }
    }
    // QUICK TUROTAIL CONTAINER
    Container {
        id: mContainetQuickTutorial
        visible: true
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        preferredHeight: 990
        layout: DockLayout {
        }
        onCreationCompleted: {
            //            mImageViewImage.urlChanged.connect(imageLoadedCompleted)

        }
        ListView {
            id: mlistview
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            dataModel: mGroupDataModelImages
            layout: StackListLayout {
                headerMode: ListHeaderMode.Overlay
                orientation: LayoutOrientation.LeftToRight
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        preferredHeight: 1050
                        preferredWidth: 768
                        leftPadding: ui.du(1.0)
                        rightPadding: ui.du(1.0)
                        topPadding: -50
                        layout: DockLayout {
                        }
                        WebImageView {
                            id: mWebViewImage
                            scalingMethod: ScalingMethod.Fill
                            preferredHeight: ui.du(110)
                            preferredWidth: ui.du(70)
                            url: ListItemData.my_images
                            onSetImageUrl: {
                                activityIndicator.start()
                            }
                            onUrlChanged: {
                                activityIndicator.stop()
                            }
                        }
                        //                        WebView {
                        //                            url: ListItemData.my_images
                        //                            preferredHeight:  1050
                        //                            preferredWidth: 768
                        //                            settings.viewport: {
                        //                                "initial-scale": 0.0
                        //                            }
                        //                            onNavigationRequested: {
                        //                                activityIndicator.start()
                        //                            }
                        //                            onLoadingChanged: {
                        //                                if (loadRequest.status == WebLoadStatus.Started) {
                        //                                    //                                    console.debug("onLoadingChanged loadRequest :", mWebImageViewIndoor.url)
                        //                                    activityIndicator.start()
                        //
                        //                                } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                        //                                    activityIndicator.stop()
                        //
                        //                                } else if (loadRequest.status == WebLoadStatus.Failed) {
                        //                                    activityIndicator.stop()
                        //                                    //                                    console.debug("onLoadingChanged failed :", mWebImageViewIndoor.url)
                        //                                }
                        //                            }
                        //                        }
                        //                        Container {
                        //                            preferredHeight: 1200
                        //                            background: Color.Black
                        //                            preferredWidth: 1.5
                        //                            horizontalAlignment: HorizontalAlignment.Right
                        //                            leftMargin: ui.du(1.0)
                        //                            rightMargin: ui.du(1.0)
                        //                        }
                        ActivityIndicator {
                            id: activityIndicator
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            preferredHeight: 150
                            preferredWidth: 150
                        }

                    }
                }

            ]

            attachedObjects: [
                ListScrollStateHandler {
                    id: scrollStateHandler
                    onScrollingChanged: {
                        mlistview.scrollToItem(mListGalleryHandler, ScrollAnimation.Smooth);
                    }
                    onFirstVisibleItemChanged: {
                        mListGalleryHandler = firstVisibleItem
                    }
                }
            ]
        }

    }
    // VIDEO TUTORAIL
    Container {
        visible: false
        id: mContainerVideo
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        //        verticalAlignment: VerticalAlignment.Fill
        preferredHeight: 990

        Label {
            //  text: qsTr("video")
        }
    }
    // CHECK BOX CONTAINER TO SHOW OR HIDE TUTORIAL 
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Bottom
        preferredHeight: 100
        preferredWidth: 768
        background: Color.Gray
        layout: DockLayout {
        }
        Container {
            id: mContainerCheckBox
            leftPadding: 30.0
            rightPadding: 30.0
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Left
            layout: StackLayout {
                id: mStackLayout
                orientation: LayoutOrientation.LeftToRight
            }
            CheckBox {
                id: mCheckBox
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
                onCheckedChanged: {
                    if (checked) {

                        _mAppParentObj.saveValueFor("mcheckboxSkipTu", "true")
                    } else {
                        _mAppParentObj.saveValueFor("mcheckboxSkipTu", "false")

                    }

                }
            }
            Label {
                text: mAllString.mDontshowatstartup
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
            }

        }
    }

    attachedObjects: [
        AllStrings {
            id: mAllString
        },
        ImagePaintDefinition {
            id: mContainerEngImageOne
            imageSource: "asset:///images/tutorial/screen_01.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageTwo
            imageSource: "asset:///images/tutorial/screen_02.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageThree
            imageSource: "asset:///images/tutorial/screen_03.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageFour
            imageSource: "asset:///images/tutorial/screen_04.png"
        },
        ComponentDefinition {
            id: mComponentDefinitionHome
            source: "Main.qml"
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllString.mDialogOk
        },
        GroupDataModel {
            id: mGroupDataModelImages
            grouping: ItemGrouping.None
        }
    ]
    ActivityIndicator {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        id: mActivityIndicator
        preferredWidth: 250
        preferredHeight: 250
    }
}

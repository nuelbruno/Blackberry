import bb.cascades 1.3
import "common"
import bb.system 1.2
import WebImageView 1.0
Page {
    id: mpage
    property string mCheck
    property variant mQuestion
    property variant mListGalleryHandler
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {

        }

        Container {
            property string mCheck
            property NavigationPane mNavigationPaneTutorial
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            onCreationCompleted: {
                _mWebServiceinstance.tutorialDone.connect(dataConnected)

                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.callTUTORIAL()
                } else {
                    mSystemDialog.body = mAllString.mNetworkCheck
                    mSystemDialog.show()
                }
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
            function dataConnected() {
                var mImages = new Array()
                mImages = _mWebServiceinstance.getImages()
                mGroupDataModelImages.clear()
                for (var i = 0; i < mImages.length; i ++) {
                    mGroupDataModelImages.insert({
                            "my_images": mImages[i].my_images
                        });
                }

            }
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
            CommonTopBar {
                id: mCommonBar
                // mText: mAllString.mTutorial
                mText: mAllString.mTitleHelp
                Container {
                    id: mContainerHome
                    leftPadding: ui.du(2)
                    rightPadding: ui.du(2)
                    visible: false
                    layout: DockLayout {

                    }
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center

                    ImageButton {
                        horizontalAlignment: HorizontalAlignment.Fill
                        defaultImageSource: "asset:///images/tutorial/Home_icon.png"
                        disabledImageSource: "asset:///images/tutorial/Home_icon.png"
                        pressedImageSource: "asset:///images/tutorial/Home_icon.png"
                        onClicked: {
                            mDialog.close()
                        }
                    }
                }
            }

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
                        text: mAllString.mFAQ
                        textStyle.fontSize: FontSize.XSmall
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
                        topMargin: ui.du(5)
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
                        topMargin: ui.du(5)
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: mAllString.mQuickUserGuideTutorial
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
//                            mWebView.url = "http://demoserver.tacme.net:4040/makani/public/uploads/6055_Makani%20User%20Guide.pdf"
                            mWebView.url = _mWebServiceinstance.setQuickGuideUrl()
                            console.debug("QUICK guide")
                        }
                    }
                }
            }
            Container {
                id: mContainerquickguide
                visible: true
                background: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                //  preferredHeight: 1000
                verticalAlignment: VerticalAlignment.Fill
                layout: DockLayout {
                }
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
            Container {
                id: mContainerFAQ
                background: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                visible: false
                preferredHeight: 950
                bottomPadding: ui.du(7.0)
                verticalAlignment: VerticalAlignment.Fill
                layout: DockLayout {

                }
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
            Container {
                id: mContainetQuickTutorial
                visible: true
                background: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                 preferredHeight: 950
                verticalAlignment: VerticalAlignment.Fill
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
                                preferredHeight: 1040
                                preferredWidth: 768
                                leftPadding: ui.du(1.0)
                                rightPadding: ui.du(1.0)
                                topPadding: -100
                                layout: DockLayout {
                                }
//                                WebView {
//                                    preferredWidth: 768
//                                    preferredHeight: 1040
//                                    url: ListItemData.my_images
//                                    settings.viewport: {
//                                        "initial-scale": 0.0
//                                    }	
//                                    onNavigationRequested: {
//                                        activityIndicator.start()
//                                    }
//
//                                    onLoadingChanged: {
//
//                                        if (loadRequest.status == WebLoadStatus.Started) {
//                                            activityIndicator.start()
//
//                                        } else if (loadRequest.status == WebLoadStatus.Succeeded) {
//                                            activityIndicator.stop()
//
//                                        } else if (loadRequest.status == WebLoadStatus.Failed) {
//                                            activityIndicator.stop()
//                                        }
//                                    }
//                                }
                                WebImageView {
                                    id: mWebViewImage
                                    scalingMethod: ScalingMethod.Fill
                                    preferredHeight: ui.du(100)
                                    preferredWidth: ui.du(70)
                                    url: ListItemData.my_images
                                    onSetImageUrl: {
                                        activityIndicator.start()
                                    }
                                    onUrlChanged: {
                                        activityIndicator.stop()
                                    }
                                }
//                                Container {
//                                    preferredHeight: 1200
//                                    background: Color.Black
//                                    preferredWidth: 1.5
//                                    horizontalAlignment: HorizontalAlignment.Right
//                                    leftMargin: ui.du(1.0)
//                                    rightMargin: ui.du(1.0)
//                                }
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

            Container {
                visible: false
                id: mContainerVideo
                background: Color.White
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                layout: DockLayout {

                }

                Label {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    //  text: qsTr("video")
                }
            }
            Container {
                leftPadding: 100
                rightPadding: 100
                visible: false
                background: Color.Gray
                verticalAlignment: VerticalAlignment.Bottom
                preferredHeight: 100
                preferredWidth: 768
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    // id: mCheckBox
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
        //        Container {
        //            leftPadding: 100
        //            rightPadding: 100
        //            background: Color.Gray
        //            verticalAlignment: VerticalAlignment.Bottom
        //            preferredHeight: 100
        //            preferredWidth: 768
        //            layout: StackLayout {
        //                orientation: LayoutOrientation.LeftToRight
        //            }
        //            CheckBox {
        //                id: mCheckBox
        //                horizontalAlignment: HorizontalAlignment.Left
        //                verticalAlignment: VerticalAlignment.Center
        //                onCheckedChanged: {
        //                    if (checked) {
        //
        //                        _mAppParentObj.saveValueFor("mcheckboxSkipTu", "true")
        //                    } else {
        //                        _mAppParentObj.saveValueFor("mcheckboxSkipTu", "false")
        //
        //                    }
        //
        //                }
        //            }
        //            Label {
        //                text: mAllString.mDontshowatstartup
        //                horizontalAlignment: HorizontalAlignment.Right
        //                verticalAlignment: VerticalAlignment.Center
        //            }
        //
        //        }

    }
}

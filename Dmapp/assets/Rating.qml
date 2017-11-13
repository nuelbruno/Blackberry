// ***********************************************************************************************************
//  RATING PAGE CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import bb.system 1.2
import "common"
Page {
    property string mRatingIdCount: "0"
    property NavigationPane mNavigationPaneRatings
    onCreationCompleted: {
       
        
        mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
        mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
        mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
        mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
        _mWebServiceinstance.insertRatingsDone.connect(showMessage)
        setAlignMent()
    }
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mlabelRateText.horizontalAlignment = HorizontalAlignment.Left
            mContainerRatings.layout.orientation = LayoutOrientation.LeftToRight
            mlabelRateStatus.horizontalAlignment = HorizontalAlignment.Left
            mlabelRateStatus.textStyle.textAlign = TextAlign.Left
            mContaineRateandCancel.layout.orientation = LayoutOrientation.LeftToRight
            mContainerRatingsMain.horizontalAlignment = HorizontalAlignment.Left
        } else {
            mlabelRateText.horizontalAlignment = HorizontalAlignment.Right
            mContainerRatings.layout.objectName = LayoutOrientation.RightToLeft
            mlabelRateStatus.horizontalAlignment = HorizontalAlignment.Right
            mlabelRateStatus.textStyle.textAlign = TextAlign.Right
            mContaineRateandCancel.layout.orientation = LayoutOrientation.RightToLeft
            mContainerRatingsMain.horizontalAlignment = HorizontalAlignment.Right
            mContainerRatings.layout.orientation = LayoutOrientation.RightToLeft
        }
    }

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        CommonTopBar {
            mText: mAllStrings.mTitleRateApp
        }
        ScrollView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: ui.du(3)
                leftPadding: ui.du(2)
                rightPadding: ui.du(2)
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Label {
                    id: mlabelRateText
                    text: mAllStrings.mTitleRateApp
                    horizontalAlignment: HorizontalAlignment.Left
                    bottomMargin: ui.du(2)
                }
                Container {
                    id: mContainerRatingsMain
                    horizontalAlignment: HorizontalAlignment.Left
                    layout: DockLayout {

                    }
                    // STAR RATING ADD CODE
                    Container {
                        id: mContainerRatings
                        topPadding: ui.du(3)
                        bottomPadding: ui.du(2)
                        rightPadding: ui.du(1)
                        horizontalAlignment: HorizontalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            ImageView {
                                id: mImageViewPoor
                                horizontalAlignment: HorizontalAlignment.Center
                                imageSource: "asset:///images/more/star_unselected.png"
                                onTouch: {
                                    if (event.isUp()) {

                                        if (mImageViewPoor.imageSource == "asset:///images/more/star_unselected.png") {
                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                            mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                            mlabelRateStatus.text = mAllStrings.mRatingsPoor
                                            mRatingIdCount = "1"
                                        } else if (mImageViewAverage.imageSource == "asset:///images/more/star_selected.png") {
                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                            mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                            mlabelRateStatus.text = mAllStrings.mRatingsPoor
                                            mRatingIdCount = "1"
                                        } else {
                                            mImageViewPoor.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                            mlabelRateStatus.text = mAllStrings.mTitleRateIt
                                            mRatingIdCount = "0"
                                        }
                                        //                                        if (mImageViewPoor.imageSource == "asset:///images/more/star_selected.png") {
                                        //                                            mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mlabelRateStatus.text = mAllStrings.mRatingsPoor
                                        //                                            mRatingIdCount = "1"
                                        //                                        }
                                    }
                                }
                            }
                            Label {
                                id: mLabelPoor
                                visible: true
                                horizontalAlignment: HorizontalAlignment.Center
                                text: mAllStrings.mRatingsPoor
                                textStyle.fontSize: FontSize.XXSmall
                                textStyle.color: Color.create("#009acd")
                            }
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            ImageView {
                                id: mImageViewAverage
                                horizontalAlignment: HorizontalAlignment.Center
                                imageSource: "asset:///images/more/star_selected.png"
                                onTouch: {
                                    if (event.isUp()) {

                                        //if (mImageViewAverage.imageSource == "asset:///images/more/star_unselected.png") {
                                        mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                        mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        mlabelRateStatus.text = mAllStrings.mRatingsAverage
                                        mRatingIdCount = "2"
                                        //  } else {
                                        //                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewAverage.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mlabelRateStatus.text = mAllStrings.mRatingsPoor
                                        //                                            mRatingIdCount = "1"
                                        //                                        }

                                    }
                                }
                            }
                            Label {
                                visible: false
                                horizontalAlignment: HorizontalAlignment.Center
                                text: mAllStrings.mRatingsAverage
                            }
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            ImageView {
                                id: mImageViewGood
                                horizontalAlignment: HorizontalAlignment.Center
                                imageSource: "asset:///images/more/star_selected.png"
                                onTouch: {
                                    if (event.isUp()) {

                                        //  if (mImageViewGood.imageSource == "asset:///images/more/star_unselected.png") {
                                        mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewGood.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        mlabelRateStatus.text = mAllStrings.mRatingsGood
                                        mRatingIdCount = "3"
                                        //                                        } else {
                                        //                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mlabelRateStatus.text = mAllStrings.mRatingsAverage
                                        //                                            mRatingIdCount = "2"
                                        //                                        }

                                    }

                                }
                            }
                            Label {
                                visible: false
                                horizontalAlignment: HorizontalAlignment.Center
                                text: mAllStrings.mRatingsGood
                            }
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            ImageView {
                                id: mImageViewVeryGood
                                horizontalAlignment: HorizontalAlignment.Center
                                imageSource: "asset:///images/more/star_selected.png"
                                onTouch: {
                                    if (event.isUp()) {
                                        //       if (mImageViewVeryGood.imageSource == "asset:///images/more/star_unselected.png") {
                                        mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewGood.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewVeryGood.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        mlabelRateStatus.text = mAllStrings.mRatingsVeryGood
                                        mRatingIdCount = "4"
                                        //                                        } else {
                                        //                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewGood.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mlabelRateStatus.text = mAllStrings.mRatingsGood
                                        //                                            mRatingIdCount = "3"
                                        //                                        }

                                    }

                                }
                            }
                            Label {
                                visible: false
                                horizontalAlignment: HorizontalAlignment.Center
                                text: mAllStrings.mRatingsVeryGood
                            }
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            ImageView {
                                id: mImageViewExcellent
                                horizontalAlignment: HorizontalAlignment.Center
                                imageSource: "asset:///images/more/star_selected.png"
                                onTouch: {
                                    if (event.isUp()) {

                                        //      if (mImageViewExcellent.imageSource == "asset:///images/more/star_unselected.png") {
                                        mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewGood.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewVeryGood.imageSource = "asset:///images/more/star_selected.png"
                                        mImageViewExcellent.imageSource = "asset:///images/more/star_selected.png"
                                        mlabelRateStatus.text = mAllStrings.mRatingsExcellent
                                        mRatingIdCount = "5"
                                        //                                        } else {
                                        //                                            mImageViewPoor.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewAverage.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewGood.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewVeryGood.imageSource = "asset:///images/more/star_selected.png"
                                        //                                            mImageViewExcellent.imageSource = "asset:///images/more/star_unselected.png"
                                        //                                            mlabelRateStatus.text = mAllStrings.mRatingsVeryGood
                                        //                                            mRatingIdCount = "4"
                                        //                                        }

                                    }
                                }
                            }
                            Label {
                                id: mlabelExcdellent
                                visible: true
                                horizontalAlignment: HorizontalAlignment.Center
                                text: mAllStrings.mRatingsExcellent
                                textStyle.fontSize: FontSize.XXSmall
                                textStyle.color: Color.create("#009acd")
                            }

                        }
                    }
                }
                Divider {
                    topMargin: ui.du(2)

                }
                Label {
                    id: mlabelRateStatus
                    textStyle.textAlign: TextAlign.Left
                    textStyle.fontSize: FontSize.Large
                    text: mAllStrings.mTitleRateIt
                    textStyle.color: Color.create("#009acd")
                }

                Divider {
                    topMargin: ui.du(3)

                }
                // RATING SUBMIT BUTTON
                Container {
                    id: mContaineRateandCancel
                    leftPadding: ui.du(3)
                    rightPadding: ui.du(3)
                    topPadding: ui.du(5)
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Center
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        id: mRateitButton
                        horizontalAlignment: HorizontalAlignment.Left
                        preferredWidth: 300
                        preferredHeight: 80
                        rightMargin: ui.du(2)
                        leftMargin: ui.du(2)
                        background: Color.create("#00b5e9")
                        layout: DockLayout {

                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.5
                        }
                        Label {
                            textStyle.color: Color.White
                            // textStyle.fontWeight: FontWeight.Bold
                            textStyle.fontStyle: FontStyle.Italic
                            textStyle.fontSize: FontSize.Medium
                            text: mAllStrings.mTitleRateIt
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                        }
                        onTouch: {
                            if (event.isUp()) {
                                _mWebServiceinstance.insertRatingsDone.connect(showMessage)
                                mRateitButton.background = Color.create("#00b5e9")
                                mCancelButton.background = Color.LightGray
                                console.debug("mRatingIdCount" + mRatingIdCount)
                                if (mRatingIdCount == 0) {
                                    mSystemDialog.body = mAllStrings.mRatingvalidationdstarts
                                    mSystemDialog.show()
                                } else {
                                    _mWebServiceinstance.InsertRatings(mRatingIdCount)
                                }
                            }
                        }
                    }
                    // RATNG CANCEL BUTTON
                    Container {
                        id: mCancelButton
                        background: Color.LightGray
                        preferredWidth: 300
                        preferredHeight: 80
                        rightMargin: ui.du(2)
                        leftMargin: ui.du(2)
                        horizontalAlignment: HorizontalAlignment.Left
                        layout: DockLayout {

                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.5
                        }
                        Label {
                            textStyle.fontStyle: FontStyle.Italic
                            textStyle.fontSize: FontSize.Medium
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                            text: mAllStrings.mCancel
                            textStyle.color: Color.White
                        }
                        onTouch: {
                            if (event.isUp()) {
                                mRateitButton.background = Color.LightGray
                                mCancelButton.background = Color.create("#00b5e9")
                                _mWebServiceinstance.insertRatingsDone.disconnect(showMessage)
                                mNavigationPaneRatings.pop()
                            }
                        }
                    }
                }

            }

        }
    }
    function showMessage(arg2) {
        _mWebServiceinstance.insertRatingsDone.disconnect(showMessage)
        if (arg2 == true) {
            mSystemDialogSuccess.body = mAllStrings.mRatingsSuccess
            mSystemDialogSuccess.show()
        } else {
            mSystemDialog.body = mAllStrings.mRatingsFail
            mSystemDialog.show()
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        SystemDialog {
            id: mSystemDialogSuccess
            cancelButton.enabled: false
            cancelButton.label: ""
            confirmButton.label: mAllStrings.mOk
            onFinished: {
                var x = result
                if (x == SystemUiResult.ConfirmButtonSelection) {
                    mNavigationPaneRatings.pop()

                }
            }
        },
        SystemDialog {
            id: mSystemDialog
            cancelButton.enabled: false
            cancelButton.label: ""
            confirmButton.label: mAllStrings.mOk
        }
    ]
}

// ***********************************************************************************************************
//  FEED BACK PAGE
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
import bb.system 1.2
Page {
    property string mFeedBackId
    property NavigationPane mNavigationPaneFeedBack

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {

        }
        //  LOAD DATA ON START
        onCreationCompleted: {
            setAlignMent()
            _mWebServiceinstance.feedbackSubmit.connect(getfeedbackData)
            //   _mWebServiceinstance.activeChanged.connect(dataloadednew())
            //_mWebServiceinstance.mymodelfeedbacktype.clear()
            //_mWebServiceinstance.GetFeedbackType()
            // mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelfeedbacktype
        }
        function dataloadednew() {

            mSystemDialog.body = _mWebServiceinstance.getFeedbackValue()
            mSystemDialog.show()
        }
        // GET DATA FROM WEB SERVICE
        function getfeedbackData(arg2) {

            if (arg2 == "Success") {
                _mWebServiceinstance.feedbackSubmit.disconnect(getfeedbackData)
                mSystemDialogSuccess.body = mAllStrings.mFeebackResponseSuccess
                mSystemDialogSuccess.show()
            } else {
                mSystemDialog.body = mAllStrings.mFeebackResponseFailed
                mSystemDialog.show()
            }
        }
        // FEEDBACK UI CONATINER
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            CommonTopBar {
                id: mCommonBar
                mText: mAllStrings.mTitleFeedBack
            }
            ScrollView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }

                    Container {
                        id: mContainerEmailId
                        leftPadding: ui.du(3)
                        rightPadding: ui.du(3)
                        topPadding: ui.du(5)
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }

                        Label {
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            text: mAllStrings.mFeedBackEmailId
                            multiline: true
                            textStyle {
                                //                                color: Color.Blue
                                color: mAllStrings.lightBlueColor
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.1
                            }
                        }
                        Container {
                            preferredWidth: 520
                            background: mImagePaintDefinitionTextFied.imagePaint
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            layout: DockLayout {

                            }
                            TextField {
                                id: mTextFieldEmail
                                backgroundVisible: false
                                hintText: ""
                                //input.keyLayout: KeyLayout.EmailAddress
                                inputMode: TextFieldInputMode.EmailAddress
                            }
                        }
                    }

                    Container {
                        id: mContainerType
                        leftPadding: ui.du(3)
                        rightPadding: ui.du(3)
                        topPadding: ui.du(3)

                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            text: mAllStrings.mFeedBackType
                            textStyle {
                                color: mAllStrings.lightBlueColor
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.2
                            }
                        }
                        Container {
                            preferredWidth: 520
                            background: mImagePaintDefinitionTextFied.imagePaint
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            layout: DockLayout {

                            }

                            TextField {
                                id: mTextFieldType
                                objectName: "mTextFieldType"
                                backgroundVisible: false
                                hintText: mAllStrings.mFedbacktypeHint

                                enabled: false
                                focusAutoShow: FocusAutoShow.None
                            }
                            Container {
                                id: mContainerArrow
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Center
                                leftPadding: ui.du(2)
                                rightPadding: ui.du(2)
                                layout: DockLayout {

                                }

                                ImageButton {
                                    defaultImageSource: "asset:///images/more/button_arrw.png"
                                    pressedImageSource: "asset:///images/more/button_arrw.png"
                                    disabledImageSource: "asset:///images/more/button_arrw.png"

                                }
                            }
                            onTouch: {

                                if (_mAppParentObj.isNetworkAvailable()) {

                                    if (event.isUp()) {
                                        //  if(mTextFieldEmail.text.length){
                                        _mWebServiceinstance.mymodelfeedbacktype.clear()
                                        _mWebServiceinstance.GetFeedbackType()
                                        mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelfeedbacktype
                                        mDialogCommonListContent.mlabelDialog = mAllStrings.mFeedBackType
                                        mDialogCommonList.open()
                                        // }
                                    }

                                } else {
                                    mSystemDialog.body = mAllStrings.mNetworkCheck
                                    mSystemDialog.show()

                                }
                            }

                        }

                    }

                    Container {
                        id: mContainerFeedBack
                        leftPadding: ui.du(3)
                        rightPadding: ui.du(3)
                        topPadding: ui.du(3)
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Top
                            layout: DockLayout {

                            }
                            topPadding: ui.du(2)
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.2
                            }
                            Label {
                                horizontalAlignment: HorizontalAlignment.Fill
                                text: mAllStrings.mTitleFeedBack

                                textStyle {
                                    color: mAllStrings.lightBlueColor
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.2
                                }
                            }
                        }
                        Container {
                            preferredWidth: 520
                            background: mImagePaintDefinitionTextFied.imagePaint
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            layout: DockLayout {

                            }

                            TextArea {
                                id: mTextAreaFeddback
                                inputMode: inputMode.Text
                                preferredHeight: 250
                                input.keyLayout: KeyLayout.Alphanumeric
                                hintText: ""
                                backgroundVisible: false
                            }
                        }
                    }
                    // FEED BACK SUBMIT  BUTTON
                    Container {
                        id: mContainerSubmit
                        leftPadding: ui.du(3)
                        rightPadding: ui.du(3)
                        topPadding: ui.du(5)
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            id: mSubmitButton
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
                                text: mAllStrings.mdirectionsubmit
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Center
                            }
                            onTouch: {
                                if (event.isUp()) {
                                    mSubmitButton.background = Color.create("#00b5e9")
                                    mCancelButton.background = Color.LightGray
                                    if (mTextFieldEmail.text.length == 0) {
                                        mSystemDialog.body = mAllStrings.mFeedBackinvalidEmail
                                        mSystemDialog.show()
                                    } else if (! validateForm(mTextFieldEmail.text.trim())) {
                                        mSystemDialog.body = mAllStrings.mFeedBackinvalidEmail
                                        mSystemDialog.show()
                                    } else if (mTextFieldType.text.trim().length == 0) {
                                        mSystemDialog.body = mAllStrings.mFeedBackSelectType
                                        mSystemDialog.show()
                                    } else if (mTextAreaFeddback.text.trim().length == 0) {
                                        mSystemDialog.body = mAllStrings.mFeedBackenterFeddback
                                        mSystemDialog.show()
                                    } else if (validateForm(mTextFieldEmail.text.trim()) && mTextFieldType.text.trim().length != 0 && mTextAreaFeddback.text.trim().length != 0) {
                                        _mWebServiceinstance.GetMakaniFeedback(mFeedBackId, mTextFieldType.text, mTextAreaFeddback.text)
                                    }
                                }
                            }
                        }
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
                                    mSubmitButton.background = Color.LightGray
                                    mCancelButton.background = Color.create("#00b5e9")
                                    mNavigationPaneFeedBack.pop()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerEmailId.layout.orientation = LayoutOrientation.LeftToRight
            mContainerType.layout.orientation = LayoutOrientation.LeftToRight
            mContainerFeedBack.layout.orientation = LayoutOrientation.LeftToRight
            mContainerSubmit.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldType.textStyle.textAlign = TextAlign.Left
            mTextFieldType.horizontalAlignment = HorizontalAlignment.Left
            mTextFieldType.leftPadding = ui.du(2)
            mContainerArrow.horizontalAlignment = HorizontalAlignment.Right
            mTextFieldEmail.textStyle.textAlign = TextAlign.Left
            mTextAreaFeddback.textStyle.textAlign = TextAlign.Left
        } else {
            mContainerEmailId.layout.orientation = LayoutOrientation.RightToLeft
            mContainerType.layout.orientation = LayoutOrientation.RightToLeft
            mContainerFeedBack.layout.orientation = LayoutOrientation.RightToLeft
            mContainerSubmit.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldType.textStyle.textAlign = TextAlign.Right
            mTextFieldType.horizontalAlignment = HorizontalAlignment.Right
            mTextFieldType.rightPadding = ui.du(2)
            mContainerArrow.horizontalAlignment = HorizontalAlignment.Left
            mTextFieldEmail.textStyle.textAlign = TextAlign.Right
            mTextAreaFeddback.textStyle.textAlign = TextAlign.Right
        }
    }
    function validateForm(email) {
        var atpos = email.indexOf("@");
        var dotpos = email.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
            //Not a valid e-mail address
            return false;
        } else {
            return true;
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTextFied
            imageSource: "asset:///images/search_option/bg_contain_white.png"
        },
        SystemDialog {
            id: mSystemDialogSuccess
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
            onFinished: {
                var x = result
                if (x == SystemUiResult.ConfirmButtonSelection) {
                    mNavigationPaneFeedBack.pop()
                }
            }
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
        },
        Dialog {
            id: mDialogCommonList
            onOpenedChanged: {
                mDialogCommonListContent.setAlignMent()
            }
            DialogCommonList {
                id: mDialogCommonListContent
                onDoneClick: {
                    mTextFieldType.text = _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? selectedData.FEEDBACK_EN : selectedData.FEEDBACK_AR
                    mFeedBackId = selectedData.FEEDBACK_ID
                }
                Container {
                    ActivityIndicator {
                        id: mc
                        enabled: _mWebServiceinstance.active
                        preferredHeight: 500
                        preferredWidth: 500
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
        }
    ]
}

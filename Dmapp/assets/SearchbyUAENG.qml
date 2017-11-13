// ***********************************************************************************************************
//  SEARCH BY UAE EN PAGE
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    id: mContainermakani
    signal searchclick()
    property string myUAENGValue
    visible: false
    property alias mTextFieldSearch: mTextFieldSearch
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom

    }
    leftPadding: 10
    rightPadding: 10
    onCreationCompleted: {
    }
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainer.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldSearch.textStyle.textAlign = TextAlign.Left
        } else {
            mContainer.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldSearch.textStyle.textAlign = TextAlign.Right
        }
    }
    Container {
        id: mContainer
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        TextField {
            id: mTextFieldSearch
            hintText: "40R CN 30002 95324"
            preferredWidth: mAllStrings.searchTextFiledWidth
            onTextChanging: {

            }
        }
        // SEARCH SUBMIT BUTTON
        CommonButtonWithLabel {
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllStrings.mSearch
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            onMyClick: {
                if (_mAppParentObj.isNetworkAvailable()) {
                    if (mTextFieldSearch.text.length > 0) {
                        myUAENGValue = _mWebServiceinstance.ConvertToUAENG(mTextFieldSearch.text)
                        if (myUAENGValue == "") {
                            mSystemDialog.body = mAllStrings.mValidationValidUAENGValue
                            mSystemDialog.show()
                        } else {
                            _mWebServiceinstance.ClearMapdata();
                            mTextFieldSearch.text = myUAENGValue
                            _mWebServiceinstance.UAENGtoCoordinates(myUAENGValue, "", "Search")
                            searchclick()
                            _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                        }

                    } else {
                        mSystemDialog.body = mAllStrings.mValidationUAENGNumber
                        mSystemDialog.show()
                    }
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }

            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        SystemToast {
            id: myQmlToast
            body: mAllStrings.mqmlToast
            onFinished: {
            }
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
        }
    ]
}
// ***********************************************************************************************************
// SEARCH BY LAND MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    id: mContainerparcle
    signal searchClick()
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    property alias mTextFieldSearchParcel:mTextFieldSearchParcel
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    leftPadding: 10
    rightPadding: 10
    onCreationCompleted: {
        setAlignMent()
    }
    // LANGAUGE CHANGE ALIGNMENT CONATINER
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainer.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldSearchParcel.textStyle.textAlign = TextAlign.Left
        } else {
            mContainer.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldSearchParcel.textStyle.textAlign = TextAlign.Right
        }
    }
    Container {
        id: mContainer
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        TextField {
            id: mTextFieldSearchParcel
            hintText: "1190353"
            inputMode: TextFieldInputMode.PhoneNumber
            preferredWidth: mAllStrings.searchTextFiledWidth
         //  inputMode:TextFieldInputMode.PhoneNumber
            onTextChanging: {
            }
        }
        // SUBMIT BUTTON TO SEARCH THE LAND
        CommonButtonWithLabel {
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllStrings.mSearch
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            onMyClick: {
                _mWebServiceinstance.ClearMapdata()
                if (_mAppParentObj.isNetworkAvailable()) {
                    if (mTextFieldSearchParcel.text.length == 0) {
                        mSystemDialog.body = mAllStrings.mValidationprovideParcelIdInputValue
                        mSystemDialog.show()
                    } else if (_mWebServiceinstance.checkLandNumberValidatoin(mTextFieldSearchParcel.text.trim())) {
                        // _mWebServiceinstance.GetParcelOutline(mTextFieldSearchParcel.text, "", "")
                        _mWebServiceinstance.GetParcelOutline_New(mTextFieldSearchParcel.text)
                        searchClick()
                    } else {
                        mSystemDialog.body = mAllStrings.mValidationParcelIdInputValue
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
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
        }
    ]
}
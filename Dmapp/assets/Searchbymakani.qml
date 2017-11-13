// ***********************************************************************************************************
//  SEARCH BY MAKANI
//  CONTAINS THE UI FOR MAKANI SEARCH
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    id: mContainermakani
    signal searchclick()
    visible: false
    property alias mTextFieldSearch: mTextFieldSearch
    property string makaniNumber
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom

    }
    leftPadding: 10
    rightPadding: 10
    onCreationCompleted: {
        setAlignMent()

    }
    // LANGAUGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainer.layout.orientation = LayoutOrientation.LeftToRight
            mContainerlist.layout.orientation = LayoutOrientation.LeftToRight
            mListViewArabic.visible = false
            mTextFieldSearch.textStyle.textAlign = TextAlign.Left
        } else {
            mContainer.layout.orientation = LayoutOrientation.RightToLeft
            mContainerlist.layout.orientation = LayoutOrientation.RightToLeft
            mListView.visible = false
            mTextFieldSearch.textStyle.textAlign = TextAlign.Right
        }
    }
    // MAIN UI CONTAINER
    Container {
        id: mContainer
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        TextField {
            id: mTextFieldSearch
            preferredWidth: mAllStrings.searchTextFiledWidth
            hintText: "29971 95280"
            inputMode: TextFieldInputMode.PhoneNumber
            onTextChanging: {
                if (_mAppParentObj.isNetworkAvailable()) {
                    if (mTextFieldSearch.text.length == 3) {
                        if (_mAppParentObj.isNetworkAvailable()) {
                             _mWebServiceinstance.setmactive(false )
                            mTextFieldSearch.enabled = false
                            _mWebServiceinstance.GetMakaniNo(mTextFieldSearch.text)
                            mTextFieldSearch.enabled = true
                            mTextFieldSearch.requestFocus();
                        }
                    }
                    if (mTextFieldSearch.text.length > 3) {
                        _mWebServiceinstance.searchDataFilter(mTextFieldSearch.text, "MakaniNo");

                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                            _mWebServiceinstance.mymodel.size() == 0 ? mListView.visible = false : mListView.visible = true

                        } else {
                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewArabic.visible = false : mListViewArabic.visible = true
                        }
                    }
                    if (mTextFieldSearch.text.length == 0) {
                        _mWebServiceinstance.mymodel.clear()
                        mListView.visible = false
                        mListViewArabic.visible = false
                    }
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }
            }

        }
        // ON SEARCH SUBMIT BUTTON
        CommonButtonWithLabel {
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllStrings.mSearch
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            onMyClick: {
                if (_mAppParentObj.isNetworkAvailable()) {
                    if (mTextFieldSearch.text.length > 0) {
                        var myResult = _mWebServiceinstance.checkInvalid(mTextFieldSearch.text.replace(" ", ""))
                        if (myResult == "number") {
                            _mWebServiceinstance.ClearMapdata();
                            _mWebServiceinstance.GetBuildingInfo(mTextFieldSearch.text)
                            searchclick()
                            _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                        } else {
                            mSystemDialog.body = mAllStrings.mValidationValidaMakaniValue
                            mSystemDialog.show()
                        }
                    } else {
                        mSystemDialog.body = mAllStrings.mValidationInputValue
                        mSystemDialog.show()
                    }
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }
            }
        }
    }
    //Added container for rabic and english maintanance
    // AUTO SUGGESTION SEARCH DROP DOWN VIEW
    Container {
        id: mContainerlist
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        ListView {
            id: mListView
            verticalAlignment: VerticalAlignment.Fill
            dataModel: _mWebServiceinstance.mymodel
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledWidth
            visible: false

            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        id: mContainerInsideList
                        background: Color.White
                        horizontalAlignment: HorizontalAlignment.Left
                        verticalAlignment: VerticalAlignment.Center
                        preferredWidth: 500
                        preferredHeight: 70
                        layout: DockLayout {
                        }
                        Label {
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.Makani
                            //leftPadding: 20
                            leftMargin: 20
                            textStyle.textAlign: TextAlign.Left
                        }
                        Divider {
                        }
                    }
                }
            ]
            onTriggered: {
                var mdata = dataModel.data(indexPath);
                mTextFieldSearch.text = mdata.Makani
                mListView.visible = false

            }

        }
        ListView {
            id: mListViewArabic
            verticalAlignment: VerticalAlignment.Fill
            dataModel: _mWebServiceinstance.mymodel
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledWidth
            visible: false

            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        id: mContainerInsideListArabic
                        background: Color.White
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Center
                        preferredWidth: 500
                        preferredHeight: 70
                        rightPadding: 20
                        layout: DockLayout {
                        }
                        Label {
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.Makani
                            textStyle.textAlign: TextAlign.Right
                        }
                        Divider {
                        }

                    }

                }

            ]
            onTriggered: {
                var mdata = dataModel.data(indexPath);
                mTextFieldSearch.text = mdata.Makani
                mListViewArabic.visible = false
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
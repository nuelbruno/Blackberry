// ***********************************************************************************************************
//  SEARCH BY PLACE NAME MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
import bb.system 1.0
Container {
    id: mContainerPoi
    property string isClickedFromList
    visible: false
    signal searchonmapclick()
    property alias mTextFieldSearch: mTextFieldSearch
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    property string selectedLatitude
    property string selectedLongitude
    property variant mdata
    onCreationCompleted: {
    }
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom

    }
    leftPadding: 10
    rightPadding: 10
    // LANGAUGE CHANGE ALIGNMENT SETUP 
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainer.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldSearch.textStyle.textAlign = TextAlign.Left
            mListViewArabic.visible = false
        } else {
            mContainer.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldSearch.textStyle.textAlign = TextAlign.Right
            mListView.visible = false
        }
    }
    Container {
        id: mContainer
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        // TEXT FIELD TO ENTER AND AUTO SEARCH UAE NG
        TextField {
            id: mTextFieldSearch
            preferredWidth: mAllString.searchTextFiledWidth
            hintText:mAllString.mpoihintText
            onTextChanging: {
                _mWebServiceinstance.SetPOISearch(false)
                if (mTextFieldSearch.text.length == 3) {
                    if (_mAppParentObj.isNetworkAvailable()) {
                        _mWebServiceinstance.GetPOIInfo(mTextFieldSearch.text, "E", true, "autoComplete")
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                            mListView.visible = true;
                        } else {
                            mListViewArabic.visible = true
                        }
                    }
                }
                if (mTextFieldSearch.text.length > 3) {
                    _mWebServiceinstance.searchDataFilterPOI(mTextFieldSearch.text, "POI");
                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                        _mWebServiceinstance.mymodel.size() == 0 ? mListView.visible = false : mListView.visible = true

                    } else {
                        _mWebServiceinstance.mymodel.size() == 0 ? mListView.visible = false : mListViewArabic.visible = true

                    }

                }
                if (mTextFieldSearch.text.length == 0) {
                    _mWebServiceinstance.mymodel.clear()
                    mListView.visible = false;
                    mListViewArabic.visible = false
                }
            }

        }
        // SEARCH SUBMIT BUTTON
        CommonButtonWithLabel {
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllString.mSearch
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            onMyClick: {
                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.poidataloaded.connect(getPOIResponseData)
                    if (mTextFieldSearch.text.length > 0) {
                        _mWebServiceinstance.ClearMapdata();
                        //_mWebServiceinstance.clearmyInfoPopupData();
                        if (isClickedFromList == mTextFieldSearch.text) {
                            _mWebServiceinstance.SetPOISearch(false)
                            _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(selectedLatitude, selectedLongitude, true, false)
                            _mWebServiceinstance.setpicturefromqml(mdata.PICTURE);
                            _mWebServiceinstance.setPoiInfoData(mdata.NAME_E, mdata.TEL_NO, mdata.FAX_NO, mdata.EMAIL, mdata.LICENSE_NO, mdata.URL, mdata.POBOX)
                            searchonmapclick()
                        } else {
                            _mWebServiceinstance.SetPOISearch(true)
                            _mWebServiceinstance.GetPOIInfo(mTextFieldSearch.text, "E", false, "searchOnMap")
                            searchonmapclick()
                            _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                        }
                    } else {
                        mSystemDialog.body = mAllString.mValidationPlaceName
                        mSystemDialog.show()
                    }
                } else {
                    mSystemDialog.body = mAllString.mNetworkCheck
                    mSystemDialog.show()
                }

            }
            function getPOIResponseData() {
                _mWebServiceinstance.poidataloaded.disconnect(getPOIResponseData)
                if (_mWebServiceinstance.hasGotResponse()) {
                    searchonmapclick()
                }
            }
        }

    }
    // AUTO SEARCH DROP DOWN OPTION
    ListView {
        id: mListView
        verticalAlignment: VerticalAlignment.Center
        dataModel: _mWebServiceinstance.mymodel
        preferredHeight: 300
//        preferredWidth: mAllString.searchTextFiledWidth
        preferredWidth: 500
        visible: false
        listItemComponents: [
            ListItemComponent {
                type: "item"
                Container {
                    background: Color.White
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 70
                    id: mContainerInsideList
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        text: ListItemData.NAME_E
                        textStyle.fontSize: FontSize.Small
                        multiline: true
                        
                    }
                    Divider {
                    }
                }
            }
        ]
        onTriggered: {

            mdata = dataModel.data(indexPath);
            selectedLatitude = mdata.X_COORD;
            selectedLongitude = mdata.Y_COORD;
            mTextFieldSearch.text = mdata.NAME_E
            isClickedFromList = mdata.NAME_E
            mListView.visible = false;

        }
    }
    ListView {
        id: mListViewArabic
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        dataModel: _mWebServiceinstance.mymodel
        preferredHeight: 300
//        preferredWidth: mAllString.searchTextFiledWidth
        preferredWidth: 500
        visible: false
        listItemComponents: [
            ListItemComponent {
                type: "item"
                Container {
                    background: Color.White
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Fill
                    preferredHeight: 70
                    id: mContainerInsideListArabic
                    layout: DockLayout {
                    }
                    Label {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                        text: ListItemData.NAME_A
                    }
                    Divider {
                    }
                }
            }
        ]
        onTriggered: {

            mdata = dataModel.data(indexPath);
            selectedLatitude = mdata.X_COORD;
            selectedLongitude = mdata.Y_COORD;
            mTextFieldSearch.text = mdata.NAME_A
            isClickedFromList = mdata.NAME_A
            mListViewArabic.visible = false;

        }
    }

    attachedObjects: [
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllString.mDialogOk
        },
        AllStrings {
            id: mAllString
        }
    ]
}

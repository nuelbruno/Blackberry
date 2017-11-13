// ***********************************************************************************************************
//  SEARCH BY BUILDING ADDRESS MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    id: mcontainerbuidlingmain
    //    visible: false
    property bool clickedonce: false
    property alias mTextFieldCommunity: mTextFieldCommunity
    property alias mTextFieldStreetname: mTextFieldStreetname
    property alias mTextFieldBuilding: mTextFieldBuilding
    property TextField mTextFieldSetData
    signal searchonmapclick()
    property bool isFromSearch
    property bool isCommunitySelected: false
    property bool isStreetSelected: false
    property int selectedType: 1
    property bool isfromDirectionbuilding: false
    property Dialog mdialog
    property string checkFromWhich

    property string currentLang: "E"
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    // LANGAUAGE CHANGE ALIGNMENT CODE
    function setAlignMentBuilding() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerCommunity.layout.orientation = LayoutOrientation.LeftToRight
            mContainerStreet.layout.orientation = LayoutOrientation.LeftToRight
            mContainerBuilding.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldCommunity.textStyle.textAlign = TextAlign.Left
            mTextFieldStreetname.textStyle.textAlign = TextAlign.Left
            mTextFieldBuilding.textStyle.textAlign = TextAlign.Left
            mContainerButton.layout.orientation = LayoutOrientation.LeftToRight

            currentLang = "E"
        } else {
            mContainerCommunity.layout.orientation = LayoutOrientation.RightToLeft
            mContainerStreet.layout.orientation = LayoutOrientation.RightToLeft
            mContainerBuilding.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldCommunity.textStyle.textAlign = TextAlign.Right
            mTextFieldStreetname.textStyle.textAlign = TextAlign.Right
            mTextFieldBuilding.textStyle.textAlign = TextAlign.Right
            mContainerButton.layout.orientation = LayoutOrientation.RightToLeft

            currentLang = "A"

        }
    }
    // RESET DATA ON LNAGAUGE CHANGE
    function resetData() {
        mTextFieldCommunity.text = "";
        mTextFieldStreetname.text = "";
        mTextFieldBuilding.text = "";
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Right
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            id: mContainerCommunity
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            preferredHeight: 90
            background: mImagePaintDefinitionTextBG.imagePaint

            verticalAlignment: VerticalAlignment.Center
            // TEXT FILED TO ENTER SEARCH TEXT
            TextField {
                id: mTextFieldCommunity
                hintText: mAllStrings.mCommunity
                horizontalAlignment: HorizontalAlignment.Fill
                backgroundVisible: false
                clearButtonVisible: false
                onTextChanging: {
                    isCommunitySelected = false;
                    mTextFieldStreetname.text = "";
                    mTextFieldBuilding.text = "";
                    if (mTextFieldCommunity.text.length > 0) {
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                            _mWebServiceinstance.mymodelcommunity.size() == 0 ? mListViewCommunity.visible = false : mListViewCommunity.visible = true
                        } else {
                            _mWebServiceinstance.mymodelcommunity.size() == 0 ? mListViewCommunityArabic.visible = false : mListViewCommunityArabic.visible = true
                        }
                        _mWebServiceinstance.searchDataFilterCommunity(mTextFieldCommunity.text, "Community")

                    } else {
                        mListViewCommunity.visible = false
                        mListViewCommunityArabic.visible = false
                        mTextFieldStreetname.text = ""
                        mTextFieldBuilding.text = ""
                        _mWebServiceinstance.mymodelBuiding.clear()
                        _mWebServiceinstance.mymodelStreet.clear()
                    }
                }
            }
            // COMMUNITIY DROP DOWN OPTION
            Container {
                id: mImageButtonCommunity
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                leftPadding: 10.0
                rightPadding: 10.0
                ImageButton {

                    defaultImageSource: "asset:///images/search_option/arrow.png"
                    pressedImageSource: "asset:///images/search_option/arrow.png"
                    onClicked: {

                        if (_mWebServiceinstance.searchDataFilterCommunity("", "Community")) {
                            selectedType = 1;
                            mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelcommunity;
                            mDialogCommonListContent.mlabelDialog = mAllStrings.mCommunity
                            mDialogCommonList.open();
                        } else {
                            mSystemDialog.body = mAllStrings.mValidationNoDataFound
                            mSystemDialog.show()
                        }
                    }
                }
            }

        }

        ListView {
            id: mListViewCommunity
            dataModel: _mWebServiceinstance.mymodelcommunity
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        id: mContainerInsideList
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        horizontalAlignment: HorizontalAlignment.Fill
                        leftPadding: 10
                        layout: DockLayout {

                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.commonCommunity
                        }
                        Divider {
                        }
                    }
                }
            ]
            onTriggered: {

                var mdata = dataModel.data(indexPath);
                mTextFieldCommunity.text = mdata.commonCommunity
                mListViewCommunity.visible = false
                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.GetStreetsFromCommunity(mdata.commonCommunity, "", currentLang)
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }
                isCommunitySelected = true;
            }
        }
        ListView {
            id: mListViewCommunityArabic
            dataModel: _mWebServiceinstance.mymodelcommunity
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            horizontalAlignment: HorizontalAlignment.Right
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        id: mContainerInsideListArabic
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        rightPadding: 10
                        layout: DockLayout {
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Fill
                            text: ListItemData.commonCommunity
                            textStyle.textAlign: TextAlign.Right
                        }
                        Divider {
                        }
                    }
                }
            ]
            onTriggered: {

                var mdata = dataModel.data(indexPath);
                mTextFieldCommunity.text = mdata.commonCommunity
                mListViewCommunityArabic.visible = false
                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.GetStreetsFromCommunity(mdata.commonCommunity, "", currentLang)
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }

                isCommunitySelected = true;
            }
        }
        //creating size issue must solve it to display listview data
        // STREET NAME DROP DOWN OPTON
        Container {

            background: mImagePaintDefinitionTextBG.imagePaint
            Container {
                id: mContainerStreet
                horizontalAlignment: HorizontalAlignment.Fill
                preferredHeight: 90
                topMargin: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }

                TextField {
                    id: mTextFieldStreetname
                    hintText: mAllStrings.mStreet
                    backgroundVisible: false
                    clearButtonVisible: false
                    horizontalAlignment: HorizontalAlignment.Fill
                    onTextChanging: {
                        isStreetSelected = false;
                        mTextFieldBuilding.text = "";
                        if (mTextFieldStreetname.text.length > 0 && mTextFieldCommunity.text.length >= 1) {

                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                mListViewCommunity.visible = false
                                mListViewStreet.visible = true
                            } else {
                                mListViewCommunityArabic.visible = false
                                mListViewStreetArabic.visible = true
                            }
                            _mWebServiceinstance.searchDataFilterStreet(mTextFieldStreetname.text, "Street")

                        } else {
                            mListViewStreet.visible = false
                            mListViewStreetArabic.visible = false
                            _mWebServiceinstance.mymodelBuiding.clear()
                            mSystemListDialogBuilding.clearList()
                            mTextFieldBuilding.text = ""
                        }
                    }
                }
                Container {
                    id: mImageButtonStreet
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    leftPadding: 10.0
                    rightPadding: 10.0
                    ImageButton {

                        defaultImageSource: "asset:///images/search_option/arrow.png"
                        pressedImageSource: "asset:///images/search_option/arrow.png"
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                        onClicked: {
                            if (isCommunitySelected) {
                                selectedType = 2;

                                if (_mWebServiceinstance.searchDataFilterStreet("", "Street")) {
                                    mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelStreet;
                                    mDialogCommonListContent.mlabelDialog = mAllStrings.mStreet
                                    mDialogCommonList.open();
                                } else {
                                    mSystemDialog.body = mAllStrings.mValidationNoDataFound
                                    mSystemDialog.show()
                                }
                            }
                        }
                    }
                }

            }
        }
        ListView {
            id: mListViewStreet
            dataModel: _mWebServiceinstance.mymodelStreet
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        horizontalAlignment: HorizontalAlignment.Fill
                        leftPadding: 10
                        layout: DockLayout {
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.commonStreet
                        }
                        Divider {
                        }
                    }

                }
            ]
            onTriggered: {

                var mdata = dataModel.data(indexPath);
                mTextFieldStreetname.text = mdata.commonStreet
                mListViewStreet.visible = false
                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.GetBuildingsList(mTextFieldCommunity.text, mTextFieldStreetname.text, currentLang)
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }

                isStreetSelected = true;
            }

        }

        ListView {
            id: mListViewStreetArabic
            dataModel: _mWebServiceinstance.mymodelStreet
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            horizontalAlignment: HorizontalAlignment.Right
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        horizontalAlignment: HorizontalAlignment.Fill
                        rightPadding: 10
                        layout: DockLayout {
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.commonStreet
                            horizontalAlignment: HorizontalAlignment.Fill
                            textStyle.textAlign: TextAlign.Right
                        }
                        Divider {
                        }
                    }

                }
            ]
            onTriggered: {

                var mdata = dataModel.data(indexPath);
                mTextFieldStreetname.text = mdata.commonStreet
                mListViewStreetArabic.visible = false
                if (_mAppParentObj.isNetworkAvailable()) {
                    _mWebServiceinstance.GetBuildingsList(mTextFieldCommunity.text, mTextFieldStreetname.text, currentLang)
                } else {
                    mSystemDialog.body = mAllStrings.mNetworkCheck
                    mSystemDialog.show()
                }

                isStreetSelected = true;
            }
        }
        // #### BUILDING NAME DROP DOWN OPTON ###### //
        Container {

            background: mImagePaintDefinitionTextBG.imagePaint
            Container {
                id: mContainerBuilding
                horizontalAlignment: HorizontalAlignment.Fill
                topMargin: 10
                preferredHeight: 90

                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                TextField {
                    id: mTextFieldBuilding
                    hintText: mAllStrings.mBuilding
                    // hintText: "Building Number"
                    horizontalAlignment: HorizontalAlignment.Fill
                    backgroundVisible: false
                    clearButtonVisible: false
                    onTextChanging: {
                        if (mTextFieldBuilding.text.length > 0 && mTextFieldStreetname.text.length >= 1) {
                            _mWebServiceinstance.searchDataFilterBuilding(mTextFieldBuilding.text, mAllStrings.mBuilding)
                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                _mWebServiceinstance.searchDataFilterBuilding(mTextFieldBuilding.text, mAllStrings.mBuilding) == true ? mListViewBuilding.visible = true : mListViewBuilding.visible = false
                                mListViewStreet.visible = false
                            } else {
                                _mWebServiceinstance.searchDataFilterBuilding(mTextFieldBuilding.text, mAllStrings.mBuilding) == true ? mListViewBuildingArabic.visible = true : mListViewBuildingArabic.visible = false
                                mListViewStreetArabic.visible = false
                            }
                        } else {
                            mListViewBuilding.visible = false
                            mListViewBuildingArabic.visible = false
                        }
                    }
                }
                Container {
                    id: mImageButton
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    leftPadding: 10.0
                    rightPadding: 10.0
                    ImageButton {

                        defaultImageSource: "asset:///images/search_option/arrow.png"
                        pressedImageSource: "asset:///images/search_option/arrow.png"
                        verticalAlignment: VerticalAlignment.Center
                        onClicked: {
                            if (isStreetSelected && isCommunitySelected) {
                                if (_mWebServiceinstance.searchDataFilterBuilding("", mAllStrings.mBuilding)) {
                                    selectedType = 3;

                                    mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelBuiding;
                                    mDialogCommonListContent.mlabelDialog = mAllStrings.mBuilding
                                    mDialogCommonList.open();

                                } else {
                                    mSystemDialog.body = mAllStrings.mValidationNoDataFound
                                    mSystemDialog.show()
                                }

                            }
                        }
                    }
                }
            }

        }

        ListView {
            id: mListViewBuilding
            dataModel: _mWebServiceinstance.mymodelBuiding
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        leftPadding: 10
                        layout: DockLayout {
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.ADDRESS_E
                        }
                        Divider {
                        }
                    }

                }
            ]
            onTriggered: {
                var mdata = dataModel.data(indexPath);
                mTextFieldBuilding.text = mdata.ADDRESS_E
                mListViewBuilding.visible = false
            }
        }
        ListView {
            id: mListViewBuildingArabic
            dataModel: _mWebServiceinstance.mymodelBuiding
            preferredHeight: 300
            preferredWidth: mAllStrings.searchTextFiledFullWidth
            visible: false
            horizontalAlignment: HorizontalAlignment.Right
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        background: Color.White
                        verticalAlignment: VerticalAlignment.Center
                        preferredHeight: 70
                        rightPadding: 10
                        layout: DockLayout {
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: ListItemData.ADDRESS_E
                            horizontalAlignment: HorizontalAlignment.Fill
                            textStyle.textAlign: TextAlign.Right
                        }
                        Divider {
                        }
                    }

                }
            ]
            onTriggered: {
                var mdata = dataModel.data(indexPath);
                mTextFieldBuilding.text = mdata.ADDRESS_E
                mListViewBuildingArabic.visible = false
            }
        }
    }
    // FINAL SUBMIT BUTTON TO SEARCH DATA
    Container {
        topMargin: 20
        id: mContainerButton
        horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        CommonButtonWithLabel {
            id: mCommonButtonWithLabelSearch
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllStrings.mSearch
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            onMyClick: {
                _mWebServiceinstance.checkDataNull.connect(checkData)
                if (mTextFieldCommunity.text.length > 0 && mTextFieldStreetname.text.length > 0 && mTextFieldBuilding.text.length > 0) {

                    if (_mAppParentObj.isNetworkAvailable()) {
                        if (isFromSearch) {
                            _mWebServiceinstance.ClearMapdata();
                            _mWebServiceinstance.setPoiInfoData(mTextFieldCommunity.text + " " + mTextFieldStreetname.text + " " + mTextFieldBuilding.text, "", "", "", "", "", "");
                            searchonmapclick()
                        }
                        _mWebServiceinstance.setcheckisFromAdvanceSearch(isFromSearch)
                        if (! isfromDirectionbuilding) {
                            _mWebServiceinstance.GetBuildingAddress(mTextFieldCommunity.text, mTextFieldStreetname.text, mTextFieldBuilding.text, currentLang)
                            //   _mWebServiceinstance.setcheckisdirectionbuilding(false)

                        } else {
                            isfromDirectionbuilding = false
                            console.debug("mTextFieldStreetname.text :", mTextFieldStreetname.text)
                            var textData = mTextFieldCommunity.text + "," + mTextFieldStreetname.text + "," + mTextFieldBuilding.text
                            mTextFieldSetData.text = textData
//                            mTextFieldSetData.text=mTextFieldStreetname.text
                            mdialog.close()
                        }
                        console.debug("community:" + mTextFieldCommunity.text)
                        console.debug("street:" + mTextFieldStreetname.text)
                        console.debug("building:" + mTextFieldBuilding.text)
                        console.debug("currentLang:" + currentLang)

                    } else {
                        mSystemDialog.body = mAllStrings.mNetworkCheck
                        mSystemDialog.show()
                    }

                } else if (mTextFieldCommunity.text.length == 0) {
                    mSystemDialog.body = mAllStrings.mValidationCommunity
                    mSystemDialog.show()
                } else if (mTextFieldStreetname.text.length == 0) {
                    mSystemDialog.body = mAllStrings.mValidationStreet
                    mSystemDialog.show()
                } else if (mTextFieldBuilding.text.length == 0) {
                    mSystemDialog.body = mAllStrings.mValidationBuilding
                    mSystemDialog.show()
                }
            }
        }
        CommonButtonWithLabel {
            id: mCommonButtonWithLabelCancel
            leftMargin: 20
            verticalAlignment: VerticalAlignment.Center
            mLableText: mAllStrings.mCancel
            mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
            mWidth: 200
            mTextColor: Color.White
            visible: ! isFromSearch
            onMyClick: {
                mDialogBuildingAddress.close();
                if (! isFromSearch) {
                    // isFromforDialog == true ? whenCancelButtonHit(true) : whenCancelButtonHit(false)
                }
            }
        }
    }
    function checkData() {
        console.debug("_mWebServiceinstance.getcheckResponseNullResult():" + _mWebServiceinstance.getcheckResponseNullResult())
        if ((! isFromSearch) && (! _mWebServiceinstance.getcheckResponseNullResult())) {
            mTextFieldSetData.text = mTextFieldCommunity.text
            mDialogBuildingAddress.close()
        }

    }
    attachedObjects: [
        TextStyleDefinition {
            id: mlabelStyle
            color: Color.Red
            fontSize: FontSize.Default
            fontWeight: FontWeight.Bold
        },
        AllStrings {
            id: mAllStrings
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTextBG
            imageSource: "asset:///images/home/bg_search.png"
        },
        SystemListDialog {
            id: mSystemListDialogBuilding
            selectionMode: selectionMode.Single
            cancelButton.label: undefined
            onFinished: {
                var mBuildingDialogData = new Array();
                mBuildingDialogData = _mWebServiceinstance.getBuildingListData();
                mTextFieldBuilding.text = mBuildingDialogData[selectedIndices];
                mListViewBuilding.visible = false
            }
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
            onFinished: {
                if (mSystemDialog.result == SystemUiResult.ConfirmButtonSelection) {

                }
            }
        },
        Dialog {
            id: mDialogCommonList
            onOpenedChanged: {
                mDialogCommonListContent.setAlignMent()
            }
            DialogCommonList {
                id: mDialogCommonListContent
                onDoneClick: {
                    if (selectedType == 1) {

                        mTextFieldCommunity.text = selectedData.commonCommunity
                        mListViewCommunity.visible = false
                        mListViewCommunityArabic.visible = false
                        if (_mAppParentObj.isNetworkAvailable()) {
                            _mWebServiceinstance.GetStreetsFromCommunity(selectedData.commonCommunity, "", currentLang)
                        } else {
                            mSystemDialog.body = mAllStrings.mNetworkCheck
                            mSystemDialog.show()
                        }
                        isCommunitySelected = true;
                    } else if (selectedType == 2) {
                        mTextFieldStreetname.text = selectedData.commonStreet
                        mListViewStreet.visible = false
                        mListViewStreetArabic.visible = false
                        if (_mAppParentObj.isNetworkAvailable()) {
                            _mWebServiceinstance.GetBuildingsList(mTextFieldCommunity.text, mTextFieldStreetname.text, currentLang)
                        } else {
                            mSystemDialog.body = mAllStrings.mNetworkCheck
                            mSystemDialog.show()
                        }
                        isStreetSelected = true;
                    } else if (selectedType == 3) {
                        mTextFieldBuilding.text = selectedData.ADDRESS_E
                        mListViewBuildingArabic.visible = false
                        mListViewBuilding.visible = false
                    }
                }
            }
        }
    ]

}

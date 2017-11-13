// ***********************************************************************************************************
//  FAVOURITE ADDING MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
import bb.DatabaseConnectionApi.data 1.0
import bb.system 1.2
Page {
    property int intSelectedDataCount: 0
    property int intTotalDataCount: 0
    property int currentTask: -1
    property int intLOAD: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property string mStringShareData
    property bool isNeedToShowDialog: true
    property string currentLang
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerCheckBox.layout.orientation = LayoutOrientation.LeftToRight
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Left
            currentLang="E&"
            mContainerActionButton.layout.orientation = LayoutOrientation.LeftToRight
            mContainerActionButton.horizontalAlignment = HorizontalAlignment.Right

            mListViewArabic.visible = false
            mListView.visible = true

            mTextFieldSearch.textStyle.textAlign = TextAlign.Left
            mContainerSearchBox.layout.orientation = LayoutOrientation.LeftToRight

        } else {
            mContainerCheckBox.layout.orientation = LayoutOrientation.RightToLeft
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Right

            mContainerActionButton.layout.orientation = LayoutOrientation.RightToLeft
            mContainerActionButton.horizontalAlignment = HorizontalAlignment.Left

            mTextFieldSearch.textStyle.textAlign = TextAlign.Right

            mListViewArabic.visible = true
            mListView.visible = false
            currentLang="A&"
            mContainerSearchBox.layout.orientation = LayoutOrientation.RightToLeft
        }
        intLOAD = -1;
        mCustomeDataSource.query = "SELECT * FROM favourite"
        mCustomeDataSource.load();
        mDialogAddToFavourites.setAlignMent();
        mDialogShareContent.setAlignMent();
    }

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onCreationCompleted: {

        }
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        CommonTopBar {
            mText: mAllString.mFavourites
        }
        Container {
            topPadding: -5
            bottomPadding: -5
            // SEARCH BOX TO SEARCH FAVOURITE ADDED ITEMS
            Container {
                id: mContainerSearchBox
                background: mImagePaintDefinitionSearch.imagePaint
                horizontalAlignment: HorizontalAlignment.Fill
                topPadding: 25
                bottomPadding: 25
                rightPadding: 35
                leftPadding: 35
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    visible: true
                    ImageButton {
                        id: doneButton
                        defaultImageSource: "asset:///images/home/icon_search.png"
                        pressedImageSource: "asset:///images/home/icon_search.png"
                    }
                }
                TextField {
                    id: mTextFieldSearch
                    hintText: mAllString.mSearchFavourites
                    onTextChanging: {
                        if (mTextFieldSearch.text.replace(new RegExp(" ", 'g'), "").length > 0) {
                            currentTask = intSELECT;
                            mCustomeDataSource.query = "SELECT * FROM favourite where getpoiname  like \"%" + mTextFieldSearch.text + "%\""
                            mCustomeDataSource.load();
                        } else {
                            currentTask = intLOAD;
                            mCustomeDataSource.query = "SELECT * FROM favourite"
                            mCustomeDataSource.load();
                        }
                    }
                }
            }
        }
        // FAVOURITE ACTIONS BUTTONS, EDIT, DELETE , SHARE , SHOW IN MAP
        Container {
            id: mContainerAction
            horizontalAlignment: HorizontalAlignment.Fill
            background: mImagePaintDefinitionHeader.imagePaint
            topPadding: 15
            bottomPadding: 15
            layout: DockLayout {
            }
            Container {
                leftPadding: 25
                rightPadding: 25
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Left
                id: mContainerCheckBox
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxHeader
                    verticalAlignment: VerticalAlignment.Center
                    onTouch: {
                        if (event.isUp()) {
                            checked = ! checked
                            checkAllData(checked);
                        }
                    }
                }
                Label {
                    leftMargin: 5
                    text: mAllString.mSelectAll
                    textStyle.color: Color.Black
                    textStyle.fontSize: FontSize.Large
                }
            } //select all layout ends
            // EDIT BUTTON
            Container {
                leftPadding: 25
                rightPadding: 25
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                id: mContainerActionButton
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                ImageButton {
                    id: mImageButtonEdit
                    verticalAlignment: VerticalAlignment.Center
                    defaultImageSource: "asset:///images/favourites/icon_edit.png"
                    pressedImageSource: "asset:///images/favourites/icon_edit_hover.png"
                    disabledImageSource: "asset:///images/favourites/icon_edit_hover.png"
                    //enabled: intSelectedDataCount == 1 ? true : false
                    enabled: true
                    onClicked: {

                        if (intSelectedDataCount > 0) {
                            
                            if (intSelectedDataCount > 1) {
                                mSystemDialog.body = mAllString.mValidationShareSelectAnyOne
                                mSystemDialog.show()
                            } else {
                                editFavourite();
                                
                            }

                        } else {
                            mSystemDialog.body = mAllString.mFaviouritesOther
                            mSystemDialog.show()
                        }

                    }
                }
                // DELETE BUTTON
                ImageButton {
                    id: mImageButtonDelete
                    verticalAlignment: VerticalAlignment.Center
                    defaultImageSource: "asset:///images/favourites/icon_delete.png"
                    pressedImageSource: "asset:///images/favourites/icon_delete_hover.png"
                    disabledImageSource: "asset:///images/favourites/icon_delete_hover.png"
                    //enabled: intSelectedDataCount > 0 ? true : false
                    onClicked: {
                        if (intSelectedDataCount > 0) {
                            mSystemDialogDelete.show();
                        } else {
                            mSystemDialog.body = mAllString.mFaviouritesOther
                            mSystemDialog.show()
                        }

                    }
                }
                // SHARE BUTTON
                ImageButton {
                    id: mImageButtonShare
                    verticalAlignment: VerticalAlignment.Center
                    defaultImageSource: "asset:///images/favourites/icon_share.png"
                    pressedImageSource: "asset:///images/favourites/icon_share_hover.png"
                    disabledImageSource: "asset:///images/favourites/icon_share_hover.png"
                    //enabled: intSelectedDataCount > 0 ? true : false
                    onClicked: {
                        if (intSelectedDataCount > 0) {
                            shareData();
                        } else {
                            mSystemDialog.body = mAllString.mFaviouritesOther
                            mSystemDialog.show()
                        }

                    }
                }
                // MAP BUTTON
                ImageButton {
                    id: mImageButtonMap
                    verticalAlignment: VerticalAlignment.Center
                    defaultImageSource: "asset:///images/favourites/icon_map.png"
                    pressedImageSource: "asset:///images/favourites/icon_map_hover.png"
                    disabledImageSource: "asset:///images/favourites/icon_map_hover.png"
                    //enabled: intSelectedDataCount > 0 ? true : false
                    onClicked: {
                        if (intSelectedDataCount > 0) {
                            dropPinForSelectedData();
                        } else {
                            mSystemDialog.body = mAllString.mFaviouritesOther
                            mSystemDialog.show()
                        }

                    }
                }

            }
        } //horizontal top ends
        // LIST VIEW TO SHOW DATA WHICH ARE IN THE FAVOURITE LIST
        ListView {
            id: mListView
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            dataModel: groupdata
            function checkAllChecked(isChecked, indexpath) {
                isAllDataSelected(isChecked, indexpath);
            }
            function getModel() {
                return groupdata;
            }
            function getLang() {
                return "en";
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    CommonListRow {
                        id: mCommonListRow
                        isDistanceVisible: false
                        onTouch: {
                            currentIndexpPath = ListItem.indexPath
                            mCommonListRow.setIndexPath(ListItem.indexPath)
                        }
                    }
                }
            ]
            onTriggered: {
                var data = dataModel.data(indexPath);
                var latlng = data.latitude + "," + data.longitude
                _mWebServiceinstance.ClearMapdata();
                _mWebServiceinstance.setPoiInfoData(data.getpoiname, data.telephone, data.fax_no, data.email, data.license_no, data.poi_url, data.pobox)
                dropSinglePin(data.location, data.latitude, data.longitude);
            }
        }
        // LIST FAVOURITE DATA IN ARABIC
        ListView {
            id: mListViewArabic
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            dataModel: groupdata
            function checkAllChecked(isChecked, indexpath) {
                isAllDataSelected(isChecked, indexpath);
            }
            function getModel() {
                return groupdata;
            }
            function getLang() {
                return "ar";
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    CommonListRow {
                        id: mCommonListRowArabic
                        isDistanceVisible: false
                        onTouch: {
                            currentIndexpPath = ListItem.indexPath
                            mCommonListRowArabic.setIndexPath(ListItem.indexPath)
                        }
                    }
                }
            ]
            onTriggered: {
                var data = dataModel.data(indexPath);
                var latlng = data.latitude + "," + data.longitude
                _mWebServiceinstance.ClearMapdata();
                _mWebServiceinstance.setPoiInfoData(data.getpoiname, data.telephone, data.fax_no, data.email, data.license_no, data.poi_url, data.pobox)
                dropSinglePin(data.location, data.latitude, data.longitude)

            }
        }
    }
    function editFavourite() {
        mListViewArabic.reset
        var count = mListView.dataModel.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = mListView.dataModel.data(indexPath);
            if (selectedItem.getChecked == true) {
                mDialogAddToFavourite.open();
                mDialogAddToFavourites.mTextHeader = selectedItem.getpoiname;
                mDialogAddToFavourites.mTextLocation = selectedItem.location;
                mDialogAddToFavourites.mLatitude = selectedItem.latitude;
                mDialogAddToFavourites.mLongitude = selectedItem.longitude;
                mDialogAddToFavourites.mBackVisible = false;
                mDialogAddToFavourites.mID = selectedItem.id
            }
        }

    }

    function dropPinForSelectedData() {
        _mWebServiceinstance.ClearMapdata();
        var count = mListView.dataModel.childCount(0);
        var isFirst = true;
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = mListView.dataModel.data(indexPath);
            if (selectedItem.getChecked == true) {
                var latlng = selectedItem.latitude + "," + selectedItem.longitude
                if (intSelectedDataCount == 1) {
                    _mWebServiceinstance.setPoiInfoData(selectedItem.getpoiname, selectedItem.telephone, selectedItem.fax_no, selectedItem.email, selectedItem.license_no, selectedItem.poi_url, selectedItem.pobox)
                    dropSinglePin(selectedItem.location, selectedItem.latitude, selectedItem.longitude)
                } else {
                    _mWebServiceinstance.setPinFromFav(false, isFirst, selectedItem.location, selectedItem.latitude, selectedItem.longitude, selectedItem.getpoiname, selectedItem.telephone, selectedItem.fax_no, selectedItem.email, selectedItem.license_no, selectedItem.poi_url, selectedItem.pobox)
                }
                isFirst = false;
            }
        }
        mainTabPaned.changeTab(0);
    }

    function dropSinglePin(singlePinData, latitude, longitude) {
        var myResult = _mWebServiceinstance.checkInvalid(singlePinData.replace(" ", ""))
        if (myResult == "number") {
            _mWebServiceinstance.GetBuildingInfo(singlePinData)
        } else {
            _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(latitude, longitude, true, false)
        }
        mainTabPaned.changeTab(0);
    }

    function deleteSelectedData() {
        var queryDelete = "";
        var count = groupdata.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = groupdata.data(indexPath);
            if (selectedItem.getChecked == true) {
                if (queryDelete == "") {
                    queryDelete = selectedItem.id
                } else {
                    queryDelete = queryDelete + "," + selectedItem.id
                }
            }
        }

        queryDelete = "DELETE FROM favourite WHERE id IN (" + queryDelete + ")"
        currentTask = intDELETE;
        mCustomeDataSource.query = queryDelete;
        mCustomeDataSource.load();
    }

    function isAllDataSelected(isCheck, indexPath) {
        var isChecked = ! isCheck;
        intTotalDataCount = groupdata.childCount(0);

        if (isChecked) {
            intSelectedDataCount = intSelectedDataCount + 1
        } else {
            intSelectedDataCount = intSelectedDataCount - 1
        }

        if (intTotalDataCount == intSelectedDataCount) {
            mCheckBoxHeader.checked = true
        } else {
            mCheckBoxHeader.checked = false
        }

        //For changed model's data
        var selectedItem = groupdata.data(indexPath);
        selectedItem.getChecked = isChecked;
        groupdata.updateItem(indexPath, selectedItem);
    }
    function checkAllData(check) {

        intTotalDataCount = 0;
        intSelectedDataCount = 0;
        var count = groupdata.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = groupdata.data(indexPath);

            intTotalDataCount = intTotalDataCount + 1;
            selectedItem.getChecked = check;
            if (check) {
                intSelectedDataCount = intSelectedDataCount + 1;
            }

            groupdata.updateItem(indexPath, selectedItem);
        }
    }

    function shareData() {
        mStringShareData = "";
        var count = mListView.dataModel.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = mListView.dataModel.data(indexPath);
            if (selectedItem.getChecked == true) {
                var shareString = selectedItem.location.replace(new RegExp(" ", 'g'), "");
                var checkText = _mWebServiceinstance.validateString(shareString)
                var shareURL;
                if (checkText == "number")
                    shareURL = mAllString.mShareURL+currentLang + "makani=" + shareString;
                else if (checkText == "UAENG")
                    shareURL = mAllString.mShareURL+currentLang + "UAENG=" + shareString;
                else
                    shareURL = selectedItem.location
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + " , " + shareURL;
                else
                    mStringShareData = shareURL

            }
        }
        mDialogShareContent.mShareData = mStringShareData;
        mDialogShareContent.mCopyData = mStringShareData;
        mDialogShareContent.mBackVisible = false;
        mDialogShareContent.selectedCount=intSelectedDataCount
        mDialogShare.open();
    }
    attachedObjects: [
        AllStrings {
            id: mAllString
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionHeader
            imageSource: "asset:///images/favourites/bg_select.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionSearch
            imageSource: "asset:///images/favourites/bg_search.png"
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/DM_App.sqlite"
            query: "SELECT * FROM favourite"
            connection: "mCustomeDataSourceFav"
            onDataLoaded: {
                if (currentTask == intSELECT || currentTask == intLOAD) {
                    intTotalDataCount = 0;
                    intSelectedDataCount = 0;
                    mCheckBoxHeader.checked = false;
                    groupdata.clear();
                    groupdata.insertList(data);
                    intTotalDataCount = data.length;
                    mListView.dataModelChanged(groupdata);
                    if (data.length > 0) {
                        mContainerAction.visible = true;
                    } else if (currentTask == intLOAD) {
                        mContainerAction.visible = false
                        mSystemDialog.body = mAllString.mValidationFavouriteNotFound
                        mSystemDialog.show();
                    }
                } else if (currentTask == intDELETE) {
                    currentTask = intLOAD;
                    mCustomeDataSource.query = "SELECT * FROM favourite"
                    mCustomeDataSource.load();
                }
            }
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        },
        Dialog {
            id: mDialogAddToFavourite
            DialogAddToFavourites {
                id: mDialogAddToFavourites
                onSuccessQuery: {
                    mTextFieldSearch.text = "";
                    currentTask = intSELECT;
                    mCustomeDataSource.query = "SELECT * FROM favourite"
                    mCustomeDataSource.load();
                }
            }
        },
        Dialog {
            id: mDialogShare
            Share {
                id: mDialogShareContent
            }

        },
        SystemDialog {
            id: mSystemDialogDelete
            title: undefined
            body: mAllString.mValidationFavouriteDelete
            cancelButton.label: mAllString.mCancel
            confirmButton.label: mAllString.mYes
            onFinished: {
                if (mSystemDialogDelete.result == SystemUiResult.ConfirmButtonSelection) {
                    mTextFieldSearch.text = "";
                    deleteSelectedData();
                }
            }
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: mAllString.mOk
            confirmButton.label: undefined
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: mAllString.mBack
            onTriggered: {
                mNavigationPaneMain.pop();
            }
        }
    }
}

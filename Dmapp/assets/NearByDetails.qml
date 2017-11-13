// ***********************************************************************************************************
//  NEAR BY LOCATION LISTING DATA MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import bb.system 1.2
import "common"
Page {
    id: mpage
    property int intSelectedDataCount: 0
    property int intTotalDataCountcheckbox: 0
    property int intTotalDataCount: 0
    property int currentTask: -1
    property int intLOAD: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property string mStringShareData
    property string mLanguageCode
    property variant mCheckBoxIndex: []
    property int mModelTotalSize: 0
    property bool isComeFromMap
    property NavigationPane mNavigationPaneNearBy

    property variant mAllCheckedLatLngList: []
    property variant mCheckedLatLngList: []
    property int mIndexPath
    property string currentLang
    onCreationCompleted: {
        mLanguageCode = _mWebServiceinstance.getValueFor("mLanguageCode", "en")
        mCheckBoxIndex = new Array()
        setAlignment()
    }
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignment() {

        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerMainTab.layout.orientation = LayoutOrientation.LeftToRight
            mContainerCheckboxwithLabel.layout.orientation = LayoutOrientation.LeftToRight
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Left
            mLabelSelectAll.textStyle.textAlign = TextAlign.Left
            mLabelDistance.textStyle.textAlign = TextAlign.Left
            mLabelPlaceName.textStyle.textAlign = TextAlign.Left
            mContainerImageButton.horizontalAlignment = HorizontalAlignment.Right
            currentLang="E&"
        } else {
            mContainerMainTab.layout.orientation = LayoutOrientation.RightToLeft
            mLabelDistance.textStyle.textAlign = TextAlign.Right
            mLabelPlaceName.textStyle.textAlign = TextAlign.Right
            mContainerCheckboxwithLabel.layout.orientation = LayoutOrientation.RightToLeft
            mLabelSelectAll.textStyle.textAlign = TextAlign.Right
            mContainerImageButton.horizontalAlignment = HorizontalAlignment.Left
            mContainerCheckBox.horizontalAlignment = HorizontalAlignment.Right
            currentLang="A&"
        }
    }

    function isAllDataSelected11(isCheck, indexPath) {
        var isChecked = ! isCheck;

        intTotalDataCount = _mWebServiceinstance.mymodelNearBy.childCount(0);

        if (isChecked) {
            intSelectedDataCount = intSelectedDataCount + 1
        } else {
            intSelectedDataCount = intSelectedDataCount - 1
        }
        console.debug("intTotalDataCount:" + intTotalDataCount)
        console.debug("intSelectedDataCount:" + intSelectedDataCount)

        if (intTotalDataCount == intSelectedDataCount) {
            mCheckBoxHeader.checked = true
        } else {
            mCheckBoxHeader.checked = false
        }
        console.debug("data in in" + _mWebServiceinstance.mymodelNearBy.data(indexPath))
        //For changed model's data
        var selectedItem = _mWebServiceinstance.mymodelNearBy.data(indexPath);
        selectedItem.getChecked = isChecked
        _mWebServiceinstance.mymodelNearBy.updateItem(indexPath, selectedItem);
    }
    function dropPinForSelectedData() {
        _mWebServiceinstance.ClearMapdata();
        _mWebServiceinstance.setIsfromNearByDetails(true)
        _mWebServiceinstance.dropMapPinForSelectedData(mAllCheckedLatLngList)
        _mWebServiceinstance.setIsfromNearByDetails(false)
    }

    function checkAllData(check) {

        var count = _mWebServiceinstance.mymodelNearBy.childCount(0)
        console.debug("count :", count)
        console.debug("check out :", check)
        var marr = new Array();

        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = _mWebServiceinstance.mymodelNearBy.data(indexPath);
            selectedItem.getChecked = check;
            _mWebServiceinstance.mymodelNearBy.updateItem(indexPath, selectedItem);
            //            ListItemData.UAENG, ListItemData.X_COORD, ListItemData.Y_COORD
            marr.push({
                    "title": selectedItem.UAENG,
                    "lat": selectedItem.X_COORD,
                    "lng": selectedItem.Y_COORD,
                    "mindexpath": i,
                    "isFromMap": "false"
                });
        }
        if (check) {
            mAllCheckedLatLngList = marr
            //            mCheckedLatLngList = marr
        } else {
            var marr = new Array();
            mAllCheckedLatLngList = marr
            //            mCheckedLatLngList = marr
        }
    }
    function getcheckdata(title, lat, lng, isCheck, indexpath) {
        mIndexPath = parseInt(indexpath)
        var marr = mAllCheckedLatLngList;
        var selectedItem = _mWebServiceinstance.mymodelNearBy.data(indexpath);
        selectedItem.getChecked = isCheck;
        _mWebServiceinstance.mymodelNearBy.updateItem(indexpath, selectedItem);

        if (isCheck) {
            marr.push({
                    "title": title,
                    "lat": lat,
                    "lng": lng,
                    "mindexpath": mIndexPath,
                    "isFromMap": "false"
                });
            mAllCheckedLatLngList = marr;

        } else {
            for (var i = 0; i < mAllCheckedLatLngList.length; i ++) {
                if (mAllCheckedLatLngList[i].mindexpath == mIndexPath) {
                    var j = marr.indexOf(mIndexPath)
                    marr.splice(i, 1);
                    mAllCheckedLatLngList = marr;
                }
            }
        }
        var count = _mWebServiceinstance.mymodelNearBy.childCount(0)
        if (count == mAllCheckedLatLngList.length) {
            mCheckBoxHeader.checked = true
        } else {
            mCheckBoxHeader.checked = false
        }
    }

    function shareData() {
        mStringShareData = "";
        var count = mListView.dataModel.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = mListView.dataModel.data(indexPath);
            if (selectedItem.getChecked == true) {
                var shareString = selectedItem.UAENG.replace(new RegExp(" ", 'g'), "");
                var checkText = _mWebServiceinstance.validateString(shareString)
               
                var shareURL;
                if (checkText == "number")
                    shareURL = mAllString.mShareURL + currentLang + "makani=" + shareString;
                else if (checkText == "UAENG")
                    shareURL = mAllString.mShareURL + currentLang + "UAENG=" + shareString;
                else
                    shareURL = selectedItem.UAENG
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + " , " + shareURL;
                else
                    mStringShareData = shareURL
            }
        }
        mDialogShareContent.mShareData = mStringShareData;
        mDialogShareContent.mCopyData = mStringShareData;
        mDialogShareContent.mBackVisible = false;
        mDialogShareContent.selectedCount = mAllCheckedLatLngList.length
        mDialogShare.open();
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
            mText: mAllString.mNeraby
        }
        // MAIN CONTAINER
        Container {
            id: mContainerMainTab
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 80
            background: Color.DarkGray
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            // DISTANCE AND PLACE NAME SHOWING TABS
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                preferredHeight: 80

                layout: DockLayout {

                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Label {
                    id: mLabelDistance
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllString.mDistance
                    textStyle.color: Color.White
                    textStyle.fontSizeValue: FontWeight.Bold
                }
                Container {
                    id: mContainerDistance
                    verticalAlignment: VerticalAlignment.Bottom
                    horizontalAlignment: HorizontalAlignment.Fill
                    preferredHeight: 10
                    background: Color.create("#00b5e9")
                    layout: DockLayout {

                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mContainerDistance.preferredHeight = 10
                        mContainerPlaceName.preferredHeight = 5
                        _mWebServiceinstance.shortingDataModel("DISTANCE")
                    }
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layout: DockLayout {

                }
                ImageView {
                    imageSource: "asset:///images/Nearby/nearby_tabs_active.9.png"
                }
            }
            // PLACE NAME CONTAIENR
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                preferredHeight: 80
                layout: DockLayout {

                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Label {
                    id: mLabelPlaceName
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.color: Color.White
                    textStyle.fontSizeValue: FontWeight.Bold
                    text: mAllString.mSearchPlace
                }
                Container {
                    id: mContainerPlaceName
                    verticalAlignment: VerticalAlignment.Bottom
                    horizontalAlignment: HorizontalAlignment.Fill
                    preferredHeight: 5
                    background: Color.create("#00b5e9")
                    layout: DockLayout {

                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mContainerDistance.preferredHeight = 5
                        mContainerPlaceName.preferredHeight = 10
                        _mWebServiceinstance.shortingDataModel(_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? "NAME_E" : "NAME_A")
                    }
                }
            }

        }
        // CHECK BOX TO SELECT OR UNSELECT PLACES
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 80
            background: mImagePaintDefinitionHeader.imagePaint
            layout: DockLayout {

            }
            Container {
                id: mContainerCheckBox
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
                layout: DockLayout {

                }
                Container {
                    id: mContainerCheckboxwithLabel
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Center
                    leftPadding: ui.du(2)
                    rightPadding: ui.du(2)
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    CheckBox {
                        id: mCheckBoxHeader
                        verticalAlignment: VerticalAlignment.Center
                        onTouch: {
                            if (event.isUp()) {

                                mCheckBoxHeader.checked = ! mCheckBoxHeader.checked
                                checkAllData(mCheckBoxHeader.checked);
                            }
                        }
                    }

                    Label {
                        id: mLabelSelectAll
                        textStyle.textAlign: TextAlign.Left
                        text: mAllString.mSelectAll
                    }
                }
            }
            // SHARE , MAP ICON TO LOCATE AND SHARE SELECTED PLACES
            Container {
                id: mContainerImageButton
                rightPadding: ui.du(2)
                leftPadding: ui.du(2)
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                layout: DockLayout {

                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    ImageButton {
                        id: mImageButtonShare
                        verticalAlignment: VerticalAlignment.Center
                        defaultImageSource: "asset:///images/favourites/icon_share.png"
                        pressedImageSource: "asset:///images/favourites/icon_share_hover.png"
                        disabledImageSource: "asset:///images/favourites/icon_share_hover.png"
                        //  enabled: intSelectedDataCount > 0 ? true : false
                        enabled: mAllCheckedLatLngList.length > 0 ? true : false
                        onClicked: {
                            if (mAllCheckedLatLngList.length == 0) {
                                mSystemDialog.body = mAllString.mFaviouritesOther
                                mSystemDialog.show()
                            } else {
                                shareData();
                            }
                        }
                    }
                    ImageButton {
                        id: mImageButtonMap
                        verticalAlignment: VerticalAlignment.Center
                        defaultImageSource: "asset:///images/favourites/icon_map.png"
                        pressedImageSource: "asset:///images/favourites/icon_map_hover.png"
                        disabledImageSource: "asset:///images/favourites/icon_map_hover.png"
                        //                        enabled: intSelectedDataCount > 0 ? true : false
                        enabled: mAllCheckedLatLngList.length > 0 ? true : false
                        //enabled: true
                        onClicked: {

                            console.debug("mAllCheckedLatLngList" + mAllCheckedLatLngList.length)

                            var marr = mAllCheckedLatLngList
                            if (mAllCheckedLatLngList.length == 0) {
                                mSystemDialog.body = mAllString.mFaviouritesOther
                                mSystemDialog.show()
                            } else {
                                console.debug("isComeFromMap:- " + isComeFromMap)
                                if (isComeFromMap) {
                                    console.debug("my previous clicked location map coords are:- " + _mWebServiceinstance.getMapCaptionLatitude() + "longitude: " + _mWebServiceinstance.getMapCaptionLongitude())
                                    //  _mWebServiceinstance.setMapSinglePinForSelectedData(_mWebServiceinstance.getValueFor("currentLatitude", "25.271139"), _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"), _mWebServiceinstance.getMapCaptionText())

                                    marr.push({
                                            "title": "from map",
                                            "lat": _mWebServiceinstance.getMapCaptionLatitude(),
                                            "lng": _mWebServiceinstance.getMapCaptionLongitude(),
                                            "mindexpath": marr.length,
                                            "isFromMap": "true"
                                        });
                                } else {
                                    console.debug("else  map coords are orifginAl form gps:- " + _mWebServiceinstance.getValueFor("currentLatitude", "25.271139") + "longitude: " + _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"))
                                    //   _mWebServiceinstance.setMapSinglePinForSelectedData(_mWebServiceinstance.getValueFor("currentLatitude", "25.271139"), _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"), _mWebServiceinstance.getMapCaptionText())

                                    marr.push({
                                            "title": "from map gps",
                                            "lat": _mWebServiceinstance.getValueFor("currentLatitude", "25.271139"),
                                            "lng": _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"),
                                            "mindexpath": marr.length,
                                            "isFromMap": "true"
                                        });

                                }
                                mAllCheckedLatLngList = marr
                                dropPinForSelectedData()

                                for (var i = 0; i < mNavigationPaneNearBy.count(); i ++) {
                                    mNavigationPaneNearBy.pop(mNavigationPaneNearBy.at(i))
                                }
                                mainTabPaned.changeTab(0);
                            }

                        }
                    }
                }
            }
        }
        // LISTING PLACES BASED ON THE SEARCH RESULT
        ListView {
            id: mListView
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            dataModel: getModel()
            property int mcheckModelSize: mListView.dataModel.childCount(0)
            property variant mFilterSearchList: []
            property int temptotal: 0
            property int tempslected: 0
            function checkAllChecked(isChecked, indexpath) {
                // isAllDataSelected(isChecked, indexpath);
                isAllDataSelected11(isChecked, indexpath)
            }
            function getModel() {
                return _mWebServiceinstance.mymodelNearBy;
            }
            function getLang() {
                return mLanguageCode;
            }
            function getWSinstance() {
                return _mWebServiceinstance;
            }

            function setmymdata(mclick, ischeked) {
                console.debug("mclick:" + mclick.toString())
                _mWebServiceinstance.SetMyCheckBoxList(mclick, ischeked)

            }
            function getmymdata() {
                return mFilterSearchList
            }
            function getsize() {
                mcheckModelSize
            }
            function getselexted() {
                tempslected = mpage.intSelectedDataCount
            }
            function checkedIndexPath(title, lat, lng, isCheck, indexpath) {
                //                isAllDataSelected(isChecked, indexpath);

                getcheckdata(title, lat, lng, isCheck, indexpath)
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    CommonNearByRow {
                        id: mCommonNearByRow
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        mLanguageCode: ListItem.view.getLang()

                        onTouchChanged: {
                            var flagcheck
                            if (mCheckBox.checked) {
                                flagcheck = false
                            } else {
                                flagcheck = true
                            }

                            ListItem.view.checkedIndexPath(ListItemData.UAENG, ListItemData.X_COORD, ListItemData.Y_COORD, flagcheck, ListItem.indexPath);
                        }
                        //
                    }
                }

            ]
            onTriggered: {
                var data = dataModel.data(indexPath);
                var latlng = data.X_COORD + "," + data.Y_COORD
                _mWebServiceinstance.ClearMapdata();
                /* //  _mWebServiceinstance.setIsfromNearByDetails(true)
                 * dropSinglePin(data.UAENG, data.X_COORD, data.Y_COORD);
                 * //   _mWebServiceinstance.setIsfromNearByDetails(false)
                 */

                var marr = new Array();
                marr.push({
                        "title": data.UAENG,
                        "lat": data.X_COORD,
                        "lng": data.Y_COORD,
                        "isFromMap": "false"
                    });

                if (isComeFromMap) {
                    console.debug("my previous clicked location map coords are:- " + _mWebServiceinstance.getMapCaptionLatitude() + "longitude: " + _mWebServiceinstance.getMapCaptionLongitude())
                    //  _mWebServiceinstance.setMapSinglePinForSelectedData(_mWebServiceinstance.getValueFor("currentLatitude", "25.271139"), _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"), _mWebServiceinstance.getMapCaptionText())
                    marr.push({
                            "title": "from map",
                            "lat": _mWebServiceinstance.getMapCaptionLatitude(),
                            "lng": _mWebServiceinstance.getMapCaptionLongitude(),
                            "isFromMap": "true"
                        });
                } else {
                    console.debug("else  map coords are orifginAl form gps:- " + _mWebServiceinstance.getValueFor("currentLatitude", "25.271139") + "longitude: " + _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"))
                    //_mWebServiceinstance.setMapSinglePinForSelectedData(_mWebServiceinstance.getValueFor("currentLatitude", "25.271139"), _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"), _mWebServiceinstance.getMapCaptionText())
                    marr.push({
                            "title": "from map gps",
                            "lat": _mWebServiceinstance.getValueFor("currentLatitude", "25.271139"),
                            "lng": _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"),
                            "isFromMap": "true"
                        });
                        

                }
                mAllCheckedLatLngList = marr
                _mWebServiceinstance.setIsfromNearByDetails(true)
                dropPinForSelectedData()
                _mWebServiceinstance.setIsfromNearByDetails(false)
                for (var i = 0; i < mNavigationPaneNearBy.count(); i ++) {
                    mNavigationPaneNearBy.pop(mNavigationPaneNearBy.at(i))
                }
                mainTabPaned.changeTab(0);

            }
        }
        // LOAD MORE OPTION IF THERE IS MORE DATA IN THE RESULT
        MLoadMore {
            id: mLoadMoreUI
            mvaluelabel: mAllString.mshow_more
            //mvaluelabel: _mWebServiceinstance.mymodelNearBy.size()
            visible: _mWebServiceinstance.mymodelNearBy.size() > 10 ? true : false
            //visible: true
            onTouch: {
                if (event.isUp()) {
                    mListView.scrollToItem(_mWebServiceinstance.mnearByLastIndex)
                    _mWebServiceinstance.loadDatamore(_mWebServiceinstance.mnearByLastIndex)
                    if (_mWebServiceinstance.mnearByLastIndex == 0) {
                        mLoadMoreUI.visible = false
                    }
                }
            }
        }
        attachedObjects: [
            AllStrings {
                id: mAllString
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionHeader
                imageSource: "asset:///images/favourites/bg_select.png"
            },
            GroupDataModel {
                id: groupdata
                grouping: ItemGrouping.None
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionSearch
                imageSource: "asset:///images/favourites/bg_search.png"
            },
            Dialog {
                id: mDialogShare
                Share {
                    id: mDialogShareContent
                }
            },
            SystemDialog {
                id: mSystemDialog
            }
        ]
    }

}

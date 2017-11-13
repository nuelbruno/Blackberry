// ***********************************************************************************************************
//  MAIN LANDING SCREEN PAGE.
// THE MAP VIEW, SEARCH 
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.cascades.maps 1.0
import bb.cascades.pickers 1.0
import bb.system 1.2
import bb.platform 1.0
import "common"
NavigationPane {
    id: mNavigationPaneMain
    // VARIABLE DECLARATION
    property bool isOpen
    property Container mContainerTovisible: null
    property string mAdvanceSearchResult
    property string myUAENGValueAdvanceSearch
    property string myResult
    property string mAdvanceSearchText
    property string mPOILat
    property string mPOILng
    property bool isfromadvance_serach: false
    // ########### LANGUAGE CHANGE SETUP ###########################  //
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mcontainerTop.layout.orientation = LayoutOrientation.LeftToRight
            mButtonMyLocation.horizontalAlignment = HorizontalAlignment.Left
            mContainerAdvanceSearch.horizontalAlignment = HorizontalAlignment.Left
            mTextFieldAdvanceSearch.textStyle.textAlign = TextAlign.Left
            mButtonSearchIcon.horizontalAlignment = HorizontalAlignment.Left
            mButtonSearchCancel.horizontalAlignment = HorizontalAlignment.Right
            mListViewArabic.visible = false
            mListView.visible = true
        } else {
            mcontainerTop.layout.orientation = LayoutOrientation.RightToLeft
            mButtonMyLocation.horizontalAlignment = HorizontalAlignment.Right
            mContainerAdvanceSearch.horizontalAlignment = HorizontalAlignment.Right
            mTextFieldAdvanceSearch.textStyle.textAlign = TextAlign.Right
            mButtonSearchIcon.horizontalAlignment = HorizontalAlignment.Right
            mButtonSearchCancel.horizontalAlignment = HorizontalAlignment.Left
            mListView.visible = false
            mListViewArabic.visible = true;
        }
        mlocation.setAlignMent();
        mContainerMakani.setAlignMent();
        mContainerPlaceName.setAlignMent();
        mContainerUaeNag.setAlignMent();
        mContainerBuilding.setAlignMentBuilding();
        mContainerCategory.setAlignMent();
        mContainerparcel.setAlignMent()
        resetData();

    }
    // RESET DATA ON CHANGE OF LANGUAGE
    function resetData() {
        mTextFieldAdvanceSearch.text = "";
        mContainerMiddle.visible = false;
        mContainerBuilding.visible = false
        mContainerCategory.visible = false
        mContainerMakani.visible = false
        mContainerPlaceName.visible = false
        mContainerUaeNag.visible = false
        mListView.visible = false
        mListViewArabic.visible = false;
    }
    function clearOtherData() {
        mContainerMakani.mTextFieldSearch.text = ""
        mContainerUaeNag.mTextFieldSearch.text = ""
        mContainerPlaceName.mTextFieldSearch.text = ""
        mContainerparcel.mTextFieldSearchParcel.text = ""
        mContainerBuilding.mTextFieldCommunity.text = ""
        mContainerBuilding.mTextFieldStreetname.text = ""
        mContainerBuilding.mTextFieldBuilding.text = ""
        mContainerBuilding.mTextFieldCommunity.hintText = mAllStringObject.mCommunity
        mContainerBuilding.mTextFieldStreetname.hintText = mAllStringObject.mStreet
        mContainerBuilding.mTextFieldBuilding.hintText = mAllStringObject.mBuilding
        mContainerCategory.mTextFieldInSide.hintText = mAllStringObject.mSearchServices
        mContainerCategory.mTextFieldInSide.text = ""
        mContainerCategory.mTextFieldCategory.text = ""
        mContainerCategory.mTextFieldCategory.hintText = mAllStringObject.mSearchCategories
        mContainerCategory.mTextFieldPlace.text = ""
        mContainerCategory.mTextFieldPlace.hintText = mAllStringObject.mSearchPlace
    }
    // CHECK GPS CONNCETION STATUS
    function checkGPSOnOff() {
        if (! _mAppParentObj.checkGPS()) {
            mSystemDialog.body = mAllStringObject.mGpsLocationMessage
            mSystemDialog.show()
        }
    }
    function nodata() {
        // _mWebServiceinstance.noDataOnLongPress.disconnect(nodata)
        mSystemDialog.body = mAllStringObject.mValidationNoDataFound
        mSystemDialog.show()
    }
    // MAIN PAGE UI AND CONTAINER CODE STARTS
    Page {
        id: mPageMain
        property variant pageLocation
        // resizeBehavior: PageResizeBehavior.None
        onCreationCompleted: {
             mMapView.latitude = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
             mMapView.longitude = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            _mWebServiceinstance.ClearMapdata();
            _mWebServiceinstance.drawCurrentLocation();
        }
        Container {
            id: mcontainer
            onCreationCompleted: {
                //                if (! _mAppParentObj.checkGPS()) {
                //                    mSystemDialog.body = mAllStringObject.mGpsLocationMessage
                //                    mSystemDialog.show()
                //                }
                _mWebServiceinstance.getMyObject(mMapView);
                setAlignMent()
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: DockLayout {

            }
            LoadingDialog {
                id: mLoadingDialog
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                active: _mWebServiceinstance.active
            }
            // MAP IS ADDED
            MapView {
                id: mMapView
                objectName: "mMapView"
                visible: true
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                latitude: 25.2000
                longitude: 55.3000
                altitude: 3000
                onCaptionLabelTapped: {
                    if (_mWebServiceinstance.getMulitple() == "entrancepin" || _mWebServiceinstance.getMulitple() == "singlepin") {

                        mDialogLocationInfo.open()
                        mlocation.mTitle = _mWebServiceinstance.getMapCaptionText();
                    } else if (_mWebServiceinstance.getMulitple() == "fromuae") {
                        mDialogLocationInfo.open()
                    }

                }
                onMapLongPressed: {

                    if (_mAppParentObj.isNetworkAvailable()) {
                        // _mWebServiceinstance.noDataOnLongPress.connect(nodata)
                        //_mWebServiceinstance.longPressOnMap(coordinates);
                        console.debug("coordinates :", coordinates)
                        _mWebServiceinstance.getCoordinateConversionLongPress(coordinates)
                    } else {
                        mSystemDialog.body = mAllStringObject.mNetworkCheck
                        mSystemDialog.show()
                    }
                }
                onLocationTapped: {

                    _mWebServiceinstance.setFouceId(id)
                    console.debug("Tap on Location :", _mWebServiceinstance.getMulitple())
                    if (_mWebServiceinstance.getMulitple() == "multiple") {

                        var myResult = _mWebServiceinstance.checkInvalid(_mWebServiceinstance.getMapCaptionText().replace(" ", ""))
                        if (myResult == "number") {
                            console.debug("in makani mulitple number")

                            _mWebServiceinstance.GetBuildingInfo(_mWebServiceinstance.getMapCaptionText())
                        } else {
                            console.debug("in makani mulitple UAENG")
                            console.debug("in makani mulitple UAENG :", _mWebServiceinstance.getMapCaptionLatitude())
                            console.debug("in makani mulitple UAENG :", _mWebServiceinstance.getMapCaptionLongitude())
                            _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), true, true)

                        }
                    } else if (_mWebServiceinstance.getMulitple() == "redmultiple") {
                        // mDialogLocationInfo.open()
                        //   mlocation.mTitle = _mWebServiceinstance.getMapCaptionText();
                        _mWebServiceinstance.GetBuildingInfo(_mWebServiceinstance.getMapCaptionText())
                        //                        _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), true, true)
                    } else if (_mWebServiceinstance.getMulitple() == "routepin") {
                        var myResult = _mWebServiceinstance.checkInvalid(_mWebServiceinstance.getMapCaptionText().replace(" ", ""))

                        _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                        if (myResult == "number") {
                            _mWebServiceinstance.GetBuildingInfo(_mWebServiceinstance.getMapCaptionText())
                        } else {
                            _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), true, true)
                        }
                    }
                    //}
                }
                onCaptionButtonClicked: {
                    _mWebServiceinstance.setFouceId(focusedId)
                    routeInvoker.startLatitude = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                    routeInvoker.startLongitude = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                    routeInvoker.endLatitude = _mWebServiceinstance.getMapCaptionLatitude()
                    routeInvoker.endLongitude = _mWebServiceinstance.getMapCaptionLongitude()
                    routeInvoker.go();
                }
            }
            // SHOW CURRENT LOCATION ON CLICK OF THE BUTTON
            Container {
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Bottom
                bottomPadding: 50
                rightPadding: 50

                ImageButton {
                    id: mButtonMyLocation
                    defaultImageSource: "asset:///images/home/btn_current_location.png"
                    verticalAlignment: VerticalAlignment.Center
                    onClicked: {
                        mMapView.latitude = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                        mMapView.longitude = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                        _mWebServiceinstance.ClearMapdata();
                        _mWebServiceinstance.drawCurrentLocation();
                    }
                }
            }
            // ICON SEARCH AT THE TOP LEFT
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                //advance search top bar start
                Container {
                    id: mcontainerTop
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Top
                    rightPadding: 30
                    background: Color.White
                    leftPadding: 30
                    preferredHeight: 100
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    ImageButton {
                        id: mButtonCollapse
                        defaultImageSource: "asset:///images/advance%20search/icon_plus.png"
                        pressedImageSource: "asset:///images/advance%20search/icon_plus.png"
                        disabledImageSource: "asset:///images/advance%20search/icon_plus.png"

                        verticalAlignment: VerticalAlignment.Center
                        implicitLayoutAnimationsEnabled: false
                        onClicked: {
                            mContainerMiddle.visible = ! mContainerMiddle.visible
                            mListView.visible = false
                            mListViewArabic.visible = false
                            mTextFieldAdvanceSearch.text = "";
                        }
                    }
                    // ADVANCE SEARCH BACKGROUND IMAGE
                    Container {
                        layout: DockLayout {

                        }
                        id: mContainerSearch
                        background: mImagePaintDefinitionAdvanceSearchTextBG.imagePaint
                        leftPadding: 10
                        rightPadding: 10
                        verticalAlignment: VerticalAlignment.Center
                        //                        layoutProperties: StackLayoutProperties {
                        //                            spaceQuota: 0.70
                        //                        }
                        ImageButton {
                            id: mButtonSearchIcon
                            defaultImageSource: "asset:///images/home/icon_search.png"
                            pressedImageSource: "asset:///images/home/icon_search.png"
                            disabledImageSource: "asset:///images/home/icon_search.png"
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Left
                            enabled: false

                        }
                        // ADVACNED SEARCH IN MAIN PAGE
                        Container {
                            id: mAdvanceSearchContainer
                            leftPadding: 15
                            rightPadding: 15
                            TextField {
                                id: mTextFieldAdvanceSearch
                                backgroundVisible: false
                                clearButtonVisible: false
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Fill
                                hintText: mAllStringObject.mCommonSearch
                                textStyle.fontSize: FontSize.XXSmall
                                onTextChanging: {
                                    isfromadvance_serach = true
                                    if (_mAppParentObj.isNetworkAvailable()) {
                                        if (mTextFieldAdvanceSearch.text.length > 1) {
                                            mButtonSearchCancel.visible = true;
                                            mAdvanceSearchResult = _mWebServiceinstance.checkAdvanceSearchNumber(mTextFieldAdvanceSearch.text)
                                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                mListView.visible = true
                                                mListViewArabic.visible = false
                                            } else {
                                                mListViewArabic.visible = true
                                                mListView.visible = false
                                            }
                                            if (mAdvanceSearchResult == "charecter") {
                                                _mWebServiceinstance.SetPOISearch(false)
                                                _mWebServiceinstance.SetisPOITextChanging(false)
                                                _mWebServiceinstance.searchDataFilterPOI(mTextFieldAdvanceSearch.text, "")
                                            } else if (mAdvanceSearchResult == "number") {
                                                _mWebServiceinstance.searchDataFilter(mTextFieldAdvanceSearch.text, "")
                                            }
                                            mContainerMiddle.visible = false
                                        } else {
                                            mListView.visible = false
                                            mListViewArabic.visible = false
                                        }
                                    } else {
                                        mSystemDialog.body = mAllStringObject.mNetworkCheck
                                        mSystemDialog.show()
                                    }
                                }

                            }
                        }
                        // SEARCH CANCEL IMAGE
                        ImageButton {
                            id: mButtonSearchCancel
                            defaultImageSource: "asset:///images/home/icon_close.png"
                            verticalAlignment: VerticalAlignment.Center
                            //                            visible: false
                            pressedImageSource: "asset:///images/home/icon_close.png"
                            disabledImageSource: "asset:///images/home/icon_close.png"
                            horizontalAlignment: HorizontalAlignment.Right
                            onClicked: {
                                //                                mButtonSearchCancel.visible = false;
                                mTextFieldAdvanceSearch.text = "";
                            }
                        }
                    }
                    // CONTACT IMAGE BUTTON
                    ImageButton {
                        id: mButtonContact
                        defaultImageSource: "asset:///images/home/icon_contact.png"
                        verticalAlignment: VerticalAlignment.Center
                        onClicked: {
                            contactPicker.open();
                        }
                    }
                } //advance search top bar ends
                // AUTO SEARCH DROP DOWN OPTION
                ListView {
                    id: mListView
                    horizontalAlignment: HorizontalAlignment.Center
                    dataModel: _mWebServiceinstance.mymodel
                    preferredHeight: 350
                    preferredWidth: 600
                    visible: mTextFieldAdvanceSearch.text.toString().length > 0 ? true : false
                    function getmAdvanceSearchResult() {
                        return mAdvanceSearchResult
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                id: mContainerInsideList
                                background: Color.White
                                verticalAlignment: VerticalAlignment.Center
                                preferredWidth: 600
                                minHeight: 70
                                leftPadding: 10
                                rightPadding: 10
                                topPadding: 10
                                bottomPadding: 10
                                layout: DockLayout {
                                }
                                Label {
                                    id: mlabelPOI
                                    text: mContainerInsideList.ListItem.view.getmAdvanceSearchResult() == "number" ? ListItemData.Makani : ListItemData.NAME_E
                                    verticalAlignment: VerticalAlignment.Center
                                    multiline: true
                                }
                                Divider {
                                }
                            }

                        }
                    ]
                    onTriggered: {
                        var mdata = dataModel.data(indexPath);

                        if (_mAppParentObj.isNetworkAvailable()) {
                            _mWebServiceinstance.ClearMapdata();
                            if (mAdvanceSearchResult == "number") {
                                mTextFieldAdvanceSearch.text = mdata.Makani
                                console.debug("mdata.Makani" + mdata.Makani)
                                _mWebServiceinstance.GetBuildingInfo(mdata.Makani)
                                _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");

                            } else {
                                mTextFieldAdvanceSearch.text = mdata.NAME_E
                                _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(mdata.X_COORD, mdata.Y_COORD, true, false)
                                console.debug("mdata.X_COORD:" + mdata.X_COORD)
                                console.debug("data.Y_COORD:" + mdata.Y_COORD)
                                console.debug("mdata.NAME_E" + mdata.NAME_E)
                                console.debug("mdata.picture" + mdata.PICTURE)
                                _mWebServiceinstance.setpicturefromqml(mdata.PICTURE)
                                _mWebServiceinstance.setPoiInfoData(mdata.NAME_E, mdata.TEL_NO, mdata.FAX_NO, mdata.EMAIL, mdata.LICENSE_NO, mdata.URL, mdata.POBOX)

                                mPOILat = mdata.X_COORD
                                mPOILng = mdata.Y_COORD
                                mAdvanceSearchText = mdata.NAME_E

                            }
                            mListView.visible = false
                        } else {
                            mSystemDialog.body = mAllStringObject.mNetworkCheck
                            mSystemDialog.show()
                        }
                    }
                }
                ListView {
                    id: mListViewArabic
                    horizontalAlignment: HorizontalAlignment.Center
                    dataModel: _mWebServiceinstance.mymodel
                    preferredHeight: 350
                    preferredWidth: 600
                    visible: mTextFieldAdvanceSearch.text.toString().length > 0 ? true : false
                    function getmAdvanceSearchResult() {
                        return mAdvanceSearchResult
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            Container {
                                id: mContainerInsideListArabic
                                background: Color.White
                                verticalAlignment: VerticalAlignment.Center
                                preferredWidth: 600
                                minHeight: 70
                                rightPadding: 10
                                leftPadding: 10
                                topPadding: 10
                                bottomPadding: 10
                                layout: DockLayout {

                                }
                                Label {
                                    id: mlabelPOIArabic
                                    text: mContainerInsideListArabic.ListItem.view.getmAdvanceSearchResult() == "number" ? ListItemData.Makani : ListItemData.NAME_A
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Right
                                    multiline: true
                                }
                                Divider {
                                }
                            }

                        }
                    ]
                    onTriggered: {
                        var mdata = dataModel.data(indexPath);
                        if (_mAppParentObj.isNetworkAvailable()) {
                            _mWebServiceinstance.ClearMapdata();
                            if (mAdvanceSearchResult == "number") {
                                mTextFieldAdvanceSearch.text = mdata.Makani
                                console.debug("mdata.Makani" + mdata.Makani)
                                _mWebServiceinstance.GetBuildingInfo(mdata.Makani)
                                _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");

                            } else {
                                mTextFieldAdvanceSearch.text = mdata.NAME_A
                                _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(mdata.X_COORD, mdata.Y_COORD, true, false)
                                _mWebServiceinstance.setpicturefromqml(mdata.PICTURE)
                                _mWebServiceinstance.setPoiInfoData(mdata.NAME_A, mdata.TEL_NO, mdata.FAX_NO, mdata.EMAIL, mdata.LICENSE_NO, mdata.URL, mdata.POBOX)
                                console.debug("mdata.NAME_E" + mdata.NAME_A)
                                mPOILat = mdata.X_COORD
                                mPOILng = mdata.Y_COORD
                                mAdvanceSearchText = mdata.NAME_A
                            }
                            mListViewArabic.visible = false
                        } else {
                            mSystemDialog.body = mAllStringObject.mNetworkCheck
                            mSystemDialog.show()
                        }
                    }
                }
                // ICON PLUS DROP DOWN SEARCH
                Container {
                    leftPadding: 30
                    rightPadding: 30
                    layout: DockLayout {
                    }
                    implicitLayoutAnimationsEnabled: false
                    id: mContainerAdvanceSearch
                    horizontalAlignment: HorizontalAlignment.Left
                    Container {
                        id: mContainerMiddle
                        leftPadding: 20
                        rightPadding: 20
                        bottomPadding: 20
                        topPadding: 20

                        background: mImagePaintDefinitionAdvanceSearchBG.imagePaint
                        visible: false
                        preferredWidth: 650
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        onVisibleChanged: {
                            if (visible) {
                                mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_minus.png"
                                mButtonCollapse.verticalAlignment = VerticalAlignment.Bottom
                            } else {
                                mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                mButtonCollapse.verticalAlignment = VerticalAlignment.Center
                            }
                        }
                        ScrollView {
                            id: mScrollView
                            Container {
                                leftPadding: 20
                                rightPadding: 20
                                // topPadding: 10
                                // SEARCH BY MAKANI NUMBER
                                CommonButtonWithLabel {
                                    mLableText: mAllStringObject.mSearchByMakaniNo
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mPageMain.closeContainer("mContainerMakani", mContainerMakani.visible = ! mContainerMakani.visible)
                                        mContainerMakani.mTextFieldSearch.text = ""
                                        //   mContainerMakani.mTextFieldSearch.hintText = ""
                                        _mWebServiceinstance.mymodel.clear()
                                    }
                                }
                                Searchbymakani {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerMakani
                                    onTouch: {
                                    }
                                    onSearchclick: {
                                        mMapView.visible = true
                                        mContainerMiddle.visible = false
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                    }
                                }
                                // SEARCH BY UAE NG 
                                CommonButtonWithLabel {
                                    topMargin: 15
                                    mLableText: mAllStringObject.mSearchByUAENAG
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mPageMain.closeContainer("mContainerUaeNag", mContainerUaeNag.visible = ! mContainerUaeNag.visible)
                                        mContainerUaeNag.mTextFieldSearch.text = ""
                                    }
                                }
                                SearchbyUAENG {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerUaeNag
                                    onSearchclick: {
                                        mMapView.visible = true
                                        mContainerMiddle.visible = false
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                        /* if (_mWebServiceinstance.ConvertToUAENG(mTextFieldSearch.text) != "") {
                                         * _mWebServiceinstance.UAENGtoCoordinates(myUAENGValue, "", "Map")
                                         * mMapView.visible = true
                                         * mContainerMiddle.visible = false
                                         * 
                                         }*/

                                    }
                                }
                                // SEARCH BY POI , PLACE NAME
                                CommonButtonWithLabel {
                                    topMargin: 15
                                    mLableText: mAllStringObject.mSearchByPlaceName
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mContainerPlaceName.mTextFieldSearch.text = ""
                                        //  mContainerPlaceName.mTextFieldSearch.hintText = ""
                                        mPageMain.closeContainer("mContainerPlaceName", mContainerPlaceName.visible = ! mContainerPlaceName.visible)
                                        _mWebServiceinstance.mymodel.clear()
                                    }
                                }

                                SearchPOI {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerPlaceName
                                    onSearchonmapclick: {
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                        mMapView.visible = true
                                        mContainerMiddle.visible = false
                                    }
                                }
                                // SERACH BY LAND
                                CommonButtonWithLabel {
                                    topMargin: 15
                                    mLableText: mAllStringObject.mserachbyland
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mPageMain.closeContainer("mContainerparcel", mContainerparcel.visible = ! mContainerparcel.visible)
                                    }
                                }
                                Searchbyland {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerparcel
                                    visible: false
                                    onSearchClick: {
                                        mMapView.visible = true
                                        mContainerMiddle.visible = false
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"

                                    }
                                }
                                // SEARCH BY BUDILING NO
                                CommonButtonWithLabel {
                                    topMargin: 15
                                    mLableText: mAllStringObject.mSearchByBuildingAddress
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mContainerBuilding.mTextFieldBuilding.text = ""
                                        mContainerBuilding.mTextFieldCommunity.text = ""
                                        mContainerBuilding.mTextFieldStreetname.text = ""
                                        _mWebServiceinstance.mymodelcommunity.clear()
                                        _mWebServiceinstance.mymodelBuiding.clear()
                                        _mWebServiceinstance.mymodelStreet.clear()
                                        mPageMain.closeContainer("mContainerBuilding", mContainerBuilding.visible = ! mContainerBuilding.visible)
                                        if (_mAppParentObj.isNetworkAvailable()) {
                                            if (mContainerBuilding.visible == true) {
                                                _mWebServiceinstance.GetAllCommunities("E");
                                            }
                                        } else {
                                            mSystemDialog.body = mAllStringObject.mNetworkCheck
                                            mSystemDialog.show()
                                        }
                                    }
                                }

                                SearchbyBuilding {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerBuilding
                                    isFromSearch: true
                                    onSearchonmapclick: {
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                        mMapView.visible = true
                                        mContainerMiddle.visible = false
                                    }
                                }
                                //SEARH BY CATEGORY
                                CommonButtonWithLabel {
                                    topMargin: 15
                                    mLableText: mAllStringObject.mSearchByCategories
                                    mBackgroundSource: "asset:///images/search_option/bg_contain_white.png"
                                    mWidth: 600
                                    mTextColor: Color.create("#004A65")
                                    onMyClick: {
                                        mPageMain.closeContainer("mContainerCategory", mContainerCategory.visible = ! mContainerCategory.visible)
                                        mContainerCategory.mTextFieldCategory.text = ""
                                        mContainerCategory.mTextFieldPlace.text = ""

                                        mContainerCategory.visible == true ? mContainerCategory.mlabelInSide.text = mAllStringObject.mSearchServices : mContainerCategory.mlabelInSide.text = ""
                                        if (_mAppParentObj.isNetworkAvailable()) {
                                            if (mContainerCategory.visible == true) {
                                                _mWebServiceinstance.GetAllServices("GetAllServicesSearch");
                                            } else {

                                            }
                                        } else {
                                            mSystemDialog.body = mAllStringObject.mNetworkCheck
                                            mSystemDialog.show()
                                        }
                                    }
                                }

                                SearchCategory {
                                    topPadding: 10
                                    bottomPadding: 10
                                    id: mContainerCategory
                                    isFromDirection: false
                                    onClickdone: {
                                        mButtonCollapse.defaultImageSource = "asset:///images/advance%20search/icon_plus.png"
                                        mContainerMiddle.visible = false;
                                    }
                                }
                            }
                        }
                    }
                }

            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Fill
                preferredHeight: 125
                background: Color.DarkBlue
                visible: false
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllStringObject.mHome
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllStringObject.mDirections
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClicked: {
                        var page = mDirections.createObject()
                        mNavigationPaneMain.push(page)
                    }
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllStringObject.mFavourites
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClicked: {
                        var page = mFavourite.createObject()
                        mNavigationPaneMain.push(page)
                    }
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllStringObject.mNeraby
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClicked: {
                        var page = mNearBy.createObject()
                        page.mLatitude = _mWebServiceinstance.getValueFor("currentLatitude", "0.0");
                        page.mLongitude = _mWebServiceinstance.getValueFor("CurrentLongitude", "0.0");
                        mNavigationPaneMain.push(page)
                    }
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: mAllStringObject.mMore
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onClicked: {
                        var page = mMore.createObject()
                        mNavigationPaneMain.push(page)

                    }
                }
            }
        }
        // SHOWING  UI BASED ON SEARCH OPTION CHOOSEN FUCNION
        function closeContainer(mycontainer, isOpen) {

            if (mycontainer == "mContainerMakani") {
                mContainerBuilding.visible = false
                mContainerCategory.visible = false
                mContainerMakani.visible = isOpen
                mContainerPlaceName.visible = false
                mContainerUaeNag.visible = false
                mContainerparcel.visible = false
            }

            if (mycontainer == "mContainerBuilding") {
                mContainerBuilding.visible = isOpen
                mContainerCategory.visible = false
                mContainerMakani.visible = false
                mContainerPlaceName.visible = false
                mContainerUaeNag.visible = false
                mContainerparcel.visible = false
            }

            if (mycontainer == "mContainerCategory") {
                mContainerBuilding.visible = false
                mContainerCategory.visible = isOpen
                mContainerMakani.visible = false
                mContainerPlaceName.visible = false
                mContainerUaeNag.visible = false
                mContainerparcel.visible = false
            }
            if (mycontainer == "mContainerPlaceName") {
                mContainerBuilding.visible = false
                mContainerCategory.visible = false
                mContainerMakani.visible = false
                mContainerPlaceName.visible = isOpen
                mContainerUaeNag.visible = false
                mContainerparcel.visible = false
            }
            if (mycontainer == "mContainerUaeNag") {
                mContainerBuilding.visible = false
                mContainerCategory.visible = false
                mContainerMakani.visible = false
                mContainerPlaceName.visible = false
                mContainerUaeNag.visible = isOpen
                mContainerparcel.visible = false
            }
            if (mycontainer == "mContainerparcel") {
                mContainerBuilding.visible = false
                mContainerCategory.visible = false
                mContainerMakani.visible = false
                mContainerPlaceName.visible = false
                mContainerUaeNag.visible = false
                mContainerparcel.visible = isOpen
            }
        }

        attachedObjects: [

            AllStrings {
                id: mAllStringObject
            },
            SystemDialog {
                id: mSystemDialog
                title: undefined
                cancelButton.label: undefined
                confirmButton.label: mAllStringObject.mDialogOk
            },
            ComponentDefinition {
                id: mNearBy

                source: "NearByServices.qml"
            },

            ComponentDefinition {
                id: mMore
                source: "More.qml"

            },
            Dialog {
                id: mDialogLocationInfo

                LocationInfo {
                    id: mlocation
                }
            },
            ComponentDefinition {
                id: mLocationInfo
                source: "LocationInfo.qml"
            },
            ComponentDefinition {
                id: mFavourite
                source: "MyFavourites.qml"
            },
            ComponentDefinition {
                id: mDirections
                source: "Directions.qml"
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionTopBG
                imageSource: "asset:///images/home/search_mean_bg.png"
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionAdvanceSearchBG
                imageSource: "asset:///images/advance%20search/bg_main.png"
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionAdvanceSearchTextBG
                imageSource: "asset:///images/home/bg_search.png"
            },
            ContactPicker {
                id: contactPicker
                onContactSelected: {
                    mContainerMiddle.visible = false
                    mListView.visible = false
                    mListViewArabic.visible = false
                    mTextFieldAdvanceSearch.text = "";
                    _mWebServiceinstance.getcontactNumberFromAdvanceSearch(contactId)
                }
            },
            SystemToast {
                id: myQmlToast
                body: mAllStringObject.mqmlToast
                onFinished: {
                }
            },
            RouteMapInvoker {
                id: routeInvoker
            }
        ]
    }
    keyListeners: [
        KeyListener {
            onKeyEvent: {

                if (event.key == "13") {

                    if (event.pressed) {
                        //check for null,empty
                        if (_mAppParentObj.isNetworkAvailable()) {
                            if (mTextFieldAdvanceSearch.text.length > 0) {

                                _mWebServiceinstance.ClearMapdata();
                                _mWebServiceinstance.setcheckisFromAdvanceSearch(true)
                                myResult = _mWebServiceinstance.CommonSearchvalidation(mTextFieldAdvanceSearch.text.replace(" ", ""))

                                if (myResult == "number") {
                                    _mWebServiceinstance.GetBuildingInfo(mTextFieldAdvanceSearch.text)
                                    _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");

                                } else if (myResult == "text") {
                                    console.debug("in text")
                                    if (mAdvanceSearchText == mTextFieldAdvanceSearch.text) {
                                        //  _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(mPOILat, mPOILng, true)

                                    } else {
                                        _mWebServiceinstance.SetPOISearch(true)
                                        _mWebServiceinstance.GetPOIInfo(mTextFieldAdvanceSearch.text, "E", false, "searchOnMap")
                                        //console.debug("GetPOIInfo:"+mTextFieldAdvanceSearch.text)
                                        _mWebServiceinstance.setcheckisFromAdvanceSearch(false)
                                        _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                                    }
                                    //call POI
                                } else if (myResult == "UAENG") {
                                    //call UAENG
                                    var myUAENGValue;
                                    myUAENGValue = _mWebServiceinstance.ConvertToUAENG(mTextFieldAdvanceSearch.text)
                                    if (myUAENGValue == "") {
                                        mSystemDialog.body = mAllStringObject.mValidationtrywithanotherinput
                                        mSystemDialog.show()
                                        mTextFieldAdvanceSearch.text = ""
                                    } else {
                                        mTextFieldAdvanceSearch.text = myUAENGValue
                                        _mWebServiceinstance.UAENGtoCoordinates(myUAENGValue, "", "Map")
                                    }
                                    _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                                } else if (myResult == "notvalid") {
                                    mSystemDialog.body = mAllStringObject.mValidationValidaMakaniValue
                                    mSystemDialog.show()
                                } else if (myResult == "") {
                                    mSystemDialog.body = mAllStringObject.mValidationtrywithanotherinput
                                    mSystemDialog.show()

                                } else {
                                    mSystemDialog.body = mAllStringObject.mValidationtrywithanotherinput
                                    mSystemDialog.show()

                                }

                            } else {
                                mSystemDialog.body = mAllStringObject.mValidationInputValue
                                mSystemDialog.show()

                            }
                        } else {
                            mSystemDialog.body = mAllStringObject.mNetworkCheck
                            mSystemDialog.show()

                        }
                    }
                } //enter pressed end
            } //onkeyevent ends
        } //keylistener ends
    ]
}
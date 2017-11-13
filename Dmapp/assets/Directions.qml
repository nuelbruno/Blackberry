// ***********************************************************************************************************
//  ADD TO FAVOURITE PAGE
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
import bb.system 1.2
import bb.cascades.pickers 1.0
import bb.DatabaseConnectionApi.data 1.0

Page {
    // VARIABLE DECLARATON
    property string myUAENGValue
    property string myUAENGValueTo
    property string myUAENGValueVia

    property string mRouteSteps
    property string mRouteStepsvia

    property string strTextFromMakani
    property string strTextFromMakaniTo
    property string strTextFromMakaniFrom

    property string strTextfromtemp
    property string strTexttotemp
    property string strTextviatemp

    property string strTextFromLat
    property string strTextFromLng
    property string strTextToLat
    property string strTextToLng

    property bool isFrom: true
    property bool isDirectionOnMap: false
    property string isFromforDialog

    property bool isFromBuilding

    property string mdataFrom
    property string mdataTo
    property string mdataVia

    property string mdataFav
    property string mdataFavTo
    property string mdataFavVia

    property string checkTagDropDownFrom
    property string checkTagDropDownTo
    property string checkTagDropDownVia

    property string isContactFrom
    property bool isPOIFrom
    property bool isReverseGeoCodeFromMap: false

    property string isTextfromList
    property string isTextToList
    property string isTextViaList

    property string mCaptionData
    property string isfromcattemp

    property bool setValueFromOrTo
    property bool isChangeClicked
    property bool isChangeClicked2

    property string mtempFavFrom
    property string mtempFavTo
    property string mtempFavia
    property string myFromDatatemp
    property string myToDatatemp
    property string fromText
    property string toText

    property string strTextViaFromLat
    property string strTextViaToLng

    property bool isfromvia: false
    // DIRECTION FINDING FUNCTION
    function receiveValue(passedBackValue, isfromhere) {
        mCaptionData = passedBackValue
        if (isfromhere) {
            //if came from directionFrom
            mTextFieldFrom.enabled = true
            mTextFieldTo.enabled = true

            //From data set
            if (_mWebServiceinstance.checkInvalid(mCaptionData.replace(" ", "")) == "number") {
                checkTagDropDownFrom = mAllStrings.mDropDownMakaniNumber
                mLabelSelectFrom.text = mAllStrings.mDropDownMakaniNumber
            } else if (_mWebServiceinstance.validateString(mCaptionData.replace(" ", "")) == "UAENG") {
                checkTagDropDownFrom = mAllStrings.mDropDownUAENG
                mLabelSelectFrom.text = mAllStrings.mDropDownUAENG
            }
            mTextFieldFrom.text = mCaptionData

            //To data set
            checkTagDropDownTo = mAllStrings.mDropDownMyLocation
            mLabelSelectTo.text = mAllStrings.mDropDownMyLocation
            strTextToLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
            strTextToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            mTextFieldTo.text = strTextToLat + "," + strTextToLng

            mListViewFrom.visible = false

            if (_mAppParentObj.isNetworkAvailable()) {
                isDirectionOnMap = false
                isReverseGeoCodeFromMap = true;
                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressTo)
                _mWebServiceinstance.reverseGeoCode();
            } else {
                mSystemDialog.body = mAllStrings.mNetworkCheck
                mSystemDialog.show()
            }
        } else {
            //if came from directionTo
            mTextFieldFrom.enabled = true
            mTextFieldTo.enabled = true

            //To data set
            if (_mWebServiceinstance.checkInvalid(mCaptionData.replace(" ", "")) == "number") {
                checkTagDropDownTo = mAllStrings.mDropDownMakaniNumber
                mLabelSelectTo.text = mAllStrings.mDropDownMakaniNumber
            } else if (_mWebServiceinstance.validateString(mCaptionData.replace(" ", "")) == "UAENG") {
                checkTagDropDownTo = mAllStrings.mDropDownUAENG
                mLabelSelectTo.text = mAllStrings.mDropDownUAENG
            }
            mTextFieldTo.text = mCaptionData

            //From data set
            checkTagDropDownFrom = mAllStrings.mDropDownMyLocation
            mLabelSelectFrom.text = mAllStrings.mDropDownMyLocation
            strTextFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
            strTextFromLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            mTextFieldFrom.text = strTextFromLat + "," + strTextFromLng

            mListViewTo.visible = false

            if (_mAppParentObj.isNetworkAvailable()) {
                isDirectionOnMap = false
                isReverseGeoCodeFromMap = true;
                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressFrom)
                _mWebServiceinstance.reverseGeoCode();

            } else {
                mSystemDialog.body = mAllStrings.mNetworkCheck
                mSystemDialog.show()
            }
        }

    }
    // LANGUAGE TRANSLATION ALIGNEMNT SETUP
    function setAlignment() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mTextFieldFrom.textStyle.textAlign = TextAlign.Left
            mTextFieldTo.textStyle.textAlign = TextAlign.Left
            mTextFieldVia.textStyle.textAlign = TextAlign.Left
            mcontainerleft.horizontalAlignment = HorizontalAlignment.Left
            mcontainerright.horizontalAlignment = HorizontalAlignment.Right
            mcontainerSearchLayoutFrom.layout.orientation = LayoutOrientation.LeftToRight
            mcontainerSearchLayoutTo.layout.orientation = LayoutOrientation.LeftToRight
            mContainerThreeButton.layout.orientation = LayoutOrientation.LeftToRight
            mcontainerDirectionsLabel.horizontalAlignment = HorizontalAlignment.Left
            mcontainerDirectionminusicon.horizontalAlignment = HorizontalAlignment.Right
            mlabelsteps.horizontalAlignment = HorizontalAlignment.Left
            mLabelRouteData.horizontalAlignment = HorizontalAlignment.Left
            mcontainerbelowTop.layout.orientation = LayoutOrientation.LeftToRight
            mStyleForLabel.textAlign = TextAlign.Left
            mListViewFromArabic.visible = false
            mListViewToArabic.visible = false
            mListViewFrom.horizontalAlignment = HorizontalAlignment.Left
            mListViewTo.horizontalAlignment = HorizontalAlignment.Left
            mListViewvia.horizontalAlignment = HorizontalAlignment.Left
            mListViewArabicvia.horizontalAlignment = HorizontalAlignment.Left
            mListViewFromArabic.horizontalAlignment = HorizontalAlignment.Left
            mListViewToArabic.horizontalAlignment = HorizontalAlignment.Left
            mContainerStpesFrom.layout.orientation = LayoutOrientation.LeftToRight
            mContainerStpesTo.layout.orientation = LayoutOrientation.LeftToRight
            mContainerStpesDuration.layout.orientation = LayoutOrientation.LeftToRight
            mContainerStpesLength.layout.orientation = LayoutOrientation.LeftToRight
            mContainerLabelSelectFrom.horizontalAlignment = HorizontalAlignment.Left
            mContainerLabelSelectTo.horizontalAlignment = HorizontalAlignment.Left
            mcontainerFromListview.horizontalAlignment = HorizontalAlignment.Left
            mContainerVia.layout.orientation = LayoutOrientation.LeftToRight
            // mcontainerFromListviewvia.horizontalAlignment = HorizontalAlignment.Left
            mcontainerlabelvia.horizontalAlignment = HorizontalAlignment.Left
            mButtonSearchIconcatFrom.horizontalAlignment = HorizontalAlignment.Right
            mButtonSearchIconcatTo.horizontalAlignment = HorizontalAlignment.Right
            mbuttonminusiconvia.horizontalAlignment = HorizontalAlignment.Right

            mContainerDest1Arrow.horizontalAlignment = HorizontalAlignment.Left
            mContainerDest2Arrow.horizontalAlignment = HorizontalAlignment.Left
            mLabelDestination1.textStyle.textAlign = TextAlign.Left
            mLabelDestination2.textStyle.textAlign = TextAlign.Left
            mlabelRouteOptions.textStyle.textAlign = TextAlign.Left
            mLabelAvoidToll.textStyle.textAlign = TextAlign.Left
            mLabelAvoidHighway.textStyle.textAlign = TextAlign.Left
            mContainerAvoidTollhighway.layout.orientation = LayoutOrientation.LeftToRight
            mContainerRouteOptions.horizontalAlignment = HorizontalAlignment.Left
            mContainerRouteOptions.leftPadding = ui.du(1)
            mContainerwithplus.layout.orientation = LayoutOrientation.LeftToRight

            mContainerwithminusviastack.layout.orientation = LayoutOrientation.LeftToRight
            mContainerAddDestination.layout.orientation = LayoutOrientation.LeftToRight

            mContainerAddDestination.horizontalAlignment = HorizontalAlignment.Left
        } else {
            mTextFieldFrom.textStyle.textAlign = TextAlign.Right
            mTextFieldTo.textStyle.textAlign = TextAlign.Right
            mTextFieldVia.textStyle.textAlign = TextAlign.Right
            mcontainerleft.horizontalAlignment = HorizontalAlignment.Right
            mcontainerright.horizontalAlignment = HorizontalAlignment.Left
            mcontainerSearchLayoutFrom.layout.orientation = LayoutOrientation.RightToLeft
            mcontainerSearchLayoutTo.layout.orientation = LayoutOrientation.RightToLeft
            mContainerThreeButton.layout.orientation = LayoutOrientation.RightToLeft
            mcontainerDirectionsLabel.horizontalAlignment = HorizontalAlignment.Right
            mcontainerDirectionminusicon.horizontalAlignment = HorizontalAlignment.Left
            mlabelsteps.horizontalAlignment = HorizontalAlignment.Right
            mLabelRouteData.horizontalAlignment = HorizontalAlignment.Right
            mcontainerbelowTop.layout.orientation = LayoutOrientation.RightToLeft
            mStyleForLabel.textAlign = TextAlign.Right
            mListViewTo.visible = false
            mListViewFrom.visible = false
            mListViewFromArabic.horizontalAlignment = HorizontalAlignment.Right
            mListViewToArabic.horizontalAlignment = HorizontalAlignment.Right
            mcontainerFromListview.horizontalAlignment = HorizontalAlignment.Right
            mContainerStpesFrom.layout.orientation = LayoutOrientation.RightToLeft
            mContainerStpesTo.layout.orientation = LayoutOrientation.RightToLeft
            mContainerStpesDuration.layout.orientation = LayoutOrientation.RightToLeft
            mContainerStpesLength.layout.orientation = LayoutOrientation.RightToLeft
            mContainerLabelSelectFrom.horizontalAlignment = HorizontalAlignment.Right
            mContainerLabelSelectTo.horizontalAlignment = HorizontalAlignment.Right
            mContainerVia.layout.orientation = LayoutOrientation.RightToLeft
            //mcontainerFromListviewvia.horizontalAlignment = HorizontalAlignment.Right
            mcontainerlabelvia.horizontalAlignment = HorizontalAlignment.Right
            mButtonSearchIconcatFrom.horizontalAlignment = HorizontalAlignment.Left
            mButtonSearchIconcatTo.horizontalAlignment = HorizontalAlignment.Left
            mbuttonminusiconvia.horizontalAlignment = HorizontalAlignment.Left
            mListViewvia.horizontalAlignment = HorizontalAlignment.Right
            mListViewArabicvia.horizontalAlignment = HorizontalAlignment.Right

            mContainerDest1Arrow.horizontalAlignment = HorizontalAlignment.Right
            mContainerDest2Arrow.horizontalAlignment = HorizontalAlignment.Right
            mLabelDestination1.textStyle.textAlign = TextAlign.Right
            mLabelDestination2.textStyle.textAlign = TextAlign.Right
            mlabelRouteOptions.textStyle.textAlign = TextAlign.Right
            mLabelAvoidToll.textStyle.textAlign = TextAlign.Right
            mLabelAvoidHighway.textStyle.textAlign = TextAlign.Right
            mContainerAvoidTollhighway.layout.orientation = LayoutOrientation.RightToLeft
            mContainerRouteOptions.horizontalAlignment = HorizontalAlignment.Right
            mContainerRouteOptions.rightPadding = ui.du(1)
            mContainerwithplus.layout.orientation = LayoutOrientation.RightToLeft
            mContainerwithminusviastack.layout.orientation = LayoutOrientation.RightToLeft
            mContainerAddDestination.layout.orientation = LayoutOrientation.RightToLeft
            mContainerAddDestination.horizontalAlignment = HorizontalAlignment.Right
        }
        mDialogContentSearchByBuilding.setAlignMentBuilding();

        loadDataForDropdown();
    }
    // ONLANGUAGE CHANGE RESET DATA
    function resetData() {

        mContainerDirectionExpandable.visible = false

        mLabelSelectFrom.text = mAllStrings.mDropDownSelectFrom
        mLabelSelectTo.text = mAllStrings.mSelectDestination
        mLabelVia.text = mAllStrings.mSelectDestination

        mImageViewCarBottomBar.visible = true
        mImageViewBusBottombar.visible = false
        mImageViewWalkBottombar.visible = false

        mTextFieldFrom.enabled = false
        mTextFieldTo.enabled = false
        mTextFieldVia.enabled = false

        mTextFieldFrom.text = ""
        mTextFieldTo.text = ""
        mTextFieldVia.text = ""

        checkTagDropDownFrom = "";
        checkTagDropDownTo = "";
        checkTagDropDownVia = ""

        mCheckBoxAvoidHighway.checked = false
        mCheckBoxAvoidTollSalik.checked = false

        clearMyRouteData()
        setAlignment()
    }
    // DATAT TO SHOW IN FROM 
    function loadDataForDropdown() {
        mModelSelectFrom.clear();
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mMapSelectedLocation

            });

        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mserachbyland
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownSelectFromContacts
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownSelectFromFaviourites
            });

        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownBuildingAddress
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownPlaceName
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownUAENG
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownMakaniNumber
            });
        mModelSelectFrom.insert({
                "my_selectFromData": mAllStrings.mDropDownMyLocation
            });
    }

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {

        }
        onCreationCompleted: {
            //Coordinates
            _mWebServiceinstance.directionServiceDataLoaded.connect(myDirectionData)

            //getPoiInfo
            _mWebServiceinstance.poidataloaded.connect(getpoidata)

            //callGoogleRoutes
            _mWebServiceinstance.routeDataLoaded.connect(setMyRoutedata)

            _mWebServiceinstance.catdataload.connect(callCat)

            _mWebServiceinstance.buildingDataLoaded.connect(getbuildingaddressData)

            strTextFromLat = ""
            strTextFromLng = ""
            strTextToLat = ""
            strTextToLng = ""
            strTextViaFromLat = ""
            strTextViaToLng = ""
            mContainerDirectionExpandable.visible = false
            /* mContainerVia.visible = false
             mContainerDest1Arrow.visible = false*/
            mImageViewPlusMinus.imageSource = "asset:///images/directions/plus_icon.png"
            setAlignment()

        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            Container {
                topPadding: 25
                bottomPadding: 25
                horizontalAlignment: HorizontalAlignment.Fill
                property alias mText: mLabelTitle.text
                layout: DockLayout {
                }
                Label {
                    id: mLabelTitle
                    text: mAllStrings.mDirectionsTitle
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.fontSizeValue: FontSize.Large
                    textStyle.color: Color.create("#004A65")
                }
            } //top bar ends
            // CAR BUS WALK TABS
            Container {
                id: mcontainerbelowTop
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                preferredHeight: 100
                background: mImagePaintDefinitionTab.imagePaint
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }

                Container {
                    id: mContainerCar
                    verticalAlignment: VerticalAlignment.Fill
                    layout: DockLayout {

                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.7
                    }

                    ImageView {
                        topMargin: 20
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        imageSource: "asset:///images/directions/car.png"
                    }
                    ImageView {
                        id: mImageViewCarBottomBar
                        visible: true
                        verticalAlignment: VerticalAlignment.Bottom
                        imageSource: "asset:///images/directions/tab_hover.png"
                    }

                    ImageView {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                        imageSource: "asset:///images/directions/seprater.png"
                    }
                    onTouch: {
                        if (event.touchType == TouchType.Up) {
                            mImageViewBusBottombar.visible = false
                            mImageViewWalkBottombar.visible = false
                            mImageViewCarBottomBar.visible = true
                            if (strTextFromLat != "" && strTextFromLng != "" && strTextToLat != "" && strTextToLng != "") {
                                callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                            }
                        }
                    }
                } //for car

                Container {
                    id: mContainerBus
                    verticalAlignment: VerticalAlignment.Fill
                    layout: DockLayout {

                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.7
                    }

                    ImageView {
                        topMargin: 20
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.4
                        }
                        imageSource: "asset:///images/directions/bus.png"
                    }
                    ImageView {
                        id: mImageViewBusBottombar
                        visible: false
                        verticalAlignment: VerticalAlignment.Bottom
                        imageSource: "asset:///images/directions/tab_hover.png"
                    }

                    ImageView {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                        imageSource: "asset:///images/directions/seprater.png"
                    }
                    onTouch: {
                        if (event.touchType == TouchType.Up) {
                            mImageViewBusBottombar.visible = true
                            mImageViewWalkBottombar.visible = false
                            mImageViewCarBottomBar.visible = false
                            if (strTextFromLat != "" && strTextFromLng != "" && strTextToLat != "" && strTextToLng != "") {
                                callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                            }
                        }
                    }
                } //for bus
                Container {
                    id: mContainerWalk
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.7
                    }
                    verticalAlignment: VerticalAlignment.Fill
                    layout: DockLayout {
                    }
                    ImageView {
                        topMargin: 20
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        imageSource: "asset:///images/directions/walk.png"
                    }
                    ImageView {
                        id: mImageViewWalkBottombar
                        visible: false
                        verticalAlignment: VerticalAlignment.Bottom
                        imageSource: "asset:///images/directions/tab_hover.png"
                    }
                    onTouch: {
                        if (event.touchType == TouchType.Up) {
                            mImageViewBusBottombar.visible = false
                            mImageViewCarBottomBar.visible = false
                            mImageViewWalkBottombar.visible = true
                            if (strTextFromLat != "" && strTextFromLng != "" && strTextToLat != "" && strTextToLng != "") {
                                callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                            }
                        }
                    }
                } //for walk
            } //directions 3  tab ends
            ScrollView {
                id: mScrollView
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    leftPadding: 20
                    rightPadding: 20
                    topPadding: 30
                    horizontalAlignment: HorizontalAlignment.Fill
                    Container {
                        preferredHeight: 100
                        topMargin: 20
                        horizontalAlignment: HorizontalAlignment.Fill
                        background: mImagePaintDefinitionDirectionsExpand.imagePaint
                        layout: DockLayout {

                        }
                        Container {
                            id: mcontainerleft
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: 20
                            rightPadding: 20
                            layout: DockLayout {
                            }
                            Label {
                                text: mAllStrings.mSearch
                                textStyle.fontSize: FontSize.Large
                                textStyle.color: Color.White
                            }
                        }
                        Container {
                            id: mcontainerright
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: 30
                            rightPadding: 30
                            layout: DockLayout {

                            }
                            ImageButton {
                                id: mImageButtonSearch
                                preferredHeight: 35
                                preferredWidth: 35
                                defaultImageSource: "asset:///images/directions/minus_icon.png"
                                pressedImageSource: "asset:///images/directions/minus_icon.png"
                                horizontalAlignment: HorizontalAlignment.Right
                                onClicked: {
                                    mContainerSearchExpandable.visible = ! mContainerSearchExpandable.visible
                                }

                            }
                        }
                        onTouch: {
                            if (event.isUp()) {
                                mContainerSearchExpandable.visible = ! mContainerSearchExpandable.visible
                            }
                        }
                    } //search expandable ends
                    Container {
                        id: mContainerSearchExpandable
                        topPadding: 20
                        verticalAlignment: VerticalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        onVisibleChanged: {
                            if (visible) {
                                mImageButtonSearch.defaultImageSource = "asset:///images/directions/minus_icon.png"
                                mImageButtonSearch.pressedImageSource = "asset:///images/directions/minus_icon.png"
                            } else {
                                mImageButtonSearch.defaultImageSource = "asset:///images/directions/plus_icon.png"
                                mImageButtonSearch.pressedImageSource = "asset:///images/directions/plus_icon.png"
                            }
                        }
                        Container {
                            id: mcontainerSearchLayoutFrom
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mFrom
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.15
                                }
                            }
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.40
                                }
                                Container {
                                    layout: DockLayout {

                                    }
                                    preferredHeight: 90
                                    background: mImagePaintDefinitionDirectionBG.imagePaint
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Center

                                    Container {
                                        id: mContainerLabelSelectFrom
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 20.0
                                        rightPadding: 20.0
                                        Label {
                                            id: mLabelSelectFrom
                                            text: mAllStrings.mDropDownSelectFrom
                                        }
                                    }
                                    Container {
                                        id: mButtonSearchIconcatFrom
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 10.0
                                        rightPadding: 10.0
                                        ImageView {
                                            verticalAlignment: VerticalAlignment.Center
                                            imageSource: "asset:///images/search_option/arrow.png"
                                            //                                            defaultImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            pressedImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            disabledImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            verticalAlignment: VerticalAlignment.Center
                                        }
                                    }
                                    onTouch: {
                                        if (event.isUp()) {
                                            isFromforDialog = "from"
                                            mDialogCommonList.open()
                                        }
                                    }
                                }
                                Container {
                                    background: mImagePaintTextFieldBG.imagePaint
                                    topMargin: 20
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    TextField {
                                        id: mTextFieldFrom
                                        //                                    enabled: false
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.6
                                        }
                                        hintText: ""
                                        horizontalAlignment: HorizontalAlignment.Right
                                        backgroundVisible: false
                                        onTextChanging: {
                                            // clearMyRouteData()
                                            mListViewTo.visible = false
                                            mListViewToArabic.visible = false
                                            mListViewvia.visible = false
                                            mListViewArabicvia.visible = false
                                            if (checkTagDropDownFrom == mAllStrings.mDropDownMakaniNumber) {
                                                if (mTextFieldFrom.text.length == 3) {
                                                    if (_mAppParentObj.isNetworkAvailable()) {
                                                        //   mTextFieldFrom.enabled=false
                                                        _mWebServiceinstance.GetMakaniNo(mTextFieldFrom.text)
                                                        //     TextFieldFrom.enabled=true
                                                    }
                                                    mListViewFrom.mLabelValue = "makani"
                                                    mListViewFromArabic.mLabelValue = "makani"
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        mListViewFrom.visible = true
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFrom.visible = false : mListViewFrom.visible = false
                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFromArabic.visible = false : mListViewFromArabic.visible = false
                                                        console.debug("in arabic listviewarabic")
                                                    }
                                                } else if (mTextFieldFrom.text.length >= 4) {
                                                    _mWebServiceinstance.searchDataFilter(mTextFieldFrom.text, "MakaniNo");

                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFrom.visible = false : mListViewFrom.visible = true

                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFromArabic.visible = false : mListViewFromArabic.visible = true

                                                    }
                                                } else if (mTextFieldFrom.text.length == 0 || mTextFieldFrom.text < 3) {
                                                    _mWebServiceinstance.mymodel.clear()
                                                    mListViewFrom.visible = false
                                                    mListViewFromArabic.visible = false

                                                }
                                            } else if (checkTagDropDownFrom == mAllStrings.mDropDownPlaceName) {
                                                _mWebServiceinstance.SetisPOITextChanging(true)
                                                if (mTextFieldFrom.text.length == 3) {
                                                    if (_mAppParentObj.isNetworkAvailable()) {
                                                        _mWebServiceinstance.GetPOIInfo(mTextFieldFrom.text, "E", true, "autoComplete")
                                                    }
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        mListViewFrom.mLabelValue = "placename"
                                                        mListViewFrom.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                        mListViewFrom.visible = true;
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFrom.visible = false : mListViewFrom.visible = true;
                                                    } else {
                                                        mListViewFromArabic.mLabelValue = "placename"
                                                        mListViewFromArabic.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFromArabic.visible = false : mListViewFromArabic.visible = true;
                                                    }
                                                }
                                                if (mTextFieldFrom.text.length > 3) {
                                                    _mWebServiceinstance.searchDataFilterPOI(mTextFieldFrom.text, "POI");
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFrom.visible = false : mListViewFrom.visible = true
                                                    
                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewFromArabic.visible = false : mListViewFromArabic.visible = true
                                                    
                                                    }
                                                    
                                                }
                                                if (mTextFieldFrom.text.length == 0 || mTextFieldFrom.text < 2) {
                                                    _mWebServiceinstance.mymodel.clear()
                                                    mListViewFrom.visible = false
                                                    mListViewFromArabic.visible = false
                                                }
                                            } //placename curly braces ends

                                        }
                                    }
                                }
                                Container {
                                    id: mcontainerFromListview
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    ListView {
                                        id: mListViewFrom
                                        verticalAlignment: VerticalAlignment.Fill
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        dataModel: _mWebServiceinstance.mymodel
                                        preferredHeight: 300
                                        //                                        preferredWidth: 500
                                        visible: false
                                        property string mLabelValue

                                        listItemComponents: [
                                            ListItemComponent {
                                                type: "item"
                                                Container {
                                                    id: mContainerInsideList
                                                    background: Color.White
                                                    visible: true
                                                    verticalAlignment: VerticalAlignment.Center
                                                    //                                                    preferredWidth: 500
                                                    preferredHeight: 80
                                                    layout: DockLayout {
                                                    }
                                                    Label {
                                                        verticalAlignment: VerticalAlignment.Center
                                                        horizontalAlignment: HorizontalAlignment.Fill
                                                        text: mContainerInsideList.ListItem.view.mLabelValue == "makani" ? ListItemData.Makani : (mContainerInsideList.ListItem.view.mLabelValue == "placename" ? ListItemData.NAME_E : ListItemData.NAME_E)
                                                        textStyle.textAlign: TextAlign.Left
                                                        multiline: true
                                                        textStyle.fontSize: FontSize.XSmall
                                                    }
                                                    Divider {
                                                    }
                                                }
                                            }
                                        ]
                                        onTriggered: {
                                            mListViewFrom.preferredWidth = mAllStrings.searchTextFiledWidth
                                            var mdata = dataModel.data(indexPath);
                                            if (mLabelValue == "makani") {
                                                mTextFieldFrom.text = mdata.Makani

                                            } else if (mLabelValue == "placename") {
                                                console.debug("lat is:" + mdata.X_COORD + "LNG IS: " + mdata.Y_COORD)
                                                strTextFromLat = mdata.X_COORD
                                                strTextFromLng = mdata.Y_COORD
                                                mTextFieldFrom.text = mdata.NAME_E
                                                isTextfromList = mdata.NAME_E
                                            }
                                            mListViewFrom.visible = false
                                        }
                                    }
                                    ListView {
                                        id: mListViewFromArabic
                                        verticalAlignment: VerticalAlignment.Fill
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        dataModel: _mWebServiceinstance.mymodel
                                        preferredHeight: 300
                                        //                                        preferredWidth: 500
                                        visible: false
                                        property string mLabelValue
                                        listItemComponents: [
                                            ListItemComponent {
                                                type: "item"
                                                Container {
                                                    id: mContainerInsideListArabicFrom
                                                    background: Color.White
                                                    visible: true
                                                    verticalAlignment: VerticalAlignment.Center
                                                    //                                                    preferredWidth: 500
                                                    preferredHeight: 80
                                                    layout: DockLayout {
                                                    }
                                                    Label {
                                                        verticalAlignment: VerticalAlignment.Center
                                                        horizontalAlignment: HorizontalAlignment.Fill
                                                        text: mContainerInsideListArabicFrom.ListItem.view.mLabelValue == "makani" ? ListItemData.Makani : (mContainerInsideListArabicFrom.ListItem.view.mLabelValue == "placename" ? ListItemData.NAME_A : ListItemData.NAME_A)
                                                        textStyle.textAlign: TextAlign.Right
                                                        multiline: true
                                                        textStyle.fontSize: FontSize.XSmall
                                                    }
                                                    Divider {
                                                    }
                                                }
                                            }
                                        ]
                                        onTriggered: {
                                            mListViewFromArabic.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                            var mdata = dataModel.data(indexPath);
                                            if (mLabelValue == "makani") {
                                                mTextFieldFrom.text = mdata.Makani

                                            } else if (mLabelValue == "placename") {
                                                console.debug("lat is:" + mdata.X_COORD + "LNG IS: " + mdata.Y_COORD)
                                                strTextFromLat = mdata.X_COORD
                                                strTextFromLng = mdata.Y_COORD
                                                mTextFieldFrom.text = mdata.NAME_A
                                                isTextfromList = mdata.NAME_A
                                            }
                                            mListViewFromArabic.visible = false
                                        }
                                    }
                                }
                            }

                        }

                        Container {
                            id: mContainerDest2Arrow
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: ui.du(7)
                            rightPadding: ui.du(7)
                            enabled: false
                            layout: DockLayout {

                            }
                            ImageView {
                                horizontalAlignment: HorizontalAlignment.Left
                                imageSource: "asset:///images/directions/arrow.png"
                            }
                            onTouch: {
                                if (event.isUp()) {
                                    //   mTextFieldFrom.text = myToData.toString()
                                    //  mTextFieldTo.text = myFromData.toString()
                                    if (mTextFieldFrom.text.length > 0 && mTextFieldTo.text.length > 0) {
                                        if (mLabelSelectFrom.text != mAllStrings.mDropDownSelectFrom || mLabelSelectTo.text != mAllStrings.mDropDownSelectTo) {
                                            var mlabeltext1 = mLabelSelectFrom.text
                                            var mlabeltext2 = mLabelSelectTo.text

                                            var mtext1 = mTextFieldFrom.text
                                            var mtext2 = mTextFieldTo.text

                                            mLabelSelectFrom.text = mlabeltext2.toString()
                                            mLabelSelectTo.text = mlabeltext1.toString()

                                            mTextFieldFrom.enabled = false
                                            mTextFieldTo.enabled = false

                                            mTextFieldFrom.text = mtext2.toString()
                                            mTextFieldTo.text = mtext1.toString()

                                            mdataFav = mTextFieldFrom.text
                                            mdataFavTo = mTextFieldTo.text

                                            checkTagDropDownFrom = mlabeltext2.toString()
                                            checkTagDropDownTo = mlabeltext1.toString()

                                            mListViewFrom.visible = false
                                            mListViewFromArabic.visible = false

                                            mListViewTo.visible = false
                                            mListViewToArabic.visible = false

                                            mListViewvia.visible = false
                                            mListViewToArabic.visible = false

                                            isChangeClicked = true

                                        }
                                    }
                                }
                            }
                        }
                        Container {
                            visible: true
                            id: mcontainerSearchLayoutTo
                            topPadding: 10
                            verticalAlignment: VerticalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }

                            Label {
                                id: mLabelDestination2
                                text: mAllStrings.mDestination1
                                textStyle.textAlign: TextAlign.Left
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Top
                                topMargin: ui.du(2)
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.15
                                }
                            }

                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.40
                                }
                                Container {
                                    layout: DockLayout {

                                    }
                                    preferredHeight: 90
                                    background: mImagePaintDefinitionDirectionBG.imagePaint
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Center

                                    Container {
                                        id: mContainerLabelSelectTo
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 20.0
                                        rightPadding: 20.0
                                        Label {
                                            id: mLabelSelectTo
                                            //text: mAllStrings.mDropDownSelectTo
                                            text: mAllStrings.mSelectDestination
                                        }

                                    }
                                    Container {
                                        id: mButtonSearchIconcatTo
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 10.0
                                        rightPadding: 10.0
                                        ImageView {
                                            imageSource: "asset:///images/search_option/arrow.png"
                                            //                                            defaultImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            pressedImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            disabledImageSource: "asset:///images/search_option/arrow.png"
                                            verticalAlignment: VerticalAlignment.Center
                                        }
                                    }
                                    onTouch: {
                                        if (event.isUp()) {
                                            isFromforDialog = "to"
                                            mDialogCommonList.open()
                                        }
                                    }
                                }
                                Container {
                                    background: mImagePaintTextFieldBG.imagePaint
                                    topMargin: 20
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    TextField {
                                        id: mTextFieldTo
                                        //                                        enabled: true
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.6
                                        }
                                        hintText: ""
                                        horizontalAlignment: HorizontalAlignment.Right
                                        backgroundVisible: false
                                        onTextChanging: {
                                            _mWebServiceinstance.mymodel.clear()
                                            //  clearMyRouteData()
                                            mListViewFrom.visible = false
                                            mListViewFromArabic.visible = false
                                            if (checkTagDropDownTo == mAllStrings.mDropDownMakaniNumber) {
                                                if (mTextFieldTo.text.length == 3) {

                                                    mListViewTo.mLabelValueTo = "makani"
                                                    mListViewToArabic.mLabelValueTo = "makani"
                                                    if (_mAppParentObj.isNetworkAvailable())
                                                        _mWebServiceinstance.GetMakaniNo(mTextFieldTo.text)
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewTo.visible = false : mListViewTo.visible = true

                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewToArabic.visible = false : mListViewToArabic.visible = true
                                                    }

                                                }
                                                if (mTextFieldTo.text.length >= 4) {
                                                    _mWebServiceinstance.searchDataFilter(mTextFieldTo.text, "MakaniNo");
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewTo.visible = false : mListViewTo.visible = true

                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewToArabic.visible = false : mListViewToArabic.visible = true
                                                    }
                                                }
                                                if (mTextFieldTo.text.length == 0) {
                                                    _mWebServiceinstance.mymodel.clear()
                                                    mListViewTo.visible = false
                                                    mListViewToArabic.visible = false
                                                }
                                            } else if (checkTagDropDownTo == mAllStrings.mDropDownPlaceName) {
                                                _mWebServiceinstance.SetisPOITextChanging(true)
                                                if (mTextFieldTo.text.length == 3) {
                                                    mListViewTo.mLabelValueTo = "placename"
                                                    mListViewToArabic.mLabelValueTo = "placename"
                                                    mListViewTo.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                    mListViewToArabic.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                    if (_mAppParentObj.isNetworkAvailable())
                                                        _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", true, "autoComplete")
                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewTo.visible = false : mListViewTo.visible = true
                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewToArabic.visible = false : mListViewToArabic.visible = true
                                                    }
                                                }
                                                if (mTextFieldTo.text.length > 3) {
                                                    _mWebServiceinstance.searchDataFilterPOI(mTextFieldTo.text, "POI");

                                                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewTo.visible = false : mListViewTo.visible = true

                                                    } else {
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewToArabic.visible = false : mListViewToArabic.visible = true
                                                    }
                                                }
                                                if (mTextFieldTo.text.length == 0) {
                                                    _mWebServiceinstance.mymodel.clear()
                                                    mListViewTo.visible = false
                                                    mListViewToArabic.visible = false
                                                }
                                            }
                                        }
                                    }
                                }
                                Container {
                                    id: mContainerDestination
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    ListView {
                                        id: mListViewTo
                                        verticalAlignment: VerticalAlignment.Fill
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        dataModel: _mWebServiceinstance.mymodel
                                        preferredHeight: 300
                                        //                                        preferredWidth: 500
                                        visible: false
                                        property string mLabelValueTo

                                        listItemComponents: [
                                            ListItemComponent {
                                                type: "item"
                                                Container {
                                                    id: mContainerInsideList1
                                                    background: Color.White
                                                    visible: true
                                                    verticalAlignment: VerticalAlignment.Fill
                                                    horizontalAlignment: HorizontalAlignment.Fill
                                                    preferredHeight: 80
                                                    layout: DockLayout {

                                                    }
                                                    Label {
                                                        verticalAlignment: VerticalAlignment.Center
                                                        horizontalAlignment: HorizontalAlignment.Fill
                                                        text: mContainerInsideList1.ListItem.view.mLabelValueTo == "makani" ? ListItemData.Makani : (mContainerInsideList1.ListItem.view.mLabelValueTo == "placename" ? ListItemData.NAME_E : ListItemData.NAME_E)
                                                        textStyle.textAlign: TextAlign.Left
                                                        multiline: true
                                                        textStyle.fontSize: FontSize.XSmall
                                                    }
                                                    Divider {
                                                    }
                                                }
                                            }
                                        ]
                                        onTriggered: {

                                            var mdata = dataModel.data(indexPath);
                                            if (mLabelValueTo == "makani") {
                                                mTextFieldTo.text = mdata.Makani

                                            } else if (mLabelValueTo == "placename") {
                                                //  mListViewTo.preferredWidth = mAllStrings.searchTextFiledWidth
                                                strTextToLat = mdata.X_COORD
                                                strTextToLng = mdata.Y_COORD
                                                mTextFieldTo.text = mdata.NAME_E
                                                isTextToList = mdata.NAME_E
                                            }
                                            mListViewTo.visible = false
                                        }
                                    }

                                    ListView {
                                        id: mListViewToArabic
                                        verticalAlignment: VerticalAlignment.Fill
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        dataModel: _mWebServiceinstance.mymodel
                                        preferredHeight: 300
                                        //                                        preferredWidth: 500
                                        visible: false
                                        property string mLabelValueTo

                                        listItemComponents: [
                                            ListItemComponent {
                                                type: "item"
                                                Container {
                                                    id: mContainerInsideList1ArabicTo
                                                    background: Color.White
                                                    visible: true
                                                    verticalAlignment: VerticalAlignment.Center
                                                    //                                                    preferredWidth: 500

                                                    preferredHeight: 80
                                                    layout: DockLayout {

                                                    }
                                                    Label {
                                                        verticalAlignment: VerticalAlignment.Center
                                                        horizontalAlignment: HorizontalAlignment.Right
                                                        text: mContainerInsideList1ArabicTo.ListItem.view.mLabelValueTo == "makani" ? ListItemData.Makani : (mContainerInsideList1ArabicTo.ListItem.view.mLabelValueTo == "placename" ? ListItemData.NAME_A : ListItemData.NAME_A)
                                                        textStyle.textAlign: TextAlign.Right
                                                        multiline: true
                                                        textStyle.fontSize: FontSize.XSmall
                                                    }
                                                    Divider {
                                                    }
                                                }
                                            }
                                        ]
                                        onTriggered: {

                                            var mdata = dataModel.data(indexPath);
                                            if (mLabelValueTo == "makani") {
                                                mTextFieldTo.text = mdata.Makani

                                            } else if (mLabelValueTo == "placename") {
                                                //mListViewToArabic.preferredWidth = mAllStrings.searchTextFiledWidth
                                                strTextToLat = mdata.X_COORD
                                                strTextToLng = mdata.Y_COORD
                                                mTextFieldTo.text = mdata.NAME_A
                                                isTextToList = mdata.NAME_A
                                            }
                                            mListViewToArabic.visible = false
                                        }
                                    }
                                }
                                Container {
                                    id: mContainerAddDestination
                                    topPadding: ui.du(1)
                                    bottomPadding: ui.du(1)
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    ImageView {
                                        id: mImageViewPlusMinusnew
                                        verticalAlignment: VerticalAlignment.Center
                                        //    imageSource: "asset:///images/directions/plus_icon.png"
                                        imageSource: "asset:///images/directions/plussign.png"
                                        visible: true
                                        preferredHeight: 30
                                        preferredWidth: 30
                                        onTouch: {
                                            if (event.isUp()) {
                                                mContainerVia.visible = ! mContainerVia.visible
                                                mContainerwithminusvia.visible = ! mContainerwithminusvia.visible
                                                mContainerAddDestination.visible = false
                                                mContainerDest1Arrow.visible = true
                                            }
                                        }
                                    }
                                    Label {
                                        text: mAllStrings.mDirectionAdddestination
                                        verticalAlignment: VerticalAlignment.Center
                                    }
                                }

                            }

                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            Container {
                                id: mContainerwithplus
                                topPadding: ui.du(1)
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight

                                }
                                Container {
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    leftPadding: ui.du(8)
                                    layoutProperties: StackLayoutProperties {
                                        spaceQuota: 0.15
                                    }

                                    ImageView {
                                        id: mImageViewPlusMinus
                                        verticalAlignment: VerticalAlignment.Center
                                        imageSource: "asset:///images/directions/plus_icon.png"
                                        visible: false

                                        onTouch: {
                                            if (event.isUp()) {
                                                if (mImageViewPlusMinus.imageSource == "asset:///images/directions/plus_icon.png") {
                                                    mImageViewPlusMinus.imageSource = "asset:///images/directions/remove.png"
                                                    mContainerVia.visible = true
                                                    mContainerDest1Arrow.visible = true
                                                } else if (mImageViewPlusMinus.imageSource == "asset:///images/directions/remove.png") {
                                                    mImageViewPlusMinus.imageSource = "asset:///images/directions/plus_icon.png"
                                                    mContainerVia.visible = false
                                                    mContainerDest1Arrow.visible = false
                                                }
                                            }
                                        }
                                    }
                                }

                            }

                        }
                        Container {
                            id: mContainerDest1Arrow
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: ui.du(7)
                            rightPadding: ui.du(7)
                            visible: false
                            enabled: false
                            layout: DockLayout {

                            }
                            ImageView {

                                horizontalAlignment: HorizontalAlignment.Left
                                imageSource: "asset:///images/directions/arrow.png"
                            }
                            onTouch: {
                                if (event.isUp()) {
                                    if (mTextFieldVia.text.length > 0) {
                                        if (mLabelSelectTo.text != mAllStrings.mDropDownSelectTo || mLabelVia.text != "via") {
                                            var mlabeltext1 = mLabelSelectTo.text
                                            var mlabeltext2 = mLabelVia.text

                                            var mtext1 = mTextFieldTo.text
                                            var mtext2 = mTextFieldVia.text

                                            mLabelSelectTo.text = mlabeltext2.toString()
                                            mLabelVia.text = mlabeltext1.toString()

                                            mTextFieldTo.enabled = false
                                            mTextFieldVia.enabled = false

                                            mTextFieldTo.text = mtext2.toString()
                                            mTextFieldVia.text = mtext1.toString()

                                            mdataFavTo = mTextFieldTo.text
                                            mdataFavVia = mTextFieldVia.text

                                            checkTagDropDownTo = mlabeltext2.toString()
                                            checkTagDropDownVia = mlabeltext1.toString()

                                            mListViewFrom.visible = false
                                            mListViewFromArabic.visible = false

                                            mListViewTo.visible = false
                                            mListViewToArabic.visible = false

                                            mListViewvia.visible = false
                                            mListViewToArabic.visible = false

                                            mcontainerFromListviewvia.visible = false

                                            isChangeClicked = true
                                        }
                                    }
                                }
                            }
                        }
                        Container {
                            id: mContainerVia
                            topPadding: 10
                            visible: false
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                id: mLabelDestination1
                                text: mAllStrings.mDestination2
                                textStyle.textAlign: TextAlign.Left
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.15
                                }
                            }
                            Container {
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 0.40
                                }

                                Container {
                                    layout: DockLayout {

                                    }
                                    preferredHeight: 90
                                    background: mImagePaintDefinitionDirectionBG.imagePaint
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Center
                                    Container {
                                        id: mcontainerlabelvia
                                        horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 20.0
                                        rightPadding: 20.0
                                        Label {
                                            id: mLabelVia
                                            text: mAllStrings.mSelectDestination
                                        }
                                        onTouch: {
                                            mcontainerFromListviewvia.visible = true
                                        }
                                    }
                                    Container {
                                        id: mbuttonminusiconvia
                                        horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Center
                                        leftPadding: 10.0
                                        rightPadding: 10.0
                                        ImageView {
                                            imageSource: "asset:///images/search_option/arrow.png"
                                            //                                            defaultImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            pressedImageSource: "asset:///images/search_option/arrow.png"
                                            //                                            disabledImageSource: "asset:///images/search_option/arrow.png"
                                            verticalAlignment: VerticalAlignment.Center
                                        }
                                    }
                                    onTouch: {
                                        if (event.isUp()) {
                                            isFromforDialog = "via"
                                            mDialogCommonList.open()
                                        }
                                    }
                                }

                            }
                        }
                        Container {
                            id: mContainerwithminusvia
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            visible: false
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }

                            Container {
                                topPadding: 20
                                id: mContainerwithminusviastack
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                Container {
                                    id: mconminus
                                    topPadding: 20
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    //                                    verticalAlignment: VerticalAlignment.Center
                                    layout: DockLayout {
                                    }
                                    layoutProperties: StackLayoutProperties {
                                        spaceQuota: 0.15
                                    }
                                    ImageView {
                                        imageSource: "asset:///images/directions/remove.png"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        onTouch: {
                                            if (event.isUp()) {

                                                mContainerVia.visible = ! mContainerVia.visible
                                                mContainerwithminusvia.visible = ! mContainerwithminusvia.visible
                                                mContainerAddDestination.visible = true
                                                mContainerDest1Arrow.visible = false
                                            }
                                        }
                                    }
                                }
                                Container {
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.TopToBottom
                                    }
                                    layoutProperties: StackLayoutProperties {
                                        spaceQuota: 0.35
                                    }
                                    Container {
                                        background: mImagePaintTextFieldBG.imagePaint
                                        TextField {
                                            id: mTextFieldVia
                                            hintText: ""
                                            visible: true
                                            enabled: false
                                            backgroundVisible: false

                                            //touchPropagationMode: TouchPropagationMode.None

                                            onTextChanging: {
                                                mTextFieldVia.text.length > 0 ? mTextFieldVia.enabled = true : mTextFieldVia.enabled = false
                                                mListViewTo.visible = false
                                                mListViewToArabic.visible = false
                                                mListViewFrom.visible = false
                                                mListViewFromArabic.visible = false
                                                if (checkTagDropDownVia == mAllStrings.mDropDownMakaniNumber) {
                                                    if (mTextFieldVia.text.length == 3) {
                                                        if (_mAppParentObj.isNetworkAvailable()) {
                                                            _mWebServiceinstance.GetMakaniNo(mTextFieldVia.text)
                                                        }
                                                        mListViewvia.mLabelValue = "makani"
                                                        mListViewArabicvia.mLabelValue = "makani"
                                                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                            mListViewvia.visible = true
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewvia.visible = false : mListViewvia.visible = false
                                                        } else {
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewArabicvia.visible = false : mListViewArabicvia.visible = false
                                                        }
                                                    } else if (mTextFieldVia.text.length >= 4) {
                                                        _mWebServiceinstance.searchDataFilter(mTextFieldVia.text, "MakaniNo");
                                                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewvia.visible = false : mListViewvia.visible = true

                                                        } else {
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewArabicvia.visible = false : mListViewArabicvia.visible = true

                                                        }
                                                    } else if (mTextFieldVia.text.length == 0 || mTextFieldVia.text < 3) {
                                                        _mWebServiceinstance.mymodel.clear()
                                                        mListViewvia.visible = false
                                                        mListViewArabicvia.visible = false

                                                    }
                                                } else if (checkTagDropDownVia == mAllStrings.mDropDownPlaceName) {
                                                    _mWebServiceinstance.SetisPOITextChanging(true)
                                                    if (mTextFieldVia.text.length == 3) {
                                                        if (_mAppParentObj.isNetworkAvailable()) {
                                                            _mWebServiceinstance.GetPOIInfo(mTextFieldVia.text, "E", true, "autoComplete")
                                                        }
                                                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                                            mListViewvia.mLabelValue = "placename"
                                                            mListViewvia.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                            mListViewvia.visible = true;
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewvia.visible = false : mListViewvia.visible = true;
                                                        } else {
                                                            mListViewArabicvia.mLabelValue = "placename"
                                                            mListViewArabicvia.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                            _mWebServiceinstance.mymodel.size() == 0 ? mListViewArabicvia.visible = false : mListViewArabicvia.visible = true;
                                                        }
                                                    }
                                                    if (mTextFieldVia.text.length > 3) {
                                                        _mWebServiceinstance.searchDataFilterPOI(mTextFieldVia.text, "POI");
                                                        _mWebServiceinstance.mymodel.size() == 0 ? mListViewvia.visible = false : mListViewvia.visible = true

                                                    }
                                                    if (mTextFieldVia.text.length == 0 || mTextFieldVia.text < 2) {
                                                        _mWebServiceinstance.mymodel.clear()
                                                        mListViewvia.visible = false
                                                        mListViewArabicvia.visible = false
                                                    }
                                                } //placename curly braces ends
                                            }
                                        }

                                    }
                                    Container {
                                        id: mcontainerFromListviewvia
                                        layout: StackLayout {
                                            orientation: LayoutOrientation.LeftToRight
                                        }
                                        ListView {
                                            id: mListViewvia
                                            verticalAlignment: VerticalAlignment.Fill
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            dataModel: _mWebServiceinstance.mymodel
                                            preferredHeight: 300
                                            //                                            preferredWidth: 500
                                            visible: false
                                            property string mLabelValue
                                            listItemComponents: [
                                                ListItemComponent {
                                                    type: "item"
                                                    Container {

                                                        id: mContainerInsideListvia
                                                        background: Color.White
                                                        visible: true
                                                        verticalAlignment: VerticalAlignment.Fill
                                                        horizontalAlignment: HorizontalAlignment.Fill
                                                        //                                                        preferredWidth: 500
                                                        preferredHeight: 80
                                                        layout: DockLayout {
                                                        }
                                                        Label {
                                                            verticalAlignment: VerticalAlignment.Center
                                                            horizontalAlignment: HorizontalAlignment.Fill
                                                            text: mContainerInsideListvia.ListItem.view.mLabelValue == "makani" ? ListItemData.Makani : (mContainerInsideListvia.ListItem.view.mLabelValue == "placename" ? ListItemData.NAME_E : ListItemData.NAME_E)
                                                            textStyle.textAlign: TextAlign.Left
                                                            multiline: true
                                                            textStyle.fontSize: FontSize.XSmall
                                                        }
                                                        Divider {
                                                        }
                                                    }
                                                }
                                            ]
                                            onTriggered: {
                                                // mListViewvia.preferredWidth = mAllStrings.searchTextFiledWidth
                                                var mdata = dataModel.data(indexPath);
                                                if (mLabelValue == "makani") {
                                                    //mTextFieldFrom.text = mdata.Makani
                                                    mTextFieldVia.text = mdata.Makani
                                                } else if (mLabelValue == "placename") {
                                                    console.debug("lat is:" + mdata.X_COORD + "LNG IS: " + mdata.Y_COORD)
                                                    strTextViaFromLat = mdata.X_COORD
                                                    strTextViaToLng = mdata.Y_COORD
                                                    mTextFieldVia.text = mdata.NAME_E
                                                    //mTextFieldFrom.text = mdata.NAME_E
                                                    isTextViaList = mdata.NAME_E
                                                }
                                                mListViewvia.visible = false
                                            }
                                        }
                                        ListView {
                                            id: mListViewArabicvia
                                            verticalAlignment: VerticalAlignment.Fill
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            dataModel: _mWebServiceinstance.mymodel
                                            preferredHeight: 300
                                            //                                            preferredWidth: 500
                                            visible: false
                                            property string mLabelValue
                                            listItemComponents: [
                                                ListItemComponent {
                                                    type: "item"
                                                    Container {
                                                        id: mContainerInsideListArabicvia
                                                        background: Color.White
                                                        visible: true
                                                        verticalAlignment: VerticalAlignment.Center
                                                        //                                                        preferredWidth: 500
                                                        preferredHeight: 80
                                                        layout: DockLayout {
                                                        }
                                                        Label {
                                                            verticalAlignment: VerticalAlignment.Center
                                                            horizontalAlignment: HorizontalAlignment.Fill
                                                            text: mContainerInsideListArabicvia.ListItem.view.mLabelValue == "makani" ? ListItemData.Makani : (mContainerInsideListArabicvia.ListItem.view.mLabelValue == "placename" ? ListItemData.NAME_A : ListItemData.NAME_A)
                                                            textStyle.textAlign: TextAlign.Right
                                                            multiline: true
                                                            textStyle.fontSize: FontSize.XSmall
                                                        }
                                                        Divider {
                                                        }
                                                    }
                                                }
                                            ]
                                            onTriggered: {
                                                //     mListViewArabicvia.preferredWidth = mAllStrings.searchTextFiledFullWidth
                                                var mdata = dataModel.data(indexPath);
                                                if (mLabelValue == "makani") {
                                                    //mTextFieldFrom.text = mdata.Makani
                                                    mTextFieldVia.text = mdata.Makani
                                                } else if (mLabelValue == "placename") {
                                                    console.debug("lat is:" + mdata.X_COORD + "LNG IS: " + mdata.Y_COORD)
                                                    strTextViaFromLat = mdata.X_COORD
                                                    strTextViaToLng = mdata.Y_COORD
                                                    // mTextFieldFrom.text = mdata.NAME_A
                                                    mTextFieldVia.text = mdata.NAME_A
                                                    //isTextfromList = mdata.NAME_A
                                                    isTextViaList = mdata.NAME_A
                                                }
                                                mListViewArabicvia.visible = false
                                            }
                                        }
                                    }
                                }

                            }

                        }
                        Container {
                            id: mContainerRouteOptions
                            topPadding: ui.du(1)
                            leftPadding: ui.du(1)
                            horizontalAlignment: HorizontalAlignment.Left
                            layout: DockLayout {

                            }
                            Label {
                                id: mlabelRouteOptions

                                horizontalAlignment: HorizontalAlignment.Fill
                                text: mAllStrings.mdirectionRouteoption
                                textStyle.textAlign: TextAlign.Left
                                textStyle.color: Color.create("#00b5e9")
                            }
                        }
                        Container {
                            id: mContainerAvoidTollhighway
                            topPadding: ui.du(1)
                            bottomPadding: ui.du(1)
                            horizontalAlignment: HorizontalAlignment.Center
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            CheckBox {
                                id: mCheckBoxAvoidTollSalik
                                checked: false

                            }
                            Label {
                                id: mLabelAvoidToll
                                preferredWidth: 250
                                textStyle.textAlign: TextAlign.Left
                                text: mAllStrings.mdirectionAvoidSalik
                            }
                            CheckBox {
                                id: mCheckBoxAvoidHighway
                                checked: false
                            }
                            Label {
                                id: mLabelAvoidHighway
                                textStyle.textAlign: TextAlign.Left
                                preferredWidth: 300
                                text: mAllStrings.mdirectionAvoidhighway
                            }
                        }
                        Container {
                            id: mContainerThreeButton
                            topPadding: 25
                            leftMargin: 20
                            rightPadding: 20
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            CommonButtonWithLabel {
                                leftPadding: 25
                                rightPadding: 25
                                background: mImagePaintDefinitionForButton.imagePaint
                                mLableText: mAllStrings.mGetDirections
                                mTextColor: Color.White
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                onMyClick: {

                                    clearMyRouteData()
                                    mContainerDirectionExpandable.visible = true
                                    mListViewFrom.visible = false
                                    mListViewTo.visible = false
                                    mListViewFromArabic.visible = false
                                    mListViewToArabic.visible = false
                                    mListViewArabicvia.visible = false
                                    mListViewvia.visible = false
                                    console.debug("fromText: " + fromText)
                                    strTextfromtemp = checkTagDropDownFrom
                                    strTexttotemp = checkTagDropDownTo
                                    strTextviatemp = checkTagDropDownVia
                                    if (mTextFieldFrom.text.length > 0 && mTextFieldTo.text.length > 0) {

                                        if (_mAppParentObj.isNetworkAvailable()) {
                                            isDirectionOnMap = false;

                                            if (mTextFieldVia.text.length == 0 && mContainerVia.visible) {
                                                mSystemDialog.body = mAllStrings.mPleaseselectFromDestination
                                                mSystemDialog.show()
                                            } else {
                                                //                                                _mWebServiceinstance.routeDataLoaded.connect(setMyRoutedata)
                                                callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                                            }
                                        } else {
                                            mSystemDialog.body = mAllStrings.mNetworkCheck
                                            mSystemDialog.show()
                                        }
                                    } else {
                                        mSystemDialog.body = mAllStrings.mPleaseselectFromDestination
                                        mSystemDialog.show()
                                    }
                                    //                                    else if (mTextFieldFrom.text.length == 0) {
                                    //                                        mSystemDialog.body = mAllStrings.mValidationFromLocation
                                    //                                        mSystemDialog.show()
                                    //                                        clearMyRouteData()
                                    //                                    } else if (mTextFieldTo.text.length == 0) {
                                    //                                        //    mSystemDialog.body = mAllStrings.mValidationToLocation
                                    //                                        mSystemDialog.body = mAllStrings.mDirectionsvalidationtextfield
                                    //                                        mSystemDialog.show()
                                    //                                        clearMyRouteData()
                                    //                                    }
                                    /*else if (mTextFieldVia.text.length == 0 && mContainerVia.visible) {
                                     * mSystemDialog.body = mAllStrings.mDirectionsvalidationtextfield
                                     * mSystemDialog.show()
                                     }*/
                                } //onMyClick ends
                            }
                            CommonButtonWithLabel {
                                leftPadding: 25
                                rightPadding: 25
                                background: mImagePaintDefinitionForButton.imagePaint
                                mLableText: mAllStrings.mViewMap
                                mTextColor: Color.White
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                onMyClick: {
                                    if (mTextFieldFrom.text.length > 0 && mTextFieldTo.text.length > 0) {

                                        /*if (_mWebServiceinstance.myPolylineData().length > 0) {
                                         * _mWebServiceinstance.ClearMapdata()
                                         * _mWebServiceinstance.drawpinOnDecodedPoly(mTextFieldFrom.text, mTextFieldTo.text,mTextFieldVia)
                                         * mainTabPaned.changeTab(0);
                                         * } else {
                                         * if (_mAppParentObj.isNetworkAvailable()) {
                                         * isDirectionOnMap = true;
                                         * callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                                         * } else {
                                         * mSystemDialog.body = mAllStrings.mNetworkCheck
                                         * mSystemDialog.show()
                                         * }
                                         }*/
                                        if (_mAppParentObj.isNetworkAvailable()) {
                                            isDirectionOnMap = false;

                                            if (mTextFieldVia.text.length == 0 && mContainerVia.visible) {
                                                mSystemDialog.body = mAllStrings.mPleaseselectFromDestination
                                                mSystemDialog.show()
                                            } else {
                                                isDirectionOnMap = true;
                                                //                                                _mWebServiceinstance.routeDataLoaded.connect(setMyRoutedata)
                                                callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                                            }
                                        } else {
                                            mSystemDialog.body = mAllStrings.mNetworkCheck
                                            mSystemDialog.show()
                                        }

                                        //
                                        //                                        if (_mAppParentObj.isNetworkAvailable()) {
                                        //                                            isDirectionOnMap = true;
                                        //                                            callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
                                        //                                        } else {
                                        //                                            mSystemDialog.body = mAllStrings.mNetworkCheck
                                        //                                            mSystemDialog.show()
                                        //                                        }
                                    } else {
                                        mSystemDialog.body = mAllStrings.mPleaseselectFromDestination
                                        mSystemDialog.show()
                                    }
                                    //                                    else if (mTextFieldFrom.text.length == 0) {
                                    //                                        mSystemDialog.body = mAllStrings.mValidationFromLocation
                                    //                                        mSystemDialog.show()
                                    //                                        clearMyRouteData()
                                    //                                    } else if (mTextFieldTo.text.length == 0) {
                                    //                                        mSystemDialog.body = mAllStrings.mValidationToLocation
                                    //                                        mSystemDialog.show()
                                    //                                        clearMyRouteData()
                                    //                                    }
                                }
                            }
                            CommonButtonWithLabel {
                                leftPadding: 25
                                rightPadding: 25
                                background: mImagePaintDefinitionForButton.imagePaint
                                mLableText: mAllStrings.mReset
                                mTextColor: Color.White
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                onMyClick: {
                                    mTextFieldFrom.text = ""
                                    mTextFieldTo.text = ""
                                    mTextFieldVia.text = ""

                                    mTextFieldFrom.enabled = false
                                    mTextFieldTo.enabled = false
                                    mTextFieldVia.enabled = false

                                    mLabelSelectFrom.text = mAllStrings.mDropDownSelectFrom
                                    // mLabelSelectTo.text = mAllStrings.mDropDownSelectTo
                                    //mLabelVia.text = "via"
                                    mLabelSelectTo.text = mAllStrings.mSelectDestination
                                    mLabelVia.text = mAllStrings.mSelectDestination
                                    strTextFromLat = ""
                                    strTextFromLng = ""
                                    strTextToLat = ""
                                    strTextToLng = ""
                                    strTextViaFromLat = ""
                                    strTextViaToLng = ""
                                    mCheckBoxAvoidHighway.checked = false
                                    mCheckBoxAvoidTollSalik.checked = false
                                    clearMyRouteData()
                                    mContainerDirectionExpandable.visible = false

                                }
                            }
                            CommonButtonWithLabel {
                                leftPadding: 25
                                rightPadding: 25
                                background: mImagePaintDefinitionForButton.imagePaint
                                mLableText: "Change"
                                visible: false
                                mTextColor: Color.White
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                onMyClick: {

                                    if (mTextFieldFrom.text.length == 0 || mTextFieldTo.text.length == 0 || mLabelSelectFrom.text == mLabelSelectTo.text) {
                                        //for showing alert if any
                                    } else {
                                        // isChangeClicked = true
                                        isfromvia = false
                                        var myFromData = mTextFieldFrom.text
                                        var myToData = mTextFieldTo.text
                                        var FromText = mLabelSelectFrom.text
                                        var ToText = mLabelSelectTo.text

                                        myFromDatatemp = myFromData.toString()
                                        myToDatatemp = myToData.toString()
                                        fromText = FromText.toString()
                                        toText = ToText.toString()

                                        //assigning vice versa values and labels
                                        mTextFieldFrom.text = myToData.toString()
                                        mTextFieldTo.text = myFromData.toString()
                                        mLabelSelectFrom.text = ToText
                                        mLabelSelectTo.text = FromText

                                        //Avoiding the probability of listview pop up/visible.
                                        mListViewFrom.visible = false
                                        mListViewTo.visible = false
                                        mListViewFromArabic.visible = false
                                        mListViewToArabic.visible = false
                                        mListViewArabicvia.visible = false
                                        mListViewvia.visible = false
                                        //setting the tag for convinience for web service execution in callmydirectiondata().
                                        checkTagDropDownFrom = ToText
                                        checkTagDropDownTo = FromText

                                        //will change if checkTagDropDownFrom or checkTagDropDownTo containes select from favourites
                                        if (checkTagDropDownFrom == mAllStrings.mDropDownSelectFromFaviourites || checkTagDropDownTo == mAllStrings.mDropDownSelectFromFaviourites) {
                                            mDialogFav.isFrom == "from" ? mDialogFav.isFrom = "to" : mDialogFav.isFrom = "from"
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Container {
                        preferredHeight: 100
                        topMargin: 50
                        horizontalAlignment: HorizontalAlignment.Fill
                        background: mImagePaintDefinitionDirectionsExpand.imagePaint
                        layout: DockLayout {

                        }
                        Container {
                            id: mcontainerDirectionsLabel
                            leftPadding: 20
                            rightPadding: 20
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Left
                            layout: DockLayout {

                            }
                            Label {
                                text: mAllStrings.mDirections
                                textStyle.fontSize: FontSize.Large
                                textStyle.color: Color.White
                            }
                        }
                        Container {
                            id: mcontainerDirectionminusicon
                            rightPadding: 30
                            leftPadding: 30
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Right
                            layout: DockLayout {

                            }
                            ImageButton {
                                id: mImageButtonDirectionsExapanded
                                horizontalAlignment: HorizontalAlignment.Right
                                preferredHeight: 35
                                preferredWidth: 35
                                defaultImageSource: "asset:///images/directions/plus_icon.png"
                                pressedImageSource: "asset:///images/directions/plus_icon.png"
                                onClicked: {
                                    mContainerDirectionExpandable.visible = ! mContainerDirectionExpandable.visible
                                }
                            }
                        }
                        onTouch: {
                            if (event.isUp()) {
                                mContainerDirectionExpandable.visible = ! mContainerDirectionExpandable.visible
                            }
                        }
                    }
                    Container {
                        id: mContainerDirectionExpandable
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        topPadding: 30
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        onVisibleChanged: {
                            if (visible) {
                                mImageButtonDirectionsExapanded.defaultImageSource = "asset:///images/directions/minus_icon.png"
                                mImageButtonDirectionsExapanded.pressedImageSource = "asset:///images/directions/minus_icon.png"
                            } else {
                                mImageButtonDirectionsExapanded.defaultImageSource = "asset:///images/directions/plus_icon.png"
                                mImageButtonDirectionsExapanded.pressedImageSource = "asset:///images/directions/plus_icon.png"
                            }
                        }
                        Container {
                            id: mContainerStpesFrom
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mFrom
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.15
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRouteFrom
                                preferredWidth: 600
                                multiline: true
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesTo
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTo1
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.1
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRouteTo
                                horizontalAlignment: HorizontalAlignment.Fill
                                preferredWidth: 600
                                multiline: true
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesDuration
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTotalDuration
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.5
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRouteduration
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesLength
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTotalLength
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.4
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRoutekm
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }

                        Label {
                            id: mlabelsteps
                            text: mAllStrings.mSteps
                            horizontalAlignment: HorizontalAlignment.Fill
                            textStyle.fontSize: FontSize.Large
                            textStyle.color: mAllStrings.lightBlueColor
                            textStyle {
                                base: mStyleForLabel.style
                            }
                        }
                        Divider {

                        }
                        Label {
                            id: mLabelRouteData
                            horizontalAlignment: HorizontalAlignment.Fill
                            multiline: true
                            textStyle {
                                base: mStyleForLabel.style
                            }
                        }
                    }
                    Container {
                        id: mContainerDirectionExpandablevia
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        visible: false
                        topPadding: 30
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        onVisibleChanged: {
                            if (visible) {
                                mImageButtonDirectionsExapanded.defaultImageSource = "asset:///images/directions/minus_icon.png"
                                mImageButtonDirectionsExapanded.pressedImageSource = "asset:///images/directions/minus_icon.png"
                            } else {
                                mImageButtonDirectionsExapanded.defaultImageSource = "asset:///images/directions/plus_icon.png"
                                mImageButtonDirectionsExapanded.pressedImageSource = "asset:///images/directions/plus_icon.png"
                            }
                        }
                        Divider {
                            bottomMargin: ui.du(2)

                        }
                        Container {
                            id: mContainerStpesFromvia
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mFrom
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.15
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRouteFromvia
                                preferredWidth: 600
                                multiline: true
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesTovia
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTo1
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.1
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRouteTovia
                                preferredWidth: 600
                                multiline: true
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesDurationvia
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTotalDuration
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.5
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRoutedurationvia
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }
                        Container {
                            id: mContainerStpesLengthvia
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                text: mAllStrings.mTotalLength
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.4
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }
                            }
                            Label {
                                id: mLabelRoutekmvia
                                horizontalAlignment: HorizontalAlignment.Fill
                                //                                leftMargin: 10
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.7
                                //                                }
                                textStyle {
                                    base: mStyleForLabel.style
                                }

                            }
                        }

                        Label {
                            id: mlabelstepsvia
                            text: mAllStrings.mSteps
                            horizontalAlignment: HorizontalAlignment.Fill
                            textStyle.fontSize: FontSize.Large
                            textStyle.color: mAllStrings.lightBlueColor
                            textStyle {
                                base: mStyleForLabel.style
                            }
                        }
                        Divider {

                        }
                        Label {
                            id: mLabelRouteDatavia
                            horizontalAlignment: HorizontalAlignment.Fill
                            multiline: true
                            textStyle {
                                base: mStyleForLabel.style
                            }
                        }
                    }

                }

            } //scroll view ends
        }

    }
    function getbuildingaddressData(arg1) {
        console.debug("arg1" + arg1)
        if (arg1 == "from") {
            mdataFrom = _mWebServiceinstance.getBuildingToDirectionLatLng("from")
            var data = mdataFrom.split(",", mdataFrom.length)

            strTextFromLat = data[0]
            strTextFromLng = data[1]
            console.debug("getbuildingaddressData arg1 true part:" + mTextFieldTo.text + "mfrom" + mTextFieldFrom.text)
            myDirectionData()
        } else if (arg1 == "via") {
            mdataVia = _mWebServiceinstance.getBuildingToDirectionLatLng("via")
            var data = mdataVia.split(",", mdataVia.length)

            strTextViaFromLat = data[0]
            strTextViaToLng = data[1]

            console.debug("getbuildingaddressData arg1 via part: strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
            if (mImageViewBusBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewCarBottomBar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewWalkBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            }
            isfromvia = false
        } else if (arg1 == "to") {
            console.debug("getbuildingaddressData arg1 else false part:" + mTextFieldTo.text + "fromtextfuiekd " + mTextFieldFrom.text)
            mdataTo = _mWebServiceinstance.getBuildingToDirectionLatLng("to")
            var data = mdataTo.split(",", mdataTo.length)
            strTextToLat = data[0]
            strTextToLng = data[1]
            if (! isfromvia && mTextFieldVia.text.length > 0) {
                callViaDirectionData(checkTagDropDownVia)
            } else {
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }
        }
    }
    function callCat() {
        console.debug("in call cat" + isfromcattemp)
        if (isfromcattemp === "from") {
            mdataFrom = _mWebServiceinstance.getPOIlatlng()
            var data = mdataFrom.split(",", mdataFrom.length)
            strTextFromLat = data[0]
            strTextFromLng = data[1]
            if (checkTagDropDownTo == mAllStrings.mDropDownCategoryAddress) {
                _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", false, "searchDirection")
            } else {
                myDirectionData()
            }
        } else if (isfromcattemp == "via") {
            mdataVia = _mWebServiceinstance.getPOIlatlng()
            var data = mdataVia.split(",", mdataVia.length)
            strTextViaFromLat = data[0]
            strTextViaToLng = data[1]
            console.debug("in via cat address strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
            isfromvia = false
            if (mImageViewBusBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewCarBottomBar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewWalkBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            }
        } else {
            mdataTo = _mWebServiceinstance.getPOIlatlng()
            var data = mdataTo.split(",", mdataTo.length)
            strTextToLat = data[0]
            strTextToLng = data[1]
            console.debug("....................to else part callCat" + strTextToLat + "," + strTextToLng + "with..." + strTextFromLat + "," + strTextFromLng, false, false)
            _mWebServiceinstance.setcat(false)
            if (isfromvia != true && mTextFieldVia.text.length > 0) {
                callViaDirectionData(checkTagDropDownVia)
            } else {
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }
        }
    }
    function getpoidata() {
        console.debug("hasGotResponse.." + _mWebServiceinstance.hasGotResponse() + "isPOIFrom:" + isPOIFrom + "with:" + isfromvia)
        if (_mWebServiceinstance.hasGotResponse()) {
            if (isPOIFrom) {
                var fromdata = _mWebServiceinstance.getPOIlatlng()
                var finalFromData = fromdata.split(",", fromdata.length)

                if (finalFromData.length > 0 && finalFromData != "") {
                    console.debug("strTextFromLng in  isPOIFrom :" + finalFromData)
                    strTextFromLat = finalFromData[0]
                    strTextFromLng = finalFromData[1]

                    myDirectionData()
                    isTextfromList = ""

                } else {
                    mSystemDialog.body = mAllStrings.mValidationRouteNotFound
                    mSystemDialog.show()
                    mContainerDirectionExpandable.visible = false
                    mContainerDirectionExpandablevia.visible = false
                    _mWebServiceinstance.setmactive(false)
                    clearMyRouteData()
                }

            } else if (isPOIFrom == false) {
                if (isfromvia == true) {
                    var viadata = _mWebServiceinstance.getPOIlatlng()
                    if (viadata.length > 0 && viadata != "") {
                        var finalviaData = viadata.split(",", viadata.length)
                        strTextViaFromLat = finalviaData[0]
                        strTextViaToLng = finalviaData[1]
                        isTextViaList = ""

                        isfromvia = false
                        console.debug("strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                        if (mImageViewBusBottombar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
v
                        } else if (mImageViewCarBottomBar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                        } else if (mImageViewWalkBottombar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                        }

                    } else {
                        strTextFromLat = ""
                        strTextFromLng = ""

                        strTextToLat = ""
                        strTextToLng = ""

                        strTextViaFromLat = ""
                        strTextViaToLng = ""
                        mSystemDialog.body = mAllStrings.mValidationRouteNotFound
                        mSystemDialog.show()
                        mContainerDirectionExpandable.visible = false
                        mContainerDirectionExpandablevia.visible = false
                        clearMyRouteData()
                        _mWebServiceinstance.setmactive(false)
                    }

                } else {
                    isTextToList = ""
                    var todata = _mWebServiceinstance.getPOIlatlng()
                    var finaltoData = todata.split(",", todata.length)

                    console.debug("finaltoData:" + finaltoData)
                    strTextToLat = finaltoData[0]
                    strTextToLng = finaltoData[1]
                    if (mTextFieldVia.text.length > 0 && mContainerVia.visible) {
                        callViaDirectionData(checkTagDropDownVia)
                    } else {
                        if (mImageViewBusBottombar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                        } else if (mImageViewCarBottomBar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                        } else if (mImageViewWalkBottombar.visible) {
                            _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                        }
                    }
                }
            }

        } else {
            mSystemDialog.body = mAllStrings.mValidationRouteNotFound
            mSystemDialog.show()
            mContainerDirectionExpandable.visible = false
            mContainerDirectionExpandablevia.visible = false
            strTextFromLat = ""
            strTextFromLng = ""

            strTextToLat = ""
            strTextToLng = ""

            strTextViaFromLat = ""
            strTextViaToLng = ""
            clearMyRouteData()
        }

    }
    function callViaDirectionData(argvia) {
        isfromvia = true
        if (argvia == mAllStrings.mserachbyland) {
            isFrom = true
            _mWebServiceinstance.setIsfromLandNumber(true)
            _mWebServiceinstance.GetParcelOutline_New(mTextFieldVia.text)
        }
        if (argvia == mAllStrings.mMapSelectedLocation) {
            isFrom = true
            
            if (_mWebServiceinstance.checkInvalid(mTextFieldVia.text.replace(" ", "") == "number")) {
                _mWebServiceinstance.getDirectionLatLon(mTextFieldVia.text, "MAKANI")

            } else if (_mWebServiceinstance.checkInvalid(mTextFieldVia.text.replace(" ", "") == "UAENG")) {
                _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(mTextFieldVia.text), "UAENG")

            }
        }
        if (argvia == mAllStrings.mDropDownMyLocation) {
            console.debug("strTextFromLat callViaDirectionData mDropDownMyLocation:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)

            if (mImageViewBusBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewCarBottomBar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            } else if (mImageViewWalkBottombar.visible) {
                _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
            }
        } else if (argvia == mAllStrings.mDropDownMakaniNumber) {
            console.debug("in callvia MakaniNumber")
            //checkTagDropDownFrom = ""
            //checkTagDropDownTo = ""
            isfromvia = true
            isFrom = true
            _mWebServiceinstance.getDirectionLatLon(mTextFieldVia.text, "MAKANI")
        } else if (argvia == mAllStrings.mDropDownUAENG) {
            console.debug("in callvia uaeng")
            isFrom = true
            myUAENGValueVia = _mWebServiceinstance.ConvertToUAENG(mTextFieldVia.text)
            if (myUAENGValueVia == "") {
                mSystemDialog.body = mAllStrings.mValidationValidUAENGValue
                mSystemDialog.show()
                clearMyRouteData()
            } else {
                _mWebServiceinstance.getDirectionLatLon(myUAENGValueVia, "UAENG")
            }
        } else if (argvia == mAllStrings.mDropDownSelectFromFaviourites || argvia == mAllStrings.mDropDownSelectFromContacts) {
            var tempdatavia = mdataFavVia
            isFrom = true
            if (mdataFavVia != "") {
                tempdatavia = mTextFieldVia.text
            }
            console.debug("mdatafav...." + mdataFavVia + "with mDialogFav.isFrom" + mDialogFav.isFrom)
            if (isChangeClicked && mDialogFav.isFrom == "via" && argvia == mAllStrings.mDropDownSelectFromFaviourites) {
                mdataFavVia = mTextFieldVia.text
                tempdatavia = mTextFieldVia.text
            } else if (isChangeClicked && argvia == mAllStrings.mDropDownSelectFromContacts) {
                mdataFavVia = mTextFieldVia.text
                tempdatavia = mTextFieldVia.text
            }

            if (_mWebServiceinstance.checkInvalid(mdataFavVia.replace(" ", "")) == "number") {
                _mWebServiceinstance.getDirectionLatLon(tempdatavia, "MAKANI")
            } else if (_mWebServiceinstance.validateString(mdataFavVia.replace(" ", "")) == "UAENG") {
                _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(tempdatavia), "UAENG")
            }

        } else if (argvia == mAllStrings.mDropDownBuildingAddress) {
            _mWebServiceinstance.setcheckisFrom("via")
            _mWebServiceinstance.GetBuildingAddress(mDialogContentSearchByBuilding.mTextFieldCommunity.text, mDialogContentSearchByBuilding.mTextFieldStreetname.text, mDialogContentSearchByBuilding.mTextFieldBuilding.text, "E")
        } else if (argvia == mAllStrings.mDropDownPlaceName) {
            console.debug("mDropDownPlaceName....")
            _mWebServiceinstance.setcat(false)
            isPOIFrom = false;
            _mWebServiceinstance.SetisPOITextChanging(false)
            _mWebServiceinstance.GetPOIInfo(mTextFieldVia.text, "E", false, "searchDirection")

        } else if (argvia == mAllStrings.mDropDownCategoryAddress) {
            console.debug("mDropDownCategoryAddress via")
            isfromcattemp = "via"
            _mWebServiceinstance.setcat(true)
            _mWebServiceinstance.GetPOIInfo(mTextFieldVia.text, "E", false, "searchDirection")
            isfromvia = false
        }
    }
    // WEBSERVICE TO GET DIRECTION DATA FUNCTION
    function callmyDirectionData(argFrom, argTo, argVia) {
        clearMyRouteData()
        mTextFieldFrom.enabled = false
        mTextFieldVia.enabled = false
        mTextFieldTo.enabled = false
        isFrom = true;
        isfromvia = false

        console.debug("argFrom" + argFrom)
        console.debug("argTo" + argTo)
        console.debug("argVia" + argVia)

        isfromcattemp = "from"
        if (argFrom == mAllStrings.mDropDownMakaniNumber) {
            _mWebServiceinstance.getDirectionLatLon(mTextFieldFrom.text, "MAKANI")
        } else if (argFrom == mAllStrings.mMapSelectedLocation) {

            if (_mWebServiceinstance.checkInvalid(mTextFieldFrom.text.replace(" ", "")) == "number") {
                _mWebServiceinstance.getDirectionLatLon(mTextFieldFrom.text, "MAKANI")

            } else if (_mWebServiceinstance.checkInvalid(mTextFieldFrom.text.replace(" ", "")) == "UAENG") {

                _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(mTextFieldFrom.text), "UAENG")

            }
        } else if (argFrom == mAllStrings.mDropDownUAENG) {
            myUAENGValue = _mWebServiceinstance.ConvertToUAENG(mTextFieldFrom.text)
            if (myUAENGValue == "") {
                mSystemDialog.body = mAllStrings.mValidationValidUAENGValue
                mSystemDialog.show()
                clearMyRouteData()
            } else {
                _mWebServiceinstance.getDirectionLatLon(myUAENGValue, "UAENG")
            }
        } else if (argFrom == mAllStrings.mserachbyland) {
            _mWebServiceinstance.setIsfromLandNumber(true)
            _mWebServiceinstance.GetParcelOutline_New(mTextFieldFrom.text.trim())
        } else if (argFrom == mAllStrings.mDropDownSelectFromFaviourites || argFrom == mAllStrings.mDropDownSelectFromContacts) {
            var tempdata = mdataFav

            console.debug("mdatafav...." + mdataFav)
            if (mDialogFav.isFrom == "from" && argFrom == mAllStrings.mDropDownSelectFromFaviourites) {
                mdataFav = mTextFieldFrom.text
                tempdata = mTextFieldFrom.text
            } else if (isChangeClicked && argFrom == mAllStrings.mDropDownSelectFromContacts) {
                mdataFav = mTextFieldFrom.text
                tempdata = mTextFieldFrom.text
            }

            if (_mWebServiceinstance.checkInvalid(mdataFav.replace(" ", "")) == "number") {
                _mWebServiceinstance.getDirectionLatLon(tempdata, "MAKANI")
            } else if (_mWebServiceinstance.validateString(mdataFav.replace(" ", "")) == "UAENG") {
                _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(tempdata), "UAENG")
            }
        } else if (argFrom == mAllStrings.mDropDownBuildingAddress) {
            _mWebServiceinstance.setcheckisFrom("from")
            _mWebServiceinstance.setcheckisdirectionbuilding(true)
            _mWebServiceinstance.GetBuildingAddress(mDialogContentSearchByBuilding.mTextFieldCommunity.text, mDialogContentSearchByBuilding.mTextFieldStreetname.text, mDialogContentSearchByBuilding.mTextFieldBuilding.text, "E")
            if (isChangeClicked) {
                console.debug("change clicked...")
                isChangeClicked = false
            }
        } else if (argFrom == mAllStrings.mDropDownPlaceName) {
            _mWebServiceinstance.setcat(false)
            isPOIFrom = true;
            /* if (isTextfromList == mTextFieldFrom.text) {
             * console.debug("in from placename condition isTextfromList matches")
             * 
             * myDirectionData()
             }*/
            if (strTextFromLat.length > 0 && strTextFromLng.length > 0) {
                console.debug("stretexy alfready filled on ilstview click i from:")

                myDirectionData()
            } else {
                _mWebServiceinstance.SetisPOITextChanging(false)
                _mWebServiceinstance.GetPOIInfo(mTextFieldFrom.text, "E", false, "searchDirection")
            }

        } else if (argFrom == mAllStrings.mDropDownCategoryAddress) {
            if (argTo == mAllStrings.mDropDownCategoryAddress) {
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            } else if (isChangeClicked) {
                _mWebServiceinstance.setcat(true)
                _mWebServiceinstance.GetPOIInfo(mTextFieldFrom.text, "E", false, "searchDirection")
                isChangeClicked = false
            } else {
                myDirectionData()
            }
        } else if (argFrom == mAllStrings.mDropDownMyLocation) {
            /*in case of if change button is pressed the value of strlat,lng
             * won't be filled so storing  the same value again
             */
            if (isChangeClicked) {
                console.debug("argFrom mylocation" + mTextFieldTo.text)
                strTextFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                strTextFromLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            }
            if (argTo == mAllStrings.mDropDownMyLocation) {

                strTextToLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                strTextToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                console.debug("argto mylocatin" + strTextToLat)
                isChangeClicked = false
                if (mTextFieldVia.text.length > 0) {
                    callViaDirectionData(checkTagDropDownVia)
                } else {
                    if (mImageViewBusBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewCarBottomBar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewWalkBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    }
                }
            } else {

                myDirectionData()
            }
        }
        mContainerDirectionExpandable.visible = true
    }

    function myDirectionData() {
        console.debug("myDirectionData checkTagDropDownFrom:- " + checkTagDropDownFrom + " checkTagDropDownTo:-" + checkTagDropDownTo + "  isfromvia:-" + isfromvia + "   isFrom:-    " + isFrom)
        if (isFrom) {

            console.debug("inside isfrom true" + checkTagDropDownTo)
            console.debug("isfromvia  :- " + isfromvia)
            isFrom = false;

            if (isfromvia != true && checkTagDropDownFrom == mAllStrings.mDropDownMakaniNumber || checkTagDropDownFrom == mAllStrings.mDropDownUAENG || checkTagDropDownFrom == mAllStrings.mDropDownSelectFromFaviourites || checkTagDropDownFrom == mAllStrings.mDropDownSelectFromContacts || checkTagDropDownFrom == mAllStrings.mserachbyland || checkTagDropDownFrom == mAllStrings.mMapSelectedLocation) {
                strTextFromLat = _mWebServiceinstance.getCCLatitude()
                strTextFromLng = _mWebServiceinstance.getCCLongitude()
                console.debug("strTextFromLat:-" + strTextFromLat)
                console.debug("strTextFromLng:-" + strTextFromLng)
                if (checkTagDropDownFrom == mAllStrings.mserachbyland) {
                    _mWebServiceinstance.setIsfromLandNumber(false)
                }
            }

            if (isfromvia == true && checkTagDropDownVia == mAllStrings.mDropDownMakaniNumber) {
                strTextViaFromLat = _mWebServiceinstance.getCCLatitude()
                strTextViaToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("isfromvia strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }
            if (isfromvia == true && checkTagDropDownVia == mAllStrings.mMapSelectedLocation) {
                strTextViaFromLat = _mWebServiceinstance.getCCLatitude()
                strTextViaToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("isfromvia strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }

            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mMapSelectedLocation) {
                if (_mWebServiceinstance.checkInvalid(mTextFieldTo.text.replace(" ", "")) == "number") {
                    _mWebServiceinstance.getDirectionLatLon(mTextFieldTo.text, "MAKANI")

                } else if (_mWebServiceinstance.checkInvalid(mTextFieldTo.text.replace(" ", "")) == "UAENG") {
                 
                    _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(mTextFieldTo.text), "UAENG")

                }
            }

            if (isfromvia == true && checkTagDropDownVia == mAllStrings.mDropDownUAENG) {
                strTextViaFromLat = _mWebServiceinstance.getCCLatitude()
                strTextViaToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("mDropDownUAENG strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }

            if (isfromvia == true && checkTagDropDownVia == mAllStrings.mserachbyland) {
                strTextViaFromLat = _mWebServiceinstance.getCCLatitude()
                strTextViaToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("Search By Land Number via strTextFromLat:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
            }
            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownSelectFromFaviourites || isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownSelectFromContacts) {
                var tempdata = mdataFavTo

                console.debug("mdatafav to :" + mdataFavTo)
                if (mDialogFav.isFrom == "to" && checkTagDropDownTo == mAllStrings.mDropDownSelectFromFaviourites) {
                    mdataFavTo = mTextFieldTo.text
                    tempdata = mTextFieldTo.text
                    isChangeClicked = false
                } else if (isChangeClicked && checkTagDropDownTo == mAllStrings.mDropDownSelectFromContacts) {
                    mdataFavTo = mTextFieldTo.text
                    tempdata = mTextFieldTo.text
                }

                if (_mWebServiceinstance.checkInvalid(mdataFavTo.replace(" ", "")) == "number") {
                    _mWebServiceinstance.getDirectionLatLon(tempdata, "MAKANI")
                } else if (_mWebServiceinstance.validateString(mdataFavTo.replace(" ", "")) == "UAENG") {
                    _mWebServiceinstance.getDirectionLatLon(_mWebServiceinstance.ConvertToUAENG(tempdata), "UAENG")
                } else {
                    mSystemDialog.body = mAllStrings.mValidationInvalidData
                    mSystemDialog.show()
                    clearMyRouteData()
                }
            }
            if (isfromvia == true && checkTagDropDownVia == mAllStrings.mDropDownSelectFromFaviourites || isfromvia == true && checkTagDropDownVia == mAllStrings.mDropDownSelectFromContacts) {
                strTextViaFromLat = _mWebServiceinstance.getCCLatitude()
                strTextViaToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("strTextFromLat mDropDownSelectFromFaviouritesOR contacts:" + strTextFromLat, "strTextFromLng:" + strTextFromLng, "strTextToLat" + strTextToLat + "strTextToLng:" + strTextToLng + "strTextViaFromLat:" + strTextViaFromLat + "strTextViaToLng" + strTextViaToLng)
                if (mImageViewBusBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModebus, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewCarBottomBar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModecar, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                } else if (mImageViewWalkBottombar.visible) {
                    _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextViaFromLat + "," + strTextViaToLng, mAllStrings.mTransitModewalk, true, strTextToLat + "," + strTextToLng, mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                }
                console.debug("after false:!!!!!!!!!!!!!!!!!!!!!!!!" + isfromvia)
            }

            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownMakaniNumber) {
                if (_mWebServiceinstance.checkInvalid(mTextFieldTo.text.replace(" ", "")) == "number") {
                    _mWebServiceinstance.getDirectionLatLon(mTextFieldTo.text, "MAKANI")
                } else {
                    mSystemDialog.body = mAllStrings.mValidationValidaMakaniValue
                    mSystemDialog.show()
                }
            }

            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mserachbyland) {
                _mWebServiceinstance.setIsfromLandNumber(true)
                _mWebServiceinstance.GetParcelOutline_New(mTextFieldTo.text.trim())
            }
            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownUAENG) {
                console.debug("in uaeng............................")
                myUAENGValueTo = _mWebServiceinstance.ConvertToUAENG(mTextFieldTo.text)
                if (myUAENGValueTo == "") {
                    mSystemDialog.body = mAllStrings.mValidationUAENGNumber
                    mSystemDialog.show()
                    clearMyRouteData()
                } else {
                    _mWebServiceinstance.getDirectionLatLon(myUAENGValueTo, "UAENG")
                }
            }
            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownBuildingAddress) {
                _mWebServiceinstance.setcheckisFrom("to")

                console.debug("in building address totextfiled:")
                _mWebServiceinstance.GetBuildingAddress(mDialogContentSearchByBuilding.mTextFieldCommunity.text, mDialogContentSearchByBuilding.mTextFieldStreetname.text, mDialogContentSearchByBuilding.mTextFieldBuilding.text, "E")
            }

            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownPlaceName) {
                _mWebServiceinstance.setcat(false)
                isPOIFrom = false;
                if (isChangeClicked) {
                    isChangeClicked = false
                }
                console.debug("isTextToList:" + isTextToList)
                if (isTextToList == mTextFieldTo.text && ! isChangeClicked) {
                    console.debug("in placename if....................")
                    _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", false, "searchDirection")
                } else if (isTextToList == "" && mTextFieldTo.text) {
                    _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", false, "searchDirection")

                }

            }

            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownMyLocation) {
                strTextToLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                strTextToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                if (mTextFieldVia.text.length > 0) {
                    callViaDirectionData(checkTagDropDownVia)
                } else {
                    if (mImageViewBusBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewCarBottomBar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewWalkBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    }
                }
            }
            isfromvia = false
        }
        //isfrom false part
        else {
            if (checkTagDropDownTo == mAllStrings.mDropDownMakaniNumber || checkTagDropDownTo == mAllStrings.mDropDownUAENG || checkTagDropDownTo == mAllStrings.mDropDownSelectFromContacts || checkTagDropDownTo == mAllStrings.mDropDownSelectFromFaviourites || checkTagDropDownTo == mAllStrings.mserachbyland || checkTagDropDownTo == mAllStrings.mMapSelectedLocation) {
                strTextToLat = _mWebServiceinstance.getCCLatitude()
                strTextToLng = _mWebServiceinstance.getCCLongitude()
                console.debug("else part my direcion data...................." + strTextToLat)
                console.debug("else part my direcion data...................." + strTextToLng)

                if (checkTagDropDownTo == mAllStrings.mserachbyland) {
                    _mWebServiceinstance.setIsfromLandNumber(false)
                }

                if (mTextFieldVia.text.length > 0) {
                    //making it true so it will go in mydirection after web service execution is success & get the results of via and stop there.
                    isFrom = true
                    console.debug("checkTagDropDownVia in else:-" + checkTagDropDownVia)
                    callViaDirectionData(checkTagDropDownVia)
                } else {
                    if (mImageViewBusBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewCarBottomBar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    } else if (mImageViewWalkBottombar.visible) {
                        _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
                    }
                }
            }
            /* if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownPlaceName) {
             * _mWebServiceinstance.setcat(false)
             * if (isChangeClicked) {
             * _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", false, "searchDirection")
             * isChangeClicked = false
             * 
             * } else if (isTextToList == mTextFieldTo.text) {
             * 
             * if (mTextFieldVia.text.length > 0) {
             * callViaDirectionData(checkTagDropDownVia)
             * } else {
             * if (mImageViewBusBottombar.visible) {
             * _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModebus, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
             * } else if (mImageViewCarBottomBar.visible) {
             * _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModecar, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
             * 
             * } else if (mImageViewWalkBottombar.visible) {
             * _mWebServiceinstance.callGoogleRoutes(_mWebServiceinstance.getUrl(strTextFromLat + "," + strTextFromLng, strTextToLat + "," + strTextToLng, mAllStrings.mTransitModewalk, false, "", mCheckBoxAvoidHighway.checked, mCheckBoxAvoidTollSalik.checked))
             * }
             * }
             * } else {
             * isPOIFrom = false;
             * _mWebServiceinstance.GetPOIInfo(mTextFieldTo.text, "E", false, "searchDirection")
             * }
             * 
             } //placename ends*/
            if (isfromvia != true && checkTagDropDownTo == mAllStrings.mDropDownCategoryAddress) {
                mdataTo = _mWebServiceinstance.getPOIlatlng()
                var data = mdataTo.split(",", mdataTo.length)
                strTextToLat = data[0]
                strTextToLng = data[1]
                callViaDirectionData(checkTagDropDownVia)
            }

        }
        //   isChangeClicked = false
    }
    function getToData() {
    }
    function getViaData() {
    }
    function setMyRoutedata() {

        //        _mWebServiceinstance.routeDataLoaded.disconnect(setMyRoutedata)

        var mStepListData = _mWebServiceinstance.getDirectionStepList()
        console.debug("setMyRoutedata :", mStepListData.length)
        if (mStepListData.length > 0) {
            parsingStepList(mStepListData)
        } else {
            mSystemDialog.body = mAllStrings.mValidationRouteNotFound
            mSystemDialog.show()
        }

    }
    function parsingStepList(mStepListData) {

        var count = mStepListData.length
        for (var i = 0; i < mStepListData.length; i ++) {

            if (i == 0) {
                mContainerDirectionExpandable.visible = true
                mContainerDirectionExpandablevia.visible = false
                mLabelRouteFrom.text = mStepListData[i].start_address
                mLabelRouteTo.text = mStepListData[i].end_address
                mLabelRouteduration.text = mStepListData[i].duration
                mLabelRoutekm.text = mStepListData[i].distance

                var mRouteSteps

                for (var j = 0; j < mStepListData[i].StepList.length; j ++) {

                    //                    console.debug("html_instructions:", mStepListData[i].StepList[j].html_instructions)
                    //                    console.debug("travel_mode:", mStepListData[i].StepList[j].travel_mode)

                    //                    var mLableObj = mComponentDefinitionLable.createObject()
                    //                    var mtext = "<html><b>" + j + " - </b> " + mStepListData[i].StepList[j].html_instructions + mAllStrings.mDirectionFollowFor + mStepListData[i].StepList[j].step_distance + "</html>"
                    //                    mLableObj.text = mtext
                    //                    mContainerStep.add(mLableObj)
                    if (j == 0) {
                        mRouteSteps = mStepListData[i].StepList[j].html_instructions + "\n"
                    } else {
                        mRouteSteps = mRouteSteps + mStepListData[i].StepList[j].html_instructions + "\n"
                    }

                }

                mLabelRouteData.text = "<html>" + mRouteSteps + "</html>"
                //                if (isDirectionOnMap && count == 1) {
                //                    console.debug("in isDirectionOnMap:" + isDirectionOnMap + "and count is:" + count)
                //                    _mWebServiceinstance.ClearMapdata()
                //                    _mWebServiceinstance.drawpinOnDecodedPolyNew(mStepListData[0], "number")
                //                    mainTabPaned.changeTab(0);
                //                }

            }

            if (i == 1) {

                mContainerDirectionExpandable.visible = true
                mContainerDirectionExpandablevia.visible = true
                mLabelRouteFromvia.text = mStepListData[i].start_address
                mLabelRouteTovia.text = mStepListData[i].end_address
                mLabelRoutedurationvia.text = mStepListData[i].duration
                mLabelRoutekmvia.text = mStepListData[i].distance

                var mRouteStepsvianew

                for (var j = 0; j < mStepListData[i].StepList.length; j ++) {

                    if (j == 0) {
                        mRouteStepsvianew = mStepListData[i].StepList[j].html_instructions + "\n"
                    } else {
                        mRouteStepsvianew = mRouteSteps + mStepListData[i].StepList[j].html_instructions + "\n"
                    }

                }
                mLabelRouteDatavia.text = "<html>" + mRouteStepsvianew + "</html>"
                //                if (isDirectionOnMap && count == 2) {
                //                    console.debug("in isDirectionOnMap:" + isDirectionOnMap + "and count is:" + count)
                //                    _mWebServiceinstance.ClearMapdata()
                //                    _mWebServiceinstance.drawpinOnDecodedPolyForVia(mTextFieldFrom.text, mTextFieldTo.text, mTextFieldVia.text)
                //                    mainTabPaned.changeTab(0);
                //                }
            }

        }
        console.debug("isDirectionOnMap :" + isDirectionOnMap + "and count is:" + count)
        if (isDirectionOnMap) {
            _mWebServiceinstance.ClearMapdata()
            //            if(mContainerVia.visible){
            //                _mWebServiceinstance.drawpinOnDecodedPoly(mTextFieldFrom.text, mTextFieldTo.text , mTextFieldVia.text)
            //            }else{
            //                _mWebServiceinstance.drawpinOnDecodedPoly(mTextFieldFrom.text, mTextFieldTo.text ,"")
            //            }
            _mWebServiceinstance.drawpinOnDecodedPoly(mTextFieldFrom.text, mTextFieldTo.text, mTextFieldVia.text)
            mainTabPaned.changeTab(0);
        }

    }
    
    function clearMyRouteData() {
        mLabelRouteData.text = ""
        mLabelRouteFrom.text = ""
        mLabelRouteTo.text = ""
        mLabelRouteduration.text = ""
        mLabelRoutekm.text = ""

        mLabelRouteDatavia.text = ""
        mLabelRouteFromvia.text = ""
        mLabelRouteTovia.text = ""
        mLabelRoutedurationvia.text = ""
        mLabelRoutekmvia.text = ""

        mContainerDirectionExpandable.visible = false
    }
    
    function whenCancelButtonHit(isFrom) {
        if (isFrom) {
            mLabelSelectFrom.text = mAllStrings.mDropDownMyLocation
            strTextFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
            strTextFromLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            mTextFieldFrom.text = strTextFromLat + "," + strTextFromLng
            mListViewFrom.mLabelValue = ""
            mListViewFromArabic.mLabelValue = ""
            mTextFieldFrom.enabled = false
            checkTagDropDownFrom = mAllStrings.mDropDownMyLocation

            if (_mAppParentObj.isNetworkAvailable()) {
                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressFrom)
                _mWebServiceinstance.reverseGeoCode();
            }
        } else {
            mLabelSelectTo.text = mAllStrings.mDropDownMyLocation
            strTextToLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
            strTextToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");

            mTextFieldTo.text = strTextToLat + "," + strTextToLng
            mListViewTo.mLabelValueTo = ""
            mListViewToArabic.mLabelValueTo = ""
            mTextFieldFrom.enabled = false
            checkTagDropDownTo = mAllStrings.mDropDownMyLocation
            if (_mAppParentObj.isNetworkAvailable()) {
                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressTo)
                _mWebServiceinstance.reverseGeoCode();
            }

        }
    }
    
    function whenCancelButtonHitVia() {
        mLabelVia.text = mAllStrings.mDropDownMyLocation

        strTextViaFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
        strTextViaToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");

        mTextFieldVia.text = strTextViaFromLat + "," + strTextViaToLng

        mTextFieldVia.enabled = false
        checkTagDropDownVia = mAllStrings.mDropDownMyLocation
        if (_mAppParentObj.isNetworkAvailable()) {
            _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressVia)
            _mWebServiceinstance.reverseGeoCode();
        }
    }
    
    function getMyLocationAddressFrom() {
        _mWebServiceinstance.getMyLocationDone.disconnect(getMyLocationAddressFrom)
        if (_mWebServiceinstance.getMyLocation().length > 0)
            mTextFieldFrom.text = _mWebServiceinstance.getMyLocation();
        if (isReverseGeoCodeFromMap) {
            isReverseGeoCodeFromMap = false;
            callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
        }
    }
    
    function getMyLocationAddressVia() {
        _mWebServiceinstance.getMyLocationDone.disconnect(getMyLocationAddressVia)
        if (_mWebServiceinstance.getMyLocation().length > 0)
            mTextFieldVia.text = _mWebServiceinstance.getMyLocation();
        if (isReverseGeoCodeFromMap) {
            isReverseGeoCodeFromMap = false;
        }
    }
    
    function setmybuildingAddressData() {

    }
    
    function getMyLocationAddressTo() {
        _mWebServiceinstance.getMyLocationDone.disconnect(getMyLocationAddressTo)
        if (_mWebServiceinstance.getMyLocation().length > 0)
            mTextFieldTo.text = _mWebServiceinstance.getMyLocation();
        if (isReverseGeoCodeFromMap) {
            isReverseGeoCodeFromMap = false;
            callmyDirectionData(checkTagDropDownFrom, checkTagDropDownTo, checkTagDropDownVia)
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        TextStyleDefinition {
            id: mStyleForLabel
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTab
            imageSource: "asset:///images/favourites/bg_text.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionDirectionsExpand
            imageSource: "asset:///images/screens/bg_convert_blue.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionForButton
            imageSource: "asset:///images/directions/Get-Directions_btn.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitiontap
            imageSource: "asset:///images/directions/tab_hover.png"
        },
        SystemToast {
            id: myQmlToast
            body: mAllStrings.mqmlToast
            onFinished: {
            }
        },
        Dialog {
            id: mDialogBuildingAddress
            onOpenedChanged: {
                if (opened) {
                    mDialogContentSearchByBuilding.resetData();
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                background: Color.create(0, 0, 0, 0.5)
                layout: DockLayout {
                }
                Container {
                    id: mContainerBuildingAddress
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    background: Color.White
                    CommonTopBar {
                        mText: mAllStrings.mSearchByBuildingAddress
                    }
                    SearchbyBuilding {
                        id: mDialogContentSearchByBuilding
                        topPadding: 40
                        leftPadding: 25
                        rightPadding: 25
                        bottomPadding: 25
                        visible: true
                        isFromSearch: false
                        onCreationCompleted: {
                            setAlignMentBuilding()
                            
                        }
                    }
                }
            }
        } //dialog buidling address ends
,
        ContactPicker {
            id: contactPicker
            onCanceled: {
//                var mVar = mAllStrings.mDropDownMyLocation;
//                if (isContactFrom == "from") {
//                    whenCancelButtonHit(true)
//                } else if (isContactFrom == "to") {
//                    whenCancelButtonHit(false)
//                } else if (isContactFrom == "via") {
//                    whenCancelButtonHitVia()
//                }
            }
            
            onContactSelected: {
                if (isContactFrom == "from") {
                    mdataFav = _mWebServiceinstance.getcontactNumber(contactId);
                    mTextFieldFrom.text = mdataFav

                } else if (isContactFrom == "to") {
                    mdataFavTo = _mWebServiceinstance.getcontactNumber(contactId);
                    mTextFieldTo.text = mdataFavTo
                } else if (isContactFrom == "via") {
                    mdataFavVia = _mWebServiceinstance.getcontactNumber(contactId)
                    mTextFieldVia.text = mdataFavVia
                }
            }

        },
        Dialog {
            id: mDialogFaviourites
            DirectionFavDialog {
                id: mDialogFav
            }
        },
        Dialog {
            id: mDialogCategory
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                background: Color.create(0, 0, 0, 0.5)
                layout: DockLayout {
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    background: Color.White
                    CommonTopBar {
                        mText: mAllStrings.mDropDownCategoryAddress
                    }

                    SearchCategory {
                        id: mSearchCategory
                        topPadding: 40
                        leftPadding: 25
                        rightPadding: 25
                        bottomPadding: 25
                        visible: true
                        isFromDirection: true
                        mtextfiled: isFromforDialog == "from" ? mTextFieldFrom : (isFromforDialog == "via" ? mTextFieldVia : mTextFieldTo)
                        onCreationCompleted: {
                            setAlignMent()
                        }
                    }
                }
            }
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionDirectionBG
            imageSource: "asset:///images/home/bg_search.png"
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
                mDialogCommonListContentSelectFrom.setAlignMent()
            }
            DialogCommonList {
                id: mDialogCommonListContentSelectFrom
                mModel: mModelSelectFrom
                mlabelDialog: isFromforDialog == "from" ? mAllStrings.mDropDownSelectFrom : (isFromforDialog == "via" ? mAllStrings.mSelectDestination : mAllStrings.mSelectDestination)
                onCloseClick: {
                    console.debug("onCloseClick")
                    if (isFromforDialog == "from") {
                        mLabelSelectFrom.text = mAllStrings.mDropDownSelectFrom
                        mTextFieldFrom.text = ""
                        mTextFieldFrom.enabled = false
                    } else if (isFromforDialog == "via") {
                        mLabelVia.text = mAllStrings.mSelectDestination
                        mTextFieldVia.text = ""
                        mTextFieldVia.enabled = false
                    } else if (isFromforDialog == "to") {
                        mLabelSelectTo.text = mAllStrings.mSelectDestination
                        mTextFieldTo.text = ""
                        mTextFieldTo.enabled = false
                    }
                }
                onDoneClick: {
                    mDialogCommonList.close()
                    if (isFromforDialog == "from") {
                        mTextFieldFrom.enabled = true
                        mContainerDirectionExpandable.enabled = false
                        mLabelSelectFrom.text = selectedData.my_selectFromData
                        checkTagDropDownFrom = selectedData.my_selectFromData

                        // mContainerDest1Arrow.visible = true
                        if (checkTagDropDownFrom == mAllStrings.mDropDownMakaniNumber || checkTagDropDownFrom == mAllStrings.mDropDownPlaceName || checkTagDropDownFrom == mAllStrings.mDropDownUAENG) {
                            mTextFieldFrom.text = ""
                        }
                        if (checkTagDropDownFrom == mAllStrings.mMapSelectedLocation) {
                            mTextFieldFrom.enabled = false
                            //    mTextFieldFrom.text = _mWebServiceinstance.getMapCaptionText()
                            mTextFieldFrom.text = _mWebServiceinstance.getValueFor("lastselectedlocation", "")

                        }
                        if (checkTagDropDownFrom == mAllStrings.mserachbyland) {
                            mTextFieldFrom.text = ""

                        }

                        if (checkTagDropDownFrom == mAllStrings.mDropDownMyLocation) {
                            strTextFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                            strTextFromLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                            //   mTextFieldFrom.text = strTextFromLat + "," + strTextFromLng
                            mListViewFrom.mLabelValue = ""
                            mListViewFromArabic.mLabelValue = ""
                            mTextFieldFrom.enabled = false
                            if (_mAppParentObj.isNetworkAvailable()) {
                                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressFrom)
                                //_mWebServiceinstance.reverseGeoCode();
                                _mWebServiceinstance.callGoogleReverceGeoCodeApi();
                            }
                        }
                        if (checkTagDropDownFrom == mAllStrings.mDropDownCategoryAddress) {
                            _mWebServiceinstance.mymodelservice.clear()
                            _mWebServiceinstance.GetAllServices("GetAllServicesSearch");
                            mSearchCategory.resetAllField()
                            setValueFromOrTo = true
                            mDialogCategory.open()
                        }
                        if (checkTagDropDownFrom == mAllStrings.mDropDownBuildingAddress) {
                            mDialogContentSearchByBuilding.mTextFieldSetData = mTextFieldFrom
                            //  _mWebServiceinstance.setcheckisdirectionbuilding(true)
                            mDialogContentSearchByBuilding.isfromDirectionbuilding = true
                            mDialogContentSearchByBuilding.mdialog = mDialogBuildingAddress
                            mDialogBuildingAddress.open()
                            mTextFieldFrom.enabled = false;
                            mTextFieldFrom.text = ""
                            if (_mAppParentObj.isNetworkAvailable()) {
                                _mWebServiceinstance.GetAllCommunities("E");
                                _mWebServiceinstance.setcheckisFrom("from")
                            } else {
                                mSystemDialog.body = mAllStrings.mNetworkCheck
                                mSystemDialog.show()
                            }

                        } else if (checkTagDropDownFrom == mAllStrings.mDropDownSelectFromContacts) {
                            isContactFrom = "from";
                            contactPicker.open()
                            mTextFieldFrom.enabled = false;
                            mTextFieldFrom.text = ""
                        } else if (checkTagDropDownFrom == mAllStrings.mDropDownSelectFromFaviourites) {
                            mDialogFav.mTextFieldSetDataFav = mTextFieldFrom
                            mDialogFav.isFrom = "from";
                            mDialogFav.setAlignMent();
                            mDialogFav.fromwhere = "From"
                            mDialogFaviourites.open()
                            mTextFieldFrom.enabled = false;
                        } else if (checkTagDropDownFrom == mAllStrings.mDropDownMyLocation || checkTagDropDownFrom == mAllStrings.mDropDownSelectFrom) {
                            mTextFieldFrom.enabled = false;
                        } else {
                            mTextFieldFrom.enabled = true;
                        }
                    } else if (isFromforDialog == "via") {
                        console.debug("isFromforDialog via called")
                        mTextFieldVia.enabled = true
                        //isfromvia = true
                        //   mContainerDest2Arrow.enabled = true
                        mLabelVia.text = selectedData.my_selectFromData
                        checkTagDropDownVia = selectedData.my_selectFromData
                        if (checkTagDropDownVia == mAllStrings.mDropDownMakaniNumber || checkTagDropDownVia == mAllStrings.mDropDownPlaceName || checkTagDropDownVia == mAllStrings.mDropDownUAENG) {
                            mTextFieldVia.text = ""
                        }
                        if (checkTagDropDownVia == mAllStrings.mMapSelectedLocation) {
                            // mTextFieldVia.text = _mWebServiceinstance.getMapCaptionText()
                            mTextFieldVia.text = _mWebServiceinstance.getValueFor("lastselectedlocation", "")
                            mTextFieldVia.enabled = false
                        }
                        if (checkTagDropDownVia == mAllStrings.mserachbyland) {
                            mTextFieldVia.text = ""
                        }
                        if (checkTagDropDownVia == mAllStrings.mDropDownMyLocation) {
                            strTextViaFromLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                            strTextViaToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");

                            mLabelVia.text = mAllStrings.mDropDownMyLocation
                            //  mTextFieldVia.text = strTextViaFromLat + "," + strTextViaToLng

                            if (_mAppParentObj.isNetworkAvailable()) {
                                _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressVia)
                                //_mWebServiceinstance.reverseGeoCode();
                                _mWebServiceinstance.callGoogleReverceGeoCodeApi();
                            }
                        }
                        if (checkTagDropDownVia == mAllStrings.mDropDownCategoryAddress) {
                            _mWebServiceinstance.mymodelservice.clear()
                            _mWebServiceinstance.GetAllServices("GetAllServicesSearch");
                            mSearchCategory.resetAllField()
                            mDialogCategory.open()
                        }
                        if (checkTagDropDownVia == mAllStrings.mDropDownBuildingAddress) {
                            mDialogContentSearchByBuilding.mTextFieldSetData = mTextFieldVia
                            // _mWebServiceinstance.setcheckisdirectionbuilding(true)
                            mDialogContentSearchByBuilding.isfromDirectionbuilding = true
                            mDialogContentSearchByBuilding.mdialog = mDialogBuildingAddress
                            mDialogBuildingAddress.open()

                            mTextFieldVia.enabled = false
                            mTextFieldVia.text = ""

                            if (_mAppParentObj.isNetworkAvailable()) {
                                _mWebServiceinstance.GetAllCommunities("E");
                                _mWebServiceinstance.setcheckisFrom("via")
                            } else {
                                mSystemDialog.body = mAllStrings.mNetworkCheck
                                mSystemDialog.show()
                            }

                        } else if (checkTagDropDownVia == mAllStrings.mDropDownSelectFromContacts) {
                            isContactFrom = "via";
                            contactPicker.open()
                            mTextFieldVia.enabled = false
                        } else if (checkTagDropDownVia == mAllStrings.mDropDownSelectFromFaviourites) {
                            mDialogFav.mTextFieldSetDataFav = mTextFieldVia
                            mDialogFav.isFrom = "via";
                            mDialogFav.setAlignMent();
                            mDialogFav.fromwhere = "Via"
                            mDialogFaviourites.open()
                            mTextFieldVia.enabled = false
                        } else if (checkTagDropDownVia == mAllStrings.mDropDownMyLocation || checkTagDropDownVia == mAllStrings.mDropDownSelectTo) {
                            mTextFieldVia.enabled = false
                        } else {
                            mTextFieldVia.enabled = true
                        }
                        //via ends
                    } else {
                        mTextFieldTo.enabled = true
                        mContainerDirectionExpandable.visible = false
                        mListViewToArabic.visible = false
                        checkTagDropDownTo = selectedData.my_selectFromData
                        mLabelSelectTo.text = selectedData.my_selectFromData
                        //  mContainerDest1Arrow.enabled = true
                        if (checkTagDropDownTo == mAllStrings.mDropDownMakaniNumber || checkTagDropDownTo == mAllStrings.mDropDownPlaceName || checkTagDropDownTo == mAllStrings.mDropDownUAENG) {
                            mTextFieldTo.text = ""
                        }
                        if (checkTagDropDownTo == mAllStrings.mMapSelectedLocation) {
                            //  mTextFieldTo.text = _mWebServiceinstance.getMapCaptionText()
                            mTextFieldTo.text = _mWebServiceinstance.getValueFor("lastselectedlocation", "")
                            mTextFieldTo.enabled = false
                        }
                        if (checkTagDropDownTo == mAllStrings.mserachbyland) {
                            mTextFieldTo.text = ""
                        }
                        if (checkTagDropDownTo == mAllStrings.mDropDownMyLocation) {
                            strTextToLat = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                            strTextToLng = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
                            // mTextFieldTo.text = strTextToLat + "," + strTextToLng
                            console.debug(".......strTextToLat......." + strTextToLat + ".......strTextToLng......." + strTextToLng)
                            mListViewTo.mLabelValueTo = ""
                            mListViewToArabic.mLabelValueTo = ""
                            mTextFieldTo.enabled = false
                            _mWebServiceinstance.getMyLocationDone.connect(getMyLocationAddressTo)
                            if (_mAppParentObj.isNetworkAvailable()) {
                                // _mWebServiceinstance.reverseGeoCode();
                                _mWebServiceinstance.callGoogleReverceGeoCodeApi();
                            }
                        }
                        if (checkTagDropDownTo == mAllStrings.mDropDownCategoryAddress) {
                            _mWebServiceinstance.mymodelservice.clear()
                            setValueFromOrTo = false
                            _mWebServiceinstance.GetAllServices("GetAllServicesSearch");
                            mSearchCategory.resetAllField()
                            mDialogCategory.open()
                        }
                        if (checkTagDropDownTo == mAllStrings.mDropDownBuildingAddress) {
                            mDialogContentSearchByBuilding.mTextFieldSetData = mTextFieldTo
                            //_mWebServiceinstance.setcheckisdirectionbuilding(true)
                            mDialogContentSearchByBuilding.isfromDirectionbuilding = true
                            mDialogContentSearchByBuilding.mdialog = mDialogBuildingAddress
                            mDialogBuildingAddress.open() //referrenced from srearch b building to set textfiled
                            mTextFieldTo.enabled = false;
                            mTextFieldTo.text = ""
                            if (_mAppParentObj.isNetworkAvailable()) {
                                _mWebServiceinstance.GetAllCommunities("E");
                                _mWebServiceinstance.setcheckisFrom("to")
                            } else {
                                mSystemDialog.body = mAllStrings.mNetworkCheck
                                mSystemDialog.show()
                            }
                        } else if (checkTagDropDownTo == mAllStrings.mDropDownSelectFromContacts) {
                            isContactFrom = "to";
                            contactPicker.open()
                            mTextFieldTo.enabled = false;
                            mTextFieldTo.text = ""
                        } else if (checkTagDropDownTo == mAllStrings.mDropDownSelectFromFaviourites) {
                            mDialogFav.mTextFieldSetDataFav = mTextFieldTo
                            mDialogFav.isFrom = "to";
                            mDialogFav.setAlignMent();
                            mDialogFav.fromwhere = "To"
                            mDialogFaviourites.open()
                            mTextFieldTo.enabled = false;
                            mTextFieldTo.text = ""
                        } else if (checkTagDropDownTo == mAllStrings.mDropDownMyLocation || checkTagDropDownTo == mAllStrings.mDropDownSelectTo) {
                            mTextFieldTo.enabled = false;
                        } else {
                            mTextFieldTo.enabled = true;
                        }
                    }
                }
            }
        },
        GroupDataModel {
            id: mModelSelectFrom
            grouping: ItemGrouping.None
        },
        ImagePaintDefinition {
            id: mImagePaintTextFieldBG
            imageSource: "asset:///images/directions/text_bg.png"
        }
    ]
    paneProperties: [
        NavigationPaneProperties {
            backButton: ActionItem {
                title: mAllStrings.mBack
                onTriggered: {
                    mNavigationPaneMain.pop();
                    _mWebServiceinstance.directionServiceDataLoaded.disconnect(myDirectionData)
                    _mWebServiceinstance.routeDataLoaded.disconnect(setMyRoutedata)
                    _mWebServiceinstance.poidataloaded.disconnect(getpoidata)
                    _mWebServiceinstance.buildingDataLoaded.disconnect(getbuildingaddressData)
                    _mWebServiceinstance.catdataload.disconnect(callCat)
                    clearMyRouteData()
                }
            }
        }
    ]
}
// ***********************************************************************************************************
//  SEARCH NEAR BY LOCATION MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
import bb.system 1.2

Page {
    property int intTotalDataCount: 0
    property int intSelectedDataCount: 0
    property bool isFromMap: false
    property string mStringShareData
    property string mapLatitude
    property string mapLongitude
    property string serviceID
    property string mCategoryID
    property NavigationPane mNavigationPane
    // GETTING NEAR BY COORINDATES 
    function callNearBy(id, latitude, longitude) {
        if (_mAppParentObj.isNetworkAvailable()) {
            // _mWebServiceinstance.GetPOIFromNearestLocation(id, latitude, longitude);
            mapLatitude = latitude;
            mapLongitude = longitude;
            console.debug("mapLatitude:-" + mapLatitude)
            console.debug("mapLongitude:-" + mapLongitude)

        } else {
            mSystemDialog.body = mAllString.mNetworkCheck
            mSystemDialog.show()
        }

    }
    function setmypage(mnavpane) {
        mNavigationPane = mnavpane
        mNavigationPane.peekEnabled = false
    }
    // CLEAR DATA AFTER REALOD
    function clearAllData() {

        mTextFieldCategory.text = ""
        mTextFieldType.text = ""
        mLabelHospital.text = ""
        mTextAreaDistance.text = ""
        mTextAreaNearest.text = "10"
        mCheckBoxNearest.checked = true
        mContainerTextFiledNearest.enabled = true
        mCheckBoxDistance.checked = false
        mContainerTextFiledDistance.enabled = false

    }
    // LANGUAGE CHANGE SETUP FILE
    function setAlignMent() {
        mCheckBoxNearest.checked = true
        mContainerTextFiledNearest.enabled = true
        mCheckBoxDistance.checked = false
        mContainerTextFiledDistance.enabled = false
        mTextFieldCategory.text = ""
        mTextFieldType.text = ""
        mLabelHospital.text = ""
        mTextAreaDistance.text = ""
        mTextAreaNearest.text = "10"
        _mWebServiceinstance.mymodelservice.clear()
        _mWebServiceinstance.mymodelcategory.clear()
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerCategory.layout.orientation = LayoutOrientation.LeftToRight
            mContainerType.layout.orientation = LayoutOrientation.LeftToRight
            mContainerRange.horizontalAlignment = HorizontalAlignment.Left
            mContainerRange.leftPadding = ui.du(3)
            mContainerNearest.layout.orientation = LayoutOrientation.LeftToRight
            mCheckBoxDistance.horizontalAlignment = HorizontalAlignment.Left
            mTextFieldCategory.textStyle.textAlign = TextAlign.Left
            mTextFieldType.textStyle.textAlign = TextAlign.Left
            mLabelDistance.textStyle.textAlign = TextAlign.Left
            mLabelRange.textStyle.textAlign = TextAlign.Left
            mContainerCategoryArrow.horizontalAlignment = HorizontalAlignment.Right
            mContainerTypeArrow.horizontalAlignment = HorizontalAlignment.Right
            mContainerArrow.horizontalAlignment = HorizontalAlignment.Right

            mContainerNearest.layout.orientation = LayoutOrientation.LeftToRight
            mContainerDistance.layout.orientation = LayoutOrientation.LeftToRight
            mLabelNearest.textStyle.textAlign = TextAlign.Left
            mLabelDistance.textStyle.textAlign = TextAlign.Left
            mLabelHospital.textStyle.textAlign = TextAlign.Left
            mLabelMeter.textStyle.textAlign = TextAlign.Left
            mTextAreaNearest.horizontalAlignment = HorizontalAlignment.Left
            mTextAreaNearest.textStyle.textAlign = TextAlign.Left
            mTextAreaDistance.textStyle.textAlign = TextAlign.Left
        } else {
            mContainerRange.rightPadding = ui.du(3)
            mContainerCategory.layout.orientation = LayoutOrientation.RightToLeft
            mContainerType.layout.orientation = LayoutOrientation.RightToLeft
            mContainerRange.horizontalAlignment = HorizontalAlignment.Right
            mContainerNearest.layout.orientation = LayoutOrientation.RightToLeft
            mCheckBoxDistance.horizontalAlignment = HorizontalAlignment.Right
            mTextFieldCategory.textStyle.textAlign = TextAlign.Right
            mTextFieldType.textStyle.textAlign = TextAlign.Right
            mLabelDistance.textStyle.textAlign = TextAlign.Right
            mLabelRange.textStyle.textAlign = TextAlign.Right
            mLabelDistance.rightPadding = ui.du(3)
            mContainerNearest.leftPadding = ui.du(3)

            //two check container
            mContainerNearest.layout.orientation = LayoutOrientation.RightToLeft
            mContainerDistance.layout.orientation = LayoutOrientation.RightToLeft
            mLabelNearest.textStyle.textAlign = TextAlign.Right
            mLabelDistance.textStyle.textAlign = TextAlign.Right
            mLabelHospital.textStyle.textAlign = TextAlign.Right
            mLabelMeter.textStyle.textAlign = TextAlign.Right
            mContainerArrow.horizontalAlignment = HorizontalAlignment.Left
            mTextAreaNearest.textStyle.textAlign = TextAlign.Right
            mTextAreaDistance.textStyle.textAlign = TextAlign.Right
            mContainerCategoryArrow.horizontalAlignment = HorizontalAlignment.Left
            mContainerTypeArrow.horizontalAlignment = HorizontalAlignment.Left
            mTextAreaNearest.horizontalAlignment = HorizontalAlignment.Right
            mTextAreaNearest.textStyle.textAlign = TextAlign.Right
            mTextAreaDistance.textStyle.textAlign = TextAlign.Right
        }

    }
    function clearAllNearByText() {
        mTextFieldCategory.text = ""
        mTextFieldType.text = ""
        mLabelHospital.text = ""
        mTextAreaDistance.text = ""
        mTextAreaNearest.hintText = "10"
    }
    // ALERT SHOWING
    function noDataFoundError() {
        _mWebServiceinstance.noDataFound.disconnect(noDataFoundError);
        _mWebServiceinstance.modelNearBychanged.disconnect(nearByResponseSuccess)
        mSystemDialog.body = mAllString.mValidationNoDataFound
        mSystemDialog.show()
        mdialoglist.close()
        mdialoglistArabic.close()
        mdialoglistTypeArabic.close()
        mdialoglistTypeEnglish.close()
    }
    // KM CONVERTOR FUNCTION
    function showKilometers(mMeters) {
        var meters = mMeters;
        var kilometers = 0.0;

        kilometers = meters * 0.001;

        return kilometers

    }

    onCreationCompleted: {

        mTextFieldCategory.text = ""
        mTextFieldType.text = ""
        mLabelHospital.text = ""
        serviceID = ""
        mCheckBoxNearest.checked = true
        mContainerNearest.enabled = true
        mCheckBoxDistance.checked = false
        mContainerDistance.enabled = false
        _mWebServiceinstance.mymodelservice.clear()
        _mWebServiceinstance.mymodelcategory.clear()
       // _mWebServiceinstance.noDataFound.connect(noDataFoundError);
       // _mWebServiceinstance.modelNearBychanged.connect(nearByResponseSuccess)
        setAlignMent();
    }
    function nearByResponseSuccess() {
        /* _mWebServiceinstance.noDataFound.disconnect(noDataFoundError);
         _mWebServiceinstance.modelNearBychanged.disconnect(nearByResponseSuccess)*/
        // mTextFieldCategory.text = ""
        //mTextFieldType.text = ""
        //mLabelHospital.text = ""
        //mTextAreaDistance.text = ""
        //mTextAreaNearest.hintText = "10"
        // mCategoryID = ""

        var mpage = mNearByDetails.createObject()
        mpage.mNavigationPaneNearBy = mNavigationPane
        mpage.mModelTotalSize = _mWebServiceinstance.mymodelNearBy.size()
        mpage.isComeFromMap = isFromMap
        _mWebServiceinstance.noDataFound.disconnect(noDataFoundError);
        _mWebServiceinstance.modelNearBychanged.disconnect(nearByResponseSuccess)
        mNavigationPane.push(mpage)
    }
    function onGetAllServicesDataLoaded() {
        mDialogCommonListContent.mActivityIndicator.stop()
        _mWebServiceinstance.modelservicechanged.disconnect(onGetAllServicesDataLoaded)
    }
    function oncategoryDataLoaded() {
        _mWebServiceinstance.modelcategorychanged.disconnect(oncategoryDataLoaded)
        mDialogCommonListContentType.mActivityIndicator.stop()
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        CommonTopBar {
            mText: mAllString.mNeraby
        }
        ScrollView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                onCreationCompleted: {

                }
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                // NEAR BY CATEGORY LOAD SETUP
                Container {
                    id: mContainerCategory
                    leftPadding: ui.du(3)
                    rightPadding: ui.du(3)
                    topPadding: ui.du(3)
                    touchPropagationMode: TouchPropagationMode.PassThrough
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Left
                        verticalAlignment: VerticalAlignment.Center
                        text: mAllString.mDialogTilteCategory
                        textStyle {
                            color: Color.Black
                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.2
                        }
                    }
                    Container {
                        preferredWidth: 450
                        background: mImagePaintDefinitionTextFied.imagePaint
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Center

                        layout: DockLayout {

                        }

                        TextField {
                            id: mTextFieldCategory
                            backgroundVisible: false
                            preferredWidth: 400
                            enabled: false

                            //  text: "Communication Services"
                            horizontalAlignment: HorizontalAlignment.Fill
                            hintText: mAllString.mDialogTilteCategory
                            //                            hintText: mAllString.mNearByCategory
                        }
                        Container {
                            id: mContainerCategoryArrow
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: ui.du(2)
                            rightPadding: ui.du(2)
                            layout: DockLayout {

                            }

                            /* ImageButton {
                             * defaultImageSource: "asset:///images/more/button_arrw.png"
                             * pressedImageSource: "asset:///images/more/button_arrw.png"
                             * disabledImageSource: "asset:///images/more/button_arrw.png"
                             }*/
                            ImageView {
                                imageSource: "asset:///images/more/button_arrw.png"
                            }

                        }
                        onTouch: {
                            if (event.isUp()) {
                                console.debug("in is up..........mear by")
                                _mWebServiceinstance.modelservicechanged.connect(onGetAllServicesDataLoaded)
                                _mWebServiceinstance.GetAllServices("GetAllServicesSearch")
                                _mWebServiceinstance.mymodelservice.clear()
                                mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelservice
                                mDialogCommonListContent.mlabelDialog = mAllString.mDialogTilteCategory
                                //  _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? mdialoglist.open() : mdialoglistArabic.open()
                                mDialogCommonList.open()
                                mDialogCommonListContent.mActivityIndicator.start()
                                if (_mAppParentObj.isNetworkAvailable()) {

                                } else {
                                    mSystemDialog.body = mAllString.mNetworkCheck
                                    mSystemDialog.show()
                                }
                            }
                        }

                    }

                }
                // NEAR BY TYPE LOAD SETUP
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
                        text: mAllString.mFeedBackType
                        textStyle {
                            color: Color.Black
                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.2
                        }
                    }
                    Container {

                        preferredWidth: 450
                        background: mImagePaintDefinitionTextFied.imagePaint
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Center
                        layout: DockLayout {

                        }

                        TextField {
                            id: mTextFieldType
                            backgroundVisible: false
                            // hintText: "Type"
                            enabled: false
                            hintText: mAllString.mFeedBackType

                            horizontalAlignment: HorizontalAlignment.Fill

                        }
                        Container {
                            id: mContainerTypeArrow
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            leftPadding: ui.du(2)
                            rightPadding: ui.du(2)
                            layout: DockLayout {

                            }

                            /* ImageButton {
                             * defaultImageSource: "asset:///images/more/button_arrw.png"
                             * pressedImageSource: "asset:///images/more/button_arrw.png"
                             * disabledImageSource: "asset:///images/more/button_arrw.png"
                             }*/
                            ImageView {
                                imageSource: "asset:///images/more/button_arrw.png"
                            }
                        }
                        onTouch: {
                            if (event.isUp()) {
                                if (_mAppParentObj.isNetworkAvailable()) {
                                    if (mTextFieldCategory.text.length == 0) {
                                        // mSystemDialog.body = "Enter data in category field"
                                        mSystemDialog.body = mAllStrings.mNearByvalidationtype
                                        mSystemDialog.show()

                                    } else {

                                        _mWebServiceinstance.GetCategoriesByServiceID(_mWebServiceinstance.getServiceId())
                                        _mWebServiceinstance.mymodelcategory.clear()
                                        mDialogCommonListContentType.mModel = _mWebServiceinstance.mymodelcategory
                                        mDialogCommonListContentType.mlabelDialog = mAllString.mFeedBackType
                                        _mWebServiceinstance.modelcategorychanged.connect(oncategoryDataLoaded)
                                        mDialogCommonListContentType.mActivityIndicator.start()
                                        mDialogCommonListType.open()

                                        /*
                                         * _mWebServiceinstance.GetCategoriesByServiceID(_mWebServiceinstance.getServiceId())
                                         * mDialogCommonListContentType.mModel = _mWebServiceinstance.mymodelcategory
                                         * mDialogCommonListContentType.mlabelDialog = mAllString.mFeedBackType
                                         * _mWebServiceinstance.modelcategorychanged.connect(oncategoryDataLoaded)
                                         * mDialogCommonListContentType.mActivityIndicator.start()
                                         mDialogCommonListType.open()*/
                                        //   _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? mdialoglistTypeEnglish.open() : mdialoglistTypeArabic.open()
                                    }
                                } else {
                                    mSystemDialog.body = mAllString.mNetworkCheck
                                    mSystemDialog.show()

                                }
                            }
                        }
                    }

                }
                Divider {
                    topMargin: ui.du(3)
                }
                Container {
                    leftPadding: ui.du(3)
                    id: mContainerRange
                    Label {
                        id: mLabelRange
                        horizontalAlignment: HorizontalAlignment.Left
                        text: mAllStrings.mdirectionSearchranges
                        textStyle.color: Color.Black
                    }
                }
                
                // NEAREST SHOWING UI SETUP
                Container {
                    id: mContainerNearest
                    topPadding: 30
                    bottomPadding: 30
                    leftPadding: 30
                    rightPadding: 30
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    CheckBox {
                        id: mCheckBoxNearest
                        checked: true

                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.1
                        }
                        onTouch: {
                            if (event.isUp()) {
                                if (mCheckBoxNearest.checked) {
                                    mContainerTextFiledDistance.enabled = false
                                    mContainerTextFiledNearest.enabled = true
                                    // mCheckBoxDistance.checked = ! mCheckBoxDistance.checked

                                    mTextAreaDistance.text = ""
                                    mCheckBoxNearest.checked = true
                                } else {
                                    mCheckBoxNearest.checked = true
                                    mCheckBoxDistance.checked = false
                                    mContainerTextFiledDistance.enabled = false
                                    mContainerTextFiledNearest.enabled = true
                                }
                            }
                        }
                        //                onCheckedChanged: {
                        //                    if (checked) {
                        //                        mContainerTextFiledDistance.enabled = false
                        //                        mContainerTextFiledNearest.enabled = true
                        //                        // mCheckBoxDistance.checked = ! mCheckBoxDistance.checked
                        //
                        //                        mTextAreaDistance.text = ""
                        //                        mCheckBoxDistance.checked = false
                        //                    }

                        //                    if(mCheckBoxDistance.checked){
                        //                        mCheckBoxDistance.checked = false
                        //                        mCheckBoxNearest.checked = true
                        //                    }
                        //                }
                    }
                    Label {
                        id: mLabelNearest
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: mAllString.mNearByNearest
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.8
                        }

                    }
                    Container {
                        id: mContainerTextFiledNearest
                        background: mImagePaintDefinitionTextFied.imagePaint
                        horizontalAlignment: HorizontalAlignment.Fill
                        layout: DockLayout {
                        }
                        TextField {
                            id: mTextAreaNearest
                            backgroundVisible: false
                            textStyle.textAlign: TextAlign.Left
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            //hintText: "10"
                            enabled: false
                            text: "10"
                        }
                        Container {
                            id: mContainerArrow
                            rightPadding: 10
                            leftPadding: 10
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            layout: StackLayout {

                            }
                            ImageView {
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Center
                                imageSource: "asset:///images/more/button_arrw.png"
                            }
                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.6
                        }
                        onTouch: {
                            if (event.isUp()) {
                                if (mCheckBoxNearest.checked) {
                                    _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? mdialoglistNearest.open() : mdialoglistNearestArabic.open()
                                }
                            }
                        }
                    }
                    Label {
                        id: mLabelHospital
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: "Hospital"
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.6
                        }
                    }

                }
                // DISTANCE SHOWING UI SETUP
                Container {
                    id: mContainerDistance
                    leftPadding: 30
                    rightPadding: 30
                    enabled: false
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    CheckBox {
                        id: mCheckBoxDistance
                        visible: true
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.1
                        }
                        onTouch: {
                            if (event.isUp()) {
                                if (mCheckBoxDistance.checked) {
                                    mContainerTextFiledNearest.enabled = false
                                    mContainerTextFiledDistance.enabled = true
                                    mTextAreaDistance.enabled = true
                                    mTextAreaDistance.text = ""
                                    // mCheckBoxNearest.checked = ! mCheckBoxNearest.checked
                                    mCheckBoxDistance.checked = true
                                } else {
                                    mCheckBoxNearest.checked = false
                                    mCheckBoxDistance.checked = true
                                    mContainerTextFiledNearest.enabled = false
                                    mContainerTextFiledDistance.enabled = true
                                    mTextAreaDistance.enabled = true
                                }
                            }
                        }
                        //                onCheckedChanged: {
                        //                    if (checked) {
                        //                        mContainerTextFiledNearest.enabled = false
                        //                        mContainerTextFiledDistance.enabled = true
                        //                        mTextAreaDistance.text = ""
                        //                        // mCheckBoxNearest.checked = ! mCheckBoxNearest.checked
                        //                        mCheckBoxNearest.checked = false
                        //                    }else{
                        //                        mCheckBoxDistance.checked = true
                        //                    }
                        //
                        //
                        //
                        //                }
                    }
                    Label {
                        id: mLabelDistance
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: mAllString.mdirectionDistanceWithin
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.8
                        }
                    }
                    Container {
                        id: mContainerTextFiledDistance
                        background: mImagePaintDefinitionTextFied.imagePaint
                        layout: DockLayout {
                        }
                        TextField {
                            id: mTextAreaDistance
                            backgroundVisible: false
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            input.keyLayout: KeyLayout.Number
                            hintText: ""

                            enabled: false
                            // textStyle.textAlign: TextAlign.Right
                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.6
                        }
                    }
                    Label {
                        id: mLabelMeter
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: mAllString.mdirectionMeters
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 0.6
                        }
                    }
                }
                // FINAL SUBMIT BUTTON TO SEARCH NEAREST LOCATION
                Container {
                    id: mSubmitButton
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredWidth: 300
                    preferredHeight: 80
                    topMargin: ui.du(5)
                    background: Color.create("#00b5e9")
                    layout: DockLayout {

                    }

                    Label {
                        textStyle.color: Color.White
                        // textStyle.fontWeight: FontWeight.Bold
                        textStyle.fontStyle: FontStyle.Italic
                        textStyle.fontSize: FontSize.Medium
                        text: mAllString.mdirectionsubmit
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                    }
                    onTouch: {
                        if (event.isUp()) {
                            console.debug("on touch event near by...")
                            if (mTextFieldCategory.text.trim().length == 0) {
                                mSystemDialog.body = mAllString.mnearbyvalidation
                                mSystemDialog.show()
                            } else if (mTextFieldType.text.length == 0) {
//                                mSystemDialog.body = "please enter type"
                                mSystemDialog.body = mAllString.mnearbyvalidationtype
                                mSystemDialog.show()
                            } else if (mCheckBoxDistance.checked && mTextAreaDistance.text.length == 0) {
                                mSystemDialog.body = mAllString.mnearbyvalidationdistance
                                mSystemDialog.show()
                            } else if ((mCheckBoxDistance.checked) && showKilometers(mTextAreaDistance.text.trim()) > 10) {
                                mSystemDialog.body = mAllStrings.mNearByvalidationdistancelessthan10
                                mSystemDialog.show()
                            } else {
                                _mWebServiceinstance.mymodelNearBy.clear()

                                _mWebServiceinstance.modelNearBychanged.connect(nearByResponseSuccess)
                                _mWebServiceinstance.noDataFound.connect(noDataFoundError);

                                //  console.debug("data to be filed in get po is:" + mapLatitude + "longutude is:" + mapLongitude)
                                console.debug("isFromMap:-" + isFromMap)

                                _mWebServiceinstance.getPOI(_mWebServiceinstance.getServiceId(), mCategoryID, mTextAreaNearest.text, mTextAreaDistance.text, mapLatitude, mapLongitude, "")
                            }
                        }
                    }
                }
            }
        }
        attachedObjects: [
            AllStrings {
                id: mAllString
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionTextFied
                imageSource: "asset:///images/search_option/bg_contain_white.png"
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitiondialogbg
                imageSource: "asset:///images/transparent_bg.png"
            },

            Dialog {
                id: mdialoglist
                Container {
                    background: Color.create("#B8FFFFFF")
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 700
                    Container {
                        leftPadding: ui.du(5)
                        rightPadding: ui.du(5)
                        layout: StackLayout {
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            background: Color.create("#00b5e9")
                            preferredHeight: 100
                            layout: DockLayout {
                            }

                            Label {
                                text: mAllString.mDialogTilteCategory
                                textStyle.color: Color.White
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }

                        }

                        Container {
                            layout: StackLayout {
                            }

                            // background: mImagePaintDefinitiondialogbg.imagePaint
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            DialogCommonList {
                                mlabelDialog: mAllStrings.mDialogTilteCategory
                                mModel: _mWebServiceinstance.mymodelservice

                            }
                            /*ListView {
                             * dataModel: _mWebServiceinstance.mymodelservice
                             * verticalAlignment: VerticalAlignment.Fill
                             * horizontalAlignment: HorizontalAlignment.Fill
                             * 
                             * listItemComponents: [
                             * ListItemComponent {
                             * type: "item"
                             * DialogCommonList {
                             * mlabelDialog:mAllStrings.mDialogTilteCategory
                             * mModel: _mWebServiceinstance.mymodelservice
                             * }
                             * Container {
                             * 
                             * verticalAlignment: VerticalAlignment.Center
                             * horizontalAlignment: HorizontalAlignment.Fill
                             * 
                             * preferredHeight: 70
                             * layout: DockLayout {
                             * }
                             * Label {
                             * verticalAlignment: VerticalAlignment.Center
                             * text: ListItemData.service_name
                             * horizontalAlignment: HorizontalAlignment.Left
                             * textStyle.textAlign: TextAlign.Left
                             * leftMargin: ui.du(1)
                             * rightMargin: ui.du(1)
                             * textStyle.color: Color.White
                             * }
                             * Container {
                             * background: Color.White
                             * Divider {
                             * 
                             * }
                             * }
                             * }
                             * }
                             * ]
                             * onTriggered: {
                             * var mdata = dataModel.data(indexPath);
                             * mTextFieldCategory.setText(mdata.service_name)
                             * //mlabelCategotyData.text = mdata.service_name
                             * mLabelHospital.text = mdata.service_name
                             * _mWebServiceinstance.setServiceId(mdata.service_id)
                             * _mWebServiceinstance.mymodelservice.clear()
                             * mTextFieldType.text = ""
                             * mdialoglist.close()
                             * }
                             }*/
                        }
                    }

                }
            },
            Dialog {
                id: mdialoglistArabic
                Container {
                    background: Color.create("#B8FFFFFF")
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 700
                    Container {
                        leftPadding: ui.du(5)
                        rightPadding: ui.du(5)
                        layout: StackLayout {
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            background: Color.create("#00b5e9")
                            preferredHeight: 100
                            layout: DockLayout {
                            }

                            Label {
                                text: mAllString.mDialogTilteCategory
                                textStyle.color: Color.White
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }

                        }
                        Container {
                            layout: StackLayout {
                            }

                            background: mImagePaintDefinitiondialogbg.imagePaint
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center

                            ListView {
                                dataModel: _mWebServiceinstance.mymodelservice
                                verticalAlignment: VerticalAlignment.Fill
                                horizontalAlignment: HorizontalAlignment.Fill
                                listItemComponents: [
                                    ListItemComponent {
                                        type: "item"
                                        Container {

                                            verticalAlignment: VerticalAlignment.Center
                                            horizontalAlignment: HorizontalAlignment.Fill

                                            preferredHeight: 70
                                            layout: DockLayout {
                                            }
                                            Label {
                                                verticalAlignment: VerticalAlignment.Center
                                                text: ListItemData.service_name
                                                horizontalAlignment: HorizontalAlignment.Right
                                                textStyle.textAlign: TextAlign.Right
                                                leftMargin: ui.du(1)
                                                rightMargin: ui.du(1)
                                                textStyle.color: Color.White
                                            }
                                            Container {
                                                background: Color.White
                                                Divider {

                                                }
                                            }
                                        }
                                    }
                                ]
                                onTriggered: {
                                    var mdata = dataModel.data(indexPath);
                                    mTextFieldCategory.setText(mdata.service_name)
                                    //   mlabelCategotyData.text = mdata.service_name
                                    serviceID = mdata.service_id
                                    _mWebServiceinstance.setServiceId(mdata.service_id)
                                    _mWebServiceinstance.mymodelservice.clear()
                                    mTextFieldType.text = ""
                                    mdialoglistArabic.close()
                                }
                            }
                        }
                    }
                }
            },
            Dialog {
                id: mdialoglistTypeEnglish
                Container {
                    background: Color.create("#B8FFFFFF")
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 700
                    Container {
                        leftPadding: ui.du(5)
                        rightPadding: ui.du(5)
                        layout: StackLayout {
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            background: Color.create("#00b5e9")
                            preferredHeight: 100
                            layout: DockLayout {
                            }

                            Label {
                                text: mAllString.mFeedBackType
                                textStyle.color: Color.White
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }

                        }
                        Container {
                            layout: StackLayout {
                            }

                            background: mImagePaintDefinitiondialogbg.imagePaint
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center

                            ListView {
                                dataModel: _mWebServiceinstance.mymodelcategory
                                verticalAlignment: VerticalAlignment.Fill
                                horizontalAlignment: HorizontalAlignment.Fill
                                listItemComponents: [
                                    ListItemComponent {
                                        type: "item"
                                        Container {
                                            verticalAlignment: VerticalAlignment.Center
                                            horizontalAlignment: HorizontalAlignment.Left
                                            preferredHeight: 70
                                            layout: DockLayout {
                                            }
                                            Label {
                                                verticalAlignment: VerticalAlignment.Center
                                                text: ListItemData.CATEGORY_NAME_E
                                                horizontalAlignment: HorizontalAlignment.Left
                                                textStyle.textAlign: TextAlign.Left
                                                leftMargin: ui.du(2)
                                                preferredWidth: 500
                                                textStyle.color: Color.White
                                            }
                                            Container {
                                                background: Color.White
                                                Divider {

                                                }
                                            }
                                        }
                                    }
                                ]
                                onTriggered: {
                                    var mdata = dataModel.data(indexPath);
                                    mTextFieldType.setText(mdata.CATEGORY_NAME_E)
                                    mCategoryID = mdata.CATEGORY_ID
                                    console.debug("mCategoryID string is:" + mCategoryID)

                                    _mWebServiceinstance.mymodelcategory.clear()
                                    mdialoglistTypeEnglish.close()
                                }
                            }
                        }
                    }
                }
            },
            Dialog {
                id: mdialoglistTypeArabic
                Container {
                    background: Color.create("#B8FFFFFF")
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 700
                    Container {
                        leftPadding: ui.du(5)
                        rightPadding: ui.du(5)
                        layout: StackLayout {
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        Container {
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            background: Color.create("#00b5e9")
                            preferredHeight: 100
                            layout: DockLayout {
                            }

                            Label {
                                text: mAllString.mFeedBackType
                                textStyle.color: Color.White
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }

                        }
                        Container {
                            layout: StackLayout {
                            }

                            background: mImagePaintDefinitiondialogbg.imagePaint
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center

                            ListView {
                                id: mli
                                dataModel: _mWebServiceinstance.mymodelcategory
                                verticalAlignment: VerticalAlignment.Fill
                                horizontalAlignment: HorizontalAlignment.Fill
                                listItemComponents: [
                                    ListItemComponent {
                                        type: "item"
                                        Container {

                                            verticalAlignment: VerticalAlignment.Center
                                            horizontalAlignment: HorizontalAlignment.Fill

                                            preferredHeight: 70
                                            layout: DockLayout {
                                            }
                                            Label {
                                                verticalAlignment: VerticalAlignment.Center
                                                text: ListItemData.CATEGORY_NAME_A
                                                preferredWidth: 500
                                                horizontalAlignment: HorizontalAlignment.Right
                                                textStyle.textAlign: TextAlign.Right
                                                rightMargin: ui.du(2)
                                                textStyle.color: Color.White
                                            }
                                            Container {
                                                background: Color.White
                                                Divider {

                                                }
                                            }
                                        }
                                    }
                                ]
                                onTriggered: {
                                    var mdata = dataModel.data(indexPath);
                                    mTextFieldType.text = mdata.CATEGORY_NAME_A
                                    mCategoryID = mdata.CATEGORY_ID
                                    _mWebServiceinstance.mymodelcategory.clear()
                                    mdialoglistTypeArabic.close()
                                }
                            }
                        }
                    }
                }
            },
            SystemDialog {
                id: mSystemDialog
                title: undefined
                cancelButton.label: undefined
                confirmButton.label: mAllString.mDialogOk
            },
            ComponentDefinition {
                id: mNearByDetails
                source: "NearByDetails.qml"
            },
            Dialog {
                id: mDialogCommonList
                onOpenedChanged: {
                    mDialogCommonListContent.setAlignMent()
                }
                DialogCommonList {
                    id: mDialogCommonListContent
                    onDoneClick: {
                        //  var mdata = selectedData.data(indexPath);

                        mTextFieldCategory.setText(selectedData.service_name)
                        //mlabelCategotyData.text = mdata.service_name
                        mLabelHospital.text = selectedData.service_name
                        _mWebServiceinstance.setServiceId(selectedData.service_id)
                        _mWebServiceinstance.mymodelservice.clear()
                        mTextFieldType.text = ""
                        mDialogCommonList.close()
                    }
                    onCloseClick: {
                        mDialogCommonListContent.mActivityIndicator.stop()
                        mDialogCommonList.close()

                    }
                }
            },
            Dialog {
                id: mDialogCommonListType
                onOpenedChanged: {
                    mDialogCommonListContentType.setAlignMent()
                }

                DialogCommonList {
                    id: mDialogCommonListContentType
                    onDoneClick: {
                        // mTextFieldType.text = _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? selectedData.CATEGORY_NAME_E : selectedData.CATEGORY_NAME_A
                        mTextFieldType.text = selectedData.Category
                        mCategoryID = selectedData.CATEGORY_ID
                        _mWebServiceinstance.mymodelcategory.clear()
                        mDialogCommonListType.close()
                    }
                    onCloseClick: {
                        console.debug("emited on close clik")
                        if (mDialogCommonListContentType.mActivityIndicator.running) {
                            mDialogCommonListContentType.mActivityIndicator.stop()

                        }
                        mDialogCommonListType.close()

                    }
                }
            },
            Dialog {
                id: mdialoglistNearest

                onCreationCompleted: {
                    setAlignMent()
                }

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: mImagePaintDefinitionMainBG.imagePaint
                    verticalAlignment: VerticalAlignment.Center
                    layout: DockLayout {
                    }
                    function setAlignMent() {
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
                            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
                            mLabel5.horizontalAlignment = HorizontalAlignment.Left
                            mLabel10.horizontalAlignment = HorizontalAlignment.Left
                            mLabel15.horizontalAlignment = HorizontalAlignment.Left
                            mLabel20.horizontalAlignment = HorizontalAlignment.Left
                        }

                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Container {
                            background: mImagePaintDefinitionTopBG.imagePaint
                            // background: Color.Transparent
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            preferredHeight: 100
                            layout: DockLayout {
                            }
                            leftPadding: 50
                            rightPadding: 50
                            topPadding: 15
                            Container {
                                id: mContaineLeft
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                verticalAlignment: VerticalAlignment.Center
                                Label {
                                    id: mlabelDialog
                                    //text: mAllStrings.mDialogTilteCategory
                                    text: mAllStrings.mNearByNearest
                                    textStyle.color: Color.White
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    visible: true
                                }
                            }
                            ImageButton {
                                id: mImageViewInfoExit
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Right
                                defaultImageSource: "asset:///images/info/icon_close_white.png"
                                pressedImageSource: "asset:///images/info/icon_close_white.png"
                                disabledImageSource: "asset:///images/info/icon_close_white.png"
                                onClicked: {
                                    mdialoglistNearest.close();

                                }
                            }
                        } //top bar ends
                        Container {
                            leftPadding: 50
                            rightPadding: 50
                            topPadding: 30
                            bottomPadding: 120
                            minHeight: 350
                            horizontalAlignment: HorizontalAlignment.Fill
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    id: mLabel5
                                    text: "5"
                                    horizontalAlignment: HorizontalAlignment.Left

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "5"
                                        mdialoglistNearest.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    id: mLabel10
                                    horizontalAlignment: HorizontalAlignment.Left
                                    text: "10"

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "10"
                                        mdialoglistNearest.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {

                                    id: mLabel15
                                    horizontalAlignment: HorizontalAlignment.Left
                                    text: "15"

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "15"
                                        mdialoglistNearest.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {
                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    id: mLabel20
                                    text: "20"
                                    horizontalAlignment: HorizontalAlignment.Left

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "20"
                                        mdialoglistNearest.close()
                                    }
                                }
                            }
                        }
                    }
                    attachedObjects: [
                        AllStrings {
                            id: mAllStrings
                        },
                        ImagePaintDefinition {
                            id: mImagePaintDefinitionTopBG
                            imageSource: "asset:///images/info_list/icon_bg_top.png"
                        },
                        ImagePaintDefinition {
                            id: mImagePaintDefinitionMainBG
                            imageSource: "asset:///images/info_list/icon_bg_white_small.png"
                        }
                    ]
                }

            },
            Dialog {

                id: mdialoglistNearestArabic

                onCreationCompleted: {
                    setAlignMent()
                }

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: mImagePaintDefinitionMainBG.imagePaint
                    verticalAlignment: VerticalAlignment.Center
                    layout: DockLayout {
                    }
                    function setAlignMent() {
                        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") != "en") {

                            mContaineLeftArabic.layout.orientation = LayoutOrientation.RightToLeft
                            mImageViewInfoExitArabic.horizontalAlignment = HorizontalAlignment.Left
                        }

                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Container {
                            background: mImagePaintDefinitionTopBG.imagePaint
                            // background: Color.Transparent
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Center
                            preferredHeight: 100
                            layout: DockLayout {
                            }
                            leftPadding: 50
                            rightPadding: 50
                            topPadding: 15
                            Container {
                                id: mContaineLeftArabic
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                verticalAlignment: VerticalAlignment.Center
                                Label {
                                    id: mlabelDialogArabic
                                    // text: mAllStrings.mDialogTilteCategory
                                    text: mAllStrings.mNearByNearest
                                    textStyle.color: Color.White
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    visible: true
                                }
                            }
                            ImageButton {
                                id: mImageViewInfoExitArabic
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Right
                                defaultImageSource: "asset:///images/info/icon_close_white.png"
                                pressedImageSource: "asset:///images/info/icon_close_white.png"
                                disabledImageSource: "asset:///images/info/icon_close_white.png"
                                onClicked: {
                                    mdialoglistNearestArabic.close()

                                }
                            }
                        } //top bar ends
                        Container {
                            leftPadding: 50
                            rightPadding: 50
                            topPadding: 30
                            bottomPadding: 120
                            minHeight: 350
                            horizontalAlignment: HorizontalAlignment.Fill
                            Container {

                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    text: "5"
                                    horizontalAlignment: HorizontalAlignment.Right

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "5"
                                        mdialoglistNearestArabic.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {

                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    text: "10"
                                    horizontalAlignment: HorizontalAlignment.Right

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "10"
                                        mdialoglistNearestArabic.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {

                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    text: "15"
                                    horizontalAlignment: HorizontalAlignment.Right

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "15"
                                        mdialoglistNearestArabic.close()
                                    }
                                }
                            }
                            Divider {

                            }
                            Container {

                                horizontalAlignment: HorizontalAlignment.Fill
                                Label {
                                    text: "20"
                                    horizontalAlignment: HorizontalAlignment.Right

                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        mTextAreaNearest.text = "20"
                                        mdialoglistNearestArabic.close()
                                    }
                                }
                            }
                        }
                    }

                }

            }
        ]

    }
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                /* mNavigationPane.peekEnabled = false;
                 * 
                 mNavigationPane.pop();*/
                clearAllNearByText()
                mContainerNearest.enabled = false
                mContainerDistance.enabled = false
            }
        }
    }
}

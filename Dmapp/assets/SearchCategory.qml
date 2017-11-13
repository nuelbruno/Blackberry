// ***********************************************************************************************************
//  SEARCH BASED ON CATEGORY
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    visible: true
    property string mSelectedData
    property string xCoords
    property string yCoords
    property int selectedType: 1
    property alias mlabelInSide: mlabelInSide
    property alias mTextFieldInSide:mTextFieldInSide
    property alias mTextFieldCategory: mTextFieldCategory
    property alias mTextFieldPlace: mTextFieldPlace
    property bool isFromDirection: false
    property TextField mtextfiled
    property string serviceId
    property string categoryId
    signal clickdone()
    property bool isSelectFromList: false
    property string currentLang: "E"
    layout: DockLayout {

    }

    /*ActivityIndicator {
     * id: mActivityIndicator
     * horizontalAlignment: HorizontalAlignment.Center
     * verticalAlignment: VerticalAlignment.Center
     * visible: _mWebServiceinstance.active == true ? mActivityIndicator.start() : mActivityIndicator.stop()
     * preferredHeight: 500
     * preferredWidth: 500
     * }*/
     // LANGAUGE CHANGE ALIGNEMNT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mCommonButtonWithLabelSearch.horizontalAlignment = HorizontalAlignment.Left
            mTextFieldCategory.textStyle.textAlign = TextAlign.Left
            mTextFieldPlace.textStyle.textAlign = TextAlign.Left
            mContainerlabelInSide.horizontalAlignment = HorizontalAlignment.Left
            mButtonSearchIcon.horizontalAlignment = HorizontalAlignment.Right
            mButtonSearchIconcat.horizontalAlignment = HorizontalAlignment.Right
            currentLang = "E"
        } else {
            mCommonButtonWithLabelSearch.horizontalAlignment = HorizontalAlignment.Right
            mTextFieldCategory.textStyle.textAlign = TextAlign.Right
            mTextFieldPlace.textStyle.textAlign = TextAlign.Right
            mContainerlabelInSide.horizontalAlignment = HorizontalAlignment.Right
            mButtonSearchIconcat.horizontalAlignment = HorizontalAlignment.Left
            mButtonSearchIcon.horizontalAlignment = HorizontalAlignment.Left
            currentLang = "A"
        }

    }

    Container {

        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill

        onCreationCompleted: {
            //  _mWebServiceinstance.serviceDataLoad.connect(callAnotherWS)
        }
        // SERVICES SEARCH 
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill

                layout: DockLayout {
                }
                preferredHeight: 90
                background: mImagePaintDefinitionCategotyTextBG.imagePaint
                verticalAlignment: VerticalAlignment.Center
                Container {
                    //leftPadding: 20.0
                    //rightPadding: 20.0
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    id: mContainerlabelInSide
                    Label {
                        id: mlabelInSide
                        text: mAllStrings.mSearchServices
                        // text: "All"
                        visible: false
                        verticalAlignment: VerticalAlignment.Center

                    }
                    TextField {
                        id: mTextFieldInSide
                        backgroundVisible: false
                        clearButtonVisible: false
                        enabled: false
                        preferredHeight: 70
                        horizontalAlignment: HorizontalAlignment.Fill
                        hintText: mAllStrings.mSearchServices
                        // hintText: "All"
                        // textStyle.fontWeight: FontWeight.Bold
                    }
                }

                Container {
                    id: mButtonSearchIcon
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    leftPadding: 10.0
                    rightPadding: 10.0

                    //                    ImageButton {
                    //
                    //                        defaultImageSource: "asset:///images/search_option/arrow.png"
                    //                        pressedImageSource: "asset:///images/search_option/arrow.png"
                    //                        disabledImageSource: "asset:///images/search_option/arrow.png"
                    //                        verticalAlignment: VerticalAlignment.Center
                    //                        horizontalAlignment: HorizontalAlignment.Right
                    //
                    //                    }
                    ImageView {
                        imageSource: "asset:///images/search_option/arrow.png"
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                    }
                }
                onTouch: {
                    if (event.touchType == TouchType.Up) {
                        selectedType = 1
                        if (_mAppParentObj.isNetworkAvailable()) {
                            mDialogCommonListContent.mlabelDialog = mAllStrings.mSearchServices
                            mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelservice
                            mTextFieldCategory.text = ""
                            mTextFieldPlace.text = ""
                            mDialogCommonList.open()
                        } else {
                            mSystemDialog.body = mAllStrings.mNetworkCheck
                            mSystemDialog.show()
                        }
                    }
                }
            }
            // CATEGORY SEARCH
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Center
                layout: DockLayout {
                }
                preferredHeight: 90
                background: mImagePaintDefinitionCategotyTextBG.imagePaint

                TextField {
                    id: mTextFieldCategory
                    backgroundVisible: false
                    clearButtonVisible: false
                    preferredHeight: 70
                    enabled: false
                    horizontalAlignment: HorizontalAlignment.Fill
                    hintText: mAllStrings.mSearchCategories
                    // hintText: "Category"
                    onTextChanging: {
                        if (mTextFieldCategory.text.length > 0) {

                            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                _mWebServiceinstance.mymodelcategory.size() == 0 ? mListViewCategory.visible = false : mListViewCategory.visible = true

                                _mWebServiceinstance.searchDataFilterCategory(mTextFieldCategory.text, "category") == true ? mListViewCategory.visible = true : mListViewCategory.visible = false

                            } else {
                                _mWebServiceinstance.mymodelcategory.size() == 0 ? mListViewCategoryArabic.visible = false : mListViewCategoryArabic.visible = true

                                _mWebServiceinstance.searchDataFilterCategory(mTextFieldCategory.text, "category") == true ? mListViewCategoryArabic.visible = true : mListViewCategoryArabic.visible = false

                            }
                        } else {
                            mListViewCategory.visible = false
                            mListViewCategoryArabic.visible = false
                            mTextFieldPlace.text = ""
                        }
                    }
                }

                Container {
                    id: mButtonSearchIconcat
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    leftPadding: 10.0
                    rightPadding: 10.0
                    //                    ImageButton {
                    //                        defaultImageSource: "asset:///images/search_option/arrow.png"
                    //                        pressedImageSource: "asset:///images/search_option/arrow.png"
                    //                        disabledImageSource: "asset:///images/search_option/arrow.png"
                    //                        verticalAlignment: VerticalAlignment.Center
                    //                    }
                    ImageView {
                        imageSource: "asset:///images/search_option/arrow.png"
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Right
                    }
                }
                onTouch: {
                    if (event.touchType == TouchType.Up) {
                        if (_mWebServiceinstance.searchDataFilterCategory(mTextFieldCategory.text, "category")) {
                            selectedType = 2
                            mDialogCommonListContent.mModel = _mWebServiceinstance.mymodelcategory;
                            mDialogCommonListContent.mlabelDialog = mAllStrings.mSearchCategories
                            mDialogCommonList.open();
                        } else {
                            mSystemDialog.body = mAllStrings.mNearByvalidationtype
                            mSystemDialog.show()
                        }
                    }
                }
            }

            ListView {
                id: mListViewCategory
                verticalAlignment: VerticalAlignment.Fill
                dataModel: _mWebServiceinstance.mymodelcategory
                preferredHeight: 300
                preferredWidth: mAllStrings.searchTextFiledWidthWithButton
                visible: false
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            background: Color.White
                            verticalAlignment: VerticalAlignment.Center
                            preferredHeight: 70
                            layout: DockLayout {
                            }
                            leftPadding: 10
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.Category
                            }
                            Divider {
                            }
                        }
                    }
                ]
                onTriggered: {
                    var mdata = dataModel.data(indexPath);
                    mTextFieldCategory.text = mdata.Category
                    mListViewCategory.visible = false

                    mTextFieldPlace.text = ""
                    mTextFieldPlace.enabled = true
                    if (_mAppParentObj.isNetworkAvailable()) {
                        //   _mWebServiceinstance.GetPOIByServiceIDAndCategoryId(mdata.CategoryId, mSelectedData)
                    } else {
                        mSystemDialog.body = mAllStrings.mNetworkCheck
                        mSystemDialog.show()
                    }
                }
            }
            ListView {
                id: mListViewCategoryArabic
                verticalAlignment: VerticalAlignment.Fill
                dataModel: _mWebServiceinstance.mymodelcategory
                preferredHeight: 300
                preferredWidth: mAllStrings.searchTextFiledWidthWithButton
                visible: false
                horizontalAlignment: HorizontalAlignment.Right
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            background: Color.White
                            verticalAlignment: VerticalAlignment.Center
                            preferredHeight: 70
                            layout: DockLayout {
                            }
                            rightPadding: 10
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.Category
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
                    mTextFieldCategory.text = mdata.category
                    mListViewCategoryArabic.visible = false
                    mTextFieldPlace.text = ""
                    mTextFieldPlace.enabled = true
                    if (_mAppParentObj.isNetworkAvailable()) {
                        //   _mWebServiceinstance.GetPOIByServiceIDAndCategoryId(mdata.CategoryId, mSelectedData)
                    } else {
                        mSystemDialog.body = mAllStrings.mNetworkCheck
                        mSystemDialog.show()
                    }
                }
            }
            // PLACE NAME SEARCH
            TextField {
                id: mTextFieldPlace
                hintText: mAllStrings.mSearchPlace
                topMargin: 5
                //textStyle.fontWeight: FontWeight.Bold
                enabled: false
                preferredWidth: mAllStrings.searchTextFiledFullWidth
                onTextChanging: {
                    if (_mAppParentObj.isNetworkAvailable()) {
                        if (mTextFieldCategory.text.length > 0) {
                            if (mTextFieldPlace.text.trim().length == 3) {
                                mTextFieldPlace.enabled = false

                                _mWebServiceinstance.GetPOIByServiceIDCategoryIdPOI(categoryId, serviceId, mTextFieldPlace.text, currentLang)
                                mTextFieldPlace.enabled = true
                                mTextFieldPlace.requestFocus()
                            }

                            if (mTextFieldPlace.text.length > 3) {
                                isSelectFromList = false;
                                _mWebServiceinstance.searchDataFilterService(mTextFieldPlace.text, "service");
                                if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                                    _mWebServiceinstance.mymodel.size() == 0 ? mListViewPlace.visible = false : mListViewPlace.visible = true

                                } else {
                                    _mWebServiceinstance.mymodel.size() == 0 ? mListViewPlaceArabic.visible = false : mListViewPlaceArabic.visible = true

                                }

                            }
                            /*else {
                             * mListViewPlace.visible = false
                             * mListViewPlaceArabic.visible = false
                             * _mWebServiceinstance.mymodel.clear()
                             }*/
                        }
                    } else {
                        mSystemDialog.body = mAllStrings.mNetworkCheck
                        mSystemDialog.show()
                    }

                }
            }
            ListView {
                id: mListViewPlace
                verticalAlignment: VerticalAlignment.Fill
                dataModel: _mWebServiceinstance.mymodel
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
                            leftPadding: 10
                            layout: DockLayout {

                            }
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.NAME_E
                            }
                            Divider {

                            }
                        }

                    }
                ]
                onTriggered: {
                    var mdata = dataModel.data(indexPath);

                    xCoords = mdata.X_COORD
                    yCoords = mdata.Y_COORD
                    if (isFromDirection == true) {
                        /*when the dialog is open selected poi name will be show in the place field
                         * so for display purpose set mtextfieldplace in to both
                         */

                        console.debug("setValueFromOrTo is:" + setValueFromOrTo)
                        //values will be set frok direction to decide in which variable pair lat,lng will be stored
                        setValueFromOrTo == true ? ((strTextFromLat = mdata.X_COORD) && (strTextFromLng = mdata.Y_COORD)) : ((strTextToLat = mdata.X_COORD) && (strTextToLng = mdata.Y_COORD))
                        mtextfiled.text = mdata.NAME_E
                        mTextFieldPlace.text = mdata.NAME_E
                    } else {
                        mTextFieldPlace.text = mdata.NAME_E
                    }
                    mListViewPlace.visible = false
                    isSelectFromList = true;
                }
            }
            ListView {
                id: mListViewPlaceArabic
                verticalAlignment: VerticalAlignment.Fill
                dataModel: _mWebServiceinstance.mymodel
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
                            layout: DockLayout {
                            }
                            rightPadding: 10
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.NAME_A
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

                    xCoords = mdata.X_COORD
                    yCoords = mdata.Y_COORD
                    if (isFromDirection == true) {
                        /*when the dialog is open selected poi name will be show in the place filed
                         * so for display purpose set mtextfieldplace in to both
                         */
                        setValueFromOrTo == true ? ((strTextFromLat = mdata.X_COORD) && (strTextFromLng = mdata.Y_COORD)) : ((strTextToLat = mdata.X_COORD) && (strTextToLng = mdata.Y_COORD))

                        mtextfiled.text = mdata.NAME_A
                        mTextFieldPlace.text = mdata.NAME_A
                    } else {
                        mTextFieldPlace.text = mdata.NAME_A
                    }
                    mListViewPlaceArabic.visible = false
                    isSelectFromList = true;
                }
            }
            // SUBMIT BUTTON FOR CATEGORY SEARCH
            Container {

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
                        if (mTextFieldInSide.text.trim().length == 0) {
                            mSystemDialog.body = mAllStrings.mValidationService
                            mSystemDialog.show()

                        } else if (mTextFieldCategory.text.length == 0) {
                            mSystemDialog.body = mAllStrings.mValidationCategory
                            mSystemDialog.show()
                        } else if (mTextFieldPlace.text.length == 0) {
                            mSystemDialog.body = mAllStrings.mValidationPOI
                            mSystemDialog.show()
                        } else {

                            _mWebServiceinstance.ClearMapdata();
                            clickdone()
                            if (isFromDirection) {
                                mDialogCategory.close()
                            } else {
                                _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(xCoords, yCoords, true, false)
                                _mWebServiceinstance.setPoiInfoData(mTextFieldPlace.text, "", "", "", "", "", "");
                            }

                        }
                    }
                }
                CommonButtonWithLabel {
                    id: mCommonButtonWithLabelCancel
                    verticalAlignment: VerticalAlignment.Center
                    mLableText: mAllStrings.mCancel
                    mBackgroundSource: "asset:///images/search_option/bg_search_blue.png"
                    mWidth: 200
                    visible: false
                    mTextColor: Color.White
                    onMyClick: {
                        isFromDirection == true ? mDialogCategory.close() : mContainerCategory.visible = false
                        if (isFromDirection) {
                            if (isFromforDialog == "from") {
                                whenCancelButtonHit(true)
                            } else if (isFromforDialog == "to") {
                                whenCancelButtonHit(false)
                            } else if (isFromforDialog = "via") {
                                whenCancelButtonHitVia()
                            }
                            mDialogCategory.close()
                        }
                    }
                }
            }
        }
        attachedObjects: [
            AllStrings {
                id: mAllStrings
            },
            SystemListDialog {
                id: mSystemListDialogCategory
                selectionMode: selectionMode.Single
                onFinished: {
                    mSystemListDialogCategory.cancel()
                    var myCatData = new Array();
                    myCatData = _mWebServiceinstance.getCategoryDialogdata();
                    mTextFieldCategory.text = myCatData[mSystemListDialogCategory.selectedIndices]

                    mListViewCategory.visible = false
                    mTextFieldPlace.text = ""
                    if (_mAppParentObj.isNetworkAvailable()) {
                        //      _mWebServiceinstance.GetPOIByServiceIDAndCategoryId(_mWebServiceinstance.getCatValueFromId(selectedIndices), mSelectedData)
                    } else {
                        mSystemDialog.body = mAllStrings.mNetworkCheck
                        mSystemDialog.show()
                    }
                }
            },
            SystemListDialog {
                id: mSystemListDialogService
                selectionMode: selectionMode.Single
                cancelButton.label: undefined
            },
            SystemDialog {
                id: mSystemDialog
                title: undefined
                cancelButton.label: undefined
                confirmButton.label: mAllStrings.mDialogOk
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
                            mlabelInSide.text = selectedData.service_name
                            mTextFieldInSide.text = selectedData.service_name
                            serviceId = selectedData.service_id
                            _mWebServiceinstance.GetCategoriesByServiceID(selectedData.service_id)
                            _mWebServiceinstance.setServiceId(selectedData.service_id)
                            mSelectedData = selectedData.service_id
                            mTextFieldPlace.enabled = false
                        } else if (selectedType == 2) {
                            mTextFieldCategory.text = selectedData.Category
                            mListViewCategory.visible = false
                            mListViewCategoryArabic.visible = false
                            mTextFieldPlace.text = ""
                            categoryId = selectedData.CategoryId
                            console.debug("categoryId:" + categoryId)
                            mTextFieldPlace.enabled = true
                            if (_mAppParentObj.isNetworkAvailable()) {
                                //   _mWebServiceinstance.GetPOIByServiceIDAndCategoryId(selectedData.CategoryId, mSelectedData)
                                //    _mWebServiceinstance.GetPOIByServiceIDCategoryIdPOI(selectedData.CategoryId, serviceId,mTextFieldPlace.text,currentLang)
                            } else {
                                mSystemDialog.body = mAllStrings.mNetworkCheck
                                mSystemDialog.show()
                            }
                        }
                    }
                }
            },
            ImagePaintDefinition {
                id: mImagePaintDefinitionCategotyTextBG
                imageSource: "asset:///images/home/bg_search.png"
            }
        ]
    }
    function resetAllField() {
        mTextFieldCategory.text = ""
        mTextFieldPlace.text = ""
        mlabelInSide.text = mAllStrings.mSearchServices
    }
}
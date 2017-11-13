// ***********************************************************************************************************
//  COORDINATE CONVERTOR MAIN PAGE
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Page {
    property variant myUAENGData
    property string mStringType
    property string mStringTypeMAKANI: "MAKANI"
    property string mStringTypeDLTM: "DLTM"
    property string mStringTypeUTM: "UTM"
    property string mStringTypeLATLNG: "LATLNG"
    property string mStringTypeUAENG: "UAENG"
    property string mStringTypeDDMMSS: "DDMMSS"
    property string mStringCoordinateX
    property string mStringCoordinateY
    property string mStringShareData
    property bool isAbleToShare: false

    function setConvertFromMap(lat, lon, title) {
        var myResult = _mWebServiceinstance.checkInvalid(title.replace(" ", ""))
        if (myResult == "number") {
            mTextFieldMakaniNumber.text = title;
        } else if (myResult == "UAENG") {
            mTextFieldUAENG.text = title;
        } else {
            mTextFieldLatitude.text = lat;
            mTextFieldLongitude.text = lon;
        }
        callConvert()
    }
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContainerMakani.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUAENG.layout.orientation = LayoutOrientation.LeftToRight
            mContainerDLTM.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUTM.layout.orientation = LayoutOrientation.LeftToRight
            //            mContainerLatLonDecimal.layout.orientation = LayoutOrientation.LeftToRight
            //            mContainerLatLonDDMMSS.layout.orientation = LayoutOrientation.LeftToRight
            mContainerBottomButton.layout.orientation = LayoutOrientation.LeftToRight

            mContainerUTMTextField.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUTMTextField2.layout.orientation = LayoutOrientation.LeftToRight

            mTextStyleLabel.textStyle.textAlign = TextAlign.Left
            mTextFieldDLTM1.textStyle.textAlign = TextAlign.Left
            mTextFieldDLTM2.textStyle.textAlign = TextAlign.Left
            mTextFieldLatitude.textStyle.textAlign = TextAlign.Left
            mTextFieldLongitude.textStyle.textAlign = TextAlign.Left
            mTextFieldMakaniNumber.textStyle.textAlign = TextAlign.Left
            mTextFieldUAENG.textStyle.textAlign = TextAlign.Left
            mTextFieldUTM1.textStyle.textAlign = TextAlign.Left
            mTextFieldUTM2.textStyle.textAlign = TextAlign.Left

        } else {
            mContainerMakani.layout.orientation = LayoutOrientation.RightToLeft
            mContainerUAENG.layout.orientation = LayoutOrientation.RightToLeft
            mContainerDLTM.layout.orientation = LayoutOrientation.RightToLeft
            mContainerUTM.layout.orientation = LayoutOrientation.RightToLeft
            //            mContainerLatLonDecimal.layout.orientation = LayoutOrientation.RightToLeft
            //            mContainerLatLonDDMMSS.layout.orientation = LayoutOrientation.RightToLeft
            mContainerBottomButton.layout.orientation = LayoutOrientation.RightToLeft

            mContainerUTMTextField.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUTMTextField2.layout.orientation = LayoutOrientation.LeftToRight

            mTextStyleLabel.textAlign = TextAlign.Right

            mTextFieldDLTM1.textStyle.textAlign = TextAlign.Right
            mTextFieldDLTM2.textStyle.textAlign = TextAlign.Right
            mTextFieldLatitude.textStyle.textAlign = TextAlign.Right
            mTextFieldLongitude.textStyle.textAlign = TextAlign.Right
            mTextFieldMakaniNumber.textStyle.textAlign = TextAlign.Right
            mTextFieldUAENG.textStyle.textAlign = TextAlign.Right
            mTextFieldUTM1.textStyle.textAlign = TextAlign.Right
            mTextFieldUTM2.textStyle.textAlign = TextAlign.Right
        }

        mDialogShareContent.setAlignMent();
        mDialogShareCoordinateContent.setAlignMent();
    }
    Container {
        onCreationCompleted: {
            mNavigationPaneMain.peekEnabled = false

            setAlignMent();
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {

        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            CommonTopBar {
                mText: mAllString.mCoordinateConnverterTitle
            }
            ScrollView {
                Container {
                    leftPadding: 12
                    rightPadding: 12
                    topPadding: 15
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    }
                    // MAKANI NUM
                    Container {
                        id: mContainerMakani

                        horizontalAlignment: HorizontalAlignment.Fill
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.5
                            }
                            verticalAlignment: VerticalAlignment.Center
                            text: mAllString.mMakaniNumber
                            textStyle {
                                base: mTextStyleLabel.style
                            }
                        }
                        TextField {
                            id: mTextFieldMakaniNumber
                            verticalAlignment: VerticalAlignment.Center
                            hintText: ""
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }
                            onFocusedChanged: {
                                if (focused) {
                                    mTextFieldUAENG.text = "";
                                    mTextFieldDLTM1.text = "";
                                    mTextFieldDLTM2.text = "";
                                    mTextFieldUTM1.text = "";
                                    mTextFieldUTM2.text = "";
                                    mTextFieldLatitude.text = "";
                                    mTextFieldLongitude.text = "";
                                    mLabelDMSLat1.text = ""
                                    mLabelDMSLat2.text = ""
                                    mLabelDMSLat3.text = ""
                                    mLabelDMSLon1.text = "";
                                    mLabelDMSLon2.text = "";
                                    mLabelDMSLon3.text = "";
                                    isAbleToShare = false;
                                }
                            }
                        }

                    }
                    Divider {

                    }
                    // UAE NG
                    Container {
                        id: mContainerUAENG
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.5
                            }
                            multiline: true
                            text: mAllString.mUAENAG
                            verticalAlignment: VerticalAlignment.Center
                            textStyle {
                                base: mTextStyleLabel.style
                            }
                        }
                        TextField {
                            id: mTextFieldUAENG
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }
                            verticalAlignment: VerticalAlignment.Center
                            hintText: ""
                            onFocusedChanged: {
                                if (focused) {
                                    mTextFieldMakaniNumber.text = "";
                                    mTextFieldDLTM1.text = "";
                                    mTextFieldDLTM2.text = "";
                                    mTextFieldUTM1.text = "";
                                    mTextFieldUTM2.text = "";
                                    mTextFieldLatitude.text = "";
                                    mTextFieldLongitude.text = "";
                                    mLabelDMSLat1.text = ""
                                    mLabelDMSLat2.text = ""
                                    mLabelDMSLat3.text = ""
                                    mLabelDMSLon1.text = "";
                                    mLabelDMSLon2.text = "";
                                    mLabelDMSLon3.text = "";
                                    isAbleToShare = false;
                                }
                            }
                        }
                    }
                    Divider {

                    }
                    //UTM CONTAINER
                    Container {
                        id: mContainerUTM
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.5
                            }
                            verticalAlignment: VerticalAlignment.Center
                            text: mAllString.mutm
                            textStyle {
                                base: mTextStyleLabel.style
                            }
                        }
                        Container {
                            id: mContainerUTMTextField
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1.0
                            }
                            TextField {
                                id: mTextFieldUTM2
                                hintText: mAllString.mHintNorthing
                                verticalAlignment: VerticalAlignment.Center

                                onFocusedChanged: {
                                    if (focused) {
                                        mTextFieldMakaniNumber.text = "";
                                        mTextFieldUAENG.text = "";
                                        mTextFieldDLTM1.text = "";
                                        mTextFieldDLTM2.text = "";
                                        mTextFieldLatitude.text = "";
                                        mTextFieldLongitude.text = "";
                                        mLabelDMSLat1.text = ""
                                        mLabelDMSLat2.text = ""
                                        mLabelDMSLat3.text = ""
                                        mLabelDMSLon1.text = "";
                                        mLabelDMSLon2.text = "";
                                        mLabelDMSLon3.text = "";
                                        isAbleToShare = false;
                                    }
                                }
                            }
                            TextField {
                                verticalAlignment: VerticalAlignment.Center
                                id: mTextFieldUTM1
                                hintText: mAllString.mHintEasting
                                //                                layoutProperties: StackLayoutProperties {
                                //                                    spaceQuota: 0.5
                                //                                }
                                onFocusedChanged: {
                                    if (focused) {
                                        mTextFieldMakaniNumber.text = "";
                                        mTextFieldUAENG.text = "";
                                        mTextFieldDLTM1.text = "";
                                        mTextFieldDLTM2.text = "";
                                        mTextFieldLatitude.text = "";
                                        mTextFieldLongitude.text = "";
                                        mLabelDMSLat1.text = ""
                                        mLabelDMSLat2.text = ""
                                        mLabelDMSLat3.text = ""
                                        mLabelDMSLon1.text = "";
                                        mLabelDMSLon2.text = "";
                                        mLabelDMSLon3.text = "";
                                        isAbleToShare = false;
                                    }
                                }
                            }
                        }

                    }
                    Divider {

                    }
                    // DLTM
                    Container {
                        id: mContainerDLTM
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 0.5
                            }
                            text: mAllString.mDLTM
                            textStyle {
                                base: mTextStyleLabel.style
                            }
                        }
                        Container {
                            id: mContainerUTMTextField2
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1.0
                            }
                            TextField {
                                id: mTextFieldDLTM2
                                hintText: mAllString.mHintNorthing
                                verticalAlignment: VerticalAlignment.Center

                                onFocusedChanged: {
                                    if (focused) {
                                        mTextFieldMakaniNumber.text = "";
                                        mTextFieldUAENG.text = "";
                                        mTextFieldUTM1.text = "";
                                        mTextFieldUTM2.text = "";
                                        mTextFieldLatitude.text = "";
                                        mTextFieldLongitude.text = "";
                                        mLabelDMSLat1.text = ""
                                        mLabelDMSLat2.text = ""
                                        mLabelDMSLat3.text = ""
                                        mLabelDMSLon1.text = "";
                                        mLabelDMSLon2.text = "";
                                        mLabelDMSLon3.text = "";
                                        isAbleToShare = false;
                                    }
                                }
                            }
                            TextField {
                                verticalAlignment: VerticalAlignment.Center
                                id: mTextFieldDLTM1
                                hintText: mAllString.mHintEasting

                                onFocusedChanged: {
                                    if (focused) {
                                        mTextFieldMakaniNumber.text = "";
                                        mTextFieldUAENG.text = "";
                                        mTextFieldUTM1.text = "";
                                        mTextFieldUTM2.text = "";
                                        mTextFieldLatitude.text = "";
                                        mTextFieldLongitude.text = "";
                                        mLabelDMSLat1.text = ""
                                        mLabelDMSLat2.text = ""
                                        mLabelDMSLat3.text = ""
                                        mLabelDMSLon1.text = "";
                                        mLabelDMSLon2.text = "";
                                        mLabelDMSLon3.text = "";
                                        isAbleToShare = false;
                                    }
                                }
                            }
                        }
                    }
                    // GEOGRAPHICAL
                    Container {
                        background: mImagePaintDefinitionGeoGraphical.imagePaint
                        leftPadding: 20
                        rightPadding: 20
                        topPadding: 10
                        bottomPadding: 15
                        topMargin: 20
                        Label {
                            horizontalAlignment: HorizontalAlignment.Fill
                            text: mAllString.mGeographical
                            textStyle {
                                base: mTextStyleLabel.style
                                fontSize: FontSize.Medium
                            }
                        }
                        Divider {
                        }
                        // LATITIDE AND LOGNTIDUE
                        Container {
                            id: mContainerLatLonDecimal
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Label {
                                    text: mAllString.mLatitudeN
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Black
                                        fontSize: FontSize.Medium
                                    }
                                }
                                Label {
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    text: mAllString.mDecimalDegree
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Gray
                                    }
                                }
                                TextField {
                                    id: mTextFieldLatitude
                                    hintText: mAllString.mHintNorthing
                                    onFocusedChanged: {
                                        if (focused) {
                                            mTextFieldMakaniNumber.text = "";
                                            mTextFieldUAENG.text = "";
                                            mTextFieldDLTM1.text = "";
                                            mTextFieldDLTM2.text = "";
                                            mTextFieldUTM1.text = "";
                                            mTextFieldUTM2.text = "";
                                            mLabelDMSLat1.text = ""
                                            mLabelDMSLat2.text = ""
                                            mLabelDMSLat3.text = ""
                                            mLabelDMSLon1.text = "";
                                            mLabelDMSLon2.text = "";
                                            mLabelDMSLon3.text = "";
                                            isAbleToShare = false;
                                        }
                                    }
                                }
                            }
                            Container {
                                leftMargin: 15
                                rightMargin: 15
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Label {
                                    text: mAllString.mLongitudeN
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Black
                                        fontSize: FontSize.Medium
                                    }
                                }
                                Label {
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    text: mAllString.mDecimalDegree
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Gray
                                    }
                                }
                                TextField {
                                    id: mTextFieldLongitude
                                    hintText: mAllString.mHintEasting
                                    onFocusedChanged: {
                                        if (focused) {
                                            mTextFieldMakaniNumber.text = "";
                                            mTextFieldUAENG.text = "";
                                            mTextFieldDLTM1.text = "";
                                            mTextFieldDLTM2.text = "";
                                            mTextFieldUTM1.text = "";
                                            mTextFieldUTM2.text = "";
                                            mLabelDMSLat1.text = ""
                                            mLabelDMSLat2.text = ""
                                            mLabelDMSLat3.text = ""
                                            mLabelDMSLon1.text = "";
                                            mLabelDMSLon2.text = "";
                                            mLabelDMSLon3.text = "";
                                            isAbleToShare = false;
                                        }
                                    }
                                }
                            }
                        }
                        // DD MM SS
                        Container {
                            id: mContainerLatLonDDMMSS
                            topMargin: 10
                            leftMargin: 15
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Label {
                                    text: mAllString.mLatitudeN
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Black
                                        fontSize: FontSize.Medium
                                    }
                                }
                                Label {
                                    text: mAllString.mDDMMSS
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Gray
                                    }
                                }
                                Container {
                                    rightPadding: 5
                                    leftPadding: 5
                                    id: mContainerLatDDMMSS
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    Container {
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.8
                                        }
                                        TextField {
                                            id: mLabelDMSLat1
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            maximumLength: 2
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                    Container {
                                        leftMargin: 15
                                        rightMargin: 15
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.8
                                        }
                                        TextField {
                                            id: mLabelDMSLat2
                                            verticalAlignment: VerticalAlignment.Center
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            maximumLength: 2
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                    Container {
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 1.0
                                        }
                                        TextField {
                                            id: mLabelDMSLat3
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                }
                                //
                            }
                            Container {
                                leftMargin: 15
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Label {
                                    text: mAllString.mLongitudeN
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Black
                                        fontSize: FontSize.Medium
                                    }
                                }
                                Label {
                                    text: mAllString.mDDMMSS
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    textStyle {
                                        base: mTextStyleLabel.style
                                        color: Color.Gray
                                    }
                                }
                                Container {
                                    id: mContainerLonDDMMSS
                                    rightPadding: 5
                                    leftPadding: 5
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    Container {
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.8
                                        }
                                        TextField {
                                            id: mLabelDMSLon1
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            maximumLength: 2
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                    Container {
                                        leftMargin: 15
                                        rightMargin: 15
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 0.8
                                        }
                                        TextField {
                                            id: mLabelDMSLon2
                                            maximumLength: 2
                                            verticalAlignment: VerticalAlignment.Center
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                    Container {
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 1.0
                                        }
                                        TextField {
                                            id: mLabelDMSLon3
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            hintText: ""
                                            clearButtonVisible: false
                                            onFocusedChanged: {
                                                if (focused) {
                                                    mTextFieldMakaniNumber.text = "";
                                                    mTextFieldUAENG.text = "";
                                                    mTextFieldDLTM1.text = "";
                                                    mTextFieldDLTM2.text = "";
                                                    mTextFieldUTM1.text = "";
                                                    mTextFieldUTM2.text = "";
                                                    mTextFieldLatitude.text = "";
                                                    mTextFieldLongitude.text = "";
                                                    isAbleToShare = false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // CONVERTOR BUTTON
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        topMargin: 30
                        bottomPadding: 30
                        id: mContainerBottomButton
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        CommonButtonWithLabel {
                            mLableText: mAllString.mConvert
                            mBackgroundSource: "asset:///images/screens/bg_convert_blue.png"
                            mTextColor: Color.White
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1.0
                            }
                            onMyClick: {
                                if (_mAppParentObj.isNetworkAvailable()) {
                                    callConvert();
                                } else {
                                    mSystemDialog.body = mAllString.mNetworkCheck
                                    mSystemDialog.show()
                                }
                            }
                        }
                        // SHARE BUTTON
                        ImageButton {
                            verticalAlignment: VerticalAlignment.Center
                            defaultImageSource: "asset:///images/favourites/icon_share.png"
                            pressedImageSource: "asset:///images/favourites/icon_share_hover.png"
                            disabledImageSource: "asset:///images/favourites/icon_share_hover.png"
                            enabled: isAbleToShare
                            onClicked: {
                                mDialogShareCoordinateContent.init();
                                mDialogShareContent.coordinateA=1;
                                mDialogShareCoordinate.open();
                            }
                        }
                        // MAP A PIN BUTTON
                        ImageButton {
                            verticalAlignment: VerticalAlignment.Center
                            defaultImageSource: "asset:///images/favourites/icon_map.png"
                            pressedImageSource: "asset:///images/favourites/icon_map_hover.png"
                            disabledImageSource: "asset:///images/favourites/icon_map_hover.png"
                            enabled: isAbleToShare
                            onClicked: {
                                _mWebServiceinstance.initMapData();
                                _mWebServiceinstance.ClearMapdata();
                                _mWebServiceinstance.setPoiInfoData("", "", "", "", "", "", "");
                                console.debug("text..." + mTextFieldMakaniNumber.text);
                                if (mTextFieldMakaniNumber.text.trim().length > 0) {
                                    _mWebServiceinstance.GetBuildingInfo(mTextFieldMakaniNumber.text)
                                } else {
                                    _mWebServiceinstance.GetBuildingOutLine_EntrancePoints(mTextFieldLatitude.text, mTextFieldLongitude.text, true, false);
                                }
                                mNavigationPaneMain.pop();
                                mainTabPaned.changeTab(0);
                            }
                        }
                    }
                }
            }
        }
    }
   // CONVERTOR FUNTION TO CONVERT ALL DATA
    function callConvert() {
        mStringCoordinateX = "";
        mStringCoordinateY = "";
        if (mTextFieldLatitude.text.trim().length > 0 || mTextFieldLongitude.text.trim().length > 0) {
            if (_mWebServiceinstance.isValidUTMNumber(mTextFieldLatitude.text.trim()) == false) {
                mSystemDialog.body = mAllString.mValidationValidLatitudeValue
                mSystemDialog.show()
            } else if (_mWebServiceinstance.isValidUTMNumber(mTextFieldLongitude.text.trim()) == false) {
                mSystemDialog.body = mAllString.mValidationValidLongitudeValue
                mSystemDialog.show()
            } else {
                mStringCoordinateY = mTextFieldLatitude.text.trim();
                mStringCoordinateX = mTextFieldLongitude.text.trim();
                mStringType = mStringTypeLATLNG;
            }
        } else if (mTextFieldMakaniNumber.text.trim().length == 0 && mTextFieldUAENG.text.trim().length == 0 && mTextFieldUTM1.text.trim().length == 0 && mTextFieldUTM2.text.trim().length == 0 && mTextFieldDLTM1.text.trim().length == 0 && mTextFieldDLTM2.text.trim().length == 0 && mTextFieldLatitude.text.trim().length == 0 && mTextFieldLongitude.text.trim().length == 0 && mLabelDMSLat1.text.trim().length == 0 && mLabelDMSLat2.text.trim().length == 0 && mLabelDMSLat3.text.trim().length == 0 && mLabelDMSLon1.text.trim().length == 0 && mLabelDMSLon2.text.trim().length == 0 && mLabelDMSLon3.text.trim().length == 0) {
            mSystemDialog.body = mAllString.mValidationValue
            mSystemDialog.show()
        } else if (mTextFieldMakaniNumber.text.trim().length > 0) {
            var makaniNumber = mTextFieldMakaniNumber.text.replace(" ", "");
            if (_mWebServiceinstance.isNumberOnly(makaniNumber) == true) {
                if (makaniNumber.length != 10) {
                    mSystemDialog.body = mAllString.mValidationValidaMakaniValue
                    mSystemDialog.show()
                } else {
                    mStringCoordinateX = makaniNumber.substring(0, 5);
                    mStringCoordinateY = makaniNumber.substring(5, 10);
                    mStringType = mStringTypeMAKANI;
                }
            } else {
                mSystemDialog.body = mAllString.mValidationNumericValue
                mSystemDialog.show()
            }

        } else if (mTextFieldUAENG.text.trim().length > 0) {
            var UAENGValue = _mWebServiceinstance.ConvertToUAENG(mTextFieldUAENG.text.trim());
            if (UAENGValue.length > 0) {
                mStringCoordinateX = UAENGValue
                mStringType = mStringTypeUAENG;
            } else {
                mSystemDialog.body = mAllString.mValidationValidUAENGValue
                mSystemDialog.show()
            }
        } else if (mTextFieldUTM1.text.trim().length > 0 || mTextFieldUTM2.text.trim().length > 0) {
            if (_mWebServiceinstance.isValidUTMNumber(mTextFieldUTM1.text.trim()) && _mWebServiceinstance.isValidUTMNumber(mTextFieldUTM2.text.trim())) {
                mStringCoordinateX = mTextFieldUTM1.text.trim();
                mStringCoordinateY = mTextFieldUTM2.text.trim();
                mStringType = mStringTypeUTM;
            } else {
                mSystemDialog.body = mAllString.mValidationValidUTMValue
                mSystemDialog.show()
            }

        } else if (mTextFieldDLTM1.text.trim().length > 0 || mTextFieldDLTM2.text.trim().length > 0) {
            if (_mWebServiceinstance.isValidUTMNumber(mTextFieldDLTM1.text.trim()) && _mWebServiceinstance.isValidUTMNumber(mTextFieldDLTM2.text.trim())) {
                mStringCoordinateX = mTextFieldDLTM1.text.trim();
                mStringCoordinateY = mTextFieldDLTM2.text.trim();
                mStringType = mStringTypeDLTM;
            } else {
                mSystemDialog.body = mAllString.mValidationValidDLTMValue
                mSystemDialog.show()
            }

        } else if (mLabelDMSLat1.text.trim().length > 0 || mLabelDMSLat2.text.trim().length > 0 || mLabelDMSLat3.text.trim().length > 0 || mLabelDMSLon1.text.trim().length > 0 || mLabelDMSLon2.text.trim().length > 0 || mLabelDMSLon3.text.trim().length > 0) {
            if (_mWebServiceinstance.isValidUTMNumber(mLabelDMSLat1.text.trim()) == false || _mWebServiceinstance.isValidUTMNumber(mLabelDMSLat2.text.trim()) == false || _mWebServiceinstance.isValidUTMNumber(mLabelDMSLat3.text.trim()) == false) {
                mSystemDialog.body = mAllString.mValidationValidLatitudeValue
                mSystemDialog.show()
            } else if (_mWebServiceinstance.isValidUTMNumber(mLabelDMSLon1.text.trim()) == false || _mWebServiceinstance.isValidUTMNumber(mLabelDMSLon2.text.trim()) == false || _mWebServiceinstance.isValidUTMNumber(mLabelDMSLon3.text.trim()) == false) {
                mSystemDialog.body = mAllString.mValidationValidLongitudeValue
                mSystemDialog.show()
            } else {
                mStringType = mStringTypeDDMMSS;
                _mWebServiceinstance.dataLoaded.connect(dataLodedCompleted)
                _mWebServiceinstance.DMSToCoordinates(mLabelDMSLat1.text.trim(), mLabelDMSLat2.text.trim(), mLabelDMSLat3.text.trim(), mLabelDMSLon1.text.trim(), mLabelDMSLon2.text.trim(), mLabelDMSLon3.text.trim());
            }
        }

        if (mStringCoordinateX.length > 0 && mStringType != mStringTypeDDMMSS) {
            _mWebServiceinstance.dataLoaded.connect(dataLodedCompleted)
            if (mStringType == mStringTypeUAENG) {
                _mWebServiceinstance.UAENGtoCoordinates(mStringCoordinateX, "", "Convertor")
            } else {
                _mWebServiceinstance.getCoordinateConversion(mStringCoordinateX, mStringCoordinateY, mStringType, "Convertor", false);
            }
        }
    }
    // AFTER WEBSERVICE CALL ASIGN VALUES
    function dataLodedCompleted() {

        if (_mWebServiceinstance.getNODATA().length > 0) {
            mSystemDialog.body = mAllString.mValidationNoDataFound
            mSystemDialog.show()
        } else {
            mTextFieldMakaniNumber.text = _mWebServiceinstance.getCCMakani();
            mTextFieldUAENG.text = _mWebServiceinstance.getCCUAENG();
            mTextFieldUTM1.text = _mWebServiceinstance.getCCUTM1();
            mTextFieldUTM2.text = _mWebServiceinstance.getCCUTM2();
            mTextFieldDLTM1.text = _mWebServiceinstance.getCCDLTM1();
            mTextFieldDLTM2.text = _mWebServiceinstance.getCCDLTM2();
            mTextFieldLatitude.text = _mWebServiceinstance.getCCLatitude();
            mTextFieldLongitude.text = _mWebServiceinstance.getCCLongitude();
            mLabelDMSLat1.text = _mWebServiceinstance.getCCDMSLatitude1();
            mLabelDMSLat2.text = _mWebServiceinstance.getCCDMSLatitude2();
            mLabelDMSLat3.text = _mWebServiceinstance.getCCDMSLatitude3();
            mLabelDMSLon1.text = _mWebServiceinstance.getCCDMSLongitude1();
            mLabelDMSLon2.text = _mWebServiceinstance.getCCDMSLongitude2();
            mLabelDMSLon3.text = _mWebServiceinstance.getCCDMSLongitude3();
            isAbleToShare = true;
        }
        _mWebServiceinstance.dataLoaded.disconnect(dataLodedCompleted)
    }
    attachedObjects: [
        TextStyleDefinition {
            id: mStyleForLabel
        },
        AllStrings {
            id: mAllString
        },
        TextStyleDefinition {
            id: mTextStyleLabel
            base: SystemDefaults.TextStyles.SmallText
            fontSize: FontSize.Small
            color: mAllString.lightBlueColor
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionGeoGraphical
            imageSource: "asset:///images/screens/bg_geographical_textbox.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionSmallBox
            imageSource: "asset:///images/screens/bg_date_textbox_big.amd"
        },
        SystemDialog {
            id: mSystemDialog
            title: mAllString.mCoordinateConnverterTitle
            cancelButton.label: undefined
            confirmButton.label: mAllString.mDialogOk
            onFinished: {
                if (mSystemDialog.result == SystemUiResult.ConfirmButtonSelection) {

                }
            }
        },
        SystemListDialog {
            id: mSystemListDialog
            title: mAllString.mCoordinateConnverterTitle
            cancelButton.label: undefined
            confirmButton.label: mAllString.mShare
            selectionMode: ListSelectionMode.Multiple
            onFinished: {

                if (selectedIndices.length > 0) {
                    for (var i = 0; i < selectedIndices.length; i ++) {
                        if (selectedIndices[i] == 0) {
                            mStringShareData = mStringShareData + "\n" + "Makani Number : " + mTextFieldMakaniNumber.text
                        } else if (selectedIndices[i] == 1) {
                            mStringShareData = mStringShareData + "\n" + "UAE NG : " + mTextFieldUAENG.text
                        } else if (selectedIndices[i] == 2) {
                            mStringShareData = mStringShareData + "\n" + "UTM : " + mTextFieldUTM1.text + ", " + mTextFieldUTM2.text
                        } else if (selectedIndices[i] == 3) {
                            mStringShareData = mStringShareData + "\n" + "DLTM : " + mTextFieldDLTM1.text + ", " + mTextFieldDLTM2.text
                        } else if (selectedIndices[i] == 4) {
                            mStringShareData = mStringShareData + "\n" + "Decimal : " + mTextFieldLatitude.text + ", " + mTextFieldLongitude.text
                        } else if (selectedIndices[i] == 5) {
                            mStringShareData = mStringShareData + "\n" + "LAT/LNG : N" + mLabelDMSLat1.text + " " + mLabelDMSLat2.text + " " + mLabelDMSLat3.text + " E " + mLabelDMSLon1.text + " " + mLabelDMSLon2.text + " " + mLabelDMSLon3.text
                        }
                    }
                    mDialogShareContent.mShareData = mStringShareData;
                    mDialogShareContent.mCopyData = mStringShareData;
                    mDialogShare.open();
                }
            }
        },
        Dialog {
            id: mDialogShare
            Share {
                id: mDialogShareContent
            }

        },
        Dialog {
            id: mDialogShareCoordinate
            ShareCoordinateData {
                id: mDialogShareCoordinateContent
            }
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
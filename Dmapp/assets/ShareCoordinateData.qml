// ***********************************************************************************************************
//  SHARE COORDINATE DATA MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {

    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Center
    property bool isEmpty: false
    signal backClick()
    layout: DockLayout {
    }
    // LANGAUGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            mContainerSelectAll.layout.orientation = LayoutOrientation.LeftToRight
            mContainerMakani.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUAENG.layout.orientation = LayoutOrientation.LeftToRight
            mContainerDLTM.layout.orientation = LayoutOrientation.LeftToRight
            mContainerUTM.layout.orientation = LayoutOrientation.LeftToRight
            mContainerDMS.layout.orientation = LayoutOrientation.LeftToRight
            mContainerDecimal.layout.orientation = LayoutOrientation.LeftToRight
        } else {
            mContaineLeft.layout.orientation = LayoutOrientation.RightToLeft
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left

            mContainerSelectAll.layout.orientation = LayoutOrientation.RightToLeft
            mContainerMakani.layout.orientation = LayoutOrientation.RightToLeft
            mContainerUAENG.layout.orientation = LayoutOrientation.RightToLeft
            mContainerDLTM.layout.orientation = LayoutOrientation.RightToLeft
            mContainerUTM.layout.orientation = LayoutOrientation.RightToLeft
            mContainerDMS.layout.orientation = LayoutOrientation.RightToLeft
            mContainerDecimal.layout.orientation = LayoutOrientation.RightToLeft
        }
    }
    // INIT ALL SETUP 
    function init() {
        mCheckBoxDecimal.checked = false
        mCheckBoxMakani.checked = false
        mCheckBoxUAENG.checked = false
        mCheckBoxUTM.checked = false
        mCheckBoxDLTM.checked = false
        mCheckBoxDMS.checked = false
        mCheckBoxSelectAll.checked = false
        isEmpty = false;
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            background: mImagePaintDefinitionTopBG.imagePaint
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
                    text: mAllStrings.mShareCoordinateconverter
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/info/icon_close_white.png"
                onClicked: {
                    mDialogShareCoordinate.close();
                }
            }
        } //top bar ends

        Container {
            leftPadding: 50
            rightPadding: 50
            topPadding: 30
            bottomPadding: 80
            minHeight: 350
            horizontalAlignment: HorizontalAlignment.Fill
            background: mImagePaintDefinitionMainBG.imagePaint

            Container {
                id: mContainerSelectAll
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxSelectAll
                    onTouch: {
                        if (event.isUp()) {
                            if (mCheckBoxSelectAll.checked) {
                                mCheckBoxDecimal.checked = false
                                mCheckBoxMakani.checked = false
                                mCheckBoxUAENG.checked = false
                                mCheckBoxUTM.checked = false
                                mCheckBoxDLTM.checked = false
                                mCheckBoxDMS.checked = false
                                mCheckBoxSelectAll.checked = false
                            } else {
                                mCheckBoxDecimal.checked = true
                                mCheckBoxMakani.checked = true
                                mCheckBoxUAENG.checked = true
                                mCheckBoxUTM.checked = true
                                mCheckBoxDLTM.checked = true
                                mCheckBoxDMS.checked = true
                                mCheckBoxSelectAll.checked = true
                            }
                        }
                    }
                }
                Label {
                    id: mLabelSelectAll
                    text: mAllStrings.mSelectAll
                    textStyle {
                        base: mTextStyleLabel.style
                        color: mAllStrings.lightBlueColor
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        if (mCheckBoxSelectAll.checked) {
                            mCheckBoxDecimal.checked = false
                            mCheckBoxMakani.checked = false
                            mCheckBoxUAENG.checked = false
                            mCheckBoxUTM.checked = false
                            mCheckBoxDLTM.checked = false
                            mCheckBoxDMS.checked = false
                            mCheckBoxSelectAll.checked = false
                        } else {
                            mCheckBoxDecimal.checked = true
                            mCheckBoxMakani.checked = true
                            mCheckBoxUAENG.checked = true
                            mCheckBoxUTM.checked = true
                            mCheckBoxDLTM.checked = true
                            mCheckBoxDMS.checked = true
                            mCheckBoxSelectAll.checked = true
                        }
                    }
                }
            }

            Container {
                id: mContainerMakani
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxMakani
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxMakani.checked = ! mCheckBoxMakani.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectMakani
                    // text: mAllStrings.mMakaniNumber
                    text: mAllStrings.mMAKANI
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxMakani.checked = ! mCheckBoxMakani.checked
                        checkAllChecked();
                    }
                }
            }
            Container {
                id: mContainerUAENG
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxUAENG
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxUAENG.checked = ! mCheckBoxUAENG.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectUAENG
                    text: mAllStrings.mUAENAG
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxUAENG.checked = ! mCheckBoxUAENG.checked
                        checkAllChecked();
                    }
                }
            }
            Container {
                id: mContainerUTM
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxUTM
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxUTM.checked = ! mCheckBoxUTM.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectUTM
                    text: mAllStrings.mutm
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxUTM.checked = ! mCheckBoxUTM.checked
                        checkAllChecked();
                    }
                }
            }
            Container {
                id: mContainerDLTM
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxDLTM
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxDLTM.checked = ! mCheckBoxDLTM.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectDLTM
                    text: mAllStrings.mDLTM
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxDLTM.checked = ! mCheckBoxDLTM.checked
                        checkAllChecked();
                    }
                }
            }
            Container {
                id: mContainerDecimal
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxDecimal
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxDecimal.checked = ! mCheckBoxDecimal.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectDecimal
                    text: mAllStrings.mDecimal
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxDecimal.checked = ! mCheckBoxDecimal.checked
                        checkAllChecked();
                    }
                }
            }
            Container {
                id: mContainerDMS
                horizontalAlignment: HorizontalAlignment.Fill
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                bottomPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                CheckBox {
                    id: mCheckBoxDMS
                    onTouch: {
                        if (event.isUp()) {
                            mCheckBoxDMS.checked = ! mCheckBoxDMS.checked
                            checkAllChecked();
                        }
                    }
                }
                Label {
                    id: mLabelSelectDMS
                    text: mAllStrings.mLatLngDMS
                    textStyle {
                        base: mTextStyleLabel.style
                    }
                }
                onTouch: {
                    if (event.isUp()) {
                        mCheckBoxDMS.checked = ! mCheckBoxDMS.checked
                        checkAllChecked();
                    }
                }
            }

            CommonButtonWithLabel {
                topMargin: 25
                leftPadding: 25
                rightPadding: 25
                horizontalAlignment: HorizontalAlignment.Center
                mLableText: mAllStrings.mShare
                mBackgroundSource: "asset:///images/screens/bg_convert_blue.png"
                mTextColor: Color.White
                onMyClick: {

                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                        createShareString();
                    } else {
                        createShareStringAR();
                    }
                   
                }
            }
        }
    }
    function checkAllChecked() {
        if (mCheckBoxDecimal.checked && mCheckBoxMakani.checked && mCheckBoxUAENG.checked && mCheckBoxUTM.checked && mCheckBoxDLTM.checked && mCheckBoxDMS.checked)
            mCheckBoxSelectAll.checked = true;
        else
            mCheckBoxSelectAll.checked = false;
    }

    function createShareString() {
        isEmpty = false;
        mStringShareData = "";
       // Qt.shareCoordinateCount = mStringShareData.length;
        if (mCheckBoxMakani.checked) {
            if (mTextFieldMakaniNumber.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "Makani: " + mTextFieldMakaniNumber.text.replace(new RegExp(" ", 'g'), "");
                else
                    mStringShareData = "Makani: " + mTextFieldMakaniNumber.text.trim().replace(new RegExp(" ", 'g'), "");
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareMakaniEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxUAENG.checked) {
            if (mTextFieldUAENG.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "UAE NG : " + mTextFieldUAENG.text.replace(new RegExp(" ", 'g'), "");
                else
                    mStringShareData = "UAE NG : " + mTextFieldUAENG.text.replace(new RegExp(" ", 'g'), "");

            } else {
                mSystemDialog.body = mAllStrings.mValidationShareUAENGEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxUTM.checked) {
            if (mTextFieldUTM1.text.trim().length > 0 && mTextFieldUTM2.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "UTM : " + mTextFieldUTM2.text + "," + mTextFieldUTM1.text;
                else
                    mStringShareData = "UTM : " + mTextFieldUTM2.text + "," + mTextFieldUTM1.text;

            } else {
                mSystemDialog.body = mAllStrings.mValidationShareUTMEmpty
                mSystemDialog.show();
                isEmpty = true;
            }

        }
        if (mCheckBoxDLTM.checked) {
            if (mTextFieldDLTM1.text.trim().length > 0 && mTextFieldDLTM2.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "DLTM : " + mTextFieldDLTM2.text + "," + mTextFieldDLTM1.text;
                else
                    mStringShareData = "DLTM : " + mTextFieldDLTM2.text + "," + mTextFieldDLTM1.text;
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDLTMEmpty
                mSystemDialog.show();
                isEmpty = true;
            }

        }
        if (mCheckBoxDecimal.checked) {
            if (mTextFieldLatitude.text.trim().length > 0 && mTextFieldLongitude.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "LAT/LNG Decimal : "+ "\n"  + mTextFieldLatitude.text + "," + mTextFieldLongitude.text;
                else
                    mStringShareData = "LAT/LNG Decimal : " + "\n" + mTextFieldLatitude.text + "," + mTextFieldLongitude.text;
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDecimalEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxDMS.checked) {
            if (mLabelDMSLat1.text.trim().length > 0 && mLabelDMSLon1.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + "DMS : N " + mLabelDMSLat1.text + " " + mLabelDMSLat2.text + " " + mLabelDMSLat3.text + " E " + mLabelDMSLon1.text + " " + mLabelDMSLon2.text + " " + mLabelDMSLon3.text;
                else
                    mStringShareData = "DMS : N " + mLabelDMSLat1.text + " " + mLabelDMSLat2.text + " " + mLabelDMSLat3.text + " E " + mLabelDMSLon1.text + " " + mLabelDMSLon2.text + " " + mLabelDMSLon3.text;
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDMSEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (! isEmpty) {
            if (mStringShareData.length > 0) {
                mDialogShareContent.mShareData = mStringShareData;
                mDialogShareContent.mCopyData = mStringShareData;
                mDialogShareContent.mBackVisible = false;
                mDialogShare.open();

                mDialogShareCoordinate.close();
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareSelectAnyOne
                mSystemDialog.show();
            }
        }
    }
    function createShareStringAR() {
        isEmpty = false;
        mStringShareData = "";
        if (mCheckBoxMakani.checked) {
            if (mTextFieldMakaniNumber.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + mTextFieldMakaniNumber.text.replace(new RegExp(" ", 'g'), "") + " : Makani";
                else
                    mStringShareData = mTextFieldMakaniNumber.text.trim().replace(new RegExp(" ", 'g'), "") + " : Makani ";
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareMakaniEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxUAENG.checked) {
            if (mTextFieldUAENG.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + mTextFieldUAENG.text.replace(new RegExp(" ", 'g'), "") + " : UAE NG";
                else
                    mStringShareData = mTextFieldUAENG.text.replace(new RegExp(" ", 'g'), "") + " : UAE NG ";

            } else {
                mSystemDialog.body = mAllStrings.mValidationShareUAENGEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxUTM.checked) {
            if (mTextFieldUTM1.text.trim().length > 0 && mTextFieldUTM2.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + mTextFieldUTM2.text + "," + mTextFieldUTM1.text + " : UTM ";
                else
                    mStringShareData = mTextFieldUTM2.text + "," + mTextFieldUTM1.text + " : UTM";

            } else {
                mSystemDialog.body = mAllStrings.mValidationShareUTMEmpty
                mSystemDialog.show();
                isEmpty = true;
            }

        }
        if (mCheckBoxDLTM.checked) {
            if (mTextFieldDLTM1.text.trim().length > 0 && mTextFieldDLTM2.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + mTextFieldDLTM2.text + "," + mTextFieldDLTM1.text + " : DLTM ";
                else
                    mStringShareData = mTextFieldDLTM2.text + "," + mTextFieldDLTM1.text + " : DLTM ";
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDLTMEmpty
                mSystemDialog.show();
                isEmpty = true;
            }

        }
        if (mCheckBoxDecimal.checked) {
            if (mTextFieldLatitude.text.trim().length > 0 && mTextFieldLongitude.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "\n" + mTextFieldLatitude.text + "," + mTextFieldLongitude.text + " : LAT/LNG Decimal ";
                else
                    mStringShareData = mTextFieldLatitude.text + "," + mTextFieldLongitude.text + " : LAT/LNG Decimal ";
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDecimalEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (mCheckBoxDMS.checked) {
            if (mLabelDMSLat1.text.trim().length > 0 && mLabelDMSLon1.text.trim().length > 0) {
                if (mStringShareData.length > 0)
                    mStringShareData = mStringShareData + "N " + mLabelDMSLat1.text + " " + mLabelDMSLat2.text + " " + mLabelDMSLat3.text + " E " + mLabelDMSLon1.text + " " + mLabelDMSLon2.text + " " + mLabelDMSLon3.text + " : DMS ";
                else
                    mStringShareData = "N " + mLabelDMSLat1.text + " " + mLabelDMSLat2.text + " " + mLabelDMSLat3.text + " E " + mLabelDMSLon1.text + " " + mLabelDMSLon2.text + " " + mLabelDMSLon3.text + " : DMS ";
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareDMSEmpty
                mSystemDialog.show();
                isEmpty = true;
            }
        }
        if (! isEmpty) {
            if (mStringShareData.length > 0) {
                mDialogShareContent.mShareData = mStringShareData;
                mDialogShareContent.mCopyData = mStringShareData;
                mDialogShareContent.mBackVisible = false;
                mDialogShare.open();

                mDialogShareCoordinate.close();
            } else {
                mSystemDialog.body = mAllStrings.mValidationShareSelectAnyOne
                mSystemDialog.show();
            }
        }
    }

    attachedObjects: [
        TextStyleDefinition {
            id: mTextStyleLabel
        },
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
        },
        SystemDialog {
            id: mSystemDialog
            title: mAllStrings.mCoordinateConnverterTitle
            cancelButton.label: undefined
            confirmButton.label: mAllStrings.mDialogOk
        }
    ]
}

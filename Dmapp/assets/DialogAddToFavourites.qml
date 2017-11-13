// ***********************************************************************************************************
//  ADD TO FAVOURITE PAGE
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
import bb.DatabaseConnectionApi.data 1.0
import bb.system 1.2
//Page {
Container {
    id: mcontainerInfoDetails
    property alias mTextHeader: mTextFieldName.text
    property alias mTextLocation: mTextFieldLocation.text
    property alias mBackVisible: mImageViewInfoBack.visible
    property string mLatitude
    property string mLongitude
    property int mID
    property bool isCheckExist: false
    signal backClick()
    signal successQuery()
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    layout: DockLayout {
    }
    // LANGUAGE TRANSLATION ALIGNMENT 
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow.png"
            mContainerName.layout.orientation = LayoutOrientation.LeftToRight
            mContainerLocation.layout.orientation = LayoutOrientation.LeftToRight
            mStyleForLabel.textAlign = TextAlign.Left
            mTextFieldName.textStyle.textAlign = TextAlign.Left
        } else {
            mContaineLeft.layout.orientation = LayoutOrientation.RightToLeft
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow_right.png"
            mContainerName.layout.orientation = LayoutOrientation.RightToLeft
            mContainerLocation.layout.orientation = LayoutOrientation.RightToLeft
            mStyleForLabel.textAlign = TextAlign.Right
            mTextFieldName.textStyle.textAlign = TextAlign.Right
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
                ImageButton {
                    id: mImageViewInfoBack
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    defaultImageSource: "asset:///images/info/icon_arrow.png"
                    onClicked: {
                        mDialogAddToFavourite.close();
                        backClick();
                    }
                }
                Label {
                    text: mAllStrings.mTitleAddToFavourites
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    textStyle.color: Color.White
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/info/icon_close_white.png"
                onClicked: {
                    mDialogAddToFavourite.close();
                }
            }
        }
        Container {
            leftPadding: 50
            rightPadding: 50
            topPadding: 25
            bottomPadding: 50
            minHeight: 350
            background: mImagePaintDefinitionMainBG.imagePaint
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {

            }
            Container {
                id: mContainerName
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    id: mLabelHeader
                    text: mAllStrings.mName
                    verticalAlignment: VerticalAlignment.Center
                    textStyle {
                        base: mStyleForLabel.style
                        color: mAllStrings.lightBlueColor
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.4
                    }
                }
                TextField {
                    id: mTextFieldName
                    hintText: ""
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                }

            }
            Container {
                topMargin: 25
                id: mContainerLocation
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    id: mLabelLocation
                    text: mAllStrings.mLocation
                    verticalAlignment: VerticalAlignment.Center
                    textStyle {
                        base: mStyleForLabel.style
                        color: mAllStrings.lightBlueColor
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.4
                    }
                }
                Label {
                    id: mTextFieldLocation
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1.0
                    }
                    textStyle.color: Color.Black
                    textStyle {
                        base: mStyleForLabel.style
                    }
                }
            }
            // FINAL SUBMIT BUTTON TO ADD THE FAVOURITE DATA INTO DATABASE, 
            CommonButtonWithLabel {
                topMargin: 25
                leftPadding: 25
                rightPadding: 25
                horizontalAlignment: HorizontalAlignment.Center
                mLableText: mAllStrings.mSave
                mBackgroundSource: "asset:///images/screens/bg_convert_blue.png"
                mTextColor: Color.White
                onMyClick: {
                    if (mTextFieldName.text.trim().length > 0) {
                        if (mImageViewInfoBack.visible) {
                            isCheckExist = true;
                            mCustomeDataSource.query = "SELECT * FROM favourite WHERE location='" + mTextFieldLocation.text + "'";
                            mCustomeDataSource.load();
                        } else {
                            isCheckExist = false;
                            mCustomeDataSource.query = "UPDATE  favourite  SET getpoiname='" + mTextFieldName.text + "' WHERE id=" + mID + ";"
                            mCustomeDataSource.load();
                            mDialogAddToFavourite.close();
                        }
                    }else {
                        mSystemDialog.body = mAllStrings.mValidationPleaseEnterName
                        mSystemDialog.show()
                    }
                }
            }
        }
    }
    //}
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
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/DM_App.sqlite"
            connection: "mCustomeDataSourceInsert"
            onDataLoaded: {
                if (isCheckExist) {
                    isCheckExist = false;
                    if (data.toString().length > 0) {
                        mSystemDialog.body = mAllStrings.mValidationFavouriteAlreadyExist
                        mSystemDialog.show()
                    } else {
                        mCustomeDataSource.query = "INSERT INTO favourite (getpoiname, location, latitude, longitude, telephone, fax_no, email, license_no, poi_url, pobox) VALUES ('" + mTextFieldName.text + "' ,'" + mTextFieldLocation.text + "','" + mLatitude + "', '" + mLongitude + "', '" + _mWebServiceinstance.poiPhone + "', '" + _mWebServiceinstance.poiFax + "', '" + _mWebServiceinstance.poiEmail + "', '" + _mWebServiceinstance.poiLicense + "', '" + _mWebServiceinstance.poiURL + "', '" + _mWebServiceinstance.poiPOBox + "');"
                        mCustomeDataSource.load();
                        mDialogAddToFavourite.close();
                    }
                } else {
                    successQuery();
                    if (mImageViewInfoBack.visible) {
                        mSystemDialog.body = mAllStrings.mValidationFavouriteAdded
                        mSystemDialog.show()
                    } else {
                        mSystemDialog.body = mAllStrings.mValidationFavouriteEdited
                        mSystemDialog.show()
                    }
                }

            }
        },
        TextStyleDefinition {
            id: mStyleForLabel
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
        }
    ]
}
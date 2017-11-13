// ***********************************************************************************************************
//  INFO PAGE TO SHOW INFO ONCLICK OF MAP PIN COORDINATES
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import WebImageView 1.0
//Page {
Container {
    id: mcontainerInfoDetails
    property alias mTextPlaceName: mLabelPlaceName.text
    property alias mTextHeader: mLabelMakaniOrUAENG.text
    property alias mIsNoticeVisible: mLabelNotice.visible
    /* property alias mUrl: mImageViewImage.url
     * property alias mActivityIndicator: mActivityIndicator
     property alias istrue: mImageViewImage.visible*/
    signal backClick()
    layout: DockLayout {
    }
    onCreationCompleted: {
        console.log("image load" + _mWebServiceinstance.mPICTURE); 
        //_mWebServiceinstance.clearmyInfoPopupData();
        //mImageViewImage.url = "http://commons.wikimedia.org/wiki/File:Empty.pn";
        mImageViewImage.urlChanged.connect(imageLoadedCompleted)

        setAlignMent()
       
        

    }
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    // LANGUAGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow.png"
            mStyleForLabel.textAlign = TextAlign.Left
            mAddressLabel.horizontalAlignment=HorizontalAlignment.Left
            
        } else {
            mContaineLeft.layout.orientation = LayoutOrientation.RightToLeft
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
            mImageViewInfoBack.defaultImageSource = "asset:///images/info/icon_arrow_right.png"
            mStyleForLabel.textAlign = TextAlign.Right
            mAddressLabel.horizontalAlignment=HorizontalAlignment.Right
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
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                ImageButton {
                    id: mImageViewInfoBack
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Left
                    defaultImageSource: "asset:///images/info/icon_arrow.png"
                    onClicked: {
                        mDialogInfo.close();
                        backClick();
                    }
                }
                Label {
                    text: mAllStrings.mInfo
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/info/icon_close_white.png"
                onClicked: {
                    mDialogInfo.close();
                }
            }
        }
        Container {
            leftPadding: 50
            rightPadding: 50
            topPadding: 15
            bottomPadding: 125
            minHeight: 350
            background: mImagePaintDefinitionMainBG.imagePaint
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {

            }
            Label {
                id: mLabelPlaceName
                multiline: true
                text: _mWebServiceinstance.poiName
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelMakaniOrUAENG
                multiline: true
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelLandNumber
                //text: mAllStrings.mInfoEntranceName + _mWebServiceinstance.mEntrance
                text: mAllStrings.minfoTextbyland + _mWebServiceinstance.mLandNumber
                visible: _mWebServiceinstance.mLandNumber.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelEntrance
                // text: mAllStrings.mInfoTelNo + _mWebServiceinstance.poiPhone
                text: mAllStrings.mInfoEntranceName + _mWebServiceinstance.mEntrance
                visible: _mWebServiceinstance.mEntrance.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelTelephone
                multiline: true
                text: mAllStrings.mInfoTelNo + _mWebServiceinstance.poiPhone
                visible: _mWebServiceinstance.poiPhone.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelFax
                multiline: true
                text: mAllStrings.mInfoFaxNo + _mWebServiceinstance.poiFax
                visible: false
                // visible: _mWebServiceinstance.poiFax.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelEmail
                multiline: true
                text: mAllStrings.mInfoEmail + _mWebServiceinstance.poiEmail
                visible: _mWebServiceinstance.poiEmail.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            
            Container {
                id: imageContainer
                visible: false
                topPadding: ui.du(2)
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                WebImageView {
                    id: mImageViewImage
                    preferredHeight: 100
                    visible: true
                    preferredWidth: 200
                    url: _mWebServiceinstance.mPICTURE
                    onCreationCompleted: {
                        //_mWebServiceinstance.mPICTUREValueNULL(); 
                    }

                }
                onTouch: {
                    if(event.isUp()){
                        if(mImageViewImage.url!=""){
                            mGalleryView.mWebImageView = mImageViewImage.url
                            mDialogImageView.open()    
                        }
                        
                    }
                }
                onCreationCompleted: {
                    //console.log("image load" + _mWebServiceinstance.mPICTURE); 
                    
                }

            }
            WebImageView {
                //id: mImageViewImage
                preferredHeight: 1
                visible: true
                preferredWidth: 1
                url: "http://commons.wikimedia.org/wiki/File:Empty.png"
            
            }

            Label {
                id: mAddressLabel
                text: mAllStrings.mInfoAddress
                visible: _mWebServiceinstance.mCOMM_EN.toString().length > 0 || _mWebServiceinstance.mROADNAMEEN.toString().length > 0 || _mWebServiceinstance.mBUILDING_NO.toString().length > 0 ? true : false
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Divider {
                visible: _mWebServiceinstance.mCOMM_EN.toString().length > 0 || _mWebServiceinstance.mROADNAMEEN.toString().length > 0 || _mWebServiceinstance.mBUILDING_NO.toString().length > 0 ? true : false
            }
            Label {
                id: mLabelCommunity
                text: mAllStrings.mInfoCommunity + _mWebServiceinstance.mCOMM_EN
                visible: _mWebServiceinstance.mCOMM_EN.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                multiline: true
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelStreet
                //text: "Street:"
                text: mAllStrings.mInfoStreet + _mWebServiceinstance.mROADNAMEEN
                // text: mAllStrings.mInfoLicenseNo + _mWebServiceinstance.poiLicense
                visible: _mWebServiceinstance.mROADNAMEEN.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            /*Label {
             * id: mLabelBuildingName
             * text: "Building Name:"
             * // text: mAllStrings.mInfoLicenseNo + _mWebServiceinstance.poiLicense
             * // visible: _mWebServiceinstance.poiLicense.toString().length > 0 ? true : false
             * horizontalAlignment: HorizontalAlignment.Fill
             * textStyle {
             * base: mStyleForLabel.style
             * color: Color.Black
             * }
             }*/
            Label {
                id: mLabelBuildingNo
                text: mAllStrings.mInfoBuildingNo+_mWebServiceinstance.mBUILDING_NO
                // text: mAllStrings.mInfoLicenseNo + _mWebServiceinstance.poiLicense
                visible: _mWebServiceinstance.mBUILDING_NO.trim().toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelURL
                multiline: true
                text: mAllStrings.mInfoUrl + _mWebServiceinstance.poiURL
                visible: false
                //  visible: _mWebServiceinstance.poiURL.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelPOBox
                multiline: true
                text: mAllStrings.mInfoPoboxNo + _mWebServiceinstance.poiPOBox
                visible: false
                //  visible: _mWebServiceinstance.poiPOBox.toString().length > 0 ? true : false
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
            }
            Label {
                id: mLabelNotice
                text: mAllStrings.mInfoNotice
                horizontalAlignment: HorizontalAlignment.Fill
                visible: false
                textStyle {
                    base: mStyleForLabel.style
                    color: mAllStrings.darkBlueColor
                    fontWeight: FontWeight.Bold
                }
                multiline: true
            }
        }
    }
    function imageLoadedCompleted() {
        mActivityIndicator.stop()
        imageContainer.visible = true;
        mImageViewImage.visible = true;
    }
    ActivityIndicator {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        id: mActivityIndicator
        preferredWidth: 250
        preferredHeight: 250
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
        },
        TextStyleDefinition {
            id: mStyleForLabel
        },Dialog {
            id: mDialogImageView
            GalleryView {
                id: mGalleryView
            }
        }
    ]
}
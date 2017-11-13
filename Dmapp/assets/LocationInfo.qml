// ***********************************************************************************************************
//  LOCATION INFO PIN POINT IN MAP
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
import bb.platform 1.0
import QtMobilitySubset.location 1.2
import bb.system 1.2
import WebImageView 1.0
Container {
    id: mainContainer
    signal passBack(string passValue, bool isHere)
    property string mStringShareData
    property alias mTitle: mLabelTitle.text
    property string currentLang
    layout: DockLayout {
    }
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill
    // LANGUAGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Left
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            currentLang = "E"
        } else {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Right
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
            currentLang = "A"
        }
        mCommonHomeRowInfo.setAlignMent()
        mCommonHomeRowShare.setAlignMent();
        mCommonHomeRowFav.setAlignMent();
        mCommonHomeRowContact.setAlignMent();
        mCommonHomeRowDirectionTo.setAlignMent();
        mCommonHomeRowDirectionFrom.setAlignMent();
        mCommonHomeRowNearBy.setAlignMent();
        mCommonHomeRowCoordinate.setAlignMent();
        mDialogShareContent.setAlignMent();
        mDialogAddToFavourites.setAlignMent();
        mInfoDetails.setAlignMent();
        mCommonHomeNavigation.setAlignMent();
    }
    // WHITE POP UP CONTAINER
    Container {
        layout: StackLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
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
            Label {
                id: mLabelTitle
                textStyle.color: Color.White
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/info/icon_close_white.png"
                onClicked: {
                    mDialogLocationInfo.close();
                }
            }
        }
        // INFO TITLE AND ITS SUB CATEGORIES
        Container {
            layout: StackLayout {
            }
            leftPadding: 50
            rightPadding: 50
            topPadding: 15
            bottomPadding: 100
            background: mImagePaintDefinitionMainBG.imagePaint
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            WebImageView {
                //id: mImageViewImage
                preferredHeight: 100
                visible: false
                preferredWidth: 200
                url: "http://commons.wikimedia.org/wiki/File:Empty.pn"
                
            }

            CommonHomeRow {
                id: mCommonHomeRowInfo
                mLableText: mAllStrings.mInfo
                mImageSource: "asset:///images/info_list/icon_info.png"
                onMyClick: {
                    mDialogLocationInfo.close()
                    mDialogInfo.open()

                    mInfoDetails.mTextHeader = _mWebServiceinstance.checkInvalid(_mWebServiceinstance.getMapCaptionText().toString().replace(" ", "")) == "number" ? mAllStrings.mInfoMakaniNumber + _mWebServiceinstance.getMapCaptionText() : mAllStrings.mInfoUAENG + _mWebServiceinstance.getMapCaptionText();
                    mInfoDetails.mIsNoticeVisible = _mWebServiceinstance.checkInvalid(_mWebServiceinstance.getMapCaptionText().toString().replace(" ", "")) == "number" ? _mWebServiceinstance.getOutlineBuilding() : false;
                }
            }
            CommonHomeRow {
                id: mCommonHomeRowShare
                mLableText: mAllStrings.mShare
                mImageSource: "asset:///images/info_list/icon_share.png"
                onMyClick: {
                    var shareText = _mWebServiceinstance.getMapCaptionText().replace(new RegExp(" ", 'g'), "");
                    //var shareText = _mWebServiceinstance.getMapCaptionText()

                    if (_mWebServiceinstance.mLandNumber != "") {
                        shareText = _mWebServiceinstance.mLandNumber
                    }
                    var checkText = _mWebServiceinstance.validateString(shareText)
                    var shareURL;

                    if (checkText == "landnumber") {
                        shareURL = mAllStrings.mShareURL + currentLang + "&" + "landnumber=" + shareText;
                    } else if (checkText == "number") {
                        shareURL = mAllStrings.mShareURL + currentLang + "&" + "makani=" + shareText;
                    } else if (checkText == "UAENG") {
                        shareURL = mAllStrings.mShareURL + currentLang + "&" + "UAENG=" + shareText;
                    } else {
                        shareURL = shareText
                    }

                    mStringShareData = shareURL
                    mDialogShareContent.mShareData = mStringShareData;
//                    mDialogShareContent.mCopyData = _mWebServiceinstance.getMapCaptionText();
                    mDialogShareContent.mCopyData = shareURL
                    mDialogShareContent.mBackVisible = true;
                    mDialogShare.open();
                    mDialogLocationInfo.close();
                }
            }

            CommonHomeRow {
                id: mCommonHomeRowFav
                mLableText: mAllStrings.mAddtoFavourites
                //  mImageSource: "asset:///images/info_list/icon_add_favorites.png"
                mImageSource: "asset:///images/favourites/button_addtofav.png"
                onMyClick: {
                    mDialogLocationInfo.close()
                    mDialogAddToFavourite.open();

                    mDialogAddToFavourites.mTextHeader = _mWebServiceinstance.poiName

                    mDialogAddToFavourites.mTextLocation = _mWebServiceinstance.getMapCaptionText();
                    mDialogAddToFavourites.mLatitude = _mWebServiceinstance.getMapCaptionLatitude();
                    mDialogAddToFavourites.mLongitude = _mWebServiceinstance.getMapCaptionLongitude();
                    mDialogAddToFavourites.mBackVisible = true;
                }
            }
            CommonHomeRow {
                id: mCommonHomeRowContact
                mLableText: mAllStrings.mAddtoContacts
                mImageSource: "asset:///images/info_list/icon_add_contact.png"
                onMyClick: {
                    _mAppParentObj.AddContact(_mWebServiceinstance.getMapCaptionText())
                }
            }
            CommonHomeRow {
                id: mCommonHomeRowDirectionTo
                visible: false
                mLableText: mAllStrings.mDirectiontohere
                mImageSource: "asset:///images/info_list/icon_directions_to.png"
                onMyClick: {
                    mainTabPaned.changeTab(1);
                    mainTabPaned.callDirections(_mWebServiceinstance.getMapCaptionText(), false);
                    mDialogLocationInfo.close();

                }

            }
            CommonHomeRow {
                visible: false
                id: mCommonHomeRowDirectionFrom
                mLableText: mAllStrings.mDirectionsfromhere
                mImageSource: "asset:///images/info_list/icon_directions_from.png"
                onMyClick: {
                    mainTabPaned.changeTab(1);
                    mainTabPaned.callDirections(_mWebServiceinstance.getMapCaptionText(), true);
                    mDialogLocationInfo.close();
                }
            }

            CommonHomeRow {
                id: mCommonHomeRowNearBy
                mLableText: mAllStrings.mNeraby
                mImageSource: "asset:///images/info_list/icon_nearby.png"
                onMyClick: {
                    // callNearBy
                  mNearby.clearAllData()
                    mainTabPaned.changeTab(3);
                    mainTabPaned.callNearBy(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), true);
                    mDialogLocationInfo.close();
                }
            }
            CommonHomeRow {
                id: mCommonHomeRowCoordinate
                mLableText: mAllStrings.mCoordinateconverter
                mImageSource: "asset:///images/info_list/icon_coordinate.png"
                onMyClick: {
                    var pagemConverter = mConverterComponentDefinition.createObject()
                    pagemConverter.setConvertFromMap(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), _mWebServiceinstance.getMapCaptionText());
                    mNavigationPaneMain.push(pagemConverter)
                    mDialogLocationInfo.close();
                }
            }

            CommonHomeRow {

                id: mCommonHomeNavigation
                mLableText: mAllStrings.mVoiceNavigation
                mContainerBg: Color.create("#00b5e9")
                mLabelTitle.textStyle.color: Color.White
                mImageSource: "asset:///images/info_list/button_voice_navigation.png"
                onMyClick: {

                    var startLatitude = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
                    var stratLongitude = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");

                    routeInvokerID.startLatitude = startLatitude
                    routeInvokerID.startLongitude = stratLongitude
                    routeInvokerID.startName = mAllStrings.mDropDownMyLocation
                    //                    routeInvokerID.startDescription = "My trip's destination"
                    //                    routeInvokerID.startAddress = "My trip's destination"

                    //                    mainTabPaned.callNearBy(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude(), true);
                    routeInvokerID.endLatitude = _mWebServiceinstance.getMapCaptionLatitude()
                    routeInvokerID.endLongitude = _mWebServiceinstance.getMapCaptionLongitude()
                    routeInvokerID.endName = _mWebServiceinstance.getMapCaptionText()

                    routeInvokerID.go();

                }
            }
        }
    }
    attachedObjects: [
        Dialog {
            id: mDialogInfo
            InfoDetails {
                id: mInfoDetails
                onBackClick: {
                    mDialogLocationInfo.open();
                }
            }
        },
        AllStrings {
            id: mAllStrings
        },
        ComponentDefinition {
            id: mNearByComponentDefinition
            source: "NearByServices.qml"
        },
        /* ComponentDefinition {
         * id: mComponentDefinitionNearBy
         * source: "NearBy.qml"
         },*/
        NearBy {

            id: mNearby
        },
        ComponentDefinition {
            id: mConverterComponentDefinition
            source: "CoordinateConverter.qml"
        },
        Dialog {
            id: mDialogShare
            Share {
                id: mDialogShareContent
                onBackClick: {
                    mDialogLocationInfo.open();
                }
            }

        },
        ComponentDefinition {
            id: mcomponentDefDirection
            source: "asset:///Directions.qml"

        },
        SystemDialog {
            id: msys
        },
        Dialog {
            id: mDialogAddToFavourite
            DialogAddToFavourites {
                id: mDialogAddToFavourites
                onBackClick: {
                    mDialogLocationInfo.open();
                }
            }
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopBG
            imageSource: "asset:///images/info_list/icon_bg_top.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionMainBG
            imageSource: "asset:///images/info_list/icon_bg_white_small.png"
        },
        RouteMapInvoker {

            id: routeInvokerID

            currentLocationEnabled: true
            // This example shows binding properties to pre-defined values
            // For example, you can request a route from Ottawa to Toronto,
            // avoiding the highways.

            // You can bind properties to values coming from other widgets
            // within this QML page (for example, text field's input)

            //            startLatitude: positionSource.position.coordinate.latitude // Ottawa's latitude
            //            startLongitude: positionSource.position.coordinate.longitude // Ottawa's longitude
            startName: "Ottawa, Ontario"
            startDescription: "Canada's capital"

            endLatitude: 23.029669 // Toronto's latitude
            endLongitude: 72.527462 // Toronto's longitude
            endName: "Toronto, Ontario"
            endDescription: "My trip's destination"

            // Specify any extra route options...
            //            avoidHighwaysEnabled: true
            //            avoidTollsEnabled: true

            // Specify what should be the center of the map.
            //                centerLatitude: 44.4555
            //                centerLongitude: -77.7744
            // 'heading' property is not explicitly set,
            // so it will be: 0 (i.e., facing North).

        }
    ]

}
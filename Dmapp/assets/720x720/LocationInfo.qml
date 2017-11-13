import bb.cascades 1.2
import "common"

Container {
    id: mainContainer
    signal passBack(string passValue, bool isHere)
    property string mStringShareData
    property alias mTitle: mLabelTitle.text
    layout: DockLayout {
    }
    verticalAlignment: VerticalAlignment.Center
    horizontalAlignment: HorizontalAlignment.Fill

    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Left
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
        } else {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Right
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
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
    }
    Container {
        layout: StackLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        /* MakaniDialogTopBar {
         * mlabelName: "Info"
         * }*/
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
                    //                    infoexitclick()
                }
            }
        }

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
            ScrollView {
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Center
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
                            var shareText = _mWebServiceinstance.getMapCaptionText().replace(" ", "");
                            var checkText = _mWebServiceinstance.checkInvalid(shareText)
                            var shareURL;

                            if (checkText == "number")
                                shareURL = mAllStrings.mShareURL + "makani=" + shareText;
                            else if (checkText == "UAENG")
                                shareURL = mAllStrings.mShareURL + "UAENG=" + shareText;
                            else
                                shareURL = shareText
                            if (mStringShareData.length > 0)
                                mStringShareData = mStringShareData + " , " + shareURL;
                            else
                                mStringShareData = shareURL

                            mDialogShareContent.mShareData = mStringShareData;
                            mDialogShare.open();
                            mDialogLocationInfo.close();
                        }
                    }

                    CommonHomeRow {
                        id: mCommonHomeRowFav
                        mLableText: mAllStrings.mAddtoFavourites
                        mImageSource: "asset:///images/info_list/icon_add_favorites.png"
                        onMyClick: {
                            mDialogLocationInfo.close()
                            mDialogAddToFavourite.open();
                            mDialogAddToFavourites.mTextHeader = _mWebServiceinstance.getMapCaptionText();
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
                            if (event.touchType == TouchType.Down) {
                                _mAppParentObj.AddContact(_mWebServiceinstance.getMapCaptionText())
                            }
                        }
                    }
                    CommonHomeRow {
                        id: mCommonHomeRowDirectionTo
                        mLableText: mAllStrings.mDirectiontohere
                        mImageSource: "asset:///images/info_list/icon_directions_to.png"
                        onMyClick: {
                            var pagemDirection = mcomponentDefDirection.createObject()
                            pagemDirection.receiveValue(_mWebServiceinstance.getMapCaptionText(), false)

                            mNavigationPaneMain.push(pagemDirection);
                            mDialogLocationInfo.close();

                        }

                    }
                    CommonHomeRow {
                        id: mCommonHomeRowDirectionFrom
                        mLableText: mAllStrings.mDirectionsfromhere
                        mImageSource: "asset:///images/info_list/icon_directions_from.png"
                        onMyClick: {
                            var pagemDirection = mcomponentDefDirection.createObject()
                            pagemDirection.receiveValue(_mWebServiceinstance.getMapCaptionText(), true)

                            mNavigationPaneMain.push(pagemDirection);
                            mDialogLocationInfo.close();
                        }
                    }

                    CommonHomeRow {
                        id: mCommonHomeRowNearBy
                        mLableText: mAllStrings.mNeraby
                        mImageSource: "asset:///images/info_list/icon_nearby.png"
                        onMyClick: {
//                            if (event.touchType == TouchType.Down) {
                                var pageNeraBy = mNearByComponentDefinition.createObject()
                                pageNeraBy.mLatitude = _mWebServiceinstance.getMapCaptionLatitude();
                                pageNeraBy.mLongitude = _mWebServiceinstance.getMapCaptionLongitude();
                                //                        pageNeraBy.mNavigationPaneNearBy = mNavigationPaneMain
                                mNavigationPaneMain.push(pageNeraBy)
                                mDialogLocationInfo.close();
//                            }
                        }
                    }
                    CommonHomeRow {
                        id: mCommonHomeRowCoordinate
                        mLableText: mAllStrings.mCoordinateconverter
                        mImageSource: "asset:///images/info_list/icon_coordinate.png"
                        onMyClick: {
//                            if (event.touchType == TouchType.Down) {
                                var pagemConverter = mConverterComponentDefinition.createObject()
                                pagemConverter.setConvertFromMap(_mWebServiceinstance.getMapCaptionLatitude(), _mWebServiceinstance.getMapCaptionLongitude());
                                mNavigationPaneMain.push(pagemConverter)
                                mDialogLocationInfo.close();
//                            }
                        }
                    }
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
        }
    ]

}
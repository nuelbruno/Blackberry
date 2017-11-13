import bb.cascades 1.2
import bb.system 1.2
import "common"
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Center
    property alias mModel: mListView.dataModel
    property alias mlabelDialog: mlabelDialog.text
    property alias mActivityIndicator: mActivityIndicator
    signal doneClick(variant selectedData)
    signal closeClick()
    layout: DockLayout {
    }

    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mContaineLeft.layout.orientation = LayoutOrientation.LeftToRight
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
        } else {
            mContaineLeft.layout.orientation = LayoutOrientation.RightToLeft
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
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
                    text: mAllStrings.mCommunity
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
                    closeClick()
                    console.debug("mImageViewInfoExit")
                    mDialogCommonList.close();

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
            background: mImagePaintDefinitionMainBG.imagePaint
            ListView {
                id: mListView
                horizontalAlignment: HorizontalAlignment.Right
                onCreationCompleted: {
                    setTextAlign()
                }
                function getListItemValue(mListItemData) {
                    if (mListView.dataModel == _mWebServiceinstance.mymodelcommunity) {
                        return mListItemData.commonCommunity
                    } else if (mListView.dataModel == _mWebServiceinstance.mymodelStreet) {
                        return mListItemData.commonStreet
                    } else if (mListView.dataModel == _mWebServiceinstance.mymodelBuiding) {
                        return mListItemData.ADDRESS_E
                    } else if (mListView.dataModel == _mWebServiceinstance.mymodelcategory) {
                        //     return _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? mListItemData.CATEGORY_NAME_E : mListItemData.CATEGORY_NAME_A
                        return mListItemData.Category
                    } else if (mListView.dataModel == _mWebServiceinstance.mymodelservice) {
                        return mListItemData.service_name
                    } else if (mListView.dataModel == _mWebServiceinstance.mymodelfeedbacktype) {
                        return _mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en" ? mListItemData.FEEDBACK_EN : mListItemData.FEEDBACK_AR
                    } else {
                        return mListItemData.my_selectFromData
                    }
                }

                function setTextAlign() {
                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                        return TextAlign.Left
                    } else {
                        return TextAlign.Right
                    }
                }

                listItemComponents: [
                    ListItemComponent {
                        type: "en"
                        Container {
                            id: mListItemComponent
                            background: Color.White
                            verticalAlignment: VerticalAlignment.Fill
                            horizontalAlignment: HorizontalAlignment.Fill
                            rightPadding: 10
                            leftPadding: 10
                            preferredHeight: 100
                            layout: DockLayout {
                            }
                            Label {
                                id: mLabel
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Fill
                                textStyle.textAlign: TextAlign.Left
                                text: mListItemComponent.ListItem.view.getListItemValue(ListItemData)
                            }
                            Divider {
                                verticalAlignment: VerticalAlignment.Bottom
                            }
                        }
                    },
                    ListItemComponent {
                        type: "ar"
                        Container {
                            id: mListItemComponentAr
                            background: Color.White
                            verticalAlignment: VerticalAlignment.Fill
                            horizontalAlignment: HorizontalAlignment.Fill
                            rightPadding: 10
                            leftPadding: 10
                            preferredHeight: 100
                            layout: DockLayout {
                            }
                            Label {
                                id: mLabelAr
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Fill
                                textStyle.textAlign: TextAlign.Right
                                text: mListItemComponentAr.ListItem.view.getListItemValue(ListItemData)
                            }
                            Divider {
                                verticalAlignment: VerticalAlignment.Bottom
                            }
                        }
                    }
                ]
                onTriggered: {
                    var mdata = dataModel.data(indexPath);
                    doneClick(mdata)
                    mDialogCommonList.close();
                }
                function itemType(data, indexPath) {
                    if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en")
                        return "en";
                    else
                        return "ar"
                }
            }
        }
    }
    /*ActivityIndicator {
     * id: mActivityIndicator
     * verticalAlignment: VerticalAlignment.Center
     * horizontalAlignment: HorizontalAlignment.Center
     * preferredWidth: 250
     * preferredHeight: 250
     }*/

    ActivityIndicator {
        id: mActivityIndicator
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 250
        preferredWidth: 250
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

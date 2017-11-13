import bb.cascades 1.2

Container {
    id: list_container
    horizontalAlignment: HorizontalAlignment.Fill
    topPadding: 15
    bottomPadding: 15
    leftPadding: 25
    rightPadding: 25
    background: ListItem.indexPath % 2 == 0 ? Color.White : Color.create("#E8E8E8")
    property alias isDistanceVisible: mContainerDistance.visible
    property variant currentIndexpPath
    layout: DockLayout {
    }
    onCreationCompleted: {
        //        currentIndexpPath = ListItem.indexPath
        //        console.debug("check....." + currentIndexpPath);
        if (list_container.ListItem.view.getLang() == "en") {
            mTextStyleLabel.textAlign = TextAlign.Left
            mCheckBox.horizontalAlignment = HorizontalAlignment.Left
        } else {
            mTextStyleLabel.textAlign = TextAlign.Right
            mCheckBox.horizontalAlignment = HorizontalAlignment.Right
        }
    }
    Container {
        // horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            orientation: list_container.ListItem.view.getLang() == "en" ? LayoutOrientation.LeftToRight : LayoutOrientation.RightToLeft
        }
        Container {
            layoutProperties: StackLayoutProperties {
                spaceQuota: 0.2
            }
            topPadding: 15
            CheckBox {
                id : mCheckBox
                horizontalAlignment: HorizontalAlignment.Left
                checked: ListItemData.getChecked
                //                onCheckedChanged: {
                //                    ListItemData.SELECTED = checked
                //                }
                onTouch: {
                    if (event.isUp()) {

                        //checked = ! checked
                        //ListItemData.getChecked = checked
                        if (mContainerDistance.visible) {
                            ListItemData.getChecked = ! ListItemData.getChecked
                            list_container.ListItem.view.checkAllChecked(checked);
                        } else {
                            list_container.ListItem.view.checkAllChecked(checked, currentIndexpPath);
                        }
                    }
                }
            }
        }

        Container {
            leftPadding: 10
//            rightPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1.0
            }
            Label {
                text: ListItemData.getpoiname
                textStyle.fontSize: FontSize.Medium
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mTextStyleLabel.style
                    color: Color.create("#004C64")
                }
            }
            Label {
                text: mContainerDistance.visible == true ?(list_container.ListItem.view.getLang() == "en" ? "Location : " + ListItemData.getpoiname : "موقع : " + ListItemData.getpoiname ) : (list_container.ListItem.view.getLang() == "en" ? "Location : " + ListItemData.location : "موقع  : " +ListItemData.location)
                textStyle.fontSize: FontSize.Medium
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mTextStyleLabel.style
                    color: Color.create("#00B6E8")
                }
            }
        } //toptobottom layout ends
        Container {
            id: mContainerDistance
            preferredHeight: 140
            verticalAlignment: VerticalAlignment.Center
            background: mImagePaintDefinitionDistance.imagePaint
            layoutProperties: StackLayoutProperties {
                spaceQuota: 0.3
            }
            topPadding: 85
            Label {
                text: ListItemData.poidistance
                //                text: "0.20KM"
                textStyle.fontSize: FontSize.XXSmall
                textStyle.color: Color.White
                horizontalAlignment: HorizontalAlignment.Center
                visible: true
            }
            //            ImageView {
            //                imageSource: "asset:///images/Nearby/taxi-icon.png"
            //                verticalAlignment: VerticalAlignment.Center
            //                horizontalAlignment: HorizontalAlignment.Center
            //            }
        }

    }
    function setIndexPath(mIndexPath) {
        currentIndexpPath = mIndexPath
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopbar
            imageSource: "asset:///images/favourites/bg_text.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionDistance
            imageSource: "asset:///images/Nearby/taxi-icon.png"
        },
        TextStyleDefinition {
            id: mTextStyleLabel
            fontSize: FontSize.Medium
        }
    ]
}

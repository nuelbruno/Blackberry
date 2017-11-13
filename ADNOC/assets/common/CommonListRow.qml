import bb.cascades 1.2

Container {
    id: list_container
    minHeight: 140.0
    maxHeight: 140.0
    horizontalAlignment: HorizontalAlignment.Fill
    topPadding: 15
    bottomPadding: 15
    leftPadding: 25
    rightPadding: 25
    
    //background: ListItem.indexPath % 2 == 0 ? Color.White : Color.create("#E8E8E8")
    background: mRowBgNews.imagePaint
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
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: (Qt.languageset == "en" )? LayoutOrientation.LeftToRight : LayoutOrientation.RightToLeft
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
        
        ImageView {
            id: cat_icon
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            imageSource: "asset:///images/icons/imgServiceStation@2x.png"     
            onCreationCompleted: { //category_unique_name
                if(ListItemData.category_unique_name == "servicestation")
                {
                    cat_icon.imageSource = "asset:///images/icons/imgServiceStation@2x.png";
                }
                else if(ListItemData.category_unique_name == "vehicleinspection") 
                {
                    cat_icon.imageSource = "asset:///images/icons/imgVehicleInspection@2x.png"; 
                }
                else if(ListItemData.category_unique_name == "autoserv") 
                {
                    cat_icon.imageSource = "asset:///images/icons/imgAutoService@2x.png"; 
                }
                else if(ListItemData.category_unique_name == "oasis365") 
                {
                    cat_icon.imageSource = "asset:///images/icons/imgOasis@2x.png"; 
                }
                else if(ListItemData.category_unique_name == "rahalcentre") 
                {
                    cat_icon.imageSource = "asset:///images/icons/imgRahalCenter@2x.png"; 
                }
                else if(ListItemData.category_unique_name == "offices") 
                {
                    cat_icon.imageSource = "asset:///images/icons/imgOffice@2x.png"; 
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
                text: ListItemData.station_code+" - " + ListItemData.title
                textStyle.fontSize: FontSize.Medium
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle {
                    base: mTextStyleLabel.style
                    color: Color.create("#004C64")
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
                text: ""
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
        },
        ImagePaintDefinition {
            id: mRowBgNews
            imageSource: "asset:///images/icons/imgNewsRowBg@2x.png"
        }
    ]
}

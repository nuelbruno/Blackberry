import bb.cascades 1.3

Container {
    id: list_container
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    topPadding: 15
    bottomPadding: 15
    leftPadding: 25
    // visible: false
    rightPadding: 25
    preferredWidth: 768
    property alias mCheckBox: mCheckBox
    background: ListItem.indexPath % 2 == 0 ? Color.White : Color.create("#E8E8E8")
    // property alias isDistanceVisible: mContainerDistance.visible
    property variant currentIndexpPath
    property string mLanguageCode

    signal touchChanged()
    layout: DockLayout {
    }
    onCreationCompleted: {
        setAlignment()

    }
    function setIndexPath(mIndexPath) {
        currentIndexpPath = mIndexPath
    }
    function setAlignment() {
        if (mLanguageCode != "en") {
            mContainerFirst.horizontalAlignment = HorizontalAlignment.Right
            mContaierSecond.horizontalAlignment = HorizontalAlignment.Left
            mStackLayoutCheckBox.orientation = LayoutOrientation.RightToLeft
            mStackLayoutDistance.orientation = LayoutOrientation.RightToLeft
            mLabelFirst.textStyle.textAlign = TextAlign.Right
            mLabelSecond.textStyle.textAlign = TextAlign.Right
            mLabelSecond.text = ListItemData.UAENG+" "+qsTr(":UAE NG") 
        }else{
            mLabelSecond.text = qsTr("UAE NG: ")+" "+ListItemData.UAENG 
        }
    }
    Container {
        id: mContainerFirst
        horizontalAlignment: HorizontalAlignment.Left
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            id: mStackLayoutCheckBox
            orientation: LayoutOrientation.LeftToRight
        }
        CheckBox {
            id: mCheckBox
            verticalAlignment: VerticalAlignment.Center
            checked: ListItemData.getChecked
            onTouch: {
                if (event.isUp()) {
                    touchChanged()
                    //                    //checked = ! checked
                    //                    ListItemData.getChecked = checked
                    //
                    //                    if (total == selecet) {
                    //                        list_container.ListItem.view.checkAllChecked(checked, currentIndexpPath);
                    //
                    //                    } else {
                    //                        ListItemData.getChecked = ! ListItemData.getChecked
                    //                        list_container.ListItem.view.checkAllChecked(checked);
                    //                    }
                }
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    horizontalAlignment: HorizontalAlignment.Fill
                    id: mLabelFirst
                    text: (mLanguageCode == "en" ? ListItemData.NAME_E : ListItemData.NAME_A)
                    preferredWidth: 450
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                Label {
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    id: mLabelSecond
//                    text: ListItemData.UAENG
//                    text: qsTr("UAE NG:")+" "+ListItemData.UAENG 
                    textStyle.color: Color.DarkBlue
                }
            }
        }
    }
    Container {
        id: mContaierSecond
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            id: mStackLayoutDistance
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            Label {
                id: mLabelkm
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Center
                textStyle.color: Color.DarkBlue
                textStyle.fontSize: FontSize.XXSmall
                text: ListItemData.DISTANCE
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Center
            ImageView {
                verticalAlignment: VerticalAlignment.Center
                id: mImageViewImage
                imageSource: "asset:///images/Nearby/button_info.png"
            }
        }
    }
}

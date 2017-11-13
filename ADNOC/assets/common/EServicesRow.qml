/* Copyright (c) 2012 Research In Motion Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0
// Item component for the item list presenting available recipes

Container {
    property bool mBoolMapImage: true
    horizontalAlignment: HorizontalAlignment.Fill
    background: mainUnSelectedBackgrounds.imagePaint
    preferredWidth: 768
    preferredHeight: 120
    rightPadding: 10.0
    leftPadding: 10.0
    property string mLanguageCode

    id: list_container
    onCreationCompleted: {
        mLanguageCode = list_container.ListItem.view.setLanguageCode();
        if (mLanguageCode != "en") {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Right
            mImageViewArrow.horizontalAlignment = HorizontalAlignment.Left
            mImageViewArrow.imageSource = "asset:///images/eservices/icon_arrow_left.png"
        } else {
            mLabelTitle.horizontalAlignment = HorizontalAlignment.Left
            mImageViewArrow.horizontalAlignment = HorizontalAlignment.Right
        }

    }
    Container {
        id: mContainer
        rightPadding: 20.0
        leftPadding: 20.0
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill

        ImageView {
            imageSource: ListItemData.imageIcon
            verticalAlignment: VerticalAlignment.Center
        }
        Label {
            id: mLabelTitle
            verticalAlignment: VerticalAlignment.Center
            textStyle.color: Color.White
            text: (mLanguageCode != "en" ? ListItemData.title_ar : ListItemData.title)
            textStyle.fontSize: FontSize.Small
        }
        
    } // Container
    Container {
        rightPadding: 10.0
        leftPadding: 10.0
        horizontalAlignment: HorizontalAlignment.Right
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.RightToLeft
        }
        ImageView {
            id: mImageViewArrow
            imageSource: "asset:///images/media/arrow_orange.png"
            verticalAlignment: VerticalAlignment.Center
        }
        ImageView {
            id: mImageViewSeprater
            rightMargin: 20.0
            imageSource: "asset:///images/common/seprater_orage_tab.png"
            verticalAlignment: VerticalAlignment.Center
        }

    } // Container
    //     Highlight function for the highlight Container
    function setHighlight() {
        console.debug("mBoolMapImage :", mBoolMapImage)
        if (mBoolMapImage) {
            list_container.background = mainSelectedBackgrounds.imagePaint
            mImageViewArrow.imageSource = "asset:///images/media/arrow_hover.png"
            mImageViewSeprater.imageSource = "asset:///images/common/seprater_tab_selected.png"
            mBoolMapImage = false
        } else {
            list_container.background = mainUnSelectedBackgrounds.imagePaint
            mImageViewArrow.imageSource = "asset:///images/media/arrow_orange.png"
            mImageViewSeprater.imageSource = "asset:///images/common/seprater_orage_tab.png"
            mBoolMapImage = true
        }
    }

    // Connect the onActivedChanged signal to the highlight function
    ListItem.onActivationChanged: {
        setHighlight();
    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mainUnSelectedBackgrounds
            imageSource: "asset:///images/common/list_unselect.png"
        },
        ImagePaintDefinition {
            id: mainSelectedBackgrounds
            imageSource: "asset:///images/common/list_select.png"
        }
    ]

}
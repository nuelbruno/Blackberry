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
    //    background: Color.White
    preferredWidth: 768
    preferredHeight: 100
    horizontalAlignment: HorizontalAlignment.Fill
    property alias mLabelTitle: mLabelTitle1.text
    id: list_container
    onCreationCompleted: {
        var mLanguageCode = _SZHP.getValueFor("mLanguageCode", "en")
        if (mLanguageCode != "en") {
        	mLabelTitle1.horizontalAlignment = HorizontalAlignment.Right
            mImageViewArrow.horizontalAlignment= HorizontalAlignment.Left
            mImageViewArrow.imageSource = "asset:///images/common/icon_arrow_left.png"
        }

    }
    layout: DockLayout {
    }
    Container {
        id: mContainer
        rightPadding: 20.0
        leftPadding: 20.0
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {
        }
        CommonLabel {
            id: mLabelTitle1
            horizontalAlignment: HorizontalAlignment.Left
//            horizontalAlignment: (_SZHP.getValueFor("mLanguageCode", "") == "en" ? HorizontalAlignment.Left : HorizontalAlignment.Right)
//            textStyle.textAlign: (_SZHP.getValueFor("mLanguageCode", "") == "en" ? TextAlign.Left : TextAlign.Right)
            textStyle.color: Color.create("#4682b4")
        }

        ImageView {
            id: mImageViewArrow
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Right
            imageSource: "asset:///images/common/icon_arrow.png"
        }
    } // Container
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }

    // Connect the onActivedChanged signal to the highlight function
    ListItem.onActivationChanged: {
        //        setHighlight();
    }

}
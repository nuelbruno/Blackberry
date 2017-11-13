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
import WebImageView 1.0
// Item component for the item list presenting available recipes

Container {
    property bool mBoolMapImage: true
    background: Color.White
    preferredWidth: 768
    preferredHeight: 200
    horizontalAlignment: HorizontalAlignment.Fill

    id: list_container
    onCreationCompleted: {
        var mLanguageCode = list_container.ListItem.view.setLanguageCode();
        if (mLanguageCode != "en") {
            mContainerLabel.horizontalAlignment = HorizontalAlignment.Right
//            mContainerLabel.rightPadding = 50.0
//            mLabelTitle.textStyle.textAlign = TextAlign.Right
            mStackLayoutGallery.orientation = LayoutOrientation.RightToLeft
//            mLabelTitle.text = qsTr(ListItemData.title_ar)
//            mImageViewArrow.imageSource = "asset:///images/eservices/icon_arrow_left.png"
            mImageViewArrow.horizontalAlignment = HorizontalAlignment.Left
//            mContainerData.horizontalAlignment = HorizontalAlignment.Right
        }
        mImageViewCategory.urlChanged.connect(imageLoadedCompleted)
        mActivityIndicator.start()
    }

    layout: DockLayout {
    }
    Container {
//        id: mContainer
        rightPadding: 20.0
        leftPadding: 20.0
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {
        }
        Container {
            id: mContainerLabel
            verticalAlignment: VerticalAlignment.Center
            layout: StackLayout {
                id: mStackLayoutGallery
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                id: mContainerData
                layout: DockLayout {
                }
                WebImageView {
                    id: mImageViewCategory
                    verticalAlignment: VerticalAlignment.Center
                    //                horizontalAlignment: HorizontalAlignment.Right
                    preferredWidth: 200
                    preferredHeight: 200
                    scalingMethod: ScalingMethod.AspectFill
                    url: ListItemData.imagepath
                }
                ActivityIndicator {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    id: mActivityIndicator
                    preferredWidth: 100
                    preferredHeight: 100
                }
            }
            CommonLabel {
                id: mLabelTitle
//                maxWidth: 650
                verticalAlignment: VerticalAlignment.Center
                text: qsTr(ListItemData.title) + Retranslate.onLanguageChanged
                textStyle.color: Color.Black
            }
        }

        ImageView {
            id: mImageViewArrow
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Right
//            imageSource: "asset:///images/eservices/icon_arrow.png"
        }
    } // Container
    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }

    // Connect the onActivedChanged signal to the highlight function
    ListItem.onActivationChanged: {
        //        setHighlight();
    }
    function imageLoadedCompleted() {
        mActivityIndicator.stop()
    }

}

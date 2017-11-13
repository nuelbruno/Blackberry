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
    //    background: mainBackgrounds.imagePaint
    horizontalAlignment: HorizontalAlignment.Fill
    property string mLanguageCode
    attachedObjects: [

        ImagePaintDefinition {
            id: mImagePaintDefinitionImageBackground
            imageSource: "asset:///images/searchresult/bg_image.png"
        }

    ]
    id: list_container
    onCreationCompleted: {
        mLanguageCode = list_container.ListItem.view.setLanguageCode();
        if (mLanguageCode == "en") {
            mStackLayoutNews.orientation = LayoutOrientation.LeftToRight
        }
        mWebImageView.urlChanged.connect(imageLoadedCompleted)
        mActivityIndicator.start()

    }
    function imageLoadedCompleted() {
        mActivityIndicator.stop()
    }
    layout: DockLayout {
    }

    Container {
        topPadding: 20
        bottomPadding: 20
        rightPadding: 10.0
        leftPadding: 10.0
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Fill
        layout: StackLayout {
            id: mStackLayoutNews
            orientation: LayoutOrientation.RightToLeft
        }

        Container {
            preferredWidth: 240
            preferredHeight: 240
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: mImagePaintDefinitionImageBackground.imagePaint
            layout: DockLayout {

            }
            ActivityIndicator {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                id: mActivityIndicator
                preferredWidth: 100
                preferredHeight: 100
            }
            WebImageView {
                id: mWebImageView
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 190
                preferredHeight: 200
                scalingMethod: ScalingMethod.AspectFill
                url: ListItemData.NewsPhoto

            }

        }

        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonLabel {
                id: mLabelNewsTitle
                preferredWidth: 550
                horizontalAlignment: HorizontalAlignment.Fill
                textStyle.color: Color.create("#FFA500")
                text: (mLanguageCode == "en" ? ListItemData.NTitleEN : ListItemData.NTitle)
            }

            CommonLabel {
                preferredWidth: 550
                id: mLabelNewsDescription
                horizontalAlignment: HorizontalAlignment.Fill
                maxHeight: 100
                text: (mLanguageCode == "en" ? ListItemData.NDescriptionEN : ListItemData.NDescription)
                multiline: true
            }

        }

    } // Container

    Divider {
        verticalAlignment: VerticalAlignment.Bottom
    }
}

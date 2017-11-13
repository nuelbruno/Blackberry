// ***********************************************************************************************************
//  MAP LEGEND
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
Page {
    Container {
        onCreationCompleted: {
            setAlignMent()
        }
        // LANGUAGE CHANGE ALIGNMENT SETUP
        function setAlignMent() {
            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
                mContainerFirst.layout.orientation = LayoutOrientation.LeftToRight
                mContainerSecond.layout.orientation = LayoutOrientation.LeftToRight
                mContainerThird.layout.orientation = LayoutOrientation.LeftToRight
                mContainerFour.layout.orientation = LayoutOrientation.LeftToRight
                mImageViewThird.imageSource = "asset:///images/map/Mappin_en.png"
            } else {
                mContainerFirst.layout.orientation = LayoutOrientation.RightToLeft
                mContainerSecond.layout.orientation = LayoutOrientation.RightToLeft
                mContainerThird.layout.orientation = LayoutOrientation.RightToLeft
                mContainerFour.layout.orientation = LayoutOrientation.RightToLeft
                mImageViewThird.imageSource = "asset:///images/map/Mappin_ar.png"
            }
        }
        CommonTopBar {
            mText: malltsrings.mMapLegend
        }
        // MAP LEGEND DESCRIPTION CONTAINER
        Container {
            leftPadding: ui.du(2)
            rightPadding: ui.du(2)
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            Container {
                id: mContainerFirst
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: ui.du(7)
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView {
                        id: mImageViewFirst
                        imageSource: "asset:///images/more/pin1.png"
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        id: mLabelFirst
                        maxWidth: 650
                        multiline: true
                        textStyle.textAlign: TextAlign.Left
                        text: malltsrings.mMapPinmakani
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
            Container {
                id: mContainerSecond
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: ui.du(7)
                layout: StackLayout {

                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView {
                        id: mImageViewSecond
                        imageSource: "asset:///images/more/pin2.png"
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        id: mLabelSecond
                        maxWidth: 620
                        multiline: true
                        textStyle.textAlign: TextAlign.Left
                        text: malltsrings.mMapPinuaeng
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
            Container {
                id: mContainerThird
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: ui.du(7)
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView {
                        id: mImageViewThird
                        imageSource: "asset:///images/map/Mappin_en.png"
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        id: mLabelThird
                        maxWidth: 650
                        multiline: true
                        textStyle.textAlign: TextAlign.Left
                        text: malltsrings.mMapPinEmergency
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
            Container {
                id: mContainerFour
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: ui.du(7)
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView {
                        id: mImageViewFour
                        imageSource: "asset:///images/map/map_pin_near_by.png"
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        id: mLabelFour
                        maxWidth: 650
                        multiline: true
                        textStyle.textAlign: TextAlign.Left
                        text:malltsrings.mLastMapSelectedLocations
                        verticalAlignment: VerticalAlignment.Center
                    }
                }
            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: malltsrings
        }
    ]
}

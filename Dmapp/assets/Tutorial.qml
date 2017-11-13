import bb.cascades 1.3
import "common"

Page {
    id: mpage
    property string mCheck
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onCreationCompleted: {
            mpage.proceess()
            //            mContainerEngImageOne.imageSource = "asset:///images/tutorial/AR_screen_01.png"
            //            mContainerEngImageTwo.imageSource = "asset:///images/tutorial/AR_screen_02.png"
            //            mContainerEngImageThree = "asset:///images/tutorial/AR_screen_03.png"
            //            mContainerEngImageFour.imageSource = "asset:///images/tutorial/AR_screen_04.png"
        }
        layout: DockLayout {
        }
        function setAlignment() {
            if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") != "en") {
                mContainerHome.horizontalAlignment = HorizontalAlignment.Left
                mContainerEngImageOne.imageSource = "asset:///images/tutorial/AR_screen_01.png"
                mContainerEngImageTwo.imageSource = "asset:///images/tutorial/AR_screen_02.png"
                mContainerEngImageThree = "asset:///images/tutorial/AR_screen_03.png"
                mContainerEngImageFour.imageSource = "asset:///images/tutorial/AR_screen_04.png"
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonTopBar {
                id: mCommonBar
                mText: mAllString.mTitleTutorial
                Container {
                    id: mContainerHome
                    preferredWidth: 200

                    layout: DockLayout {

                    }
                    horizontalAlignment: HorizontalAlignment.Right
                    Button {
                        text: "Home"
                        horizontalAlignment: HorizontalAlignment.Fill
                        onClicked: {

                        }
                    }
                }
            }
            Container {
                background: Color.Blue
                preferredHeight: 100
                preferredWidth: 768
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    id: mContainerLeftFaq
                    preferredHeight: 90
                    background: Color.Gray
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("FAQ")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onTouch: {
                        console.log("quick")
                        mContainerLeft.preferredHeight = 95
                        mContainerRight.preferredHeight = 95
                        mContainerLeftFaq.preferredHeight = 90
                        mContainetQuickTutorial.visible = false
                        mContainerVideoTutorial.visible = false
                    }
                }
                Container {
                    background: Color.Black
                    preferredHeight: 100
                    preferredWidth: 5
                }
                Container {
                    id: mContainerLeft
                    preferredHeight: 95
                    background: Color.Gray
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("Quick Tutorial")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onTouch: {
                        console.log("quick")
                        mContainerLeft.preferredHeight = 90
                        mContainerRight.preferredHeight = 95
                        mContainerLeftFaq.preferredHeight = 95
                        mContainetQuickTutorial.visible = true
                        mContainerVideoTutorial.visible = false
                    }
                }
                Container {
                    background: Color.Black
                    preferredHeight: 100
                    preferredWidth: 5
                }
                Container {
                    id: mContainerRight
                    preferredHeight: 95
                    background: Color.Gray
                    layout: DockLayout {
                    }
                    Label {
                        text: qsTr("Video Tutorial")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    onTouch: {
                        console.log("quick")
                        mContainerLeft.preferredHeight = 95
                        mContainerRight.preferredHeight = 90
                        mContainerLeftFaq.preferredHeight = 95
                        mContainetQuickTutorial.visible = false
                        mContainerVideoTutorial.visible = true
                    }
                }
            }
        }

        Container {
            id: mContainetQuickTutorial
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            preferredHeight: 400
            topPadding: ui.du(5)
            layout: DockLayout {
            }
            Container {
                id: mcontainerOne
                background: mContainerEngImageOne.imagePaint
                property int downX
                property int upX
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
             
                animations: [
                    TranslateTransition {
                        id: animCloseOne
                        toX: -768
                        fromX: 0
                        duration: 1000

                    },
                    TranslateTransition {
                        id: animOpenOne
                        toX: 0
                        fromX: 768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }

                    },
                    TranslateTransition {
                        id: animCloseOneLeft
                        toX: 768
                        fromX: 0
                        duration: 1000

                    },
                    TranslateTransition {
                        id: animOpenOneLeft
                        toX: 0
                        fromX: -768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }

                    }
                ]
                onTouch: {
                    var pointX = event.windowX
                    if (event.isDown()) {
                        downX = pointX
                    }
                    if (event.isUp()) {
                        upX = pointX
                        if (downX >= upX + 25) {
                            animCloseOne.play()
                            animOpenTwo.play()
                            mcontainerTwo.visible = true
                            mpage.mCheck = "Two"
                        } else {
                            if (upX >= downX + 25) {
                                animCloseOneLeft.play()
                                animOpenFourLeft.play()
                                mcontainerFour.visible = true
                                mpage.mCheck = "Four"
                            }
                        }
                    }

                }
            }
            Container {
                id: mcontainerTwo
                property int downX
                property int upX
                visible: false
                preferredHeight: 600
                preferredWidth: 768
                background: mContainerEngImageTwo.imagePaint
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: StackLayout {
                }
                animations: [
                    TranslateTransition {
                        id: animOpenTwo
                        toX: 0
                        fromX: 768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                    },
                    TranslateTransition {
                        id: animCloseTwo
                        toX: -768
                        fromX: 0
                        duration: 1000

                    },
                    TranslateTransition {
                        id: animCloseTwoLeft
                        toX: 768
                        fromX: 0
                        duration: 1000

                    },
                    TranslateTransition {
                        id: animOpenTwoLeft
                        toX: 0
                        fromX: -768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                    }
                ]
                onTouch: {
                    var pointX = event.windowX
                    if (event.isDown()) {
                        downX = pointX
                    }
                    if (event.isUp()) {
                        upX = pointX
                        if (downX >= upX + 25) {
                            animOpenThree.play()
                            animCloseTwo.play()
                            mcontainerThree.visible = true
                            mpage.mCheck = "Three"
                        } else {
                            if (upX >= downX + 25) {
                                animCloseTwoLeft.play()
                                animOpenOneLeft.play()
                                mcontainerOne.visible = true
                                mpage.mCheck = "One"
                            }
                        }
                    }
                }
            }
            Container {
                id: mcontainerThree
                visible: false
                property int downX
                property int upX
                preferredHeight: 600
                preferredWidth: 768
                background: mContainerEngImageThree.imagePaint
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: StackLayout {
                }
                animations: [
                    TranslateTransition {
                        id: animOpenThree
                        toX: 0
                        fromX: 768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                    },
                    TranslateTransition {
                        id: animCloseThree
                        toX: -768
                        fromX: 0
                        duration: 1000

                    },
                    TranslateTransition {
                        id: animCloseThreeLeft
                        toX: 768
                        fromX: 0
                        duration: 1000
                    },
                    TranslateTransition {
                        id: animOpenThreeLeft
                        toX: 0
                        fromX: -768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                    }
                ]
                onTouch: {
                    var pointX = event.windowX
                    if (event.isDown()) {
                        downX = pointX
                    }
                    if (event.isUp()) {
                        upX = pointX
                        if (downX >= upX + 25) {
                            animOpenFour.play()
                            animCloseThree.play()
                            mcontainerFour.visible = true
                            mpage.mCheck = "Four"
                        } else {
                            if (upX >= downX + 25) {
                                animCloseThreeLeft.play()
                                animOpenTwoLeft.play()
                                mcontainerTwo.visible = true
                                mpage.mCheck = "Two"
                            }
                        }
                    }
                }
            }
            Container {
                visible: false
                id: mcontainerFour
                property int downX
                property int upX
                preferredHeight: 600
                preferredWidth: 768
                background: mContainerEngImageFour.imagePaint
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: StackLayout {
                }

                animations: [
                    TranslateTransition {
                        id: animOpenFour
                        toX: 0
                        fromX: 768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                    },
                    TranslateTransition {
                        id: animCloseFour
                        toX: -768
                        fromX: 0
                        duration: 1000
                        onEnded: {
                        }
                        onStarted: {
                        }
                    },
                    TranslateTransition {
                        id: animCloseFourLeft
                        toX: 768
                        fromX: 0
                        duration: 1000
                        onEnded: {
                        }
                        onStarted: {
                        }
                    },
                    TranslateTransition {
                        id: animOpenFourLeft
                        toX: 0
                        fromX: -768
                        duration: 1000
                        onEnded: {
                            mpage.proceess()
                        }
                        onStarted: {
                        }
                    }
                ]
                onTouch: {
                    var pointX = event.windowX
                    if (event.isDown()) {
                        downX = pointX
                    }
                    if (event.isUp()) {
                        upX = pointX
                        if (downX >= upX + 25) {
                            animOpenOne.play()
                            animCloseFour.play()
                            mcontainerOne.visible = true
                            mpage.mCheck = "One"
                        } else {
                            if (upX >= downX + 25) {
                                animCloseFourLeft.play()
                                animOpenThreeLeft.play()
                                mcontainerThree.visible = true
                                mpage.mCheck = "Three"
                            }
                        }
                    }
                }
            }
            Container {
                bottomPadding: 125
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Bottom
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    id: mProcessIconOne
                    leftMargin: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    ImageView {
                        id: mImageViewProcessOne
                        imageSource: "asset:///images/tutorial/slider_btn_hover.png"
                    }
                }
                Container {
                    id: mProcessIconTwo
                    leftMargin: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    ImageView {
                        id: mImageViewProcessTwo
                        imageSource: "asset:///images/tutorial/slider_btn_normal.png"
                    }
                }
                Container {
                    id: mProcessIconThree
                    leftMargin: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    ImageView {
                        id: mImageViewProcessThree
                        imageSource: "asset:///images/tutorial/slider_btn_normal.png"
                    }
                }
                Container {
                    id: mProcessIconFour
                    leftMargin: 20
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    ImageView {
                        id: mImageViewProcessFour
                        imageSource: "asset:///images/tutorial/slider_btn_normal.png"
                    }
                }
            }
        }
        Container {
            id: mContainerVideoTutorial
            visible: false
            preferredHeight: 700
            preferredWidth: 768
            background: Color.Yellow
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            Label {
                text: qsTr("Video Tutorial")
            }
        }
        Container {
            leftPadding: 100
            rightPadding: 100
            background: Color.Gray
            verticalAlignment: VerticalAlignment.Bottom
            preferredHeight: 100
            preferredWidth: 768
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            CheckBox {
                id: mCheckBox
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
            }
            Label {
                text: qsTr("Don't show at start up")
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
            }

        }
    }
    function proceess() {
        console.log("call Process")
        if (mpage.mCheck == "One") {
            mImageViewProcessOne.imageSource = "asset:///images/tutorial/slider_btn_hover.png"
            mImageViewProcessTwo.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessThree.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessFour.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
        } else if (mpage.mCheck == "Two") {
            mImageViewProcessOne.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessTwo.imageSource = "asset:///images/tutorial/slider_btn_hover.png"
            mImageViewProcessThree.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessFour.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
        } else if (mpage.mCheck == "Three") {
            mImageViewProcessOne.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessTwo.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessThree.imageSource = "asset:///images/tutorial/slider_btn_hover.png"
            mImageViewProcessFour.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
        } else if (mpage.mCheck == "Four") {
            mImageViewProcessOne.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessTwo.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessThree.imageSource = "asset:///images/tutorial/slider_btn_normal.png"
            mImageViewProcessFour.imageSource = "asset:///images/tutorial/slider_btn_hover.png"
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllString
        },
        ImagePaintDefinition {
            id: mContainerEngImageOne
            imageSource: "asset:///images/tutorial/screen_01.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageTwo
            imageSource: "asset:///images/tutorial/screen_02.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageThree
            imageSource: "asset:///images/tutorial/screen_03.png"
        },
        ImagePaintDefinition {
            id: mContainerEngImageFour
            imageSource: "asset:///images/tutorial/screen_04.png"
        }
    ]
}

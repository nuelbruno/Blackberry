// ***********************************************************************************************************
//  FAQ EXPAND COLLPASE MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
Container {
    property alias bodyVisible: mContentBody.visible
    property alias mContentBody: mContentBody
    property alias mLableQuationValue: mLableQuation.text
    property alias mLableAnswerValue: mLableAnswer.text

    property string collapseImage
    property string expandImage
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    preferredWidth: 768
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        // EXPAND COLLAPSE BUTTON
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Top
            topPadding: ui.du(1)
            leftPadding: ui.du(1)
            bottomPadding: ui.du(1)
            preferredWidth: ui.du(8.0)
            preferredHeight: ui.du(10.0)
            minHeight: ui.du(10.0)
            minWidth: ui.du(8.0)

            ImageButton {
                id: mImageIcon
                defaultImageSource: expandImage
                pressedImageSource: expandImage
                onClicked: {

                    if (bodyVisible) {
                        setVisibleFalse()
                    } else {
                        setVisibleTrue()
                    }
                }
            }
        }
        // TEXT TO SHOW ON EXPAND AND COLLPASE
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Top
            topPadding: ui.du(1)

            Label {
                id: mLableQuation
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Center
                multiline: true
                textStyle.textAlign: TextAlign.Left
            }
            Container {
                id: mContentBody
                verticalAlignment: VerticalAlignment.Top
                rightPadding: ui.du(2)
                visible: false
                layout: DockLayout {

                }
                Label {
                    id: mLableAnswer
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    textStyle.textAlign: TextAlign.Left

                }
            }
        }

    }

    function setVisibleTrue() {
        mContentBody.visible = true;
        mImageIcon.defaultImageSource = collapseImage;
        mImageIcon.pressedImageSource = collapseImage;
    }
    function setVisibleFalse() {
        mContentBody.visible = false;
        mImageIcon.defaultImageSource = expandImage;
        mImageIcon.pressedImageSource = expandImage;
    }
}
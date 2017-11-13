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
            orientation: LayoutOrientation.RightToLeft
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Right
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
        Container {
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Top
            topPadding: ui.du(1)
            
            Label {
                id: mLableQuation
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                multiline: true
                textStyle.textAlign: TextAlign.Right
            }
            Container {
                id: mContentBody
                verticalAlignment: VerticalAlignment.Top
                leftPadding: ui.du(2)
                visible: false
                
                layout: DockLayout {
                
                }
                Label {
                    id: mLableAnswer
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    textStyle.textAlign: TextAlign.Right
                
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
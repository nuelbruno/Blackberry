// ***********************************************************************************************************
//  GALLERY VIEW TO SHOW IMAGES IN MAP PINS
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
//Page {
//    property NavigationPane mNavigationPaneParent
//    function setData(selectedItem) {
//
//
//        mCommonTitleBar.mTitleValue = selectedItem.Title
//        mWebImageView.url = selectedItem.FullUrl
//
//        mLoadingDialog.open()
//
//    }
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    background: Color.Black
    property alias mWebImageView: mWebImageView.url
    layout: DockLayout {
    }
    Container {
        verticalAlignment: VerticalAlignment.Top
        horizontalAlignment: HorizontalAlignment.Right
        rightPadding: 50.0
        topPadding: 50.0
        bottomPadding: 50.0
        leftPadding: 50.0
        ImageButton {
            id: mImageViewInfoExit
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Right
            defaultImageSource: "asset:///images/info/icon_close_white.png"
            onClicked: {
                mDialogImageView.close();
            }
        }    
    }
    // WEBVIEW TO SHOW THE PIN COORDINATE IMAGES
    WebView {
        id: mWebImageView
        visible: true
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
//        preferredHeight: Infinity
//        preferredWidth: Infinity
//        settings.viewport: {
//            "width": "device-width",
//            "height": "device-height",
//            "initial-scale": 1.0
//        }
        onCreationCompleted: {
        }
        onMinContentScaleChanged: {
            //            scrollView.scrollViewProperties.minContentScale = minContentScale;
        }
        onMaxContentScaleChanged: {
            //            scrollView.scrollViewProperties.maxContentScale = maxContentScale;
        }
        onLoadingChanged: {

            if (loadRequest.status == WebLoadStatus.Started) {
                //                                    console.debug("onLoadingChanged loadRequest :", mWebImageViewIndoor.url)
                mLoadingDialog.start()

            } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                mLoadingDialog.stop()
                //mWebImageView.visible = true;

            } else if (loadRequest.status == WebLoadStatus.Failed) {
                mLoadingDialog.stop()
                //                                    console.debug("onLoadingChanged failed :", mWebImageViewIndoor.url)
            }
        }
    }
    ActivityIndicator {
        id: mLoadingDialog
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 250
        preferredWidth: 250
    }

}

//}

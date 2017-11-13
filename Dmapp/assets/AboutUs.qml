// ***********************************************************************************************************
//  ABOUT US PAGE CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import "common"
Page {
    property alias mTitle: mCommonBar.mText
    property alias mWebViewPath: mWebView.url
    property string mUrlRequest
    property NavigationPane mNavigationPaneMain
    property bool mFlag: true

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onCreationCompleted: {
        }
        layout: DockLayout {
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonTopBar {
                id: mCommonBar
                mText: mAllString.mSearchServices
            }
            // ABOUT US CONTENT HOLDING IN WEBVIEW
            ScrollView {
                verticalAlignment: VerticalAlignment.Fill
                scrollViewProperties {
                    scrollMode: ScrollMode.Both
                }
                //                layoutProperties: StackLayoutProperties {
                //                    spaceQuota: 1.0
                //                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    leftPadding: ui.du(2.0)
                    rightPadding: ui.du(2.0)
                    layout: DockLayout {
                    }
                    WebView {
                         id: mWebView
                         horizontalAlignment: HorizontalAlignment.Center
                         preferredWidth: 720
                        //verticalAlignment: VerticalAlignment.Fill
                        //                        settings.devicePixelRatio: 2.5
                        //                        onMessageReceived: {
                        //                            console.debug("message : " + message.origin);
                        //                            console.debug("message : " + message.data);
                        //                            if (message.data == "makani") {
                        //                                mNavigationPaneMain.pop();
                        //                                _mWebServiceinstance.ClearMapdata();
                        //                                _mWebServiceinstance.GetBuildingInfo("2997195280")
                        //                                _mWebServiceinstance.setPoiInfoData(mAllString.mContactTitle, "", "+971 4 206 4846", "MakaniTeam@dm.gov.ae", "", "", "67");
                        //                                mainTabPaned.changeTab(0);
                        //                            }
                        //                        }
                        onUrlChanged: {
                            console.debug("onUrlChanged :", url)
                        }
                        onNavigationRequested: {

                            console.debug("onNavigationRequested :", request.url)
                            mActivityIndicatorwebview.start()
                            mUrlRequest = request.url;
                            if (mUrlRequest.indexOf("makani=") != -1) {
                                //                                console.debug("Length :", "&makani=".length)
                                //                                var dataUrl = mUrlRequest.substr("makani=".indexOf, mUrlRequest.length);
                                var dataUrl = mUrlRequest.substr(mUrlRequest.indexOf("makani="), mUrlRequest.length);
                                //                                mUrlRequest.indexOf("nextpage:///")
                                //                                console.debug("dataUrl :", dataUrl)
                                if (mFlag) {

                                    if (mUrlRequest.indexOf("makani=") != -1) {
                                        var makaniUrl = dataUrl.split('=')
                                        var makaniNumber = makaniUrl[1]
                                        _mWebServiceinstance.ClearMapdata();
                                        _mWebServiceinstance.GetBuildingInfo(makaniNumber)
                                        _mWebServiceinstance.setPoiInfoData(mAllString.mContactTitle, "", "+971 4 206 4846", "MakaniTeam@dm.gov.ae", "", "", "67");

                                        for (var i = 0; i < mNavigationPaneMain.count(); i ++) {
                                            mNavigationPaneMain.pop(mNavigationPaneMain.at(i))
                                        }
                                        mainTabPaned.changeTab(0);
                                        mFlag = false
                                        return;
                                    }
                                }
                            }

                            //                            console.debug("onNavigationRequested :", mUrlRequest)
                            //                            if (mUrlRequest.indexOf("denied") != -1) {
                            //                                if (mUrlRequest.indexOf("denied") != -1) {
                            //                                    console.debug("onLoadingChanged Succeeded :", mUrlRequest)
                            //                                    mButtonTwitter.enabled = false;
                            //                                    loginView.close()
                            //                                }
                            //                                //                                    request.action.Ignore
                            //                            }
                        }
                        onLoadingChanged: {

                            if (loadRequest.status == WebLoadStatus.Started) {
                                mActivityIndicatorwebview.start()

                            } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                                mActivityIndicatorwebview.stop()

                            } else if (loadRequest.status == WebLoadStatus.Failed) {
                                mActivityIndicatorwebview.stop()
                            }
                        }
                    }
                    ActivityIndicator {
                        id: mActivityIndicatorwebview
                        preferredHeight: 250
                        preferredWidth: 250
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center

                    }
                }
            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllString
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: mAllString.mBack
            onTriggered: {
                mNavigationPaneMain.pop();
            }
        }
    }
}

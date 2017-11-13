// ***********************************************************************************************************
//  SHOWING ROUTE ON THE MAP CONATINER
//
// 
// ***********************************************************************************************************
import bb.cascades 1.2

Page {
    Container {
        onCreationCompleted: {
            webViewHtml.loadHtml(_mWebServiceinstance.myPolylineData(),  "local:///assets/polyconverter.html")
        }
        WebView {
            id: webViewHtml
        }
    }
}

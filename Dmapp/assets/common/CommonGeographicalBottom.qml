import bb.cascades 1.2

Container {
    property alias mLabelBelowFirst2: mLabelBelowFirst2.text
    //horizontalAlignment: HorizontalAlignment.Fill
    preferredWidth: 370
    // rightPadding: 50
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    Label {
//        text: mAllString.mLongitude
        textStyle.color: Color.Blue
        textStyle.fontWeight: FontWeight.Bold
    }
    Label {
        id: mLabelBelowFirst2

        textStyle.color: Color.Red
    }
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }

        TextField {
            preferredWidth: 50
            /*layoutProperties: StackLayoutProperties {
             * spaceQuota: 0.1
             * }*/
        }

        TextField {
            preferredWidth: 50
            /*layoutProperties: StackLayoutProperties {
             * spaceQuota: 0.1
             * }*/
        }

        TextField {
            preferredWidth: 210
            /*layoutProperties: StackLayoutProperties {
             * spaceQuota: 0.9
             * }*/
        }

    }
    attachedObjects: [
//        AllStrings {
//            id: mAllString
//        }
    ]
}

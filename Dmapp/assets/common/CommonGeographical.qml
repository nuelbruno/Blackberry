import bb.cascades 1.2

Container {
    property alias mLabelBelowFirst: mLabelBelowFirst.text
    horizontalAlignment: HorizontalAlignment.Fill
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    Label {
        text: "Longitude"
        textStyle.color: Color.Blue
        textStyle.fontWeight: FontWeight.Bold
    }
    Label {
        id: mLabelBelowFirst

        textStyle.color: Color.Red
    }
    TextField {
        id: mTextFieldlng
        preferredWidth: 350
    }
}

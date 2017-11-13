import bb.cascades 1.0

Label {
    id: txtCommon
    text: qsTr("") + Retranslate.onLanguageChanged
//    multiline: true
    verticalAlignment: VerticalAlignment.Center
//    textStyle.fontWeight: FontWeight.Bold

    textStyle {
//        textAlign: TextAlign.Default
//        base: SystemDefaults.TextStyles.TitleText
        fontSize: FontSize.Small
//                color: Color.create("#FFFFFF")
//        color: Color.White
    }
}

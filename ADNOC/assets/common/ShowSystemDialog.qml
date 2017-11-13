import bb.cascades 1.0
import bb.system 1.0
Container {
    property alias mSystemDialogBody: myQmlDialog.body
    property alias mSystenDialogId: myQmlDialog
    property alias mSystemDialogTitle: myQmlDialog.title
    property alias myQmlDialogLabelConfirm: myQmlDialog.confirmButton
    signal closePage()
    onCreationCompleted: {
        myQmlDialog.cancelButton.label = undefined
        //        myQmlDialog.confirmButton.label = qsTr(_SZHP.getValueFor("mLanguageCode", "en") == "en" ? "Ok" : "موافق") + Retranslate.onLanguageChanged
    }
    attachedObjects: [

        SystemDialog {
            id: myQmlDialog
            title: qsTr("SZHP") + Retranslate.onLanguageChanged
            onFinished: {
                var x = result;
                if (x == SystemUiResult.ConfirmButtonSelection) {
                    closePage()
                }
            }

        }
    ]
}

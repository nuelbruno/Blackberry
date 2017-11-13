import bb.cascades 1.0
import bb.system 1.0
// creates one page with a label
Page {
    titleBar: TitleBar {
        id: pageTitleBar
        
      
        // The 'Cancel' action
        dismissAction: ActionItem {
            title: qsTr ("Cancel")
            
            onTriggered: navigationPane.pop()
        }
    }
    Container {
        layout: DockLayout {}
        
        
        
        TextField {
            id: inputnumber
            text: '4444'
            preferredWidth: 400.0
            translationY: 350.0
            translationX: 0
            visible: true
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            inputMode: TextFieldInputMode.PhoneNumber
            input {
                flags: TextInputFlag.PredictionOff | TextInputFlag.AutoCorrectionOff
            }
            input.submitKey: SubmitKey.Next
            textStyle.textAlign: TextAlign.Center
            clearButtonVisible: false
            enabled: false
            //hintText: "Input SMS number"
        }
        
        
        
        TextField {
            id: inputtext
            preferredWidth: 600.0
            translationY: 450.0
            translationX: 0
            visible: true
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            inputMode: TextFieldInputMode.Text
            input.submitKey: SubmitKey.Next
            textStyle.textAlign: TextAlign.Center
            clearButtonVisible: false
            hintText: ""
        }
        
        
        
        
        Button {
            id: sendsms
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            translationX: 0
            translationY: 550.0
            attachedObjects: [
                SystemDialog {
                    id: dialog
                    title: qsTr("Are you sure to send sms?")
                    body: qsTr("Confirm your action?")
                    cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    onFinished: {
                        if (dialog.result == SystemUiResult.ConfirmButtonSelection) _smsexample.sendSMS(inputtext.text, inputnumber.text);
                    }
                }
            ]
            onClicked: {
                dialog.show()
            }
            text: qsTr("Send")
        }
    
    
    
    
    }
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: qsTr("Back") + Retranslate.onLanguageChanged
            onTriggered: {
                    navigationPane.peekEnabled = true;
                    navigationPane.pop();
            }
        }
    }
}
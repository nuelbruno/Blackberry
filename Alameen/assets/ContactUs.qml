import bb.cascades 1.0
import bb.system.phone 1.0
import bb.system 1.0

NavigationPane {
    id: navigationPane

    onPopTransitionEnded: page.destroy()

    Page {
        property int tabWidth: 300
         
         onCreationCompleted: {
             console.debug("message instance call checek......."+ _messages);
         }
        titleBar: TitleBar {
            title: qsTr("Contact Us") + Retranslate.onLanguageChanged
        }
        Container {
            background: Color.create("#F2EEE4")
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            leftPadding: 50.0
            topPadding: 10.0
            //maxWidth: tabWidth
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }

            Container {
                leftPadding: 45.0
                topPadding: 20.0
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top

                Label {
                    id: contactdesLabel
                    text:qsTr("Please choose any following services to contact us") + Retranslate.onLanguageChanged
                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                    textStyle.color: Color.create("#666666")
                    maxWidth: 600
                    multiline: true
                    //leftPadding: 85.0
                }
            }
            // ####### First  layer #################  //
            Container {
                // background: Color.create("#666666")
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                topPadding: 40.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {

                    topPadding: 45.0
                    leftPadding: 45.0
                    preferredHeight: 205

                    layout: DockLayout {
                    }

                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }
                    // ###### call box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/call.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: callLabel
                            text: qsTr("Toll Free") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: callnumLabel
                            text: "+971 800 4888"
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            textStyle.color: Color.create("#333333")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        onTouch: {

                            if (event.isUp()) {
                                callusconfirmalert.show();
                               // phone.requestDialpad("+971 80048888")
                            }
                        }

                    }
                    attachedObjects: [
                        Phone {
                            id: phone
                        },
                        SystemDialog {
                            id: callusconfirmalert
                            title: qsTr("Are you sure to call?") + Retranslate.onLanguageChanged
                            body: qsTr("Confirm your action?") + Retranslate.onLanguageChanged
                            cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
                            confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                            //buttons: [ok]
                            onFinished: {
                                onFinished: {
                                    if (callusconfirmalert.result == SystemUiResult.ConfirmButtonSelection) phone.requestDialpad("+971 80048888") ;
                                }
                            }
                        }
                    ]

                } // box container
                Container {

                    topPadding: 45.0
                    leftPadding: 0.0
                    preferredHeight: 205
                    layout: DockLayout {
                    }

                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }
                    // ###### email box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 282
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/email.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: emailLable
                            text: qsTr("Email") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: emailaddLabel
                            text: "alameen@alameen.gov.ae"
                            textStyle.base: SystemDefaults.TextStyles.SmallText
                            textStyle.color: Color.create("#333333")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }

                    }
                    onTouch: {

                        if (event.isUp()) {
                            _messages.composeMessage()
                            navigationPane.push(messageComposer.createObject())
                        }
                    }

                } // box container

            }
            // ####### second layer #################  //
            Container {
                // background: Color.create("#666666")
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {

                    topPadding: 0.0
                    leftPadding: 45.0
                    preferredHeight: 205
                    layout: DockLayout {
                    }
                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }
                    // ###### SMS box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 282
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/sms.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: smsLable
                            text: qsTr("SMS only from UAE") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            multiline: true
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: smstxtlabel
                            text: "4444"
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            textStyle.color: Color.create("#333333")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        onTouch: {
                            
                            if (event.isUp()) {
                                
                                navigationPane.push(smsComposer.createObject())
                            }
                        }

                    }

                }
                Container {

                    topPadding: 0.0
                    leftPadding: 0.0
                    preferredHeight: 205
                    layout: DockLayout {
                    }
                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }
                    // ###### Instagram box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 282
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/intagram.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: instagramLabel
                            text:  qsTr("Instagram") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: instagramtxtLabel
                            text: qsTr("Coming soon..") + Retranslate.onLanguageChanged
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            textStyle.color: Color.create("#666666")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }

                    }

                } // box container
            }
            // ####### Third  layer #################  //
            Container {
                //background: Color.create("#666666")
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {

                    topPadding: 0.0
                    leftPadding: 45.0
                    preferredHeight: 205
                    layout: DockLayout {
                    }
                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }

                    // ###### FAX box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 282
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/fax.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: faxlabel
                            text: qsTr("Fax") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: faxTxtLabel
                            text: "+971 800 4888"
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            textStyle.color: Color.create("#333333")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }

                    }

                }
                Container {

                    topPadding: 0.0
                    leftPadding: 0.0
                    preferredHeight: 205
                    layout: DockLayout {
                    }
                    ImageView {
                        imageSource: "asset:///images/bg.png"
                        minWidth: 282
                        minHeight: 242
                    }

                    // ###### Twitter box ######## //
                    Container {
                        //background: Color.create("#666666")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 282
                        topPadding: 0.0
                        // layout: StackLayout {
                        // orientation: LayoutOrientation.TopToBottom
                        // }
                        ImageView {
                            imageSource: "asset:///images/twitter.png"
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: twitterLabel
                            text: qsTr("Twitter") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#666666")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            id: twitterTxtLabel
                            text: "@AlAmeenService"
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            textStyle.color: Color.create("#333333")
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                        }
                        onTouch: {
                            
                            if (event.isUp()) {
                                
                                _socialInvocation.invoke("Twitter", "bb.action.SHARE", "text/plain", 'http://alameen.gov.ae/')
                                //_socialInvocation.invoke("com.twitter.urihandler", "bb.action.VIEW", "", "twitter:connect:test")
                            }
                        }

                    }

                } // box container
            }

        }
        attachedObjects: [
            ComponentDefinition {
                id: messageComposer
                source: "MessageComposer.qml"
            },
            ComponentDefinition {
                            id: smsComposer
                            source: "SmsComposer.qml"
            }
        ]

    }    //

}
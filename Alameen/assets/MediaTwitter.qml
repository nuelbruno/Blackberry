import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0
import bb.system 1.0
import "common"

Page {
    id: tweetlist
    property string mLanguageCode
    property string twitterAccessToken
    titleBar: TitleBar {
        title: qsTr("Twitter Feeds") + Retranslate.onLanguageChanged
    }
    function passNewsUniqName(data) {
        console.debug("twiter access token getting in twite page companyNumber :", data);
        twitterAccessToken = data;
    }
    Container {
        
        background: Color.create("#F2EEE4")
        onCreationCompleted: {
            if (_MOL.isNetworkAvailable()) {
                weatherService.getTweetsToken(twitterAccessToken)
                console.debug("setCompanyData ...")
                console.debug('qml list out put' + weatherService.modelPlateList);
                mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
                Qt.languageset = mLanguageCode;
            }
            else {
                nointernetConnectalert.show();
            }    
        }
        Container {
            topPadding: 40
            leftPadding: 40
            rightPadding: 40           
            background: Color.create("#F2EEE4")
                        
            ListView {
                                
                dataModel: weatherService.modelPlateList
                              
                //layoutProperties: StackLayoutProperties {
                // Spacequota needs to be set so the list doesn't take precedence
                // when the Page is laid out (if not set, it will fill the entire screen).
                //spaceQuota: 1
                // }
                
                listItemComponents: [
                    
                    ListItemComponent {
                        type: ""
                        Container {
                            id: itemRoot
                            bottomPadding: 20.0
                            layout: DockLayout {
                            }
                            
                            // Item background
                            ImageView {
                                imageSource: "asset:///images/listingbg.png"
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Fill
                                maxHeight: 150
                                minHeight: 150
                            
                            }
                            
                            // Item highlight
                            Container {
                                background: Color.create("#75b5d3")
                                opacity: itemRoot.ListItem.active ? 0.2 : 0.0
                                maxWidth: 670
                                minWidth:670                                  
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                            }
                            
                            
                            Container {
                                id: labelcontainer
                                leftPadding: 10.0
                                rightPadding: 10.0
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                
                                layout: StackLayout {
                                    id: mStackLayoutlistNews
                                    orientation: (Qt.languageset != "en")? LayoutOrientation.RightToLeft :LayoutOrientation.LeftToRight
                                }                              
                                
                                // Item image, delivered via ListItemData from the models/sheet.xml model
                                WebImageView {
                                    id: webViewImage
                                    url: ListItemData.getStationID
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    maxWidth: 220
                                    minWidth: 220
                                    maxHeight: 138
                                    minHeight: 138
                                    // visible: (webViewImage.loading == 1.0)
                                }
                                Label {
                                    id: usefilLabel
                                    text: ListItemData.getArea
                                    textStyle.color: Color.create("#666666")
                                    horizontalAlignment:HorizontalAlignment.Center
                                    textStyle.base: SystemDefaults.TextStyles.SmallText
                                    verticalAlignment: VerticalAlignment.Center
                                    maxWidth: 425
                                    minWidth: 425
                                    maxHeight: 138
                                    minHeight: 138
                                    topPadding: 0
                                    multiline: true
                                }
                                
                            }
                        
                        
                        } // Container
                    
                    } // ListItemComponent
                ]
                onTriggered: {
                    
                    var chosenItem = dataModel.data(indexPath);
                    console.debug('qml list out put' + chosenItem.getDistance);
                    
                    var  TwitterDetailpage = mediatwitterDetail.createObject();
                    TwitterDetailpage.passNewsUniqName(chosenItem)
                    navigationPane.push(TwitterDetailpage)
                }
            } // ListView
            
            
        
        } // list holding container
        attachedObjects: [
            WeatherService {
                id: weatherService
            },
            ComponentDefinition {
                id: mediatwitterDetail
                source: "MediaTwitterDetail.qml"
            },
            SystemDialog {
                id: nointernetConnectalert
                title: qsTr("Alert") + Retranslate.onLanguageChanged
                body: qsTr("No internet connection available") + Retranslate.onLanguageChanged
                cancelButton.label: undefined
                confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                //buttons: [ok]
                onFinished: {
                
                }
            }
        ]
        LoadingDialog {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            active: weatherService.active
        }
    } // main container
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: qsTr("Back") + Retranslate.onLanguageChanged
            onTriggered: {
                if (! weatherService.active) {
                    navigationPane.peekEnabled = true;
                    navigationPane.pop();
                }
            }
        }
    }
}// main 

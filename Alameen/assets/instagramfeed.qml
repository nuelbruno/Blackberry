import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0
import bb.system 1.0
import "common"

Page {
    id: instagramlist
    property string mLanguageCode
    property string instgramAccessToken
    titleBar: TitleBar {
        title: qsTr("Instagram Feeds") + Retranslate.onLanguageChanged
    }
    function passNewsUniqName(data) {
        //console.debug("twiter access token getting in twite page companyNumber :", data);
        instgramAccessToken = data;
        console.debug("instagram access token  ..."+instgramAccessToken);
        if (_MOL.isNetworkAvailable()) {
            weatherService.getInstagramFeed(instgramAccessToken);
            console.debug("instagram access token qml file ..."+instgramAccessToken);
            console.debug('qml list out put' + weatherService.modelPlateList);
            mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
            Qt.languageset = mLanguageCode;
        }
        else {
            nointernetConnectalert.show();
        }  
    }
    Container {
        
        background: Color.create("#F2EEE4")
        onCreationCompleted: {
            
        }
        Container {
            topPadding: 40
            leftPadding: 40
            rightPadding: 40
            background: Color.create("#F2EEE4")
            
            // A grid list with some fruits that can be put in the fruit basket.
            ListView {
                // dataModel: XmlDataModel {
                //     source: "models/sheetmodel.xml"
                // }
                property string weblink
                
                dataModel: weatherService.modelPlateList
                layout: GridListLayout {
                    columnCount: 3
                    cellAspectRatio: 1.5
                }
                
                layoutProperties: StackLayoutProperties {
                    // Spacequota needs to be set so the list doesn't take precedence
                    // when the Page is laid out (if not set, it will fill the entire screen).
                    spaceQuota: 1
                }
                
                listItemComponents: [
                    ListItemComponent {
                        type: ""
                        Container {
                            id: itemRoot
                            
                            layout: DockLayout {
                            }
                            
                            
                            // Item image, delivered via ListItemData from the models/sheet.xml model
                            WebImageView {
                                id: webViewImage
                                url: ListItemData.getStationID
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                scalingMethod: ScalingMethod.AspectFill
                                visible: loading == 1
                            }
                            Container {
                                id: labelcontainer
                                bottomPadding: 10.0
                                leftPadding: 10.0
                                rightPadding: 10.0
                                
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Bottom
                                Label {
                                    id: usefilLabel
                                    text: ListItemData.getTitle
                                    //text:weatherService.succeeded
                                    bottomPadding: 10.0
                                    textStyle.color: Color.create("#FFFFFF")
                                    textStyle.base: SystemDefaults.TextStyles.SmallText
                                
                                }
                            }
                        
                        
                        } // Container
                    
                    } // ListItemComponent
                ]
                onTriggered: {
                    
                    var chosenItem = dataModel.data(indexPath);
                    console.debug('qml list out put' + chosenItem.getArea);
                    
                    var  instagramDetailpage = mediaInstagramDetails.createObject();
                    instagramDetailpage.passNewsUniqName(chosenItem);
                    navigationPane.push(instagramDetailpage);
                
                }
            } // ListView
        } // Container
        attachedObjects: [
            WeatherService {
                id: weatherService
            },
            ComponentDefinition {
                id: mediaInstagramDetails
                source: "instagramDetails.qml"
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

import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0
import bb.system 1.0
import "common"

    Page {
        id: newslist
        property string mLanguageBool
        property string mLanguageCode
        property int newsCount
        titleBar: TitleBar {
            title: qsTr("Al Ameen News") + Retranslate.onLanguageChanged
        }
        onCreationCompleted: {
            
            if (_MOL.isNetworkAvailable()) {
                mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
                mLanguageBool = (mLanguageCode == 'ar')? '2' : '1'; 
                
                weatherService.requestNewlistData(mLanguageBool, '15');
                console.debug("setCompanyData ...")
                console.debug('qml list out put' + weatherService.modelPlateList);
                Qt.languageset = mLanguageCode;
            }
            else {
                nointernetConnectalert.show();
            }
        
           
        }
        Container {
            
           

            background: Color.create("#F2EEE4")
            
            Container {
                topPadding: 40
                leftPadding: 40
                rightPadding: 40
               
                background: Color.create("#F2EEE4")
               
                
                ListView {
                   
                    // dataModel: XmlDataModel {
                    //     source: "models/sheetmodel.xml"
                    // }
                  
                    
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
                                    id: labelcontainer
                                    background: Color.create("#75b5d3")
                                    opacity: itemRoot.ListItem.active ? 0.2 : 0.0
                                    maxWidth: 670
                                    minWidth:670                                  
                                    verticalAlignment: VerticalAlignment.Fill
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    layout: StackLayout {
                                        id: mStackLayoutlistNews
                                        orientation: LayoutOrientation.LeftToRight
                                    } 
                                   
                                }
                                
                                
                                Container {
                                    id: imageContainer
                                    leftPadding: 10.0
                                    rightPadding: 10.0
                                    maxWidth: 222
                                    minWidth: 222
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment:(Qt.languageset != "en")? HorizontalAlignment.Right : HorizontalAlignment.Left
                                    layout: DockLayout {
                                    
                                    }
                                                                 
                                    ImageView {
                                        imageSource: "asset:///images/defaultImage.png"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        scalingMethod: ScalingMethod.AspectFill
                                        maxWidth: 220
                                        //minWidth: 120
                                        maxHeight: 138
                                        //minHeight: 78
                                        visible: (ListItemData.getDescription != 1)
                                    }
                                    // Item image, delivered via ListItemData from the models/sheet.xml model
                                    WebImageView {
                                        id: webViewImage
                                        url: "http://alameen.ae" + ListItemData.getDescription
                                        //horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        scalingMethod: ScalingMethod.AspectFill
                                        maxWidth: 220
                                        minWidth: 220
                                        maxHeight: 138
                                        minHeight: 138
                                        visible: (webViewImage.loading == 1.0)
                                    }
                                }
                                Container {
                                    id: contentContainer
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment:(Qt.languageset != "en")? HorizontalAlignment.Left : HorizontalAlignment.Right
                                    leftPadding: 5.0
                                    rightPadding: 5.0
                                    maxWidth: 440
                                    minWidth: 440
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.TopToBottom
                                    }
                                    Label {
                                        id: usefilLabel
                                        text: ListItemData.getTitle
                                        textStyle.color: Color.create("#666666")
                                        textStyle.base: SystemDefaults.TextStyles.SmallText
                                        //horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        maxWidth: 430
                                        minWidth: 430
                                        maxHeight:60
                                        minHeight: 60
                                        multiline: true
                                    }
                                    Label {
                                        id: usefilLabel2
                                        text: ListItemData.getStationID
                                        textStyle.color: Color.create("#666666")
                                        textStyle.base: SystemDefaults.TextStyles.SmallText
                                        //horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        maxWidth: 430
                                        minWidth: 430
                                        maxHeight: 60
                                        minHeight: 60
                                        multiline: true
                                    }
                                    
                                }
                            
                            
                            } // Container
                        
                        } // ListItemComponent
                    ]
                    onTriggered: {
                        
                        var chosenItem = dataModel.data(indexPath);
                        console.debug('qml list out put' + indexPath);
                        
                        var  NewsDetailpage = mediaNewsDetail.createObject();
                        NewsDetailpage.passNewsUniqName(chosenItem)
                        navigationPane.push(NewsDetailpage)
                    }
                } // ListView
                LoadingDialog {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    active: weatherService.active
                }
                
            } // list holding container
            attachedObjects: [
                WeatherService {
                    id: weatherService
                },
                ComponentDefinition {
                    id: mediaNewsDetail
                    source: "MediaNewsDetail.qml"
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

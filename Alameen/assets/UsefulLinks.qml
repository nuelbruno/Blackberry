import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0
import "common"
import bb.system 1.0

NavigationPane {
    id: navigationPane

    onPopTransitionEnded: page.destroy()
    Page {
        id: sheetFruit
        signal cancel()
        signal save(string newFruit)
       
       

       

        titleBar: TitleBar {
            id: addBar
            title: qsTr("Useful Links") + Retranslate.onLanguageChanged

        }

        Container {
            property string mLanguageCode
            property string mLanguageBool
            background: Color.create("#F2EEE4")

            onCreationCompleted: {
                if (_MOL.isNetworkAvailable()) {
                mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
                mLanguageBool = (mLanguageCode == 'ar')? '2' : '1'; 
                weatherService.requestWeatherInformation(mLanguageBool, 'general', '50');
                console.debug("setCompanyData ...------------------------" + mLanguageCode);
                console.debug('qml list out put' + weatherService.modelPlateList);
                }
                else {
                    nointernetConnectalert.show();
                }
                // weatherService.activeChanged.connect(dataLodedCompleted);
               
                //console.debug("active status-----" + weatherService.succeeded);
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
                        cellAspectRatio: 1.2
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

                                // Item background
                                ImageView {
                                    imageSource: "asset:///images/empty_box.amd"
                                    verticalAlignment: VerticalAlignment.Fill
                                    horizontalAlignment: HorizontalAlignment.Fill
                                }

                                // Item highlight
                                Container {
                                    background: Color.create("#75b5d3")
                                    opacity: itemRoot.ListItem.active ? 0.2 : 0.0
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                }

                                // Item image, delivered via ListItemData from the models/sheet.xml model
                                ImageView {
                                    imageSource: "asset:///images/defaultImageVsmall.png"
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    scalingMethod: ScalingMethod.AspectFill
                                    visible: webViewImage.loading < 1.0
                                }
                                WebImageView {
                                    id: webViewImage
                                    url: "http://alameen.ae" + ListItemData.getDescription                                   
                                    // imageSource: "asset:///images/call.png"
                                    horizontalAlignment: HorizontalAlignment.Center
                                    verticalAlignment: VerticalAlignment.Center
                                    //scalingMethod: ScalingMethod.AspectFill
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

                                        textStyle.color: Color.create("#666666")
                                        textStyle.base: SystemDefaults.TextStyles.SmallText

                                    }
                                }
                                

                            } // Container

                        } // ListItemComponent
                    ]
                    onTriggered: {

                        var chosenItem = dataModel.data(indexPath);
                        console.debug('qml list out put' + chosenItem.getArea);
                        
                        //var webViewLink = chosenItem.getDescription;
                        weblink = chosenItem.getArea;
                        var  webPage = webUsefulLink.createObject();
                        webPage.subCatValue = chosenItem.getArea;
                        navigationPane.push(webPage)

                    }
                } // ListView
            } // Container
            LoadingDialog {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                active: weatherService.active
            }
            
           
            
            attachedObjects: [
                WeatherService {
                    id: weatherService
                },
                ComponentDefinition {
                    id: webUsefulLink
                    source: "UsefulLinkWeb.qml"
                },
                SystemDialog {
                    id: nointernetConnectalert
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("No internet connection available") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    onFinished: {
                    
                    }
                }
            ]
        } // RecipeContainer
    }
}
import bb.cascades 1.0
import WeatherService 1.0
import bb.system 1.0

NavigationPane {
    id: navigationPane
    property string mLanguageCode
    property string twitterAccess
    property string facebookAccess
    property string  instagramAccess
    onPopTransitionEnded: page.destroy()

    Page {
        titleBar: TitleBar {
            title: qsTr("Media") + Retranslate.onLanguageChanged
        }
        onCreationCompleted: {
            if (_MOL.isNetworkAvailable()) {
            mLanguageCode = _MOL.getValueFor("mLanguageCode", "en")
            weatherService.getMediaFeedsEnable();
            console.debug("setCompanyData ...")
            console.debug('qml list out put' + weatherService.modelPlateList);
            weatherService.dataLoaded.connect(afterDataLoad);
            }
            else {
                nointernetConnectalert.show();
            }
        }
        
        function afterDataLoad() {
            console.debug("data loaded.......")
            var socialType1 =  weatherService.getNewDetailTitle();
            console.debug("social fisrst enable get :", socialType1);
            var socialType1_value =  weatherService.getNewDetailDescribtion();
            console.debug("social fisrst enable get :", socialType1_value);
            facebookAccess =  weatherService.getFacebookAccesstoken();
            console.debug("social facebookAccess enable get :", facebookAccess);
            if(socialType1_value != 0)
            {
                facebookcontainer.visible = true  
            }
            // facebookcontainer.visible = true  
            var socialType2 =  weatherService.getNewDetailDate();
            console.debug("social se enable get :", socialType2);
            var socialType2_value =  weatherService.getNewDetailImagePath();
            console.debug("social se enable get :", socialType2_value);
            twitterAccess =  weatherService.getTwitterAccesstoken();
            console.debug("social fisrst enable get :", twitterAccess);
            if(socialType2_value != 0)
            {
                twittercontainer.visible = true  
            }
            var socialType3 =  weatherService.getNewDetailCurUnniquename();
            console.debug("social thi enable get :", socialType3);
            var socialType3_value =  weatherService.getNewDetailpreUnqName();
            console.debug("social thi enable get :", socialType3_value);
            instagramAccess =  weatherService.getInstagramAccesstoken();
            console.debug("token for instagram  :", instagramAccess);
            
            if(socialType3_value != 0)
            {
                instagramcontainer.visible = true  
            }
            //instagramcontainer.visible = true  
        
        }
       
        Container {
            layout: StackLayout {
            }
            background: Color.create("#F2EEE4")

            Container {

                id: newscontainer

                layout: AbsoluteLayout {

                }

                ImageView {
                    imageSource: "asset:///images/listingbg.png"
                    minWidth: 660
                    minHeight: 180
                    leftMargin: 80
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 50
                        positionY: 50
                    }
                    //minWidth: '80%'
                }

                Container {

                    id: newscontainerSub
                    layout: AbsoluteLayout {
                        // orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 80
                        positionY: 60
                    }
                    ImageView {
                        id: newsIcon
                        imageSource: "asset:///images/news.png"
                        layoutProperties: AbsoluteLayoutProperties {
                            id: postionsetup
                            positionX: (mLanguageCode != "en")? 510 : 50
                            positionY: 50
                        }
                        onCreationCompleted: {
                            if (_MOL.isNetworkAvailable()) {
                            }
                            else {
                                postionsetup.positionX = 50 
                            }
                        }

                    }
                    Label {
                        id: newsLabel
                        text: qsTr("Al Ameen News") + Retranslate.onLanguageChanged
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                        layoutProperties: AbsoluteLayoutProperties {
                            id: postionsetup2
                            positionX:(mLanguageCode != "en")? 250 : 140
                            positionY: 50
                        }
                        onCreationCompleted: {
                            if (_MOL.isNetworkAvailable()) {
                            }
                            else {
                                postionsetup2.positionX = 140 
                            }
                        }

                    }
                    
                    onTouch: {
                        if (event.touchType == TouchType.Down) {
                            
                            if (_MOL.isNetworkAvailable()) {
                                navigationPane.push(mediaNews.createObject());
                            }
                            else {
                                nointernetConnectalert.show();
                            }
                            
                            
                        }
                    
                    }

                } // inner most
            } // holding container

            // ####### twitter Container ######### //
            Container {

                id: twittercontainer
                visible: false
                layout: AbsoluteLayout {

                }

                ImageView {
                    imageSource: "asset:///images/listingbg.png"
                    minWidth: 660
                    minHeight: 180
                    leftMargin: 80
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 50
                        positionY: 50
                    }
                    //minWidth: '80%'
                }

                Container {

                    id: twittercontainersub
                    
                    layout: AbsoluteLayout {
                        // orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 80
                        positionY: 60
                    }
                    ImageView {
                        imageSource: "asset:///images/twitter.png"
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: (mLanguageCode != "en")? 510 : 50
                            positionY: 50
                        }

                    }
                    Label {
                        id: twitterlabel
                        text: qsTr("Twitter Feeds") + Retranslate.onLanguageChanged
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX:(mLanguageCode != "en")? 170 : 140
                            positionY: 50
                        }

                    }
                    
                    
                    
                    onTouch: {
                        if (event.touchType == TouchType.Down) {
                            var  twitterObject = contactViewer.createObject();
                            twitterObject.passNewsUniqName(twitterAccess);
                            navigationPane.push(twitterObject);
                        }

                    }

                   
                    
                    
                    

                } // inner most
            } // holding container
            
          // ############# FACEBOOK CONTAINER ###############  //
            Container {
                
                id: facebookcontainer
                visible: false
                layout: AbsoluteLayout {
                
                }
                
                ImageView {
                    imageSource: "asset:///images/listingbg.png"
                    minWidth: 660
                    minHeight: 180
                    leftMargin: 80
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 50
                        positionY: 50
                    }
                    //minWidth: '80%'
                }
                
                Container {
                    
                    id: facebookcontainersub
                    
                    layout: AbsoluteLayout {
                        // orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 80
                        positionY: 60
                    }
                    ImageView {
                        imageSource: "asset:///images/facebook.png"
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: (mLanguageCode != "en")? 520 :40
                            positionY: 40
                        }
                    
                    }
                    Label {
                        id: facebooklabel
                        text: qsTr("Facebook Feeds") + Retranslate.onLanguageChanged
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                        //horizontalAlignment: HorizontalAlignment.Right
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX:(mLanguageCode != "en")? 100 : 140
                            positionY: 50
                        }
                    
                    }
                    
                    
                    
                    onTouch: {
                        if (event.touchType == TouchType.Down) {
                            
                            var  facebookObject = facebookViewer.createObject();
                            facebookObject.passNewsUniqName(facebookAccess);
                            navigationPane.push(facebookObject);
                        }
                    
                    }
                
                
                
                
                
                
                } // inner most
            } // holding container
            // ############# Instagram CONTAINER ###############  //
            Container {
                
                id: instagramcontainer
                visible: false
                layout: AbsoluteLayout {
                
                }
                
                ImageView {
                    imageSource: "asset:///images/listingbg.png"
                    minWidth: 660
                    minHeight: 180
                    leftMargin: 80
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 50
                        positionY: 50
                    }
                    //minWidth: '80%'
                }
                
                Container {
                    
                    id: instagramcontainersub
                    
                    layout: AbsoluteLayout {
                        // orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 80
                        positionY: 60
                    }
                    ImageView {
                        imageSource: "asset:///images/intagram.png"
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: (mLanguageCode != "en")? 510 : 50
                            positionY: 45
                        }
                    
                    }
                    Label {
                        id: instagramlabel
                        text: qsTr("Instagram Feeds") + Retranslate.onLanguageChanged
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX:(mLanguageCode != "en")? 70 : 140
                            positionY: 40
                        }
                    
                    }
                    
                    
                    
                    onTouch: {
                        if (event.touchType == TouchType.Down) {
                            var  instagramObject = instgramViewer.createObject();
                            instagramObject.passNewsUniqName(instagramAccess);
                            navigationPane.push(instagramObject);
                        }
                    
                    }
                
                
                
                
                
                
                } // inner most
            } // holding container
            
          // ###########  other list ######## //
            attachedObjects: [
                ComponentDefinition {
                    id: mediaNews
                    source: "MediaNews.qml"
                },
                WeatherService {
                    id: weatherService
                },
                ComponentDefinition {
                    id: contactViewer
                    source: "MediaTwitter.qml"
                },
                ComponentDefinition {
                    id: facebookViewer
                    source: "facebookfeed.qml"
                },
                ComponentDefinition {
                    id: instgramViewer
                    source: "instagramfeed.qml"
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
        }
        
    }
    

}

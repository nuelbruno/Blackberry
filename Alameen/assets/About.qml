import bb.cascades 1.0
import WeatherService 1.0
import bb.system 1.0
import "common"

Page {
    property NavigationPane mNavigationPaneMain
    property string strCurrentTab: "Goals"
    property bool mFlagVisionMission: true
    property bool mFlagMinisterMessage: true
    property string mLanguageCode
    property string mLanguageBool
    property string mButtonBgSourceSelected: "asset:///images/call.png"
    property string mLangCode
    property int tabWidth: 590
    property int tabsubWidth: 589

    titleBar: TitleBar {
        title: qsTr("About Us") + Retranslate.onLanguageChanged
    }
    
    
    
    function afterDataLoad() {
        console.debug("aferdata load called in about us");
        var dataContents;
        dataContents = weatherService.getAboutustabcontent();
        for (var x = 0; x < dataContents.length; x ++) {
            console.debug(dataContents.length + "aboutus text after praseing and inserting in qml" + dataContents[x].Content);

        }
        
       // mWebViewAboutus.text = dataContents[0].Content;
    }
    
    onMLangCodeChanged: {
        console.debug("about page test onmlang code change event");
    }
    Container {
        id: rootcon
        background: Color.create("#F2EEE4")

        onCreationCompleted: {
           
            mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
            Qt.mLanguageCodeqt = mLanguageCode;
            console.debug('aboutus language code' + mLanguageCode);
            if (mLanguageCode != "en") {
                //mScrollViewTab.scrollToPoint(2150, 0, ScrollAnimation.Smooth);
                listviewscrolltypeaboutus.orientation = LayoutOrientation.RightToLeft;
  
            } else {
                // mScrollViewTab.scrollToPoint(0, 0, ScrollAnimation.Smooth);
                listviewscrolltypeaboutus.orientation = LayoutOrientation.LeftToRight;
            }
            
            _MOL.networkToatShow();
            
            mLanguageBool = (mLanguageCode == 'ar') ? '2' : '1';
            
            if (_MOL.isNetworkAvailable()) {
                
                weatherService.requestAboutusTab("aboutus.mobile", mLanguageBool);
                console.debug('qml list out put aboutus' + weatherService.modelPlateList);
                weatherService.dataLoaded.connect(afterDataLoad);
            
            } else {
                console.debug('no internet connection condition' );
                nointernetConnectalert.show();
            
            }

        }

        ListView {
            id: listviewAboutus

            layout: StackListLayout {
                id: listviewscrolltypeaboutus
                orientation: LayoutOrientation.LeftToRight
            }
            onCreationCompleted: {
                
            }
            flickMode: FlickMode.SingleItem
            scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
            
            dataModel: weatherService.modelPlateList

            listItemComponents: [

                ListItemComponent {
                    type: ""
                    
                    Container {
                        id: mainContaioner
                        background: Color.create("#F2EEE4")

                        Container {
                            topPadding: 10
                            leftPadding: 0
                            rightPadding: 0
                            maxHeight: 87
                            minHeight: 87
                            background: Color.create("#F2EEE4")

                            Container {
                                topPadding: 15.0
                                preferredHeight: 86
                                property int tabWidth: 590
                                property int tabsubWidth: 588
                                id: mContainerAboutTab
                                //background: mImagePaintDefinitionSelected.imagePaint
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                //preferredWidth: 768
                                Container {
                                    id: buttonContab1
                                    preferredHeight: 82
                                    preferredWidth: 768
                                    rightPadding: 30.0
                                    leftPadding: 40.0
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Top
                                    Label {
                                        id: mLabelAbout
                                        //text: qsTr("Welcome to Alameen services") + Retranslate.onLanguageChanged
                                        text: ListItemData.getTitle
                                       
                                        //customid: ListItemData.getTitle
                                        //horizontalAlignment: HorizontalAlignment.Right
                                        verticalAlignment: VerticalAlignment.Top
                                        textStyle.color: Color.create("#03879e")
                                        preferredHeight: 20
                                        onCreationCompleted: {
                                            
                                            console.debug('aboutus language code' + Qt.mLanguageCodeqt );
                                            
                                            if (Qt.mLanguageCodeqt  != "en") {
                                                mLabelAbout.horizontalAlignment =HorizontalAlignment.Right
                                            }
                                            else 
                                            {
                                                mLabelAbout.horizontalAlignment =HorizontalAlignment.Left   
                                            }
                                        }

                                    }
                                    
                                    
                                    Container {
                                        id: borderLinetab1
                                        preferredHeight: 16
                                        preferredWidth: 768
                                        // topPadding: 75.0
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Bottom
                                        background: Color.create("#03879e")
                                    
                                    }

                                }
                                
                                
                            }
                        } // sub main container
                        Container {
                            topPadding: 30.0
                            bottomPadding: 10.0
                            rightPadding: 30.0
                            leftPadding: 40.0
                            id: mContainerAboutusMsg

                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            visible: true

                            ScrollView {
                                id: englishcontentscroll
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                scrollViewProperties.initialScalingMethod: ScalingMethod.Fill
                                scrollViewProperties.scrollMode: ScrollMode.Vertical
                                visible: false
                              
                            
                                Label {
                                    id: mWebViewAboutus
                                    //leftPadding: 10.0
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    maxWidth: 700
                                    minWidth: maxWidth
                                    maxHeight: 1000
                                    minHeight: maxHeight
                                    multiline: true
                                    text:  ListItemData.getArea
                                    textFormat: TextFormat.Html
                                    //textStyle.textAlign: TextAlign.Center
                                    //text: qsTr("The Al Ameen Service Officially Launched in september 2003. Using this service, the people of Duabi can communicate confidentially with the authorities to keep abreast of development in Dubai and on issues that concern them. The media that can be used include toll free telephones, fax, sms on mobiles, e-mail via the Alameen, web site, blackberry, twiiter, iphone, NFC and QR") + Retranslate.onLanguageChanged
                                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                    visible: true
                                }
                                
                               
                            } // main container
                            WebView {
                                id: mWebViewaboutusArabic
                                html: ListItemData.getArea
                                visible: false
                                maxWidth: 700
                                minWidth: maxWidth
                                maxHeight: 1000
                                minHeight: maxHeight
                                settings.background: Color.Transparent
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Fill                               
                                settings.defaultFontSize: 31
                                onLoadingChanged: {
                                }
                            
                            }
                            
                            onCreationCompleted: {
                               
                                if(Qt.mLanguageCodeqt != "en")
                                {
                                    englishcontentscroll.visible = false;
                                    mWebViewaboutusArabic.visible = true;  
                                }
                                else {
                                    englishcontentscroll.visible = true;
                                    mWebViewaboutusArabic.visible = false;
                                }
                            }
                            

                        }
                    }

                } // ListItemComponent
            ]
            onTriggered: {

                var chosenItem = dataModel.data(indexPath);
                console.debug('index path' + chosenItem);
                console.debug('listview selection about us value' + chosenItem.getStationID);
                //chosenItem.borderLinetab1.preferredHeight = 20;

            }
            onScrollRoleChanged: {
                console.debug('listview scroll event');
            }
           
        } // list holding container
        

        LoadingDialog {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            active: weatherService.active
        }
    } // main contaione
    
    attachedObjects: [
        WeatherService {
            id: weatherService
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

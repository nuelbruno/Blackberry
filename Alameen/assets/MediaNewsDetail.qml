import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0
import bb.system 1.0
import "common"

Page {
    id: webUsefullink
    property string subCatValue
    property string preUniqName
    property string nextUniqName
    property string medianewscount
    property string mLanguageCode
    property string mLanguageBool
    
    
    
    titleBar: TitleBar {
        id: addBar
        title: qsTr("News Detail") + Retranslate.onLanguageChanged

    }
    function passNewsUniqName(data) {
        console.debug("companyNumber :", data.getArea)
        preUniqName = data.getZoneNo;
        nextUniqName = data.getDistance;
        console.debug("lastuniqnmae qml show......." + data.getID);
        Qt.lastUniqNameset = data.getID;
        //medianewscount = data.getID;
        
        mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
        mLanguageBool = (mLanguageCode == 'ar')? '2' : '1'; 
        
        if (_MOL.isNetworkAvailable()) {
       
          weatherService.requestNewlistDetail(data.getArea, mLanguageBool);       
          weatherService.dataLoaded.connect(afterDataLoad);
        }
        else {
            nointernetConnectalert.show();
        }
    } 
    function afterDataLoad() {
        
        titleLable.text = weatherService.getNewDetailTitle();
        var dateget = weatherService.getNewDetailDate();
        var date_funtion = new Date(parseInt(dateget.replace("/Date(", "").replace(")/", "")));  
        var news_date = date_funtion.getDate()+1;
        var news_month = date_funtion.getMonth() + 1;
        var news_year = date_funtion.getFullYear();
        dateLabel.text  = "";
        newsDetailLabel.text = "";
        newsDetailLabel2.text ="";
        dateLabel.text = news_date + ' - ' + news_month + ' - ' + news_year;
        newsDetailLabel.text = weatherService.getNewDetailDescribtion();
        newsDetailLabel2.text = weatherService.getNewDetailConetent();
        //webViewImage.resetImage();
        //webViewImage.clearCache();
        console.debug("image path news deatils......"+weatherService.getNewDetailImagePath())
        //console.debug("iamge loaded resutl......."+weatherService.imageLoaded());
        if(weatherService.getNewDetailImagePath() != '')
        {
            webviewImagechange.html =  "<html><head><title>hi</title></head>" + 
            "<body>" +
            "<img src='http://alameen.ae"+weatherService.getNewDetailImagePath()+"' alt='web pic' height ='400px' width='100%'>" +
            "</body>" +
            "</html>";
          //webViewImage.url ="http://alameen.ae" + weatherService.getNewDetailImagePath();
          webViewImage_default.visible = false;
          webviewImagechange.visible = true;
         // webViewImage.maxHeight = 400;
         // webViewImage.minHeight = 400;  
          //webViewImage.visible = true;
        }
        else 
        {
            
            
            //webViewImage.url = "http://alameen.ae/_resources/ar-AE/_images/alameen_images/common/alameen-logo.png";
             
             webViewImage_default.visible = true;
             webviewImagechange.visible = false;
        }  
        console.debug("iamge path loaded......."+weatherService.getNewDetailImagePath());
        preUniqName = weatherService.getNewDetailpreUnqName();
        nextUniqName = weatherService.getNewDetailNextUnqName();
        console.debug("companypreUniqName :", nextUniqName);
        Qt.CurretCheckUniqName = nextUniqName;
    
    }
    
    Container {
        id:newsMaincontainer
        background: Color.create("#F2EEE4")
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        
 
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        ScrollView {
            scrollViewProperties.scrollMode: ScrollMode.Vertical
            id: mScrollViewTab
            minHeight: 940
           
            Container {
                id: newsSubContainer
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                bottomPadding: 100.0
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                leftPadding: 10.0
                rightPadding: 10.0
                topPadding: 5.0
              //  visible: (webViewImage.loading == 1.0)
                

                /*WebImageView {
                    id: webViewImage
                    //url: "http://upload.wikimedia.org/wikipedia/commons/d/de/Al-Ameen_College_of_Pharmacy_Block.jpg"
                    //default:"asset:///images/share.jpg"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                   // visible: (webViewImage.loading == 1.0)
                    visible: loading == 1
                    scalingMethod: ScalingMethod.AspectFill
                    maxHeight: 400
                    minHeight: 400
                }*/
                
                WebView {
                    id: webviewImagechange
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    maxHeight: 400
                    minHeight: 400
                    //html: 
                }
                
                ImageView {
                    id: webViewImage_default
                    imageSource: "asset:///images/default512.png"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    scalingMethod: ScalingMethod.AspectFill
                    // maxWidth: 420
                    //minWidth: 120
                    maxHeight: 400
                    //minHeight: 78
                    //visible: (ListItemData.getDescription != 1)
                }
                
                Label {
                    id: titleLable
                    text: subCatValue
                    horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Right : HorizontalAlignment.Left
                    multiline: true
                    textStyle.color: Color.create("#666666")
                    textStyle.base: SystemDefaults.TextStyles.SubtitleText

                }

                Label {
                    id: dateLabel
                    text: 'Date'
                    horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Right : HorizontalAlignment.Left
                    textStyle.color: Color.create("#666666")
                    textStyle.base: SystemDefaults.TextStyles.SmallText

                }

                Container {
                    id: borderLineDetails
                    preferredHeight: 5
                    //preferredWidth: 295
                    // topPadding: 75.0
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: Color.create("#03879e")
                }

                Label {
                    id: newsDetailLabel
                    horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Right : HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    textFormat: TextFormat.Html
                    //textStyle.textAlign: TextAlign.Center
                    //text: "The Al Ameen Service Officially Launched in september 2003. Using this service, the people of Duabi can communicate confidentially with the authorities to keep abreast of development in Dubai and on issues that concern them. The media that can be used include toll free telephones, fax, sms on mobiles, e-mail via the Alameen, web site, blackberry, twiiter, iphone, NFC and QR"
                    textStyle.base: SystemDefaults.TextStyles.SmallText
                    textStyle.color: Color.create("#666666")
                    visible: true
                }
                Label {
                    id: newsDetailLabel2
                    horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Right : HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    multiline: true
                    textFormat: TextFormat.Html
                    //textStyle.textAlign: TextAlign.Center
                    //text: "The Al Ameen Service Officially Launched in september 2003. Using this service, the people of Duabi can communicate confidentially with the authorities to keep abreast of development in Dubai and on issues that concern them. The media that can be used include toll free telephones, fax, sms on mobiles, e-mail via the Alameen, web site, blackberry, twiiter, iphone, NFC and QR"
                    textStyle.base: SystemDefaults.TextStyles.SmallText
                    textStyle.color: Color.create("#666666")
                    visible: true
                }

              
                onCreationCompleted: {
                    console.debug("companypreUniqName12 :", nextUniqName)
                }

            }// sub contaioner
        }// scroll view
        
        Container {
            id: stackLayoutContainer
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Bottom
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight               
            }
            
            leftPadding: 0.0
            leftMargin: 0.0
            ImageButton {
               //imageSource: "asset:///images/left.jpg"
                defaultImageSource: "asset:///images/left.jpg"
                pressedImageSource: "asset:///images/left.jpg"
                disabledImageSource: "asset:///images/left.jpg"
                horizontalAlignment: HorizontalAlignment.Left
                leftPadding: 0.0
                leftMargin: 0.0
                rightMargin: 0.0
                rightPadding: 0.0
                preferredHeight: 100
                layoutProperties: StackLayoutProperties {spaceQuota: 1 }
                
                onClicked: {
                    
                    console.debug("companypreUniqName :", preUniqName);
                    if(preUniqName != '')
                    {
                      //mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
                      //mLanguageBool = (mLanguageCode == 'ar')? '2' : '1'; 
                      //webViewImage.resetImage();
                      weatherService.requestNewlistDetail(preUniqName, mLanguageBool);
                    
                      weatherService.dataLoaded.connect(afterDataLoad);
                    }  
                   
                }
                
            }
            ImageButton {
                //imageSource: "asset:///images/right.jpg"
                defaultImageSource: "asset:///images/right.jpg"
                pressedImageSource: "asset:///images/right.jpg"
                disabledImageSource: "asset:///images/right.jpg"
                horizontalAlignment: HorizontalAlignment.Left
                leftPadding: 0.0
                leftMargin: 0.0
                rightMargin: 0.0
                rightPadding: 0.0
                preferredHeight: 100
                layoutProperties: StackLayoutProperties {spaceQuota: 1}
                onClicked: {
                    if(Qt.CurretCheckUniqName == Qt.lastUniqNameset)
                    {}
                    else 
                    {
                        console.debug("companynextUniqName :", nextUniqName);
                        if(nextUniqName != '')
                        {
                            //webViewImage.resetImage();
                             weatherService.requestNewlistDetail(nextUniqName, mLanguageBool);
                            
                             weatherService.dataLoaded.connect(afterDataLoad);
                        }  
                     }   
                
                }
                
            }
            ImageButton {
                //imageSource: "asset:///images/share.jpg"
                defaultImageSource: "asset:///images/share.jpg"
                pressedImageSource: "asset:///images/share.jpg"
                disabledImageSource: "asset:///images/share.jpg"
                horizontalAlignment: HorizontalAlignment.Left
                leftPadding: 0.0
                leftMargin: 0.0
                rightMargin: 0.0
                rightPadding: 0.0
                preferredHeight: 100
                layoutProperties: StackLayoutProperties {spaceQuota: 1}
                
                onClicked: {
                    //_socialInvocation.invoke("Twitter", "bb.action.SHARE", "", 'http://alameen.gov.ae/1/'+nextUniqName)
                   //_socialInvocation.invoke("Facebook", "bb.action.SHARE", "", 'http://alameen.gov.ae/1/'+nextUniqName)
                    mySheet.open();
                
                }
                
            }
        }
        
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
            },
            Sheet {
                id: mySheet
                
                content: Page {
                   
                    titleBar: TitleBar {
                        id: sharebar
                        title: qsTr("Share News") + Retranslate.onLanguageChanged
                        dismissAction: [
                            ActionItem {
                                title: qsTr("Close") + Retranslate.onLanguageChanged
                                ActionBar.placement: ActionBarPlacement.OnBar
                                onTriggered: {
                                    mySheet.close();
                                }
                            }
                        ]
                    
                    }
                    Container {
                        
                        background: Color.create("#F2EEE4")
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        leftPadding: 30.0
                        rightPadding: 10.0
                        topPadding: 10.0
                        
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        
                        /*onCreationCompleted: {
                            if(mLanguageCode != 'en')
                            {
                                facebookcontaionr.orientation = LayoutOrientation.LeftToRight;
                                twittercontainer.orientation = LayoutOrientation.LeftToRight;
                            }
                            else {
                                facebookcontaionr.orientation = LayoutOrientation.LeftToRight;
                                twittercontainer.orientation = LayoutOrientation.LeftToRight;
                            }
                        }*/
                        
                        Container {
                           // id:facebookcontaionr
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            topPadding: 30.0
                            layout: StackLayout {
                                  id: facebookcontaionr
                                  orientation: LayoutOrientation.LeftToRight
                            }
                        
                        ImageButton {
                            //imageSource: "asset:///images/share.jpg"
                            defaultImageSource: "asset:///images/fb.png"
                            pressedImageSource: "asset:///images/fb.png"
                            disabledImageSource: "asset:///images/fb.png"
                            //horizontalAlignment: HorizontalAlignment.Left
                            maxHeight: 65
                            minHeight: 65
                            maxWidth: 65
                            minWidth: 65
                            layoutProperties: StackLayoutProperties {spaceQuota: 1}
                            
                                                   
                          }
                          Label {
                              id: faceLabel
                              text: qsTr("Share using Facebook") + Retranslate.onLanguageChanged
                              textStyle.color: Color.create("#666666")
                              textStyle.base: SystemDefaults.TextStyles.SubtitleText 
                              layoutProperties: StackLayoutProperties {spaceQuota: 5}
                              //horizontalAlignment: HorizontalAlignment.Center
                              verticalAlignment: VerticalAlignment.Center                     
                          }
                          
                          onTouch: {
                              
                              if (event.isUp()) {
                                  _socialInvocation.invoke("Facebook", "bb.action.SHARE", "", 'http://alameen.gov.ae/1/'+nextUniqName)
                                  mySheet.open();
                              }
                          }
                        
                        } // sub contaioner 
                        Container {
                            //id: twittercontainer
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            layout: StackLayout {
                                id: twittercontainer
                                orientation: LayoutOrientation.LeftToRight
                            }
                            topPadding: 70.0
                            
                            ImageButton {
                                //imageSource: "asset:///images/share.jpg"
                                defaultImageSource: "asset:///images/tw.png"
                                pressedImageSource: "asset:///images/tw.png"
                                disabledImageSource: "asset:///images/tw.png"
                                horizontalAlignment: HorizontalAlignment.Left
                                maxHeight: 65
                                minHeight: 65
                                maxWidth: 65
                                minWidth: 65
                                layoutProperties: StackLayoutProperties {spaceQuota: 1}
                                                         
                            }
                            Label {
                                id: twitterLable
                                text: qsTr("Share using Twitter") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#666666")
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText   
                                layoutProperties: StackLayoutProperties {spaceQuota: 5}   
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center                   
                            }
                            onTouch: {
                                
                                if (event.isUp()) {
                                    _socialInvocation.invoke("Twitter", "bb.action.SHARE", "", 'http://alameen.gov.ae/1/'+nextUniqName)
                                    //_socialInvocation.invoke("Facebook", "bb.action.SHARE", "", 'http://alameen.gov.ae/1/'+nextUniqName)
                                    mySheet.open();
                                }
                            }
                        
                        } // sub contaioner 
                    }// sheet main container    
                    
                    
                }
            }    
        ]  
        LoadingDialog {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            active: weatherService.active
        } 
        
        

    }// main container
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
   

} // end

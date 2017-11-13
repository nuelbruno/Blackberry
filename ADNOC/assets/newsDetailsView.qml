import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import WebImageView 1.0

Page {
    property string stationCode
    property string mLanguageBool
    property string mLanguageCode
    
    function passNewsUniqName(data) {
        
        if(_ADNOC.isNetworkAvailable())
        {
            aADNOCwebservice.statisticsADNOC('', "News Detail-"+data.news_title, "Get");
        }
        
        console.debug("news details page titlet show:"+ data.news_title);
        //Qt.ImagePathStoreNews = data.getZoneNo;
        //webViewImage.url = "http://demoserver.tacme.net:3030/AdnocDistTacsoft/" + data.getZoneNo;
        newTitle.text = data.news_title;
        newsDescription.text = data.news_content;
        webviewImagechange.html =  "<html><head><title>hi</title></head>" + 
        "<body>" +
        "<img src='http://demoserver.tacme.net:3030/AdnocDistTacsoft/"+data.news_main_image+"' alt='web pic' height ='400px' width='100%'>" +
        "</body>" +
        "</html>";
        var newsDatev = data.news_date;
        var str = newsDatev.slice(0,10);
        var res = str.split("-");
        var month = res[1].toString();
        var monthNames = [ "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December" ];
        
        var MonthCount = parseInt(res[1]);
        newsDate.text =res[2] +"-" + monthNames[MonthCount] + "-" + res[0];
        
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        Qt.languageset = mLanguageCode;
    }
    
    
    Container {
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                id: mainContainer
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                minHeight: 120
                maxHeight: minHeight
                background: Color.create("#0088CE")
                //topMargin: 30.0
                topPadding: 32.0
                Label {
                    id: mLabelHome
                    text: qsTr("News") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    //textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.Large
                    textStyle.color: Color.create("#FFFFFF")
                }
            }
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                id: mScrollViewTab
                
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: mBackgroundImage.imagePaint
                    preferredWidth: 800
                    //bottomPadding: 0
                    preferredHeight: 1500
                    
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        rightPadding: 60.0
                        leftPadding: 23.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        
                        Container {
                            id: bannerContainer
                            topPadding: 10.0
                            topMargin: 10.0
                            // leftPadding: 20.0
                            // leftMargin: 20.0
                            //preferredWidth: 350
                            horizontalAlignment: HorizontalAlignment.Fill
                            //verticalAlignment: VerticalAlignment.Fill
                            preferredHeight: 350
                            
                            //background:Color.create("#333333")
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            
                            WebView {
                                id: webviewImagechange
                                verticalAlignment: VerticalAlignment.Center
                                horizontalAlignment: HorizontalAlignment.Center
                                maxHeight: 400
                                minHeight: 400
                                //html: 
                            }
                           
                        
                        }
                        
                        CommonLabel {
                            id: newTitle
                            horizontalAlignment: (Qt.languageset !="en")? HorizontalAlignment.Right :  HorizontalAlignment.Left
                            //text: "sunday to saturday"
                            multiline: true
                            textStyle.color: Color.create("#0083CA")                       
                        }
                        CommonLabel {
                            id: newsDate
                            horizontalAlignment: (Qt.languageset !="en")? HorizontalAlignment.Right :  HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")                      
                        }
                        Container {
                            id: borderLineDetails
                            preferredHeight: 3
                            //preferredWidth: 295
                            // topPadding: 75.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            background: Color.create("#666666")
                        }
                        CommonLabel {
                            id: newsDescription
                            horizontalAlignment: (Qt.languageset !="en")? HorizontalAlignment.Right :  HorizontalAlignment.Left
                            multiline: true
                           // text: "Refuel, change oil and tyres, shop at the Oasis and have a snack, and buy a wide range of Voyager lubricants and LPG cylinders. Check below for services available at this station."
                            textStyle.color: Color.create("#000000")          
                        }
                    
                    
                    } //  content holding container
                }
            }
        
        } // main top to bottom stack layout
    }
    actions: [
        
        ActionItem {
            id: listAct
            title: "List"
            accessibility.name: "list"
            imageSource: "asset:///images/common/icnShare@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                var mStringShareData;
                mStringShareData = mStringShareData + "\n" + newTitle.text; 
                mStringShareData = mStringShareData + "\n" + newsDate.text;
                mStringShareData = mStringShareData + "\n" + newsDescription.text;
                mDialogShareContent.mShareData = mStringShareData;
                mDialogShare.open();
            }
        }
    ]
    attachedObjects: [
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        Dialog {
            id: mDialogShare
            Share {
                id: mDialogShareContent
            }
        
        },
        ImagePaintDefinition {
            id: mBackgroundImage
            imageSource: "asset:///images/background/bgView.png"
        }
    ]
}

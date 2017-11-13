import bb.cascades 1.0
import WeatherService 1.0
import WebImageView 1.0

Page {
    id: webUsefullink
    property string subCatValue
    property string preUniqName
    property string nextUniqName
    
    property string mLanguageCode
    property string mLanguageBool
    
    onCreationCompleted: {
        mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
    }
    
    titleBar: TitleBar {
        id: addBar
        title: qsTr("Twitter Detail") + Retranslate.onLanguageChanged
    
    }
    function passNewsUniqName(data) {
        console.debug("companyNumber :", data.getArea)
        preUniqName = data.getZoneNo;
        nextUniqName = data.getDistance;
        
        titleLable.text = data.getTitle;
        dateLabel.text = data.getDistance;
        newsDetailLabel.text = data.getArea;
        webViewImage.url =data.getStationID;
        
       
    } 
    
    
    Container {
        
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
                
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                bottomPadding: 100.0
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
                leftPadding: 10.0
                rightPadding: 10.0
                topPadding: 5.0
                
                WebImageView {
                    id: webViewImage
                    //url: "http://upload.wikimedia.org/wikipedia/commons/d/de/Al-Ameen_College_of_Pharmacy_Block.jpg"
                    //default:"asset:///images/share.jpg"
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    // visible: (webViewImage.loading == 1.0)
                    maxHeight: 350
                    minHeight: 350
                    maxWidth: 350
                    minWidth: 350
                }
                Label {
                    id: titleLable
                    text: subCatValue
                    multiline: true
                    horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Right : HorizontalAlignment.Left
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
                    preferredWidth: 730
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
                    //textStyle.textAlign: TextAlign.Center
                    //text: "The Al Ameen Service Officially Launched in september 2003. Using this service, the people of Duabi can communicate confidentially with the authorities to keep abreast of development in Dubai and on issues that concern them. The media that can be used include toll free telephones, fax, sms on mobiles, e-mail via the Alameen, web site, blackberry, twiiter, iphone, NFC and QR"
                    textStyle.base: SystemDefaults.TextStyles.SmallText
                    textStyle.color: Color.create("#666666")
                    visible: true
                }
                
                //        Label {
                //            id: usefilLabel
                //            text: subCatValue
                //            textStyle.color: Color.create("#666666")
                //            textStyle.base: SystemDefaults.TextStyles.SmallText
                //
                //         }
                onCreationCompleted: {
                 }
            
            }// sub contaioner
        }// scroll view
        
       
        
        attachedObjects: [
            WeatherService {
                id: weatherService
            }   
        ]   
    
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

import bb.cascades 1.0
import WeatherService 1.0


Page {
    
    titleBar: TitleBar {
        title: "About Us"
    }
    Container {
        layout: StackLayout {}
        background:  Color.create("#F2EEE4")
        //minWidth: 900
        // Create a SegmentedControl with three options
        onCreationCompleted: {
            weatherService.requestWeatherInformation('1' , 'general', '15');
        }
        SegmentedControl {
            Option {
                id: option1
                text: "About Alameen"
                
                selected: true
            }
            Option {
                id: option2
                text: "Vision"
            }
            Option {
                id: option3
                text: "Mission"
            }
            Option {
                id: option4
                text: "Goals"
            }
            Option {
                id: option5
                text: "Service Advantages"
            }
            onSelectedOptionChanged: {
                // Use an if statement to change the text style of the 
                // Label based on the selection option
                if (selectedOption == option1) {
                   
                    aboutalameen.visible = true;
                } else if (selectedOption == option2) {
                    
                    aboutalameen.visible = false;
                } else if (selectedOption == option3) {
                    
                    aboutalameen.visible = false;
                }
                else if (selectedOption == option4) {
                    
                    aboutalameen.visible = false;
                }
                else if (selectedOption == option5) {
                    
                    aboutalameen.visible = false;
                }
            }
        }
        // Create a Label and set the label text and text style
       /* Label {
            id: aboutalameen
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            maxWidth:600
            minWidth: maxWidth
            maxHeight: 1000
            minHeight: maxHeight
            multiline: true
            //textStyle.textAlign: TextAlign.Center
            text: "The Al Ameen Service Officially Launched in september 2003. Using this service, the people of Duabi can communicate confidentially with the authorities to keep abreast of development in Dubai and on issues that concern them. The media that can be used include toll free telephones, fax, sms on mobiles, e-mail via the Alameen, web site, blackberry, twiiter, iphone, NFC and QR"
            textStyle.base: SystemDefaults.TextStyles.TitleText
            visible: true
        }*/
        Label {
            id: aboutalameen
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            maxWidth:600
            minWidth: maxWidth
            maxHeight: 1000
            minHeight: maxHeight
            multiline: true
            //textStyle.textAlign: TextAlign.CenterqsTr("Minister's Message") + Retranslate.onLanguageChanged
            text: weatherService.temperature + 'test' +weatherService.description + 'errortest'+weatherService.error
            textStyle.base: SystemDefaults.TextStyles.TitleText
            visible: true
        }
        
        
        
        attachedObjects: [
            WeatherService {
                id: weatherService
            }
        ]
    }
}
import bb.cascades 1.0
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
import bb.system 1.0
import WeatherService 1.0

import CustomTimer 1.0

import bb.cascades.pickers 1.0

import "common"

NavigationPane {
    id: navigationPane
    property variant myArray:[];
    property variant arr: new Array(3);
    property int audioRecord: 0;
    property int subitcount: 0;
    property int imageCount: 0;
    property string mLanguageCode
    
   
    
    function dataLodedCompleted() {
        console.debug("active status dataload complete-----" + weatherService.succeeded);  
        reportField.text = '';
        commentField.text = '';
        Qt.latitude = '';
        Qt.longitude = '';
        Qt.image1upload = '';
        Qt.image2upload = '';
        Qt.image3upload = '';
        Qt.image4upload = '';
        Qt.video1upload = '';
        Qt.video2upload = '';
        Qt.video3upload = '';
        Qt.video4upload = '';
        Qt.iamgecouny = 0;
        Qt.DeleteImageCount1 = 0;
        Qt.DeleteImageCount2 = 0;
        Qt.DeleteImageCount3 = 0;
        Qt.DeleteImageCount4 = 0;
        Qt.audioRecord = false;
        sliderID.value = 0;
        sliderID.visible = true;
        playSlider.visible = false;
        playSlider.value = 0;
        labeltext.text = 0;
        photo1Container.visible = false;
        photo2Container.visible = false;
        photo3Container.visible = false;
        photo4Container.visible = false;
        if(weatherService.succeeded == true)
        {
            reportDialog.show();
        }
        else if(weatherService.succeeded == false) 
        {
            reportDialogFail.show();  
        }
        submitLabel.touchPropagationMode =TouchPropagationMode.Full;
        //loaderShow.active = false;
        //dataLoadIndicator.stop();
        loadingToastalert.cancel();
        //loadingToastalert.close();
        mainContainerReport.visible = true;
    }
    
    onCreationCompleted: {
        Qt.iamgecouny = 0;
        Qt.DeleteImageCount1 = 0;
        Qt.DeleteImageCount2 = 0;
        Qt.DeleteImageCount3 = 0;
        Qt.DeleteImageCount4 = 0;
        Qt.image1upload = '';
        Qt.image2upload = '';
        Qt.image3upload = '';
        Qt.image4upload = '';
        Qt.video1upload  = '';
        Qt.video2upload = '';
        Qt.video3upload = '';
        Qt.video4upload = '';
        var temarry= [];
        mLanguageCode = _MOL.getValueFor("mLanguageCode", "en")
        if (mLanguageCode != "en") {
            setLanguageAlignment()
        
        }
    }
    
    attachedObjects: [
        SystemProgressDialog {
            id: loadingToastalert
            title: qsTr("Alert") + Retranslate.onLanguageChanged
            body: qsTr("Loading....") + Retranslate.onLanguageChanged
            progress: -1
            // cancelButton.label: undefined
            confirmButton.label: cancelButton.label
            //buttons: [ok]
        }       
    ]
    
   
    
    onPopTransitionEnded: page.destroy()
    Page {
        
        property alias labelText: deleLable1.text
        
        //property  property variant globalForJs: 10
        titleBar: TitleBar {
            title: qsTr("Report") + Retranslate.onLanguageChanged
        }
        
        

        Container {
            id: root
            background: Color.create("#F2EEE4")
            
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            property int currentCount: 0
            property int initCount : 0
            property int increCount: sliderID.value
            
            /*LoadingDialog {
                id: loaderShow
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                //active: false //weatherService.active
            }*/
            
            ActivityIndicator {
                id: dataLoadIndicator
                
                preferredWidth: 400
                preferredHeight: 400
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
            }

            Container {
                id: mainContainerReport
                background: Color.create("#F2EEE4")
                leftPadding: 10.0
                rightPadding: 10.0
                topPadding: 5.0
                visible: (weatherService.active != 1)
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                
               

                Label {
                    id: reportLabel
                    text: qsTr("Report Comments") + Retranslate.onLanguageChanged
                    textStyle.color: Color.create("#666666")
                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Top
                }
                TextArea {
                    id: reportField
                    preferredHeight: 170
                    hintText: qsTr('Write Comments..') + Retranslate.onLanguageChanged

                }
                Label {
                    id: commentLable
                    text: qsTr("Contact") + Retranslate.onLanguageChanged
                    textStyle.color: Color.create("#666666")
                    textStyle.base: SystemDefaults.TextStyles.SubtitleText
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Top
                }
                TextField {
                    id: commentField 
                    hintText: qsTr('Mobile No / Email address..') + Retranslate.onLanguageChanged
                    onTextChanging: {
                        // Update the text in the Label with
                        // the text entered in the text area
                        //myLabel.text = text 
                    }
                }
                // ############# Audio recording controle BOX ################### //
                Container {
                    background: Color.create("#FFFFFF")
                    preferredHeight: 100
                    leftPadding: 10.0
                    rightPadding: 10.0
                    topPadding: 5.0
                    preferredWidth: 740
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    ImageView {
                        id: audioimage
                        imageSource: "asset:///images/audio.png"
                        horizontalAlignment: HorizontalAlignment.Left
                        verticalAlignment: VerticalAlignment.Center
                        preferredWidth: 65
                        preferredHeight: 65
                        visible: (mLanguageCode == "en")? true : false
                    }
                    Container {
                        background: Color.create("#FFFFFF")
                        preferredHeight: 90
                        preferredWidth: 630                        
                        //topPadding: 10.0
                        leftPadding: 30.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        Label {
                            id: durationLabel
                            text: qsTr("Duration") + Retranslate.onLanguageChanged
                            textStyle.color: Color.create("#424242")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Top
                        }
                        Container {
                            background: Color.create("#FFFFFF")
                            //preferredHeight: 110
                            preferredHeight: 90
                            preferredWidth: 630
                            topPadding: 0.0
                            // rightPadding: 10.0
                            layout: StackLayout {
                                orientation:(mLanguageCode != "en")? LayoutOrientation.RightToLeft :   LayoutOrientation.LeftToRight                     
                            }
                            Label {
                                id: playaudioLable
                                text: qsTr("Play Audio") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#008046")
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Top

                                onTouch: {
                                    
                                    if (event.isUp() && Qt.audioRecord != false) { 
	                                    if (player.play() != MediaError.None) {
	                                        // Your error handling code here.
	                                    }
                                       // playTimer.stop();
                                        playSlider.visible = true; 
                                        playTimer.start();
                                        sliderID.visible = false;
                                        //root.currentCount = 0;
                                    }
                                }                             
                            }
                            Label {
                                id: horizaLine
                                text: "|"
                                textStyle.color: Color.create("#008046")
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Top

                                onTouch: {
                                }
                            }
                            Label {
                                id: removerecordingLabel
                                text: qsTr("Remove This Recording") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#008046")
                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Top

                                onTouch: {
                                    if (event.isUp()) { 
                                       Qt.audioRecord = false;
                                       player.reset();
                                       playTimer.stop();
                                       audiDelete.show();
                                       audioRecord = 0;
                                       durationLabel.text =qsTr("Duration") + Retranslate.onLanguageChanged;
                                       labeltext.text = '';
                                       playSlider.value = 0;
                                       sliderID.value = 0;
                                     }  
                                }
                            }
                        } // play audio container

                    } // container play audio and duration
                    ImageView {
                        id: audioimage2
                        imageSource: "asset:///images/audio.png"
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Center
                        preferredWidth: 65
                        preferredHeight: 65
                        visible: (mLanguageCode == "en")? false : true
                    }
                }
                // ############# Image and vidoe box after uploading ################### //
                Container {
                    //background: Color.create("#FFFFFF")
                    id: photoBox
                    preferredHeight: 240
                    leftPadding: 5.0
                    rightPadding: 10.0
                    topPadding: 15.0
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    //preferredWidth: 740
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                ScrollView {
                    id: photoscrollview
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    scrollViewProperties.initialScalingMethod: ScalingMethod.Fill
                    scrollViewProperties.scrollMode: ScrollMode.Horizontal
                    visible: true
                Container {
                    //background: Color.create("#FFFFFF")
                    id: photoBoxscroll
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    //preferredWidth: 740
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                     Container {
                        id: photo1Container
                        objectName: "photo1Container"
                        visible: false
                        topPadding: 10.0
                        leftPadding: 10.0
                        maxHeight: 200
                        minHeight: 200
                        maxWidth: 230
                        minWidth: 230
                        background:Color.create("#FFFFFF") 
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Top
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        ImageView {
                            id: photoImageview1
                            objectName: "photoImageview1"
                            //visible: false
                            //imageSource: "asset:///images/bottom_icons_bg.jpg"
                            preferredHeight: 170
                            preferredWidth: 210
                            
                        }
                        Container {
                           
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                id: photoDeleteImg1
                                //visible: false
                                imageSource: "asset:///images/delete.png"
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Center
                                
                            }
                            Label {
                                id: deleLable1
                                objectName: "deleLable1"
                                //visible: false
                                text: qsTr("Delete") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#FF0000")
                                textStyle.base: SystemDefaults.TextStyles.SmallText

                                onTouch: {

                                    if (event.isUp()) {
                                    	var tem =[];
                                        photo1Container.visible = false;
                                        Qt.iamgecouny = Qt.iamgecouny - 1;
                                        tem.push(1);      
                                        arr[0] = 1;
                                        Qt.DeleteImageCount1 = 1;
                                        console.debug(Qt.DeleteImageCount1+'imagecount decresee'+ JSON.stringify(arr));

                                    }
                                }

                            }
                            
                            
                        }
                        
                    }
                    Container {
                        id: photo2Container
                        objectName: "photo2Container"
                        visible: false
                        topPadding: 10.0
                        leftPadding: 10.0
                        leftMargin: 20.0
                        background:Color.create("#FFFFFF") 
                        maxHeight: 200
                        minHeight: 200
                        maxWidth: 230
                        minWidth: 230
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Top
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        ImageView {
                            id: photoImageview2
                            objectName: "photoImageview2"
                            //imageSource: "asset:///images/bottom_icons_bg.jpg"
                            preferredHeight: 170
                            preferredWidth: 210
                        
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/delete.png"
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Center
                            
                            }
                            Label {
                                id: submitLabel2
                                text: qsTr("Delete") + Retranslate.onLanguageChanged
                                textStyle.color: Color.create("#FF0000")
                                textStyle.base: SystemDefaults.TextStyles.SmallText
                                
                                
                                onTouch: {
                                    
                                    if (event.isUp()) {
                                        
                                        photo2Container.visible = false;
                                        Qt.iamgecouny = Qt.iamgecouny - 1;
                                       // Qt.DeleteImageCount = 2;
                                        //root.temarry.push(2);
                                        Qt.DeleteImageCount2 = 2;
                                        console.debug(Qt.DeleteImageCount2+'imagecount decresee'+ Qt.iamgecouny);
                                    
                                    }
                                }
                            
                            }
                        }
                    }
                    
                    Container {
                        id: photo3Container
                        objectName: "photo3Container"
                        visible: false
                        topPadding: 10.0
                        leftPadding: 10.0
                        leftMargin: 20.0
                        background:Color.create("#FFFFFF") 
                        maxHeight: 200
                        minHeight: 200
                        maxWidth: 230
                        minWidth: 230
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Top
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        ImageView {
                            id: photoImageview3
                            objectName: "photoImageview3"
                           // imageSource: "file:///accounts/1000/appdata/com.tacme.Alameen.testDev_cme_Alameenc35bb2ca/shared/camera//IMG_20140421_122952_1.jpg"
                            preferredHeight: 170
                            preferredWidth: 210
                        
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/delete.png"
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Center
                            
                            }
                            Label {
                                id: submitLabel3
                                objectName: "submitLabel3"
                                text: qsTr("Delete") + Retranslate.onLanguageChanged
                                //visible: true
                                textStyle.color: Color.create("#FF0000")
                                textStyle.base: SystemDefaults.TextStyles.SmallText
                                
                                
                                
                                onTouch: {
                                    
                                    if (event.isUp()) {
                                        
                                        photo3Container.visible = false;
                                        Qt.iamgecouny = Qt.iamgecouny - 1;
                                        Qt.DeleteImageCount3 = 3;
                                       // root.temarry.push(3);
                                       // Qt.DeleteImageCount = root.temarry;
                                        console.debug(Qt.DeleteImageCount3+'imagecount decresee'+ Qt.iamgecouny);
                                        //console.debug('imagecount decresee'+ Qt.iamgecouny);
                                    
                                    }
                                }
                            
                            }
                        }
                    }
                    Container {
                        id: photo4Container
                        objectName: "photo4Container"
                        visible: false
                        topPadding: 10.0
                        leftPadding: 10.0
                        leftMargin: 20.0
                        background:Color.create("#FFFFFF") 
                        maxHeight: 200
                        minHeight: 200
                        maxWidth: 230
                        minWidth: 230
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Top
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        ImageView {
                            id: photoImageview4
                            objectName: "photoImageview4"
                            // imageSource: "file:///accounts/1000/appdata/com.tacme.Alameen.testDev_cme_Alameenc35bb2ca/shared/camera//IMG_20140421_122952_1.jpg"
                            preferredHeight: 170
                            preferredWidth: 210
                        
                        }
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/delete.png"
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Center
                            
                            }
                            Label {
                                id: submitLabel4
                                objectName: "submitLabel4"
                                text: qsTr("Delete") + Retranslate.onLanguageChanged
                                //visible: true
                                textStyle.color: Color.create("#FF0000")
                                textStyle.base: SystemDefaults.TextStyles.SmallText
                                
                                
                                
                                onTouch: {
                                    
                                    if (event.isUp()) {
                                        
                                        photo4Container.visible = false;
                                        Qt.iamgecouny = Qt.iamgecouny - 1;
                                        Qt.DeleteImageCount4 = 4;
                                        // root.temarry.push(3);
                                        // Qt.DeleteImageCount = root.temarry;
                                        console.debug(Qt.DeleteImageCount4+'imagecount decresee'+ Qt.iamgecouny);
                                        //console.debug('imagecount decresee'+ Qt.iamgecouny);
                                    
                                    }
                                }
                            
                            }
                        }
                    }
                  }// scroll end
                 }
               }
                // ############# submit button ################### //
                Container {
                    leftPadding: 10.0
                    rightPadding: 10.0
                    preferredHeight: 60
                    preferredWidth: 740
                    layout: AbsoluteLayout {

                    }
                    ImageButton {
                        //imageSource: "asset:///images/share.jpg"
                        defaultImageSource: "asset:///images/submit_btn.png"
                        pressedImageSource: "asset:///images/submit_btn.png"
                        disabledImageSource: "asset:///images/submit_btn.png"
                    
                        preferredHeight: 60
                        preferredWidth: 740
                        onClicked: {

                        }
                    }
                    Container {
                        //property variant anArray: ["1","2","3"]
                        topPadding: 8.0
                        preferredWidth: 740
                        preferredHeight: 60
                        //leftPadding: 270.0
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        Label {
                            id: submitLabel                      
                            text: qsTr("Submit Report") + Retranslate.onLanguageChanged
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            
                            textStyle.color: Color.create("#FFFFFF")
                            textStyle.base: SystemDefaults.TextStyles.SubtitleText
                            touchPropagationMode: TouchPropagationMode.Full
                            //overlapTouchPolicy: OverlapTouchPolicy.Deny
                            onTouch: {
                                
                                if (event.isUp()) {
                                    
                                    
                                    if(commentField.text != ''  && reportField.text != '')
                                    {
                                        
                                            var m_or_e;
                                            var momEmail;
                                            var submitSet;
                                            if (!isNaN(parseFloat(commentField.text)) && isFinite(commentField.text)) {
                                                
                                                var phoneno = /^\d{10}$/;
                                                
                                               
                                                
                                                if (commentField.text.match(phoneno)) {
                                                    submitSet = 1;
                                                    m_or_e = 1;
                                                } else {
                                                    console.debug('mobile  error --------'+reportField.text);
                                                    submitSet = 2;
                                                    reportMobileAlert.show();
                                                }
                                            
                                            } else {
                                                
                                                var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                                                
                                               
                                                
                                                if (!filter.test(commentField.text)) {
                                                    submitSet = 2;
                                                    console.debug('email error --------');
                                                    reportEmailAlert.show();
                                                }
                                                else {
                                                    submitSet = 1;
                                                    m_or_e = 2;
                                                }
                                                //console.debug('email no no err --------');
                                            }
                                        
		                                    //console.debug(myArray); audioRecord = 1; commentField reportField
                                            if(submitSet == 1)
		                                    {
                                                
                                                //myQmlToast.show();
                                                loadingToastalert.show();
                                                //dataLoadIndicator.start();
                                                mainContainerReport.visible = false;
                                                //console.debug("dataLoadIndicator.started()----"+dataLoadIndicator.start());
                                                //if(dataLoadIndicator.started())
                                                //{
                                                    if (_MOL.isNetworkAvailable()) {
                                                       // loaderShow.active = true;
                                                          durationLabel.text =qsTr("Duration") + Retranslate.onLanguageChanged;
                                                          submitLabel.touchPropagationMode =TouchPropagationMode.None;
        			                                      //Qt.audioRecord = audioRecord;
        			                                      console.debug("Qt.latitude------------------------------- :"+Qt.image1upload+ ''+Qt.image2upload + '' +Qt.image3upload);
        			                                      console.debug(reportField.text+"Qt.latitude------------------------------- :"+Qt.latitude +'+'+Qt.longitude);
                                                          weatherService.submitReport(reportField.text, commentField.text,m_or_e, Qt.latitude, Qt.longitude,  Qt.audioRecord, Qt.image1upload, Qt.image2upload, Qt.image3upload,Qt.image4upload, Qt.video1upload, Qt.video2upload, Qt.video3upload, Qt.video4upload);
        			                                      //weatherService.doPOST('1');weatherService.active
        			                                      //console.debug("active status-----" + weatherService.succeeded);
        			                                      weatherService.activeChanged.connect(dataLodedCompleted);
        			                                }else {
                                                        nointernetConnectalert.show();
                                                        //dataLoadIndicator.stop();
                                                        mainContainerReport.visible = true;
        			                                }  
                                                 //}    
                                                
			                                }   
		                                    
                                    }
                                    else {
                                        console.debug('report filed value error --------');
                                        if(reportField.text == '')
                                        {
                                            reportEmptyComment.show();
                                            console.debug('report comment error --------');
                                        }
                                        else if(commentField.text == '')
                                        {
                                            reportEmptyMobEmail.show();
                                            console.debug('report email/mobile error --------');
                                        }
                                       
                                    }
                                }    
                            }
                    
                        }
                       
                        
                        
                    }
                    
                }
                
                
               
            } // sub main contoller close
            
            
            // ######### player scroller ########## //
            /*Container {
             * leftPadding: 0.0
             * rightPadding: 0.0
             * topPadding: 30.0
             * //preferredHeight: 30
             * preferredWidth: 770
             * 
             * ImageView {
             * imageSource: "asset:///images/player_bg.png"
             * preferredHeight:93
             * preferredWidth: 770
             * }
             * 
             * }*/
            // ############### map and media controller ############# //
            Container {
                leftPadding: 0.0
                rightPadding: 0.0
                topPadding: 0.0
                visible: (weatherService.active != 1)
                //preferredHeight: 60
                preferredWidth: 770
                layout: AbsoluteLayout {

                }
                layoutProperties: AbsoluteLayoutProperties {
                    positionX: 0
                    positionY: 0
                }
                ImageView {
                    imageSource: "asset:///images/player_bg.png"
                    preferredHeight: 93
                    preferredWidth: 770
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 0
                        positionY: 30
                    }
                }
               
                   
                    Container {
                        
                        //leftPadding: 20
                        //rightPadding: leftPadding
                        topPadding: 40.0
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        
                        
                        // A simple Slider with changing values from  
                        // 0 to 1 (one-digit precision)
                        Slider {
                            id: sliderID
                            fromValue: 0
                            toValue: 15
                           // value: 3
                            onImmediateValueChanged: {
                                // Update the Label with current 
                                // value (with one-digit precision)
                                labeltext.text =  immediateValue.toFixed(1);
                            }
                        }
                        Slider {
                            id: playSlider
                            visible: false
                            fromValue: 0
                            toValue: root.currentCount
                            // value: 3
                            onImmediateValueChanged: {
                                // Update the Label with current 
                                // value (with one-digit precision)
                                labeltext.text =  immediateValue.toFixed(1);
                            }
                        }
                        
                        
                        // A label that presents the current Slider 
                        // values (with one-digit precision)
                        Container {
                            topPadding: 10.0
                            rightPadding: 10.0
                            maxWidth: 50
                            minWidth: 50
                            horizontalAlignment: HorizontalAlignment.Left
	                        Label {
	                            id: labeltext
	                            text: "0"
	                            textStyle.base: SystemDefaults.TextStyles.SmallText
	                            
	                        }
	                       
	                        
	                     }
                       
                         
                         
                    }
                    
                   

                ImageView {
                    imageSource: "asset:///images/bottom_icons_bg.jpg"
                    preferredWidth: 770
                    preferredHeight: 100
                    layoutProperties: AbsoluteLayoutProperties {
                        positionX: 0
                        positionY: 123
                    }
                }
                Container {
                    topPadding: 20.0
                    preferredWidth: 770

                    layout: AbsoluteLayout {
                        //orientation: LayoutOrientation.LeftToRight
                    }
                    ImageButton {
                        defaultImageSource: "asset:///images/locationBig.png"
                        pressedImageSource: "asset:///images/locationBig.png"
                        disabledImageSource: "asset:///images/locationBig.png"
                        horizontalAlignment: HorizontalAlignment.Left
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 10
                            positionY: 143
                        }
                        maxHeight: 45
                        minHeight: 45
                        onClicked: {
                            var mapPage = reportMap.createObject();
                            navigationPane.push(mapPage)
                        }
                        //layoutProperties: StackLayoutProperties {spaceQuota: 5}
                    }
                    ImageButton {
                        property bool pressed
                        property double lastClickTime: 0 
                        defaultImageSource: "asset:///images/record.png"
                        pressedImageSource: "asset:///images/record.png"
                        disabledImageSource: "asset:///images/record.png"
                        horizontalAlignment: HorizontalAlignment.Left
                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 320
                            positionY: 93
                        }
                        maxHeight: 90
                        minHeight: 90
                        
                        onTouch: {
                            
                            if (event.isUp()) {
                                Qt.audioRecord = true;
                                console.debug("touch enter-2-------------------------------- :");
                                audioRecorder.reset();
                                player.reset();
                                lightTimer.stop();
                                durationLabel.text =qsTr("Duration") + Retranslate.onLanguageChanged+": "+ root.currentCount;
                            }
                            else if(event.isDown())
                            {
                                console.debug("event down-------------------------------- :"+event.isDown()); 
                                audioRecorder.record(); 
                                root.currentCount = 0;
                                
                                //audioRecord = 1;
                                lightTimer.start();
                                sliderID.fromValue = 0;
                                playSlider.visible = false; 
                                sliderID.visible = true;
                            }
                           
                            
                            //console.debug("touch enter--------------------------------- :");
                            //audioRecorder.record();
                                                  
                        }
                    
                        //layoutProperties: StackLayoutProperties {spaceQuota: 5}
                    }
                    ImageButton {

                        defaultImageSource: "asset:///images/camersBig.png"
                        pressedImageSource: "asset:///images/camersBig.png"
                        disabledImageSource: "asset:///images/camersBig.png"
                        horizontalAlignment: HorizontalAlignment.Right

                        layoutProperties: AbsoluteLayoutProperties {
                            positionX: 710
                            positionY: 143

                    }
                        maxHeight: 45
                        minHeight: 45
                        //layoutProperties: StackLayoutProperties {spaceQuota: 5}
                        onClicked: {
                            if(Qt.iamgecouny == 4)
                            {
                                maxlimitmedia.show();
                            }
                           else {
	                            if (! listDialog.created) {
                                listDialog.appendItem(qsTr("Upload photo using Gallery") + Retranslate.onLanguageChanged)
                                listDialog.appendItem(qsTr("Upload photo using Camera") + Retranslate.onLanguageChanged)
                                listDialog.appendItem(qsTr("Take video") + Retranslate.onLanguageChanged)
	                                listDialog.created = true
	                            }
	                            listDialog.show()
	                        }   
                        }
                    }
                }
                
                
            }
            
           
            attachedObjects: [
                ComponentDefinition {
                    id: reportMap
                    source: "Report_map.qml"
                },
                SystemDialog {
                    id: reportDialog
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Report posted successfully") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: reportDialogFail
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Media Upload Error") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: maxlimitmedia
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Maximum Limit reached") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: reportEmptyComment
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Please enter the report comment") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: reportEmptyMobEmail
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Please enter correct email or ten digit mobile number") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: reportEmailAlert
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Please enter correct email") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: audiDelete
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("File deleted") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: reportMobileAlert
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("Please enter correct  ten digit mobile number(eg,0512345678)") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                }, SystemDialog {
                    id: nointernetConnectalert
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("No internet connection available") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemDialog {
                    id: timerecordingcompleteAlert
                    title: qsTr("Alert") + Retranslate.onLanguageChanged
                    body: qsTr("15 seconds recording is completed") + Retranslate.onLanguageChanged
                    cancelButton.label: undefined
                    confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                    //buttons: [ok]
                    onFinished: {
                    
                    }
                },
                SystemToast {
                    id: myQmlToast
                    body: qsTr("Loading....") + Retranslate.onLanguageChanged
                    
                },
                WeatherService {
                    id: weatherService
                },
                ComponentDefinition {
                    id: reportCamera
                    
                    source: "Report_camera.qml"
                },
                ComponentDefinition {
                    id: reportVideo
                    source: "Report_Video.qml"
                },
                AudioRecorder {
                    id: audioRecorder
                    //outputUrl: _MOL.voice + "recording.m4a"
                    //outputUrl: "file:///accounts/1000/shared/voice/recording.m4a"
                    outputUrl: "file:///accounts/1000/appdata/com.tacme.Alameen.testDev_cme_Alameenc35bb2ca/shared/voice/recording.m4a"
                
                },
                MediaPlayer {
                    id: player
                    //sourceUrl: "file:///accounts/1000/shared/voice/recording.m4a"
                    sourceUrl: "file:///accounts/1000/appdata/com.tacme.Alameen.testDev_cme_Alameenc35bb2ca/shared/voice/recording.m4a"
                    //sourceUrl: _MOL.voice + "recording.m4a" 
                    // Set these properties for video
                    videoOutput: VideoOutput.PrimaryDisplay
                    windowId: fwcVideoSurface.windowId
                    
                    onMediaStateChanged: {
                        switch (player.mediaState) {
                            case MediaState.Unprepared:
                                break;
                            case MediaState.Prepared:
                                break;
                            // ...
                        }
                    }
                },
                FilePicker {
                    id: picker
                    type : FileType.Picture
                    property string selectedFile
                    
                    title: qsTr("Upload Options")
                                       
                    onFileSelected: {                      
                        selectedFile = selectedFiles[0]
                       // temarry                     
                        //imageArray=Qt.temAry;
                        //imageCount = imageCount++;
                        Qt.iamgecouny =  Qt.iamgecouny +1;
                        if(Qt.iamgecouny == 1)
                        {
                            Qt.image1upload = selectedFile;
                        }
                        else if(Qt.iamgecouny == 2)
                        {
                            Qt.image2upload = selectedFile;
                        }
                        else if(Qt.iamgecouny == 3)
                        {
                            Qt.image3upload = selectedFile;
                        }
                        else if(Qt.iamgecouny == 4)
                        {
                            Qt.image4upload = selectedFile;
                        }
                        
                        if(Qt.DeleteImageCount1 != 0)
                        {
                            var delimage1 = 1;
                            Qt.DeleteImageCount1 = 0;
                        }
                        else if(Qt.DeleteImageCount2 != 0)
                        {
                            var delimage2 = 2;
                            Qt.DeleteImageCount2 = 0;
                        }
                        else if(Qt.DeleteImageCount3 != 0)
                        {
                            var delimage3 = 3;
                            Qt.DeleteImageCount3 = 0;
                        }
                        else if(Qt.DeleteImageCount4 != 0)
                        {
                            var delimage4 = 4;
                            Qt.DeleteImageCount4 = 0;
                        }
                        
                       
                        console.debug("file selected file u"+ Qt.iamgecouny);
                        console.debug("file selected file upload-------------------------------- :"+selectedFile);
                        _MOL.manipulatePhoto(selectedFile, Qt.iamgecouny, delimage1, delimage2, delimage3, delimage4, 1);
                     }
                },
                SystemListDialog {
                    property bool created: false
                    id: listDialog
                    title: qsTr("Upload Options") + Retranslate.onLanguageChanged
                    selectionMode: ListSelectionMode.Single
                    confirmButton.label: qsTr("Ok") + Retranslate.onLanguageChanged
                    cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
                    onFinished: {
                        if (listDialog.result == SystemUiResult.ConfirmButtonSelection) {
                            console.log("Selected Value" + listDialog.selectedIndices);
                            if(listDialog.selectedIndices == 1)
                            {
                                var cameraPhoto = reportCamera.createObject();
                                navigationPane.push(cameraPhoto);
                                //cameraPhoto.inputData(imageCOUNT);
                            }
                            if(listDialog.selectedIndices == 0)
                            {
                                picker.open();
                            }
                            if(listDialog.selectedIndices == 2)
                            {
                                var cameraVideo= reportVideo.createObject();
                                navigationPane.push(cameraVideo)
                            }
                        } else if (listDialog.result == SystemUiResult.CancelButtonSelection) {
                            console.log("Selected Value" + listDialog.result);
                            listDialog.cancel();
                            listDialog.clearButtons();
                        }
                    }
                }, TimerCount {
                    id: lightTimer
                    
                    // Specify a timeout interval of 1 second
                    interval: 1000
                    onTimeout: {
                        console.debug("counter timer-+++++++++++++++++++++++++++++++++++++:");
                        // Decrement the counter and update the countdown text
                        root.currentCount += 1;
                        
                        sliderID.value = root.currentCount;
                       
                        labeltext.text = "" + root.currentCount;
                        
                        
                       
                        
                        // When the counter reaches 0, change the traffic light
                        // state, stop the countdown timer, and start the pause
                        // timer
                        if (root.currentCount == 15 || root.currentCount >= 15) {
                            
                            lightTimer.stop();
                            durationLabel.text =qsTr("Duration") + Retranslate.onLanguageChanged+" "+ root.currentCount;
                            timerecordingcompleteAlert.show();
                        
                        }
                    } // end of onTimeout signal handler
                },
                TimerCount {
                    id: playTimer
                    
                    // Specify a timeout interval of 1 second
                    interval: 1000
                    onTimeout: {
                        console.debug("counter timer-+++++++++++++++++++++++++++++++++++++:");
                        // Decrement the counter and update the countdown text
                       
                        root.initCount += 1;
                        
                        playSlider.value = root.initCount;
                       // playSlider.toValue = root.currentCount;
                        
                        labeltext.text = "" + root.initCount;
                        
                        // When the counter reaches 0, change the traffic light
                        // state, stop the countdown timer, and start the pause
                        // timer
                        if (root.initCount == root.currentCount || root.initCount >= 15) {
                            
                            playTimer.stop();
                            root.initCount = 0;
                            
                        
                        }
                    } // end of onTimeout signal handler
                } // end of Timer  
                 
            ]
            
           
            
        } // Mian conroller top most
    }
    function setLanguageAlignment() {
        
        reportLabel.horizontalAlignment = HorizontalAlignment.Right
        reportField.horizontalAlignment = HorizontalAlignment.Right
        commentLable.horizontalAlignment = HorizontalAlignment.Right
        commentField.horizontalAlignment = HorizontalAlignment.Right
        durationLabel.horizontalAlignment = HorizontalAlignment.Right
        playaudioLable.horizontalAlignment = HorizontalAlignment.Right   
        horizaLine.horizontalAlignment = HorizontalAlignment.Right
        removerecordingLabel.horizontalAlignment = HorizontalAlignment.Right
    }
}
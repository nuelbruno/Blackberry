import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.DatabaseConnectionApi.data 1.0
import WebImageView 1.0

Page {
    property string stationCode
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intLOAD: -1
    property int addtofavourite: -1 //intDELETE
    property int intDELETE: -1
    property int favouriteData: -1
    
    signal successQuery()
    
    function passMyfavouriteData(data)
    {
        console.log("data from favourite" + JSON.stringify(data))
        stationTiltle.text =  data.station_code+"-"+data.title;
        titleText.text = data.title;
        stationcode.text = data.station_code;
        stationDistance.text = parseFloat(data.distance).toFixed(2)+ qsTr(" Km Away") + Retranslate.onLanguageChanged;
        
        addtofavourite ==1;
        favouriteData = 1;
        Qt.favoutData = data;
        if(data.category_description != "")
        {
            descriptionLabel.text = data.category_description;
        }
        
        latitudelab.text = data.latitude;
        longitudeLab.text = data.longitude;
        uniqueName.text = data.unique_name;
        phoneNumb.text = data.phone;
        keywords.text = data.keyword;  //CategoriesUniqueNameList
        catUniqName.text = data.category_unique_name;
        //theDataModel.insertList(stationCode["facilityList"]);
        //information
        //var facilityMain =  data.information;
        var faclityList = data.information;
        var faclityMain = faclityList.split(',');
        console.log(faclityMain.length+"facility list favourite"+faclityMain[1]+" pass" + JSON.stringify(faclityMain));
        for (var j = 0; j < faclityMain.length; j++) {
            if(faclityMain[j].length > 1)
            {
                var mButton = mcontainerFacilityList.createObject();
                mButton.textString = "•  " +faclityMain[j];
                faclilityListContainer.add(mButton);
            }
        
        }
        
        webviewImagechange.html =  "<html><head><title>hi</title></head>" + 
        "<body>" +
        "<img src='"+data.image_url+"' alt='web pic' height ='400px' width='100%'>" +
        "</body>" +
        "</html>";
        
        imageURl.text = data.category_main_image;
        catMainImage.text = data.category_main_image;
        
        var newsDatev = data.close_time;
        
        var closeAMPM = "AM";
        if(newsDatev > 12)
        {
            newsDatev = newsDatev -12; 
            closeAMPM  = "PM";
        }
        
        var newsDateop = data.open_time;
       
        var openAMPM = "AM";
        if(newsDateop > 12)
        {
            newsDateop = newsDateop -12; 
            openAMPM  = "PM";
        }
        
        
        
        var fromdate = data.from_day;
        var todate = data.to_day;
        
        durationLabel.text =  fromdate +" to "+todate;
        durationTimelabel.text = newsDateop +" " +openAMPM + " - " + newsDatev +" " + closeAMPM;
        if(_ADNOC.isNetworkAvailable())
        {         
            aADNOCwebservice.statisticsADNOC('', "Site Detail-"+data.station_code+"-"+data.title, "Get");
        }
        
    }
    
    function passStationDataList(data){
        
        console.debug("pass data listview station Title:" + JSON.stringify(data));
        stationTiltle.text =  data.getCreatedBy+"-"+data.getCreatedDate;
        titleText.text = data.getCreatedDate;
        stationcode.text = data.getCreatedBy;
        stationDistance.text = parseFloat(data.getPublished).toFixed(2)+ qsTr(" Km Away") + Retranslate.onLanguageChanged;
        
        currentTask = intSELECT;
        mCustomeDataSource.query = "SELECT * FROM tbl_favourite WHERE station_code ='"+data.getCreatedBy+"'"
        mCustomeDataSource.load();
        
        favouriteData = 2;
        Qt.stationData = data.getCreatedBy;
        
        if(data.getDescription != "")
        {
            descriptionLabel.text = data.getDescription;
        }
        
        serviceID.text = data.getArea;
        latitudelab.text = data.getTitle;
        longitudeLab.text = data.getStationID;
        uniqueName.text = data.getZoneNo;
        phoneNumb.text = data.getID;
        keywords.text = data.getUniqueName;  //CategoriesUniqueNameList
        catUniqName.text = data.getDistance;
        //theDataModel.insertList(stationCode["facilityList"]);
        console.log("list of facility array "+ JSON.stringify(data.getVal2));
        var faclityList = data.getVal2;
        var faclityMain = faclityList.split(',');
        
        console.log("list of facility array "+ JSON.stringify(faclityMain));
        for (var j = 0; j < faclityMain.length; j++) {
            if(faclityMain[j].length > 1)
            {
                var mButton = mcontainerFacilityList.createObject();
                mButton.textString = "•  " +faclityMain[j];
                faclilityListContainer.add(mButton);
            }
        
        }
        Qt.facliltiArrylst= faclityMain;
        
        webviewImagechange.html =  "<html><head><title>hi</title></head>" + 
        "<body>" +
        "<img src='"+data.getGeoCoordinateY+"' alt='web pic' height ='400px' width='100%'>" +
        "</body>" +
        "</html>";
        
        imageURl.text = data.getGeoCoordinateY;
        catMainImage.text = data.getGeoCoordinateX;
        
        var newsDatev = data.getWorkingTime;
        var closeTime = newsDatev.slice(11,13);
        var closeTimeAM = parseInt(closeTime);
        var closeAMPM = "AM";
        if(closeTimeAM > 12)
        {
            closeTimeAM = closeTimeAM -12; 
            closeAMPM  = "PM";
        }
        
        var newsDateop = data.getService;
        var OpenTime = newsDateop.slice(11,13);
        var OpenTimeAM = parseInt(OpenTime);
        var openAMPM = "AM";
        if(OpenTimeAM > 12)
        {
            OpenTimeAM = OpenTimeAM -12; 
            openAMPM  = "PM";
        }
        
        
        
        var fromdate = data.getContactNo;
        var todate = data.getVal1;
        
        durationLabel.text =  fromdate +" to "+todate;
        durationTimelabel.text = OpenTimeAM +" " +openAMPM + " - " + closeTimeAM +" " + closeAMPM;
        openTime.text = OpenTimeAM;
        closeTimelbl.text = closeTimeAM;
        fromDate.text = fromdate;
        todatelbl.text = todate;
    }
    function passNewsUniqName(stationCode) {
        
        console.debug(stationCode["CategoryDescription"]+"stationCode Title:" );
        stationTiltle.text =  stationCode["StationCode"] +"-"+stationCode["Title"];
        titleText.text = stationCode["Title"];
        stationcode.text = stationCode["StationCode"];
        stationDistance.text = parseFloat(stationCode["Distance"]).toFixed(2)+ qsTr("Km Away") + Retranslate.onLanguageChanged;
        
        currentTask = intSELECT;
        mCustomeDataSource.query = "SELECT * FROM tbl_favourite WHERE station_code ='"+stationCode["StationCode"]+"'"
        mCustomeDataSource.load();
        
        favouriteData = 0;
        Qt.stationData = stationCode;
        
        if(stationCode["CategoryDescription"] != "")
        {
          descriptionLabel.text = stationCode["CategoryDescription"];
        }
        serviceID.text = stationCode["ID"];
        latitudelab.text = stationCode["GeoCoordinateX"];
        longitudeLab.text = stationCode["GeoCoordinateY"];
        uniqueName.text = stationCode["UniqueName"];
        phoneNumb.text = stationCode["Phone"];
        keywords.text = stationCode["Keywords"];  //CategoriesUniqueNameList
        catUniqName.text = stationCode["CategoriesUniqueNameList"];
        //theDataModel.insertList(stationCode["facilityList"]);
        console.log("list of facility array "+JSON.stringify(stationCode["facilityList"]));
        var faclityMain = [];
        faclityMain = stationCode["facilityList"];
        for (var j = 0; j < stationCode["facilityList"].length; j++) {
            if(faclityMain[j] != "")
            {
                var mButton = mcontainerFacilityList.createObject();
                mButton.textString = "•  " +faclityMain[j];
                faclilityListContainer.add(mButton);
            }
        
        }
        Qt.facliltiArrylst = faclityMain;
        //Qt.FaclityArray = stationCode["facilityList"];
        
        webviewImagechange.html =  "<html><head><title>hi</title></head>" + 
        "<body>" +
        "<img src='"+stationCode["CategoryMainImageFullURL"]+"' alt='web pic' height ='400px' width='100%'>" +
        "</body>" +
        "</html>";
        
        imageURl.text = stationCode["CategoryMainImageFullURL"];
        catMainImage.text = stationCode["CategoryMainImage"];

        var newsDatev = stationCode["CloseTime"];
        var closeTime = newsDatev.slice(11,13);
        var closeTimeAM = parseInt(closeTime);
        var closeAMPM = "AM";
        if(closeTimeAM > 12)
        {
            closeTimeAM = closeTimeAM -12; 
            closeAMPM  = "PM";
        }
        
        var newsDateop = stationCode["OpenTime"];
        var OpenTime = newsDateop.slice(11,13);
        var OpenTimeAM = parseInt(OpenTime);
        var openAMPM = "AM";
        if(OpenTimeAM > 12)
        {
            OpenTimeAM = OpenTimeAM -12; 
            openAMPM  = "PM";
        }
        
        
        
        var fromdate = stationCode["FromDay"];
        var todate = stationCode["ToDay"];
        
        durationLabel.text =  fromdate +" to "+todate;
        durationTimelabel.text = OpenTimeAM +" " +openAMPM + " - " + closeTimeAM +" " + closeAMPM;
        openTime.text = OpenTimeAM;
        closeTimelbl.text = closeTimeAM;
        fromDate.text = fromdate;
        todatelbl.text = todate;
    }
    
    onCreationCompleted: {
        
       
        
    }

   
    Container {
        
       
        
        Label {
            id: titleText
            visible: false
        }
        
        Label {
            id: openTime
            visible: false
        }
        
        Label {
            id: closeTimelbl
            visible: false
        }
        Label {
            id: fromDate
            visible: false
        }
        Label {
            id: todatelbl
            visible: false
        }
        
        Label {
            id: serviceID
            visible: false
        }
        Label {
            id: latitudelab
            visible: false
        }
        Label {
            id: stationcode
            visible: false
        }
        Label {
            id: longitudeLab
            visible: false
        }
        Label {
            id: uniqueName
            visible: false
        }
        Label {
            id: phoneNumb
            visible: false
        }
        Label {
            id: keywords
            visible: false
        }
        Label {
            id: imageURl
            visible: false
        }
        Label {
            id: catUniqName
            visible: false
        }
        Label {
            id: catMainImage
            visible: false
        }
        
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
                    text: qsTr("Service Station") + Retranslate.onLanguageChanged
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
                        CommonLabel {
                            id: stationTiltle
                            horizontalAlignment: HorizontalAlignment.Left
                            text: "869 -al madina"
                            textStyle.color: Color.create("#0083CA")                     
                        }
                        CommonLabel {
                            id: stationDistance
                            horizontalAlignment: HorizontalAlignment.Left
                            text: "19.98Km away"
                            textStyle.color: Color.create("#000000")                    
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
                            Container {
                                
                                //preferredWidth: 570
                                horizontalAlignment: HorizontalAlignment.Fill
                                //verticalAlignment: VerticalAlignment.Fill
                                WebView {
                                    id: webviewImagechange
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Center
                                    maxHeight: 350
                                    minHeight: 350
                                    //html: 
                                }
                                
                            }
                        
                        }
                        
                        CommonLabel {
                            id: durationLabel
                            horizontalAlignment: HorizontalAlignment.Left
                            text: "sunday to saturday"
                            textStyle.color: Color.create("#0083CA")                       
                        }
                        CommonLabel {
                            id: durationTimelabel
                            horizontalAlignment: HorizontalAlignment.Left
                            text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")                      
                        }
                        CommonLabel {
                            id: descriptionLabel
                            horizontalAlignment: HorizontalAlignment.Left
                            multiline: true
                            text: "Refuel, change oil and tyres, shop at the Oasis and have a snack, and buy a wide range of Voyager lubricants and LPG cylinders. Check below for services available at this station."
                            textStyle.color: Color.create("#000000")          
                        }
                        Container {
                            id: faclilityListContainer
                            horizontalAlignment: HorizontalAlignment.Fill
                            preferredHeight: 350
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                        }
                         
                        
                        
                    } //  content holding container
                }
            }

        } // main top to bottom stack layout
    }
    actions: [
        
        ActionItem {
            id: editItem
            title: "Feedback"
            accessibility.name: "Feedback"
            imageSource: "asset:///images/common/icnFeedback@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                //mFeedback
                if(_ADNOC.isNetworkAvailable())
                {         
                    aADNOCwebservice.statisticsADNOC('', "Site Feedback-"+stationcode.text+"-"+titleText.text, "Get");
                }
                var  mFeedbackPage = mFeedback.createObject();
                mFeedbackPage.stationFeedpass(stationcode.text, titleText.text, "station");
                mNavigationPaneMain.push(mFeedbackPage)
              
            }
        },
        ActionItem {
            id: mapPin
            title: "Map"
            accessibility.name: "mapPin"
            imageSource: "asset:///images/common/imgMapWhite@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if(_ADNOC.isNetworkAvailable())
                {         
                    aADNOCwebservice.statisticsADNOC('', "Site Direction-"+stationcode.text+"-"+titleText.text, "Get");
                }
                var  mapLocationPage = mapLocation.createObject();
                if(favouriteData ==1) {   
                    mapLocationPage.passMappinData(Qt.favoutData, favouriteData);
                 }
                 else if(favouriteData ==2){
                    mapLocationPage.passMappinData(Qt.stationData, favouriteData);  
                 }
                else{
                    mapLocationPage.passMappinData(Qt.stationData, favouriteData);   
                }
                mNavigationPaneMain.push(mapLocationPage)
                
            }
            attachedObjects: [
                ComponentDefinition {
                    id: mapLocation
                    source: "mapLocation.qml"
                }
            ]
        },
        ActionItem {
            id: share
            title: "Share"
            accessibility.name: "share"
            imageSource: "asset:///images/common/icnShare@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if(_ADNOC.isNetworkAvailable())
                {         
                    aADNOCwebservice.statisticsADNOC('', "Site Share-"+stationcode.text+"-"+titleText.text, "Get");
                }
                var mStringShareData;
                mStringShareData = mStringShareData + "\n" + stationTiltle.text; 
                mStringShareData = mStringShareData + "\n" + stationDistance.text;
                mStringShareData = mStringShareData + "\n" + durationLabel.text;
                mStringShareData = mStringShareData + "\n" + durationTimelabel.text;
                mStringShareData = mStringShareData + "\n" + descriptionLabel.text;
                mDialogShareContent.mShareData = mStringShareData;
                mDialogShare.open();
            }
        },
        ActionItem {
            id: favourite
            title: "Favourite"
            accessibility.name: "favourite"
            imageSource: "asset:///images/common/icnFavourite@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                if(_ADNOC.isNetworkAvailable())
                {         
                    aADNOCwebservice.statisticsADNOC('', "Site Favourites-"+stationcode.text+"-"+titleText.text, "Get");
                }
                if(addtofavourite ==2)
                {
                currentTask = intUPDATE;
                mCustomeDataSource.query = "INSERT INTO tbl_favourite (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+serviceID.text+"','"+titleText.text+"','"+Qt.facliltiArrylst+"','"+phoneNumb.text+"','"+uniqueName.text+"','"+keywords.text+"','"+latitudelab.text+"','"+longitudeLab.text+"','"+imageURl.text+"','"+stationDistance.text+"','"+openTime.text+"','"+closeTimelbl.text+"','"+fromDate.text+"','"+ todatelbl.text+"','"+catUniqName.text+"','"+catMainImage.text+"','"+descriptionLabel.text+"','','"+stationcode.text+"');"
                mCustomeDataSource.load(); 
                console.log("opne date" + closeTimelbl.text);    
                }else {
                    mSystemDialogDelete.show(); 
                }      
            }
        }
        
    ]
    
    function deleteFavouritelist()
    {
        currentTask = intDELETE;
        mCustomeDataSource.query = "DELETE FROM tbl_favourite WHERE station_code IN (" + stationcode.text + ")"
        mCustomeDataSource.load(); 
    }
    
    attachedObjects: [
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        },
        ImagePaintDefinition {
            id: mBackgroundImage
            imageSource: "asset:///images/background/bgView.png"
        },
        ComponentDefinition {
            id: mFeedback
            source: "feedback.qml"
        },
        
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/ADNOC.sqlite"
            connection: "mCustomeDataSourceInsert"
            onDataLoaded: {
                if(currentTask == intUPDATE)
                 { 
                    currentTask = intLOAD;
                    customAlert.body = qsTr("successfully added to favourite") + Retranslate.onLanguageChanged;
                    customAlert.show(); 
                    successQuery();
                }
                else if(currentTask == intSELECT)
                {
                    currentTask = intLOAD;
                    //var dataSting = JSON.parse(data);
                    console.log("Test data load" + JSON.stringify(data.service_id) +""+JSON.stringify(data));
                    if(data == "")
                    {   console.log("empty");
                        addtofavourite = 2;
                    }else{
                        console.log("not empty");
                        addtofavourite = 1; 
                    }
                }
                else if(currentTask == intDELETE)
                {
                    currentTask = intLOAD;
                    customAlert.body = qsTr("successfully removed from favourite") + Retranslate.onLanguageChanged;
                    customAlert.show(); 
                }
                
            }
        },
        SystemDialog {
            id: customAlert
            title: qsTr("Alert") + Retranslate.onLanguageChanged
            //body: qsTr("Request saved successfully.") + Retranslate.onLanguageChanged
            cancelButton.label: undefined
            confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
            //buttons: [ok]
            onFinished: {
            
            }
        },
        SystemDialog {
            id: mSystemDialogDelete
            title: undefined
            body: qsTr("Are you sure to Delete this Favourite?") + Retranslate.onLanguageChanged
            cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
            confirmButton.label: qsTr("Ok") + Retranslate.onLanguageChanged
            onFinished: {
                if (mSystemDialogDelete.result == SystemUiResult.ConfirmButtonSelection) {
                    //mTextFieldSearch.text = "";
                    deleteFavouritelist();
                }
            }
        },
        ComponentDefinition {
            id: mcontainerFacilityList
            
            Container {
                property string textString
                property int count
                id: container1
                //leftPadding: 20
                preferredHeight: 80
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                CommonLabel {
                    id: label1
                    horizontalAlignment: HorizontalAlignment.Left
                    text: textString
                    textStyle.color: Color.create("#0083CA")                      
                }
                        
            }
        },
        Dialog {
            id: mDialogShare
            Share {
                id: mDialogShareContent
            }
        
        }
    ]
}

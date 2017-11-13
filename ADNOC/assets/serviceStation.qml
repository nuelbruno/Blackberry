import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import QtMobility.sensors 1.2
import bb.DatabaseConnectionApi.data 1.0


Page {
    property string mLanguageBool
    property string mLanguageCode
    property string mStationUniqueName
    property string mTitleStation
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property int intLOAD: -1
   
    function passStationData(uniqname, title)
    {
        
        mTitleStation = title;
        Qt.uniqueName = uniqname;
        var longitude = _ADNOC.getValueFor("longitude", "")
        var latitude = _ADNOC.getValueFor("latitude", "")
        Qt.CurrentLatitude =  "25.111917";
        Qt.CurrentLongitude =  "55.385406";
        pinContainer.addPin(Qt.CurrentLatitude, Qt.CurrentLongitude, "", "", "");  
        console.log("categoryniqname" +  mStationUniqueName);
        
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        Qt.languageset = mLanguageCode;
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        if(uniqname != "")
        {
           mCustomeDataSource.query = "SELECT * FROM tbl_services WHERE category_unique_name = '" + uniqname + "' AND language_id = '"+mLanguageBool+"' "
           mCustomeDataSource.load();
        } else {
            mCustomeDataSource.query = "SELECT * FROM tbl_services WHERE  language_id = '"+mLanguageBool+"' "
            mCustomeDataSource.load();  
        }
        
        Qt.serviceCategory = uniqname;
        
        if(_ADNOC.isNetworkAvailable())
        {
            
            if(Qt.serviceCategory == "servicestation,"){
                aADNOCwebservice.statisticsADNOC('', "Service Station Home", "Get");
            }
            else if(Qt.serviceCategory == "vehicleinspection,"){
                aADNOCwebservice.statisticsADNOC('', "Vehicle Inspection Home", "Get");
            }
            else if(Qt.serviceCategory == "autoserv,"){
                aADNOCwebservice.statisticsADNOC('', "AUTOSERVE Home", "Get");
            }
            else if(Qt.serviceCategory == "oasis365,"){
                aADNOCwebservice.statisticsADNOC('', "OASIS 365 Home", "Get");
            }
            else if(Qt.serviceCategory == "rahalcentre,"){
                aADNOCwebservice.statisticsADNOC('', "Rahal Centre Home", "Get");
            }
            else if(Qt.serviceCategory == "offices,"){
                aADNOCwebservice.statisticsADNOC('', "Office Home", "Get");
            }
            else{
                aADNOCwebservice.statisticsADNOC('', "Global Search Home", "Get");
            }
        }
        
       
        
       // aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, mLanguageBool, uniqname , "MAP");
       // aADNOCwebservice.dataLoadedSec.connect(afterdatastationList);
        console.log("called map oncompleted to call webservice2");
        //setAlignment();
    }
   
    
    
    function afterdatastationList()
    {
        console.log("afterdatastationList");
        var data = aADNOCwebservice.getQVariantListData();
        var size = data.length
        for(var j= 0; j< data.length; j++)
        {
            //console.debug("absence code   profile data length......"+ data[j].GeoCoordinateX); 
            pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
        }
        mDialogCommonList.close();
    }
    
   

    Container {
        
        Container {

            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            minHeight: 120
            background:Color.create("#0088CE")
            maxHeight: minHeight
            //topMargin: 30.0
            topPadding: 32.0
            Label {
                id: mLabelUserType

                text:  mTitleStation//qsTr("Service Station") + Retranslate.onLanguageChanged
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                //textStyle.fontWeight: FontWeight.Bold
                textStyle.fontSize: FontSize.Large
                textStyle.color: Color.create("#FFFFFF")
            }
        }
        Container {
            id: containerMain
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: Color.create("#F3F3F3")
            layout: DockLayout {
            }
            
            LoadingDialog {
                topMargin: 0
                topPadding: 0
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                active: aADNOCwebservice.active
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                topPadding: 0.0
                leftPadding: 0.0
                rightPadding: 0.0
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    minHeight: 120
                    background: mBgsearchImagePaint.imagePaint
                    maxHeight: minHeight
                    //topMargin: 30.0
                    topPadding: 22.0
                    layout: DockLayout {
                    }
                    Container {
                        id: searchContainer
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        topPadding: 0.0
                        leftPadding: 0.0
                        rightPadding: 0.0
                        layout: StackLayout {
                            orientation: (mLanguageCode != "en")? LayoutOrientation.RightToLeft : LayoutOrientation.LeftToRight
                        }
                        Container {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 4
                            }
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            leftPadding: (mLanguageCode != "en")? 0.0 :20.0
                            rightPadding:(mLanguageCode != "en")? 20.0 :0.0 
                            topPadding: 0.0
                            layout: DockLayout {
                            }
                            ImageView {
                                horizontalAlignment: (mLanguageCode != "en")? HorizontalAlignment.Right :HorizontalAlignment.Left
                                imageSource: "asset:///images/common/bgTextField@2x.png"
                                preferredWidth: 600
                            }
                            TextField {
                                id: search
                                hintText: ""
                                backgroundVisible: false
                                preferredWidth: 560                              
                            }
                            Container {
                                rightMargin: (mLanguageCode != "en")? 0.0 :10.0
                                rightPadding: (mLanguageCode != "en")? 0.0 :10.0
                                leftMargin: (mLanguageCode != "en")? 10.0 :0.0
                                leftPadding: (mLanguageCode != "en")? 10.0 :0.0
                                topMargin: 13.0
                                topPadding: 13.0
                                horizontalAlignment: (mLanguageCode != "en")?HorizontalAlignment.Left : HorizontalAlignment.Right
                                //verticalAlignment: VerticalAlignment.Center
                                ImageView {
                                    imageSource: "asset:///images/common/icnSearch.png"
                                    preferredHeight: 40
                                    preferredWidth: 40                              
                                }
                                onTouch: {
                                    if (event.isUp()) {
                                        pinContainer.removeAll();
                                        //aADNOCwebservice.searchDataNearBylocation(search.text, "search"); 
                                        if (search.text.replace(new RegExp(" ", 'g'), "").length > 0) {
                                            currentTask = intSELECT;
                                            mCustomeDataSource.query = "SELECT * FROM tbl_services where station_code  like \"%" + search.text + "%\" OR title  like \"%" + search.text + "%\""
                                            mCustomeDataSource.load();
                                        } else {
                                            currentTask = intLOAD;
                                            mCustomeDataSource.query = "SELECT * FROM tbl_services"
                                            mCustomeDataSource.load();
                                        }
                                        if(_ADNOC.isNetworkAvailable())
                                        {
                                            if(Qt.serviceCategory == "servicestation,"){
                                              aADNOCwebservice.statisticsADNOC(search.text, "Service Station Simple Search", "Post");
                                            }
                                            else if(Qt.serviceCategory == "vehicleinspection,"){
                                                aADNOCwebservice.statisticsADNOC(search.text, "Vehicle Inspection Simple Search", "Post");
                                            }
                                            else if(Qt.serviceCategory == "autoserv,"){
                                                aADNOCwebservice.statisticsADNOC(search.text, "AUTOSERVE Simple Search", "Post");
                                            }
                                            else if(Qt.serviceCategory == "oasis365,"){
                                                aADNOCwebservice.statisticsADNOC(search.text, "OASIS 365 Simple Search", "Post");
                                            }
                                            else if(Qt.serviceCategory == "rahalcentre,"){
                                                aADNOCwebservice.statisticsADNOC(search.text, "Rahal Centre Simple Search", "Post");
                                            }
                                            else if(Qt.serviceCategory == "offices,"){
                                                aADNOCwebservice.statisticsADNOC(search.text, "Office Simple Search", "Post");
                                            }
                                            else{
                                                aADNOCwebservice.statisticsADNOC(search.text, "Global  Simple Search", "Post");
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        Container {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }
                            leftPadding: 23.0
                            //horizontalAlignment: HorizontalAlignment.
                            topMargin: 13.0
                            topPadding: 13.0
                            
                            ImageView {                            
                                imageSource: "asset:///images/common/icnFilter.png"
                                preferredWidth: 40
                                preferredHeight: 40
                            }
                            
                            onTouch: {
                                if (event.isUp()) {
                                    console.log("filter search popup");
                                    // mContainerMiddle.visible = true;
                                    mDialogCommonList.open();
                                    //aADNOCwebservice.ClearMapdata();
                                    //pinContainer.removeAll();
                                    //_ADNOC.clearPins(mapview);
                                }
                            }
                        }
                    }
                    
                }
                // ################### MAP VIEW CONTAINER ######################### //
                Container {
                    id: mapcontainerLayout
                    layout: DockLayout {
                    }
                    preferredWidth: 770
                    preferredHeight: 1050
                    background: Color.create(0.5, 0.5, 0.5)
                    visible: true
                    
                    MapView {
                        id: mapview
                        altitude: 180000                   
                        visible: true                      
                        // latitude: latitude //45.342614
                        //longitude: longitude //-75.914991
                        latitude: 25.111917 //45.342614
                        longitude: 55.385406 //-75.914991
                        onRequestRender: {
                            pinContainer.updateMarkers();
                            console.log("map restrcition" + mapview.geoUri());
                            
                            var latLong =  mapview.geoUri();
                            var latLongSplit = latLong.split(",");
                            console.log(latLongSplit[1]+"map latitideLOGN" + latLongSplit[0]);

                            var lat = latLongSplit[0].split(".");
                            //var long ="";
                            var longi = latLongSplit[1].split(".");
                            console.log("map latitide" + (lat[0].toString()));
                            var CheckLat = lat[0].toString();
                            
                            var mattch = lat[0].match(/25/g);
                            var mattch1 = lat[0].match(/24/g);
                            var mattch2 = lat[0].match(/23/g);
                            var mattch3 = lat[0].match(/22/g);
                            
                            
                            
                            var matLong = longi[0].match(/51/g);
                            var matLong1 = longi[0].match(/52/g);
                            var matLong2 = longi[0].match(/53/g);
                            var matLong3 = longi[0].match(/54/g);
                            var matLong4 = longi[0].match(/55/g);
                            
                            console.log("map latitide mattch " + mattch);
                            
                            if(mattch == "25" || mattch1 == "24" || mattch2 == "23" || mattch3 == "22")
                            {
                                console.log("map condition satisfied"); 
                                  
                            }
                            else {
                                //customAlert.body = qsTr("map wrong") + Retranslate.onLanguageChanged;
                                //customAlert.show(); 
                                console.log("map rearrange position");  
                                mapview.latitude =  25.111917;
                                mapview.longitude = 55.385406;
                            }
                            
                            if(matLong == "51" || matLong1 == "52" || matLong2 == "53" || matLong3 == "54" || matLong4 == "55") 
                            {
                                console.log("map condition satisfied"); 
                            
                            }
                            else {
                                //customAlert.body = qsTr("map wrong") + Retranslate.onLanguageChanged;
                                //customAlert.show(); 
                                console.log("map rearrange position");  
                                mapview.latitude =  25.111917;
                                mapview.longitude = 55.385406;
                            }
                            //mapview.setLatitude(25.111917);
                            // mapview.setLongitude(55.385406);
                        }
                        onCreationCompleted: {
                            mapview.setFollowedId("device-location-id");
                        }
                        
                    }
                    //mapview.setFollowedId("device-location-id");
                    
                    Container {
                        id: pinContainer
                        // Must match the mapview width and height and position
                        preferredHeight: 1280
                        preferredWidth: 768
                        
                        //touchPropagationMode: TouchPropagationMode.PassThrough
                        overlapTouchPolicy: OverlapTouchPolicy.Allow
                        property variant currentBubble
                        property variant me
                        layout: AbsoluteLayout {
                        }
                        
                        function addPin(lat, lon , stationcode, title, distance, data) {
                            var marker = pin.createObject();
                            marker.stationData = data;
                           // marker.passNewsUniqName(data)
                            marker.lat = lat;
                            marker.lon = lon;
                            marker.stationCode = stationcode;
                            marker.title = title;
                            marker.distance = parseFloat(distance).toFixed(2);
                            console.log("add pin lat & long" + lat +"-" +lon);
                            var xy = _mapViewTest.worldToPixelInvokable(mapview, marker.lat, marker.lon);
                            marker.x = xy[0];
                            marker.y = xy[1];
                            pinContainer.add(marker);
                            marker.animDrop.play();
                        }
                        
                        function showBubble(pin) {
                            pinContainer.remove(currentBubble);
                            var details = bubble.createObject();
                            details.lat = pin.lat;
                            details.lon = pin.lon;
                            details.stationCode = pin.stationCode;
                            details.title = pin.title;
                            details.distance = pin.distance;
                            details.stationData = pin.stationData;
                            console.log("showbubbel lat & long" + details.lat +"-" +details.lon);
                            var xy = _mapViewTest.worldToPixelInvokable(mapview, details.lat, details.lon);
                            details.x = xy[0];
                            details.y = xy[1];
                            pinContainer.add(details);
                            details.play();
                            currentBubble = details;
                        }
                        
                        function showMe() {
                            var marker = pin.createObject();
                            marker.pinImageSource = "asset:///images/icons/imgAnnotation@2x.png"
                            marker.pointerOffsetX = 30
                            marker.pointerOffsetY = 30
                            pinContainer.insert(-1, marker);
                            marker.visible = false;
                            me = marker;
                        }
                        
                        function updateMarkers() {
                            _mapViewTest.updateMarkers(mapview, pinContainer);
                        }
                        
                        function removeBubble() {
                            pinContainer.remove(currentBubble);
                        }
                        
                        onTouch: {
                            if (event.isDown()) {
                                if ((event.localX <= currentBubble.actualX) || (event.localX >= currentBubble.actualX + currentBubble.contentWidth) || (event.localY <= currentBubble.actualY) || (event.localY >= currentBubble.actualY + currentBubble.contentHeight)) {
                                    removeBubble();
                                }
                            }
                        }
                    }
                    // ####### filter search pop up menu #######  //
                    Container {
                        topPadding: 10.0
                        leftPadding: 30
                        rightPadding: 30
                        layout: DockLayout {
                        }
                        implicitLayoutAnimationsEnabled: false
                        id: mContainerAdvanceSearch
                        horizontalAlignment: HorizontalAlignment.Left
                        Container {
                            id: mContainerMiddle
                            leftPadding: 20
                            rightPadding: 20
                            bottomPadding: 20
                            topPadding: 20
                            
                            background: mBgsearchImagePaint.imagePaint
                            visible: false
                            preferredWidth: 650
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            onVisibleChanged: {
                                if (visible) {
                                    // mButtonCollapse.defaultImageSource = "asset:///images/icon_minus.png"
                                    // mButtonCollapse.verticalAlignment = VerticalAlignment.Bottom
                                } else {
                                    //mButtonCollapse.defaultImageSource = "asset:///images/icon_plus.png"
                                    //mButtonCollapse.verticalAlignment = VerticalAlignment.Center
                                }
                            }
                            ScrollView {
                                id: mScrollView
                                Container {
                                    leftPadding: 20
                                    rightPadding: 20
                                    Label {
                                        text: qsTr("Service Station") + Retranslate.onLanguageChanged
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        //textStyle.fontWeight: FontWeight.Bold
                                        textStyle.fontSize: FontSize.Large
                                        textStyle.color: Color.create("#FFFFFF")
                                    }
                                    Label {
                                        text: qsTr("Service Station") + Retranslate.onLanguageChanged
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        //textStyle.fontWeight: FontWeight.Bold
                                        textStyle.fontSize: FontSize.Large
                                        textStyle.color: Color.create("#FFFFFF")
                                    }
                                    Label {
                                        text: qsTr("Service Station") + Retranslate.onLanguageChanged
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        //textStyle.fontWeight: FontWeight.Bold
                                        textStyle.fontSize: FontSize.Large
                                        textStyle.color: Color.create("#FFFFFF")
                                    }
                                
                                }
                            }
                        }
                    }
                }
                // ########### LIST VIEW CONTAINER ################# //
                Container {
                    id: listViewContainer
                    layout: AbsoluteLayout {
                    }
                    preferredWidth: 770
                    preferredHeight: 1050
                    //background: Color.create(0.5, 0.5, 0.5)
                    visible: false
                    ListView {
                        id: listView
                        dataModel: groupdata
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        //scrollRole: ScrollRole.Default
                        function getModel() {
                            return groupdata;
                        }
                        function getLang() {
                            return "en";
                        }
                        listItemComponents: [

                            ListItemComponent {
                                type: "item"

                                Container {
                                    id: rootContainer
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.TopToBottom
                                    }
                                    Container {
                                        id: leaveStatusContainer
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        verticalAlignment: VerticalAlignment.Fill
                                        background: mRowBgNews.imagePaint
                                        minHeight: 160
                                        maxHeight: minHeight
                                        preferredWidth: 780
                                        //background: Color.create(0.5, 0.5, 0.5)
                                        topPadding: 8.0
                                        leftPadding: 20.0
                                        rightPadding: 20.0
                                        layout: StackLayout {
                                            orientation: (Qt.languageset != "en")?LayoutOrientation.RightToLeft : LayoutOrientation.LeftToRight
                                        }
                                        
                                        ImageView {
                                            id: stationImageset
                                            horizontalAlignment: HorizontalAlignment.Center
                                            verticalAlignment: VerticalAlignment.Center
                                            imageSource: "asset:///images/icons/imgServiceStation@2x.png"   
                                            onCreationCompleted: {
                                                console.log("listview items listing" + ListItemData.category_unique_name);
                                                if(ListItemData.category_unique_name == "servicestation,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgServiceStation@2x.png" 
                                                }
                                                else if(ListItemData.category_unique_name == "vehicleinspection,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgVehicleInspection@2x.png"                                                  
                                                }
                                                else if(ListItemData.category_unique_name == "autoserv,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgAutoService@2x.png"                                                  
                                                }
                                                else if(ListItemData.category_unique_name == "oasis365,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgOasis@2x.png"                                                  
                                                }
                                                else if(ListItemData.category_unique_name == "rahalcentre,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgRahalCenter@2x.png"                                                  
                                                }
                                                else if(ListItemData.category_unique_name == "offices,"){
                                                    stationImageset.imageSource = "asset:///images/icons/imgOffice@2x.png"                                                  
                                                }
                                            }                                      
                                        }
                                        
                                        Container {
                                            id: subcontainer
                                            horizontalAlignment: HorizontalAlignment.Center
                                            verticalAlignment: VerticalAlignment.Center
                                            layout: StackLayout {
                                                orientation: LayoutOrientation.TopToBottom
                                            }
                                            Label {
                                                id: leavAppNumberID
                                                text: ListItemData.station_code +" - "+ListItemData.title
                                                horizontalAlignment: HorizontalAlignment.Left
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
    
                                            }
                                            Label {
                                                id: kmAway
                                                //text: ListItemData.getPublished + qsTr(" Km Away") + Retranslate.onLanguageChanged
                                                horizontalAlignment: HorizontalAlignment.Left
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
                                                onCreationCompleted: {
                                                    //parseFloat(distance).toFixed(2);
                                                    kmAway.text = parseFloat( ListItemData.distance).toFixed(2)+ qsTr(" Km Away") + Retranslate.onLanguageChanged;
                                                }
                                            
                                            }
                                        }
                                        
                                    }
                                    
                                    attachedObjects: [
                                        ImagePaintDefinition {
                                            id: mRowBgNews
                                            imageSource: "asset:///images/icons/imgNewsRowBg@2x.png"
                                        }
                                    ]
                                }
                                
                            }
                            
                        ]
                        onTriggered: {
                            var chosenItem = dataModel.data(indexPath);
                            console.debug('qml list out put' + indexPath);
                            
                            var  stationDetailsPage = stationDetails.createObject();
                            stationDetailsPage.passMyfavouriteData(chosenItem)
                            mNavigationPaneMain.push(stationDetailsPage)
                        
                        }
                        attachedObjects: [
                            ComponentDefinition {
                                id: stationDetails
                                source: "asset:///stationDetails.qml"
                            }
                        ]
                        

                    }

                }
                
                

                attachedObjects: [
                    ComponentDefinition {
                        id: pin
                        source: "pin.qml"
                    },
                    ComponentDefinition {
                        id: pin_current
                        source: "pin_current.qml"
                    },
                    ComponentDefinition {
                        id: bubble
                        source: "bubble.qml"
                    }
                    
                ]
                
                onCreationCompleted: {
                    
                }
                
                
                
            
               
            } // main container
        }
    }
   
    
    actions: [
       
        ActionItem {
            id: listAct
            title: qsTr("List") + Retranslate.onLanguageChanged
            accessibility.name: "list"
            imageSource: "asset:///images/icons/imgListWhite@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                //var serviceStationListPages = serviceStationList.createObject();
               // mNavigationPaneMain.pop();
                //mNavigationPaneMain.push(serviceStationListPages);
                if(listAct.accessibility.name == "list")
                {
                    listAct.accessibility.name = "Map"; 
                    listAct.title = qsTr("Map") + Retranslate.onLanguageChanged
                    listAct.imageSource = "asset:///images/icons/imgMapWhite@2x.png";
                    listViewContainer.visible = true;
                    mapcontainerLayout.visible = false;
                }
                else if(listAct.accessibility.name == "Map")
                {
                    listAct.accessibility.name = "list"; 
                    listAct.title = qsTr("List") + Retranslate.onLanguageChanged
                    listAct.imageSource = "asset:///images/icons/imgListWhite@2x.png"
                    listViewContainer.visible = false;
                    mapcontainerLayout.visible = true;
                }
            }
        }
    ]
    attachedObjects: [
        ImagePaintDefinition {
            id: mBgsearchImagePaint
            imageSource: "asset:///images/common/bgSearchBar.png"
        },    
        ADNOCwebservice {
            id: aADNOCwebservice
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
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        },
        Dialog {
            id: mDialogCommonList
            onOpenedChanged: {
                //mDialogCommonListContent.setAlignMent()
            }
            FilterSearchLayout {
                id: mDialogCommonListContent
                onDoneClick: {
                    
                }
            }
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/ADNOC.sqlite"
            //query: "SELECT * FROM tbl_favourite"
            connection: "mCustomeDataSourceInsert"
            onDataLoaded: {
                if (currentTask == intSELECT || currentTask == intLOAD) {
                    groupdata.clear();
                    console.log("sql data pass" + JSON.stringify(data));
                    groupdata.insertList(data);
                    //intTotalDataCount = data.length;
                    listView.dataModelChanged(groupdata);
                    var size = data.length;
                    for(var j= 0; j< data.length; j++)
                    {
                        console.debug("station data listing......"+ data[j].title); 
                        pinContainer.addPin(data[j].latitude, data[j].longitude , data[j].station_code, data[j].title, data[j].distance, data[j]);  
                    }
                    //mDialogCommonList.close();
   
                }
                else if (currentTask == intDELETE) {
                    
                }
            
            }
        }
    ]
    function afterdatastationListFiltersearch(data)
    {
        console.log("afterdatastationListFiltersearch");
        groupdata.clear();
        console.log("sql data pass" + JSON.stringify(data));
        groupdata.insertList(data);
        //intTotalDataCount = data.length;
        listView.dataModelChanged(groupdata);
        pinContainer.removeAll();
        var size = data.length
        for(var j= 0; j< data.length; j++)
        {
            console.debug("station data listing......"+ data[j].title); 
            pinContainer.addPin(data[j].latitude, data[j].longitude , data[j].station_code, data[j].title, data[j].distance, data[j]);  
        }
    }
}

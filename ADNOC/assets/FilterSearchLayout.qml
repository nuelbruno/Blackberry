import bb.cascades 1.2
import bb.system 1.2
import ADNOCwebservice 1.0
import "common"
import bb.DatabaseConnectionApi.data 1.0

Container {
    property string mLanguageBool
    property string mLanguageCode
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property int intSELECTData: 3
    property int intLOAD: -1
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Center
    property string facilityChoosen
    property variant arr: new Array()
    // property alias mModel: mListView.dataModel
    property alias mlabelDialog: mlabelDialog.text
    property alias mActivityIndicator: mActivityIndicator
    signal doneClick(variant selectedData)
    signal closeClick()
    layout: DockLayout {
    }
    onCreationCompleted: {
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        Qt.languageset = mLanguageCode;
        mCustomeDataFilter.query = "SELECT * FROM tbl_facilitynew"
        mCustomeDataFilter.load(); 
        //aADNOCwebservice.getAllFacilitiesParent(mLanguageBool, "", "Facility");
        //aADNOCwebservice.dataLoadedthird.connect(afterdatafacilityList);
    }
    function afterdatafacilityList()
    {
        facilityListCont.removeAll();
        var data = aADNOCwebservice.getQVfacilityData();
        var size = data.length;
        console.log("list of facliity in qml" + JSON.stringify(data));
        for (var j = 0; j < size; j++) {
            
            if(data[j].hasSub == "true")
            {
                
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.textString = data[j].Title;
                mButton.showPlus = true;
                mButton.leftIntend = 0.0;
                mButton.uniqstring = data[j].UniqueName;
                facilityListCont.add(mButton);
                addsubfacility(data[j].facilityListString);
            
            }
            else {
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.textString = data[j].Title;
                mButton.showPlus = false;
                mButton.leftIntend = 0.0;
                mButton.uniqstring = data[j].UniqueName;
                facilityListCont.add(mButton);
                addsubfacility(data[j].facilityListString);
            }
        
        
        
        }
        
        //mcontainerButtons  //mcontainerFacilitySearchSUBm
        var msubmitButton = mcontainerButtons.createObject();
        facilityListCont.add(msubmitButton);
    
    }
    function addsubfacility(facilityListString)
    {
        var faclityList = facilityListString;
        var faclityMain = faclityList.split(',');
        for (var j = 0; j < faclityMain.length; j++) {
            if(faclityMain[j].length > 1)
            {
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.showPlus = false;
                mButton.textString = faclityMain[j];
                mButton.uniqstring = faclityMain[j];
                mButton.leftIntend = 30.0;
                facilityListCont.add(mButton);
            }
        
        }
    }
    
    function setAlignMent() {
    
    
    }
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Center
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            background: mImagePaintDefinitionTopBG.imagePaint
            // background: Color.Transparent
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            preferredHeight: 100
            layout: DockLayout {
            }
            leftPadding: 50
            rightPadding: 50
            topPadding: 15
            Container {
                id: mContaineLeft
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                verticalAlignment: VerticalAlignment.Center
                Label {
                    id: mlabelDialog
                    //text: mAllStrings.mCommunity
                    textStyle.color: Color.White
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    visible: true
                }
            }
            ImageButton {
                id: mImageViewInfoExit
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Right
                defaultImageSource: "asset:///images/icon_close_white.png"
                pressedImageSource: "asset:///images/icon_close_white.png"
                disabledImageSource: "asset:///images/icon_close_white.png"
                onClicked: {
                    closeClick()
                    console.debug("mImageViewInfoExit")
                    mDialogCommonList.close();
                
                }
            }
        } //top bar ends
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
        }
        
        Container {
            
            leftPadding: 50
            rightPadding: 50
            topPadding: 30
            bottomPadding: 120
            minHeight: 350
            horizontalAlignment: HorizontalAlignment.Fill
            background: mImagePaintDefinitionMainBG.imagePaint
            ScrollView {
                id: mScrollView
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    id: facilityListCont
                    rightPadding: (Qt.languageset != "en")? 20.0: 0
                    horizontalAlignment: HorizontalAlignment.Fill 
                    layout: StackLayout {
                        orientation: LayoutOrientation.TopToBottom
                    } 
                
                
                }
            
            
            
            }
        }
    }
    /*ActivityIndicator {
     * id: mActivityIndicator
     * verticalAlignment: VerticalAlignment.Center
     * horizontalAlignment: HorizontalAlignment.Center
     * preferredWidth: 250
     * preferredHeight: 250
     }*/
    
    ActivityIndicator {
        id: mActivityIndicator
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        preferredHeight: 250
        preferredWidth: 250
    }
    attachedObjects: [
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionTopBG
            imageSource: "asset:///images/icon_bg_top.png"
        },
        ImagePaintDefinition {
            id: mImagePaintDefinitionMainBG
            imageSource: "asset:///images/icon_bg_white_small.png"
        },
        ComponentDefinition {
            id: mcontainerFacilitySearchSUBm
            
            Container {
                property string textString
                property string  uniqstring
                property string  showPlus
                property string  leftIntend
                property int count
                id: container12
                //leftPadding: 20
                onCreationCompleted: {
                
                }
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    preferredHeight: 80
                    leftPadding: leftIntend
                    layout: StackLayout {
                        orientation: (Qt.languageset != "en")? LayoutOrientation.RightToLeft : LayoutOrientation.LeftToRight
                    }
                    
                    ImageView {
                        id: showPlussetS
                        visible: showPlus
                        imageSource: "asset:///images/common/icnPlus@2x.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                    }
                    
                    CommonLabel {
                        id: label1S
                        //accessibility.name: "faclityLabel"
                        
                        horizontalAlignment: HorizontalAlignment.Left
                        text: textString
                        textStyle.color: Color.create("#000000")  
                    
                    }
                
                
                
                
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    preferredHeight: 2
                    //visible: (pmowebservice.active == true)? false : true
                    //topMargin: 30.0
                    topPadding: 0.0
                    background: Color.create("#999999")
                
                }
            
            
            }
        },
        ComponentDefinition {
            id: mcontainerFacilitySearch
            
            Container {
                property string textString
                property string  uniqstring
                property string  showPlus
                property string  leftIntend
                property int count
                id: container1
                //leftPadding: 20
                onCreationCompleted: {
                
                }
                
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    id: objectContainer
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    preferredHeight: 80
                    leftPadding: leftIntend
                    layout: StackLayout {
                        orientation: (Qt.languageset != "en")? LayoutOrientation.RightToLeft : LayoutOrientation.LeftToRight
                    }
                    
                    ImageView {
                        id: showPlusset
                        visible: showPlus
                        imageSource: "asset:///images/common/icnPlus@2x.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                    }
                    
                    CommonLabel {
                        id: label1
                        //accessibility.name: "faclityLabel"
                        
                        horizontalAlignment: HorizontalAlignment.Left
                        text: textString
                        textStyle.color: Color.create("#000000")  
                    
                    }
                    
                    ImageView {
                        id: uniqstring
                        visible: false
                        imageSource: "asset:///images/common/icnSelectedBlue@2x.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                    
                    }
                    
                    onTouch: {
                        if (event.isDown()) {
                            objectContainer.background =  Color.create("#0083CA");
                        }
                        else if(event.isUp())
                        {
                            objectContainer.background =  Color.create("#FFFFFF");
                            var AlreadyChs = facilityChoosen.search(label1.text);
                            console.log("faclity count"+ AlreadyChs );
                            if(AlreadyChs > 0)
                            {
                                uniqstring.visible = false; 
                                facilityChoosen = facilityChoosen.replace(label1.text, "");
                                console.log("faclity repalce"+ facilityChoosen );
                            }
                            else {
                                uniqstring.visible = true;
                                facilityChoosen = facilityChoosen +","+ label1.text;
                            }
                            console.log("faclity choosen string"+ JSON.stringify(facilityChoosen));
                        }
                        else if(event.isCancel())
                        {
                            objectContainer.background =  Color.create("#FFFFFF");
                        }
                    }  
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    preferredHeight: 2
                    //visible: (pmowebservice.active == true)? false : true
                    //topMargin: 30.0
                    topPadding: 0.0
                    background: Color.create("#999999")
                
                }
            
            
            }
        },
        ComponentDefinition {
            id: mcontainerButtons
            Container {
                topMargin: 20.0
                bottomMargin: 20.0
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: StackLayout {
                    orientation: (Qt.languageset != "en")? LayoutOrientation.RightToLeft :LayoutOrientation.LeftToRight
                }
                
                Container {
                    topPadding: 5.0
                    preferredHeight: 60
                    //rightMargin: 30.0
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: mImagePaintTextBoxborder.imagePaint
                    layout: StackLayout {
                        //orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 5
                    }
                    CommonLabel {
                        id: submitButton
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: qsTr("Filter") + Retranslate.onLanguageChanged
                        textStyle.color: Color.create("#FFFFFF")
                    }
                    onTouch: {
                        if (event.isUp()) {
                            
                            var faclityMain = facilityChoosen.split(',');
                            var faclilitSearchString = "";
                            for (var j = 0; j < faclityMain.length; j++) {
                                if(faclityMain[j].length > 1)
                                {
                                    if(j == faclityMain.length-1)  
                                    {
                                        faclilitSearchString = faclilitSearchString+"'"+faclityMain[j]+"'"; 
                                    }else {
                                        faclilitSearchString = faclilitSearchString+"'"+faclityMain[j]+"',";
                                    }
                                   
                                }
                            
                            }
                            if(_ADNOC.isNetworkAvailable())
                            {
                                
                                if(Qt.serviceCategory == "servicestation,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "Service Station Advance Search", "Get");
                                }
                                else if(Qt.serviceCategory == "vehicleinspection,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "Vehicle Inspection Advance Search", "Get");
                                }
                                else if(Qt.serviceCategory == "autoserv,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "AUTOSERVE Advance Search", "Get");
                                }
                                else if(Qt.serviceCategory == "oasis365,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "OASIS 365 Advance Search", "Get");
                                }
                                else if(Qt.serviceCategory == "rahalcentre,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "Rahal Centre Advance Search", "Get");
                                }
                                else if(Qt.serviceCategory == "offices,"){
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "Office Advance Search", "Get");
                                }
                                else{
                                    aADNOCwebservice.statisticsADNOC(facilityChoosen, "Global Advance Search", "Get");
                                }
                            }
                            
                            if(Qt.serviceCategory != "" || Qt.serviceCategory != undefined){
                                currentTask = intSELECTData; //\"%"+facilityChoosen+"%\"  //,Motor insurance,OASIS,Mosque
                                mCustomeDataFilter.query = "SELECT * FROM tbl_services where information   IN ("+faclilitSearchString+") AND category_unique_name = '" + Qt.serviceCategory  + "'" 
                                mCustomeDataFilter.load();
                            }
                            else {
                            
                                currentTask = intSELECTData; //\"%"+facilityChoosen+"%\"  //,Motor insurance,OASIS,Mosque
                                mCustomeDataFilter.query = "SELECT * FROM tbl_services where information   IN ("+faclilitSearchString+")" 
                                mCustomeDataFilter.load();
                            }
                            
                            //aADNOCwebservice.searchNearByLocationFacilities(Qt.CurrentLatitude, Qt.CurrentLongitude, mLanguageBool, facilityChoosen,  Qt.uniqueName, "Map"); 
                            //aADNOCwebservice.dataLoadedSec.connect(afterdatastationList);
                        }
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        //orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                }
                Container {
                    topPadding: 5.0
                    preferredHeight: 60
                    
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: mImagePaintTextBoxborder.imagePaint
                    layout: StackLayout {
                        //orientation: LayoutOrientation.LeftToRight
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 5
                    }
                    CommonLabel {
                        id: cancelButton
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: qsTr("Reset") + Retranslate.onLanguageChanged
                        textStyle.color: Color.create("#FFFFFF")
                    }
                    onTouch: {
                        if (event.isUp()) {
                            //aADNOCwebservice.getAllFacilitiesParent(mLanguageBool, "", "Facility");
                            //aADNOCwebservice.dataLoaded.connect(afterdatafacilityList);
                            facilityChoosen = "";
                            mCustomeDataFilter.query = "SELECT * FROM tbl_facilitynew"
                            mCustomeDataFilter.load(); 
                            
                        }
                    }
                }
            } 
        },
        ImagePaintDefinition {
            id: mImagePaintTextBoxborder
            imageSource: "asset:///images/common/button_grey.png"
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
        DatabaseConnectionApi {
            id: mCustomeDataFilter
            source: "sql/ADNOC.sqlite"
            //query: "SELECT * FROM tbl_favourite"
            connection: "mCustomeDataFilterSearch"
            onDataLoaded: {
                if (currentTask == intSELECT || currentTask == intLOAD) {
                    currentTask == intDELETE
                    
                    console.log("list of facliity in qml" + JSON.stringify(data));
                    afterdatafacilityList2(data);
                
                }
                else if (currentTask == intSELECTData) {
                    console.log("list of data in qml" + JSON.stringify(data));
                    if(data.length > 0)
                    {
                      afterdatastationListFiltersearch(data);
                      closeClick()
                      console.debug("mImageViewInfoExit")
                      mDialogCommonList.close();
                    }else {
                        customAlert.body = qsTr("No data Found") + Retranslate.onLanguageChanged;
                        customAlert.show(); 
                    }
                }
            
            }
        }
    ]
    
    function afterdatafacilityList2(data)
    {
        facilityListCont.removeAll();
        //var data = aADNOCwebservice.getQVfacilityData();
        var size = data.length;
        console.log(data.length+"list of facliity in qml" + JSON.stringify(data));
        for (var j = 0; j < size; j++) {
            
            if(data[j].hasSub == "true")
            {
                
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.textString = data[j].title;
                mButton.showPlus = true;
                mButton.leftIntend = 0.0;
                mButton.uniqstring = data[j].unique_name;
                facilityListCont.add(mButton);
                addsubfacility(data[j].facilityListString);
            
            }
            else {
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.textString = data[j].title;
                mButton.showPlus = false;
                mButton.leftIntend = 0.0;
                mButton.uniqstring = data[j].unique_name;
                facilityListCont.add(mButton);
                addsubfacility(data[j].facilityListString);
            }
        
        
        
        }
        
        //mcontainerButtons  //mcontainerFacilitySearchSUBm
        var msubmitButton = mcontainerButtons.createObject();
        facilityListCont.add(msubmitButton);
    
    }
    
    function addsubfacility2(facilityListString)
    {
        var faclityList = facilityListString;
        var faclityMain = faclityList.split(',');
        for (var j = 0; j < faclityMain.length; j++) {
            if(faclityMain[j].length > 1)
            {
                var mButton = mcontainerFacilitySearch.createObject();
                mButton.showPlus = false;
                mButton.textString = faclityMain[j];
                mButton.uniqstring = faclityMain[j];
                mButton.leftIntend = 30.0;
                facilityListCont.add(mButton);
            }
        
        }
    }
}

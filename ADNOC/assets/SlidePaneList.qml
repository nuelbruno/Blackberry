
import bb.cascades 1.0
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"


Container {
    property string mLanguageCode
    property string mLangCode
    
    signal languageChanged()
    
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    layout: DockLayout {
    }
    
    
    onCreationCompleted: {
          
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        Qt.languageset = mLanguageCode;
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        setAlignment(mLanguageCode);
       
        Qt.langSettings = mLanguageCode;
    }
    onLanguageChanged: {
        
       
    }
    

    function setAlignment(lang)
    {
        if(lang == "en"){
            prfileNameorientation.orientation = LayoutOrientation.LeftToRight; 
            vechicleInspection.orientation = LayoutOrientation.LeftToRight;  
            serviceStationMenu.orientation = LayoutOrientation.LeftToRight;  
            autoService.orientation = LayoutOrientation.LeftToRight;  
            oasis365.orientation = LayoutOrientation.LeftToRight;  
            rahalCenter.orientation = LayoutOrientation.LeftToRight; 
            office.orientation = LayoutOrientation.LeftToRight;   
            favourite.orientation = LayoutOrientation.LeftToRight;   
            news.orientation = LayoutOrientation.LeftToRight;   
            contactUS.orientation = LayoutOrientation.LeftToRight;   
            search.orientation = LayoutOrientation.LeftToRight;   
            changeLanguage.orientation = LayoutOrientation.LeftToRight;
            mLabelPhotoTitle.text =   qsTr("Home") + Retranslate.onLanguageChanged;   
            serviceStationLabel.text = qsTr("Service Station") + Retranslate.onLanguageChanged;
            vechileInspectionLbl.text = qsTr("Vechile Inspection") + Retranslate.onLanguageChanged;
            mAutoservLbl.text = qsTr("AUTOSERV") + Retranslate.onLanguageChanged;
            oASIS365lbl.text = qsTr("OASIS 365") + Retranslate.onLanguageChanged;
            rahalCenterLbl.text = qsTr("Rahal Centre") + Retranslate.onLanguageChanged;
            officeLbl.text = qsTr("Office") + Retranslate.onLanguageChanged;
            favouriteLbl.text = qsTr("Favourities") + Retranslate.onLanguageChanged;
            newsLable.text = qsTr("News") + Retranslate.onLanguageChanged;
            contactusLbl.text = qsTr("Contact Us") + Retranslate.onLanguageChanged;
            msearchLbl.text =  qsTr("Search") + Retranslate.onLanguageChanged;
            
        }else {
            prfileNameorientation.orientation = LayoutOrientation.RightToLeft; 
            vechicleInspection.orientation = LayoutOrientation.RightToLeft;
            serviceStationMenu.orientation = LayoutOrientation.RightToLeft;
            autoService.orientation = LayoutOrientation.RightToLeft;
            oasis365.orientation = LayoutOrientation.RightToLeft;
            rahalCenter.orientation = LayoutOrientation.RightToLeft;
            office.orientation = LayoutOrientation.RightToLeft;
            favourite.orientation = LayoutOrientation.RightToLeft;
            news.orientation = LayoutOrientation.RightToLeft;
            contactUS.orientation = LayoutOrientation.RightToLeft;
            search.orientation = LayoutOrientation.RightToLeft;
            changeLanguage.orientation = LayoutOrientation.RightToLeft; 
            mLabelPhotoTitle.text =   qsTr("Home") + Retranslate.onLanguageChanged; 
            serviceStationLabel.text = qsTr("محطة الخدمة") + Retranslate.onLanguageChanged; 
            vechileInspectionLbl.text = qsTr("فحص الفني للسيارة") + Retranslate.onLanguageChanged;  
            mAutoservLbl.text = qsTr("اوتوسيرف") + Retranslate.onLanguageChanged;
            oASIS365lbl.text = qsTr("واحة أدنوك 365") + Retranslate.onLanguageChanged;
            rahalCenterLbl.text = qsTr("مركز إصدار بطاقات رحال") + Retranslate.onLanguageChanged;
            officeLbl.text = qsTr("المكتب") + Retranslate.onLanguageChanged;
            favouriteLbl.text = qsTr("المفضلة") + Retranslate.onLanguageChanged;
            newsLable.text = qsTr("الاخبار") + Retranslate.onLanguageChanged;
            contactusLbl.text = qsTr("الاتصال بنا") + Retranslate.onLanguageChanged;
            msearchLbl.text =  qsTr("بحث") + Retranslate.onLanguageChanged;
        }
        
    }
    
    
    Container {
        verticalAlignment: VerticalAlignment.Fill
        horizontalAlignment: HorizontalAlignment.Right
        preferredWidth: 14
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        //minHeight: 1204
        //preferredHeight: 1204
        ImageView {
            imageSource: "asset:///images/background/shadow_right.png"
            //horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layoutProperties: StackLayoutProperties {
                spaceQuota: 10
            }
        }
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        background:Color.create("#0088CE")
        rightPadding: 7.0
        topPadding: 60.0
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            id: home
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: prfileNameorientation
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgHomeWhite@2x.png"
            }
            CommonLabel {
                id: mLabelPhotoTitle
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Home") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
                
            } //mHomescreen
            onTouch: {
                if(event.isUp())
                {
                    //var mHomescreenPage = mHomescreen.createObject();
                    //mNavigationPaneMain.push(mHomescreenPage);
                }
            }
            
        } 
        Container {
            id: horline1
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 5
            background: Color.create("#FFFFFF")
        } 
        Container {
           id: serviceStation
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: serviceStationMenu
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgServiceStationWhite@2x.png"
            }
            CommonLabel {
                id: serviceStationLabel
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Service Station") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("servicestation,", qsTr("Service Station") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        } 
        Container {
           
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {   
            id: vehcileINpsection   
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: vechicleInspection
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgVehicleInspectionWhite@2x.png"
            }
            CommonLabel {
                id: vechileInspectionLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Vechile Inspection") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("autoserv,", qsTr("AUTOSERV") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container { 
            id: autoserv     
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: autoService
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgAutoServiceWhite@2x.png"
            }
            CommonLabel {
                id: mAutoservLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("AUTOSERV") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("autoserv,", qsTr("AUTOSERV") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {     
            id: oasisContainer 
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: oasis365
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgOasisWhite@2x.png"
            }
            CommonLabel {
                id: oASIS365lbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("OASIS 365") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("oasis365,", qsTr("OASIS365") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: rahalCenter
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgRahalCenterWhite@2x.png"
            }
            CommonLabel {
                id: rahalCenterLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Rahal Centre") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("rahalcentre,", qsTr("Rahal Centre") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: office
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgOfficeWhite@2x.png"
            }
            CommonLabel {
                id: officeLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Office") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("offices,", qsTr("Offcie") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 5
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: favourite
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgFavouritesWhite@2x.png"
            }
            CommonLabel {
                id: favouriteLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Favourities") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mFavouritesPage = mFavourites.createObject();
                    mNavigationPaneMain.push(mFavouritesPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: news
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgNewsWhite@2x.png"
            }
            CommonLabel {
                id: newsLable
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("News") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mNewsListingPage = mNewsListing.createObject();
                    mNavigationPaneMain.push(mNewsListingPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: contactUS
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgContactUsWhite@2x.png"
            }
            CommonLabel {
                id: contactusLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Contact Us") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mContactusPage = mContactus.createObject();
                    mNavigationPaneMain.push(mContactusPage);
                }
            }
        
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 2
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: search
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgSearchWhite@2x.png"
            }
            CommonLabel {
                id: msearchLbl
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Search") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
            
            }
            onTouch: {
                if(event.isUp())
                {
                    var mServiceStationPage = mServiceStation.createObject();
                    mServiceStationPage.passStationData("", qsTr("Search") + Retranslate.onLanguageChanged);
                    mNavigationPaneMain.push(mServiceStationPage);
                }
            }
        
        } 
        Container {
            
            topMargin: 20
            horizontalAlignment: HorizontalAlignment.Fill
            preferredHeight: 5
            background: Color.create("#FFFFFF")
        } 
        Container {      
            horizontalAlignment: HorizontalAlignment.Fill
            //preferredHeight: 40
            topPadding: 20.0
            leftPadding: 20.0
            rightPadding: 20.0
            //background: Color.create("#FFFFFF")
            layout: StackLayout {
                id: changeLanguage
                orientation: LayoutOrientation.LeftToRight
            }
            ImageView {
                imageSource: "asset:///images/icons/imgChangeLanguageWhite@2x.png"
            }
            CommonLabel {
                id: langauge
                horizontalAlignment: HorizontalAlignment.Center
                text: qsTr("Change Language") + Retranslate.onLanguageChanged;
                textStyle.color: Color.create("#FFFFFF")
                
            
            }
            onTouch: {
                if(event.isUp())
                {
                    if (_ADNOC.getValueFor("mLanguageCode", "en") == "en") {
                        _ADNOC.updateLocale("ar")
                        _ADNOC.saveValueFor("mLanguageCode", "ar")
                        langauge.text = qsTr("English");
                        setAlignment("ar");
                        setAlignment1("ar");
                    } else {
                        _ADNOC.updateLocale("en-US")
                        _ADNOC.saveValueFor("mLanguageCode", "en")
                        langauge.text = qsTr("العربية");
                        setAlignment("en");
                        setAlignment1("en");
                    }
                }
            }
        
        } 
        
    }
    attachedObjects: [
        ComponentDefinition {
            id: mServiceStation
            source: "serviceStation.qml"
        }, 
        ComponentDefinition {
            id: mNewsListing
            source: "newsListing.qml"
        },
        ComponentDefinition {
            id: mContactus
            source: "contactus.qml"
        },
        ComponentDefinition {
            id: mFavourites
            source: "myFavourites.qml"
        },
        ComponentDefinition {
            id: mHomescreen
            source: "Landingscreen.qml"
        }
    ]
   
}
import bb.cascades 1.0
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import CustomTimer 1.0
import bb.DatabaseConnectionApi.data 1.0

Page {
    
    signal languageChangedMain()
    
    property string mLanguageBool
    property string mLanguageCode
    property int imageCount: 0
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int imageLoadSelect: 3
    property int imageLOAD: 4
    property int imgDelete: 5
    property int facilitySELECT: 6
    property int facLoad: 7
    property int facDelete: 8
    property int newsSELECT: 9
    property int newsLOAD: 10
    property int newsDelete: 11
    property int contactSELECT: 12
    property int contactLoad: 13
    property int contactDelete: 14
    property int facLocSELECT: 12
    property int facLocLOAD: 13
    property int facLocDelete: 14
    property int closeSheet: 15
    property int intDELETE: 2
    property int intLOAD: -1
    
    
    
    onCreationCompleted: {
        loadingSheet.open();
        //aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, "1", "servicestation" , "MAP");
        //mLanguageCode = _PMO.getValueFor("mLanguageCode", "en")
        Qt.webServiceData = "";
        Qt.serviceDataDB = "";
        mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
        console.debug("landing singal called succ" + mLanguageCode);
        mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
        setAlignment1(mLanguageCode);
        //aADNOCwebservice.getMediagalleryImages(mLanguageBool);
        // aADNOCwebservice.dataLoaded.connect(afterDataImageload);
        //videoTimer.start();
        
        currentTask = intSELECT;
        mCustomeDataSource.query = "SELECT * FROM tbl_services"
        mCustomeDataSource.load();
        
        var longitude = _ADNOC.getValueFor("longitude", "")
        var latitude = _ADNOC.getValueFor("latitude", "")
        Qt.CurrentLatitude =  "25.111917";
        Qt.CurrentLongitude =  "55.385406";
        
        
        
        //aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, mLanguageBool, "servicestation" , "MAP");
        //aADNOCwebservice.dataLoadedSec.connect(afterdatastationList);
    
    }
    
    
    
   
    
    function setAlignment1(lang)
    {
        if(lang == "en"){
            mLabelHome.text = "ADNOC Distribution";
            mCommonHomeAboutUs.mLableText = "Service Station";
            mvechileinsepction.mLableText = "Vehicle Inspection";
            mAutoserv.mLableText = "AUTOSERV";
            moasis365.mLableText = "OASIS365";
            mRahalCenter.mLableText = "Rahal Center";
            mOffice.mLableText = "Office";
            favourite.mLableText = "Favourites";
            news.mLableText = "News";
            contactsus.mLableText = "Contact Us";
            search.mLableText = "Search";
        }
        else{
            mLabelHome.text = "شركة أدنوك للتوزيع"; 
            mCommonHomeAboutUs.mLableText = "محطة الخدمة";
            mvechileinsepction.mLableText = "فحص الفني للسيارة";
            mAutoserv.mLableText = "اوتوسيرف";
            moasis365.mLableText = "واحة أدنوك 365";
            mRahalCenter.mLableText = "مركز إصدار بطاقات رحال";
            mOffice.mLableText = "المكتب";
            favourite.mLableText = "المفضلة";
            news.mLableText = "الاخبار";
            contactsus.mLableText = "الاتصال بنا";
            search.mLableText = "بحث";
        }
    }
    
    onLanguageChangedMain: {
    
    }
    
    
    
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {
        }
        
        
        
        
        Container {
            id: contentContainer
            
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            
            animations: [
                TranslateTransition {
                    id: animCloseMain
                    toX: 0
                    fromX: mContainerContext.preferredWidth
                    duration: 500
                },
                TranslateTransition {
                    id: animOpenMain
                    toX: mContainerContext.preferredWidth
                    fromX: 0
                    duration: 500
                    onEnded: {
                    
                    }
                }
            ]
            
            Container {
                id: mainContainer
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                minHeight: 120
                maxHeight: minHeight
                background:Color.create("#0088CE")
                //topMargin: 30.0
                topPadding: 32.0
                Label {
                    id: mLabelHome       
                    text: qsTr("ADNOC Distribution") + Retranslate.onLanguageChanged
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
                //background: Color.create("#0088CE")
                layout: DockLayout {
                }
                
                LoadingDialog {
                    topMargin: 0
                    topPadding: 0
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    active: aADNOCwebservice.active
                    // loadingSheet.open();
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
                    preferredHeight: 1100
                    
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
                            Container {
                                
                                //preferredWidth: 570
                                horizontalAlignment: HorizontalAlignment.Fill
                                //verticalAlignment: VerticalAlignment.Fill
                                WebView {
                                    id: bannerImage
                                    verticalAlignment: VerticalAlignment.Center
                                    horizontalAlignment: HorizontalAlignment.Center
                                    maxHeight: 350
                                    minHeight: 350
                                    //html: 
                                }
                                /* ImageView {
                                 id: imageview1
                                 preferredHeight: 350
                                 
                                 //preferredWidth: 570
                                 horizontalAlignment: HorizontalAlignment.Fill
                                 imageSource: "asset:///images/background/imgWaterMark.png"
                                 //scalingMethod: ScalingMethod.AspectFill
                                 }*/
                            }
                                                    
                        }
                        
                        Container {
                            id: menuList
                            topPadding: 10.0
                            topMargin: 10.0
                            
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            // preferredHeight: 400
                            //background:Color.create("#333333")
                            layout: DockLayout {
                            }
                            
                            ImageView {
                                id: backImage
                                horizontalAlignment: HorizontalAlignment.Fill
                                //preferredWidth: 700
                                imageSource: "asset:///images/background/bgMainMenu@2x.png"
                                //scalingMethod: ScalingMethod.AspectFill
                            }
                            Container {
                                id: menuIconsContainerMain
                                topPadding: 10.0
                                topMargin: 10.0
                                //background:Color.create("#999999")
                                horizontalAlignment: HorizontalAlignment.Fill
                                layout: StackLayout {
                                    orientation: LayoutOrientation.TopToBottom
                                }
                                Container {
                                    //background:Color.create("#333333")
                                    layout: StackLayout {
                                        id: landingFirstRowOrientation
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    horizontalAlignment: HorizontalAlignment.Left
                                    CommonHomeRow {
                                        id: mCommonHomeAboutUs
                                        mLableText: qsTr("Service Station") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgServiceStation@2x.png"
                                        mImageSource: "asset:///images/icons/imgServiceStation@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgServiceStation@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("servicestation,", qsTr("Service Station") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        
                                        }
                                    }
                                    CommonHomeRow {
                                        id: mvechileinsepction
                                        mLableText: qsTr("Vehicle Inspection") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgVehicleInspection@2x.png"
                                        mImageSource: "asset:///images/icons/imgVehicleInspection@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgVehicleInspection@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("vehicleinspection,", qsTr("Vehicle Inspection") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        
                                        }
                                    }
                                    CommonHomeRow {
                                        id: mAutoserv
                                        mLableText: qsTr("AUTOSERV") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgAutoService@2x.png"
                                        mImageSource: "asset:///images/icons/imgAutoService@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgAutoService@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("autoserv,", qsTr("AUTOSERV") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        
                                        }
                                    }
                                }
                                Container {
                                    //background:Color.create("#333333")
                                    layout: StackLayout {
                                        id: landingFirstRowOrientation2
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    horizontalAlignment: HorizontalAlignment.Left
                                    CommonHomeRow {
                                        id: moasis365
                                        mLableText: qsTr("OASIS365") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgOasis@2x.png"
                                        mImageSource: "asset:///images/icons/imgOasis@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgOasis@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("oasis365,", qsTr("OASIS365") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        
                                        }
                                    }
                                    CommonHomeRow {
                                        id: mRahalCenter
                                        mLableText: qsTr("Rahal Center") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgRahalCenter@2x.png"
                                        mImageSource: "asset:///images/icons/imgRahalCenter@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgRahalCenter@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("rahalcentre,", qsTr("Rahal Centre") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        }
                                    }
                                    CommonHomeRow {
                                        id: mOffice
                                        mLableText: qsTr("Office") + Retranslate.onLanguageChanged
                                        defaultImageSource: "asset:///images/icons/imgOffice@2x.png"
                                        mImageSource: "asset:///images/icons/imgOffice@2x.png"
                                        mSelectedImageSource:  "asset:///images/icons/imgOffice@2x.png"
                                        onMyClick: {
                                            var mServiceStationPage = mServiceStation.createObject();
                                            mServiceStationPage.passStationData("offices,", qsTr("Offcie") + Retranslate.onLanguageChanged);
                                            mNavigationPaneMain.push(mServiceStationPage);
                                        
                                        }
                                    }
                                }
                            
                            }
                        
                        
                        }
                        Container {
                            id: menuIconsContainerMain2
                            //topPadding: 30.0
                            topMargin: 30.0
                            preferredHeight: 120
                            
                            background:Color.create("#0088CE")
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }
                            Container {
                                //background:Color.create("#333333")
                                horizontalAlignment: HorizontalAlignment.Fill
                                verticalAlignment: VerticalAlignment.Fill
                                layout: StackLayout {
                                    id: bottomMenusContaner
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                //horizontalAlignment: HorizontalAlignment.Left
                                CommonBottomMenu {
                                    id: favourite
                                    mLableText: qsTr("Favourites") + Retranslate.onLanguageChanged
                                    defaultImageSource: "asset:///images/icons/icnFavourite@2x.png"
                                    mImageSource: "asset:///images/icons/icnFavourite@2x.png"
                                    mSelectedImageSource:  "asset:///images/icons/icnFavourite@2x.png"
                                    onMyClick: {
                                        var mFavouritesPage = mFavourites.createObject();
                                        mNavigationPaneMain.push(mFavouritesPage);
                                    
                                    }
                                }
                                CommonBottomMenu {
                                    id: news
                                    mLableText: qsTr("News") + Retranslate.onLanguageChanged
                                    defaultImageSource: "asset:///images/icons/imgNews@2x.png"
                                    mImageSource: "asset:///images/icons/imgNews@2x.png"
                                    mSelectedImageSource:  "asset:///images/icons/imgNews@2x.png"
                                    onMyClick: {
                                        var mNewsListingPage = mNewsListing.createObject();
                                        mNavigationPaneMain.push(mNewsListingPage);
                                    
                                    }
                                }
                                CommonBottomMenu {
                                    id: contactsus
                                    mLableText: qsTr("Contact Us") + Retranslate.onLanguageChanged
                                    defaultImageSource: "asset:///images/icons/imgContactUs@2x.png"
                                    mImageSource: "asset:///images/icons/imgContactUs@2x.png"
                                    mSelectedImageSource:  "asset:///images/icons/imgContactUs@2x.png"
                                    onMyClick: {
                                        var mContactusPage = mContactus.createObject();
                                        mNavigationPaneMain.push(mContactusPage);
                                    
                                    }
                                }
                                CommonBottomMenu {
                                    id: search
                                    mLableText: qsTr("Search") + Retranslate.onLanguageChanged
                                    defaultImageSource: "asset:///images/icons/imgSearch@2x.png"
                                    mImageSource: "asset:///images/icons/imgSearch@2x.png"
                                    mSelectedImageSource:  "asset:///images/icons/imgSearch@2x.png"
                                    onMyClick: {
                                        var mServiceStationPage = mServiceStation.createObject();
                                        mServiceStationPage.passStationData("", qsTr("Search") + Retranslate.onLanguageChanged);
                                        mNavigationPaneMain.push(mServiceStationPage);
                                    
                                    }
                                }
                            }
                        }
                    
                    }
                
                }
            } // nav bar container
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Bottom
                background: mImagePaintBottomBG.imagePaint
                leftPadding: 25.0
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                // mImagePaintBottomBG
                SlideButton {
                    id: mSlideButton
                    horizontalAlignment: HorizontalAlignment.Fill
                    onOpenSlidePane: {
                        mainContainer.background = Color.create("#FFFFFF");
                        mContainerContextMain.visible = true;
                        animOpen.play();
                        animOpenMain.play();
                        videoTimer.stop();
                        //languageChangedMain();
                    }
                
                
                }
            
            }
        
        } // main container
        
        // ####################  SECOND SLIDE CONTAIONER START ###################### //
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            id: mContainerContextMain
            layout: DockLayout {
            }
            visible: false
            onTouch: {
                var posx = event.windowX
                if (event.isUp()) {
                    if (posx >= 600) {
                        mainContainer.background = Color.create("#0088CE");
                        animClose.play();
                        animCloseMain.play();
                        languageChangedMain();
                        //videoTimer.start();
                        console.log("touch bar");
                    }
                }
            }
            Container {
                id: mContainerContext
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Left
                preferredWidth: 670
                //background: Color.Black
                animations: [
                    TranslateTransition {
                        id: animOpen
                        toX: 0
                        fromX: - mContainerContext.preferredWidth
                        duration: 500
                    },
                    TranslateTransition {
                        id: animClose
                        toX: - mContainerContext.preferredWidth
                        fromX: 0
                        duration: 500
                        onEnded: {
                            mContainerContextMain.visible = false;
                        }
                    }
                ]
                layout: DockLayout {
                }
                
                SlidePaneList {
                    id: mSlidePaneList
                    preferredWidth: 670
                    maxWidth: 670
                
                }
            
            } // Second Slide Containe end
        }// Second Slide Containe end
    
    } // main container dock layout  mTravelRequestMainPage
    attachedObjects: [
        ImagePaintDefinition {
            id: mImagePaintBottomBG
            imageSource: "asset:///images/common/home_bottom_bg.png"
        },
        ImagePaintDefinition {
            id: mBackgroundImage
            imageSource: "asset:///images/background/bgView.png"
        },
        ComponentDefinition {
            id: mServiceStation
            source: "serviceStation.qml"
        }, 
        ComponentDefinition {
            id: mvehicleInspection
            source: "vehicleInsepction.qml"
        }, 
        ComponentDefinition {
            id: mAutoServ
            source: "autoservice.qml"
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
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        TimerCount {
            id: videoTimer
            
            
            interval: 1700
            onTimeout: {
                console.debug("counter timer-+++++++++++++++++++++++++++++++++++++:");
                // Decrement the counter and update the countdown text
                afterDataImageload();
            
            } // end of onTimeout signal handler
        }, // end of Timer
        Sheet {
            id: loadingSheet
            content: Page {
                onCreationCompleted: {
                    
                }

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    topPadding: 0.0
                    leftPadding: 0.0
                    rightPadding: 0.0
                    background: Color.create("#0088CE")
                    
                    Container {
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        topPadding: 220
                        ImageView {
                            horizontalAlignment: HorizontalAlignment.Center
                            verticalAlignment: VerticalAlignment.Center
                            imageSource: "asset:///images/Logo.gif"
                            
                        }
                    }
                }
            }
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/ADNOC.sqlite"
            //query: "SELECT * FROM tbl_favourite"
            connection: "mCustomeDataSourceLoad"
            onDataLoaded: {
                if(currentTask == intSELECT) {
                    currentTask = intLOAD;
                    console.log("sql data pass" + JSON.stringify(data) +"  value");
                    Qt.serviceDataDB = data;
                    aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, mLanguageBool, "" , "MAP");
                    aADNOCwebservice.dataLoadedSec.connect(afterdatastationList);
                }
                else if(currentTask == intDELETE) {
                    currentTask = imageLoadSelect;
                    console.log("initdelte load f");
                    var data = Qt.webServiceData;
                    for(var j= 0; j< data.length; j++) // for(var j= 0; j< data.length; j++)
                    {
                        console.log("initdelte load f" + data[j].facilityList);
                        //console.log("INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');");
                        mCustomeDataSource.query = "INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');"
                        mCustomeDataSource.load(); 
                        //pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
                    }
                    Qt.webServiceData = "";
                }
                else if(currentTask == imageLoadSelect){
                    
                    currentTask = imageLOAD;
                    mCustomeDataSource.query = "SELECT * FROM tbl_homeimages"
                    mCustomeDataSource.load();
                    
                } //property int imageLoad: 3  //imgDelete
                else if(currentTask == imageLOAD){
                   
                    Qt.homeImage = data;
                    console.log("home image load database" +JSON.stringify(data));
                    currentTask = intLOAD;
                    aADNOCwebservice.getMediagalleryImages(mLanguageBool);
                    aADNOCwebservice.dataLoaded.connect(afterDataImageload);
                }
                else if(currentTask == imgDelete) {
                    
                    console.log("initdelte load f");
                    var data = Qt.webHomeImage;
                    for(var j= 0; j< data.length; j++) // for(var j= 0; j< data.length; j++)
                    {
                        // console.log("INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');");
                        mCustomeDataSource.query = "INSERT INTO tbl_homeimages (title, description, unique_name, main_image, image_id) VALUES ('"+data[j].Title+"','"+data[j].Description+"','"+data[j].UniqueName+"','"+data[j].MainImageFullURL+"','"+data[j].ID+"');"
                        mCustomeDataSource.load();                      
                        //pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
                    }
                    Qt.webHomeImage = "";
                    currentTask = facilitySELECT;
                }
                else if(currentTask == facilitySELECT){
                    
                    currentTask = facLoad;
                    mCustomeDataSource.query = "SELECT * FROM tbl_facilitynew"
                    mCustomeDataSource.load();
                
                }
                else if(currentTask == facLoad){
                    currentTask = intLOAD;
                    Qt.facilitySQl = data;
                    //console.log("faclility load database" +JSON.stringify(data));
                    aADNOCwebservice.getAllFacilitiesParent(mLanguageBool, "", "Facility");
                    aADNOCwebservice.dataLoadedthird.connect(afterdatafacilityList);
                }   
                else if(currentTask == facDelete){
                    currentTask = newsSELECT;
                    console.log("init delte load f");
                    var data = Qt.webFacility;
                    for(var j= 0; j< data.length; j++) // for(var j= 0; j< data.length; j++)
                    {
                        // console.log("INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');");
                        mCustomeDataSource.query = "INSERT INTO tbl_facilitynew (service_id, unique_name, title, language_id, hasSub , facilityListString) VALUES ('"+data[j].Title+"','"+data[j].UniqueName+"','"+data[j].Title+"','"+mLanguageBool+"',  '"+data[j].hasSub+"', '"+data[j].facilityListString+"');" ; //"+data[j].facilityListString+"
                        mCustomeDataSource.load();                      
                        // pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
                    }
                    mCustomeDataSource.load();  
                    Qt.webFacility = "";
                }
                else if(currentTask == newsSELECT){
                    
                    currentTask = newsLOAD;
                    mCustomeDataSource.query = "SELECT * FROM tbl_news"
                    mCustomeDataSource.load();
                
                }
                else if(currentTask == newsLOAD){
                    currentTask = intLOAD;
                    Qt.newsSQL = data;
                    //console.log("faclility load database" +JSON.stringify(data));
                    aADNOCwebservice.getNewslistings("1", mLanguageBool);
                    aADNOCwebservice.dataLoadedfour.connect(afterDataNews);
                }   
                else if(currentTask == newsDelete){
                    currentTask = contactSELECT;
                    console.log("init delte load f");
                    var data = Qt.webNEWSlist;
                    for(var j= 0; j< data.length; j++) // for(var j= 0; j< data.length; j++)
                    {
                        // console.log("INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');");
                        mCustomeDataSource.query = "INSERT INTO tbl_news (news_id, news_title, news_date, news_content, news_main_image, language_id) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].NewsDate+"','"+data[j].Summary+"', '"+data[j].MainImage+"' , '"+mLanguageBool+"');"
                        mCustomeDataSource.load();                      
                        // pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
                    }
                    Qt.webNEWSlist = "";
                    Qt.newsSQL = "";
                }
                else if(currentTask == contactSELECT){
                    
                    currentTask = contactLoad;
                    mCustomeDataSource.query = "SELECT * FROM tbl_contact"
                    mCustomeDataSource.load();
                
                }
                else if(currentTask == contactLoad){
                    currentTask = intLOAD;
                    Qt.contactSQL = data;
                    //console.log("faclility load database" +JSON.stringify(data));
                    aADNOCwebservice.getContastusList( "1", mLanguageBool);
                    aADNOCwebservice.dataLoadFinal.connect(afterDataContactUs);
                }   
                else if(currentTask == contactDelete){
                    currentTask = closeSheet;
                    console.log("init delte load f");
                    var data = Qt.webContactus;
                    for(var j= 0; j< data.length; j++) // for(var j= 0; j< data.length; j++)
                    {
                        // console.log("INSERT INTO tbl_services (service_id, title, information, phone, unique_name, keyword, latitude, longitude, image_url, distance, open_time, close_time, from_day, to_day, category_unique_name, category_main_image, category_description, language_id, station_code) VALUES ('"+data[j].ID+"','"+data[j].Title+"','"+data[j].facilityList+"','"+data[j].Phone+"','"+data[j].UniqueName+"','"+data[j].Keywords+"','"+data[j].GeoCoordinateX+"','"+data[j].GeoCoordinateY+"','"+data[j].CategoryMainImageFullURL+"','"+data[j].Distance+"','"+data[j].OpenTime+"','"+data[j].CloseTime+"','"+data[j].FromDay+"','"+ data[j].ToDay+"','"+data[j].CategoriesUniqueNameList+"','"+data[j].CategoryMainImage+"','"+data[j].CategoryDescription+"','"+mLanguageBool+"','"+data[j].StationCode+"');");
                        mCustomeDataSource.query = "INSERT INTO tbl_contact (title, sub_title, address, pobox, city, country, phone, fax, email, latitude, longitude, language_id) VALUES ('"+data[j].Title+"','"+data[j].SubTitle+"','"+data[j].ContactAddress+"','"+data[j].POBOX+"', '"+data[j].city+"' , '"+data[j].country+"' ,'"+data[j].Phone+"' , '"+data[j].Fax+"' , '"+data[j].Email+"' , '"+data[j].GeoCoordinateX+"' ,'"+data[j].GeoCoordinateY+"' , '"+mLanguageBool+"');"
                        mCustomeDataSource.load();                      
                        // pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY , data[j].StationCode, data[j].Title, data[j].Distance, data[j]);  
                    }
                    Qt.webContactus = "";
                    Qt.contactSQL = "";
                     
                }
                else if(currentTask == closeSheet){
                    currentTask = intLOAD;
                    console.log("init delte load f");
                    if(_ADNOC.isNetworkAvailable())
                    {
                        aADNOCwebservice.statisticsADNOC('', "Home", "Get");
                    }
                    loadingSheet.close();
                }
               
                  
            
            }
        }
    ]
    
    function callImageSQL()
    {
        
    }
    
    function afterdatastationList()
    {
        console.log("service load fucntion call");
        var data = aADNOCwebservice.getQVariantListData();
        Qt.webServiceData = data;
        var size = data.length;
        var Dbsize = 0;
        if(Qt.serviceDataDB != undefined)
        {
            Dbsize =Qt.serviceDataDB.length; 
        }
        
        console.log(Dbsize+"datab lengtha and websevice lengh"+size);
        
       // if () {
        
        if((data.length > Dbsize || Dbsize == 0) && _ADNOC.isNetworkAvailable())
        {
            currentTask = intDELETE;
            mCustomeDataSource.query = "DELETE FROM tbl_services"
            mCustomeDataSource.load();   
        }
        else {
            Qt.webServiceData = "";
            Qt.serviceDataDB = "";
            currentTask = imageLoadSelect;         
        }
    
    }
    
    function afterDataImageload()
    {
        var dataWEb = aADNOCwebservice.getQVariantListData();
        var size = dataWEb.length
        Qt.webHomeImage = dataWEb;
       // console.log("length of web images" +Qt.webHomeImage.length +"length of sql image" + Qt.homeImage.length);
        var Dbsize = 0;
        var data = dataWEb;
        if(Qt.homeImage != undefined)
        {
            Dbsize =Qt.homeImage.length;
            data = Qt.homeImage; 
        }
        
        if((dataWEb.length > Dbsize || Dbsize == 0) &&  _ADNOC.isNetworkAvailable())
        {
            currentTask = imgDelete;
            mCustomeDataSource.query = "DELETE FROM tbl_homeimages"
            mCustomeDataSource.load();   
        }
        else {
            currentTask = facilitySELECT;  
        }
              
        if(data.length == imageCount){
            imageCount = 0      
        }
        
        console.log("images" + JSON.stringify(data[imageCount].MainImageFullURL));
        bannerImage.html =  "<html><head><title>hi</title></head>" + 
        "<body>" +
        "<img src='"+data[imageCount].MainImageFullURL+"' alt='web pic' height ='350px' width='100%'>" +
        "</body>" +
        "</html>";
        
        imageCount = imageCount+1;
        
        console.log("images imageCount" + imageCount);
    
    }
    
    function afterdatafacilityList()
    {
        var dataWEb = aADNOCwebservice.getQVfacilityData();
        var size = dataWEb.length
        Qt.webFacility = dataWEb;
        // console.log("length of web images" +Qt.webHomeImage.length +"length of sql image" + Qt.homeImage.length);
        var Dbsize = 0;
        var data = dataWEb;
        if(Qt.facilitySQl != undefined)
        {
            Dbsize =Qt.facilitySQl.length;
        }
        console.log(Dbsize+"datab lengtha and websevice lengh"+size);
        
        if((data.length > Dbsize || Dbsize == 0) && _ADNOC.isNetworkAvailable())
        {
            currentTask = facDelete;
            mCustomeDataSource.query = "DELETE FROM tbl_facilitynew"
            mCustomeDataSource.load();   
        }
        else {
            Qt.facilitySQl = "";
            Qt.webFacility = "";
            currentTask = facDelete;         
        }
        
    }
    
    function afterDataNews(){
        
        var dataWEb = aADNOCwebservice.getQVariantListData();
        var size = dataWEb.length
        Qt.webNEWSlist = dataWEb;
        
        var Dbsize = 0;
        var data = dataWEb;
        if(Qt.newsSQL != undefined)
        {
            Dbsize =Qt.newsSQL.length;
        }
        console.log(Dbsize+"datab lengtha and websevice lengh"+size);
        
        if((dataWEb.length > Dbsize || Dbsize == 0) && _ADNOC.isNetworkAvailable())
        {
            currentTask = newsDelete;
            mCustomeDataSource.query = "DELETE FROM tbl_news"
            mCustomeDataSource.load();   
        }
        else {
            Qt.webNEWSlist = "";
            Qt.newsSQL = "";
            currentTask = newsDelete;         
        }
    }
    
    function afterDataContactUs(){
        
        var dataWEb = aADNOCwebservice.getQVariantListData();
        var size = dataWEb.length
        Qt.webContactus = dataWEb;
        
        var Dbsize = 0;
        var data = dataWEb;
        if(Qt.contactSQL != undefined)
        {
            Dbsize =Qt.contactSQL.length;
        }
        console.log(Dbsize+"datab lengtha and websevice lengh"+size);
        
        if((dataWEb.length > Dbsize || Dbsize == 0) && _ADNOC.isNetworkAvailable())
        {
            currentTask = contactDelete;
            mCustomeDataSource.query = "DELETE FROM tbl_contact"
            mCustomeDataSource.load();   
        }
        else {
            Qt.webContactus = "";
            Qt.contactSQL = "";
            currentTask = contactDelete;         
        }
        
        //Qt.contactSQL 
    }
    
    
    
}

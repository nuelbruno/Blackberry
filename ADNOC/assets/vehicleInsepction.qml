import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import QtMobility.sensors 1.2

Page {
    property string mLanguageBool
    property string mLanguageCode
    
    
    onCreationCompleted: {
        
        var longitude = _ADNOC.getValueFor("longitude", "")
        var latitude = _ADNOC.getValueFor("latitude", "")
        console.debug("lat :", latitude)
        console.debug("long :", longitude)
        mapview.latitude = latitude
        mapview.longitude = longitude

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
                
                text: qsTr("Vehicle Inspection") + Retranslate.onLanguageChanged
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
                //active: aADNOCwebservice.active
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
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        topPadding: 0.0
                        leftPadding: 0.0
                        rightPadding: 0.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Container {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 4
                            }
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            leftPadding: 20.0
                            topPadding: 0.0
                            layout: DockLayout {
                            }
                            ImageView {
                                horizontalAlignment: HorizontalAlignment.Left
                                imageSource: "asset:///images/common/bgTextField@2x.png"
                                preferredWidth: 600
                            }
                            TextField {
                                id: search
                                backgroundVisible: false
                                preferredWidth: 560
                            
                            }
                            Container {
                                rightMargin: 10.0
                                rightPadding: 10.0
                                topMargin: 13.0
                                topPadding: 13.0
                                horizontalAlignment: HorizontalAlignment.Right
                                //verticalAlignment: VerticalAlignment.Center
                                ImageView {
                                    imageSource: "asset:///images/common/icnSearch.png"
                                    preferredHeight: 40
                                    preferredWidth: 40
                                
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
                        }
                    }
                
                }
                // ################### MAP VIEW CONTAINER ######################### //
                Container {
                    id: mapcontainerLayout
                    layout: AbsoluteLayout {
                    }
                    preferredWidth: 770
                    preferredHeight: 1050
                    background: Color.create(0.5, 0.5, 0.5)
                    visible: true
                    MapView {
                        id: mapview
                        altitude: 90000
                        visible: true
                        //mapData:  
                        // latitude: latitude //45.342614
                        //longitude: longitude //-75.914991
                        latitude: 25.111917 //45.342614
                        longitude: 55.385406 //-75.914991
                        onRequestRender: {
                            pinContainer.updateMarkers();
                        }
                        onCreationCompleted: {
                            //_ADNOC.manipulateMapView();
                            
                        }
                    }
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
                        function addPin(lat, lon) {
                            var marker = pin.createObject();
                            marker.lat = lat;
                            marker.lon = lon;
                            Qt.latitude = lat;
                            Qt.longitude = lon;
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
                        dataModel: aADNOCwebservice.modelPlateList
                        scrollRole: ScrollRole.Default
                        
                        listItemComponents: [
                            
                            ListItemComponent {
                                type: ""
                                
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
                                            orientation: LayoutOrientation.LeftToRight
                                        }
                                        
                                        ImageView {
                                            horizontalAlignment: HorizontalAlignment.Center
                                            verticalAlignment: VerticalAlignment.Center
                                            imageSource: "asset:///images/icons/imgVehicleInspection@2x.png"
                                        
                                        }
                                        Container {
                                            id: subcontainer
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            verticalAlignment: VerticalAlignment.Fill
                                            layout: StackLayout {
                                                orientation: LayoutOrientation.TopToBottom
                                            }
                                            Label {
                                                id: leavAppNumberID
                                                text: ListItemData.getCreatedBy +" - "+ListItemData.getCreatedDate
                                                horizontalAlignment: HorizontalAlignment.Center
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
                                            
                                            }
                                            Label {
                                                //id: leavAppNumberID
                                                text: ListItemData.getPublished + qsTr(" Km Away") + Retranslate.onLanguageChanged
                                                horizontalAlignment: HorizontalAlignment.Center
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
                                            
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
                    var longitude = _ADNOC.getValueFor("longitude", "")
                    var latitude = _ADNOC.getValueFor("latitude", "")
                    Qt.CurrentLatitude =  "25.111917";
                    Qt.CurrentLongitude =  "55.385406";
                    pinContainer.addPin(Qt.CurrentLatitude, Qt.CurrentLongitude);  
                    aADNOCwebservice.searchNearByLocation(Qt.CurrentLatitude, Qt.CurrentLongitude, "1", "vehicleinspection" , "MAP");
                    aADNOCwebservice.dataLoadedSec.connect(afterdatastationList);
                }
                function afterdatastationList()
                {
                    var data = aADNOCwebservice.getQVariantListData();
                    var size = data.length
                    for(var j= 0; j< data.length; j++)
                    {
                        console.debug("absence code   profile data length......"+ data[j].GeoCoordinateX); 
                        pinContainer.addPin(data[j].GeoCoordinateX, data[j].GeoCoordinateY);  
                    
                    }
                }
            
            
            
            } // main container
        }
    }
    
    
    actions: [
        
        ActionItem {
            id: listAct
            title: "List"
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
                    listAct.title ="Map";
                    listAct.imageSource = "asset:///images/icons/imgMapWhite@2x.png";
                    listViewContainer.visible = true;
                    mapcontainerLayout.visible = false;
                }
                else if(listAct.accessibility.name == "Map")
                {
                    listAct.accessibility.name = "list"; 
                    listAct.title ="List";
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
        }
    ]
}

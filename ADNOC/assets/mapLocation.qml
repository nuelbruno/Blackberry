import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import QtMobility.sensors 1.2
import bb.platform 1.0


Page {
    property string mLanguageBool
    property string mLanguageCode
    
    function passMappinData(data, method)
    {
        
        var longitude = _ADNOC.getValueFor("longitude", "");
        var latitude = _ADNOC.getValueFor("latitude", "");
        
        latitude =  "25.111917";
        longitude =  "55.385406";
        
        var getLatitude;
        var getLongitude;
        
        
        if(method == 1)
        {
            console.log("test data"+data.latitude); 
            getLatitude = data.latitude;
            getLongitude = data.longitude;
        }
        else if(method == 0){
            console.log("test data"+data["GeoCoordinateX"]); 
            getLatitude = data["GeoCoordinateX"];
            getLongitude = data["GeoCoordinateY"];
        }
        else if(method == 2){
            console.log("test data"+data.getTitle); 
            getLatitude = data.getTitle;
            getLongitude = data.getStationID;
        }
        
        routeInvokerID.startLatitude = latitude;
        routeInvokerID.startLongitude = longitude;
        routeInvokerID.endLatitude = getLatitude;
        routeInvokerID.endLongitude = getLongitude;
        routeInvokerID.centerLatitude = latitude;
        routeInvokerID.centerLongitude = longitude;
        routeInvokerID.go();
    
    }
    
    onCreationCompleted: {
        
        
        
       

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
                
                text: qsTr("Direction") + Retranslate.onLanguageChanged
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
                
                // ################### MAP VIEW CONTAINER ######################### //
                CommonLabel {
                    id: stationDistance
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    text: "Route invoker opened"
                    textStyle.color: Color.create("#000000")                    
                }
                    
               
            } // main container
        }
    }
    
    
    
    attachedObjects: [
        ImagePaintDefinition {
            id: mBgsearchImagePaint
            imageSource: "asset:///images/common/bgSearchBar.png"
        },    
        ADNOCwebservice {
            id: aADNOCwebservice
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
        },
        RouteMapInvoker {
            id: routeInvokerID  
            avoidHighwaysEnabled : true

        }
    ]
}

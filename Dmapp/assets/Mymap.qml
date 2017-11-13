// ***********************************************************************************************************
// COMMON MAP VIEW TO USE IN ALL PAGES
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import bb.cascades.maps 1.0
import "common"

    Container {
        onCreationCompleted: {
            _mWebServiceinstance.getMyObject(mMapView);
        }
        MapView {
            id: mMapView
            objectName: "mMapView"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            preferredHeight: 1100
            latitude: 25.2000
            longitude: 55.3000
            altitude: 3000
            onCaptionLabelTapped: {
                dialog.open()
            }

        }
        attachedObjects: [
            Dialog {
                id: dialog
                LocationInfo {
                    id: mlocation
                
                }
            }
        ]
    }
    



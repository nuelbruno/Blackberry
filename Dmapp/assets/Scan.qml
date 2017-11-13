// ***********************************************************************************************************
//  SCANING MAKANI NUMBER MAIN CONTAINER
//
//
// ***********************************************************************************************************
import bb.cascades 1.3
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
import bb.system 1.2
Page {
    id: page
    property string myUAENGValue
    property string myCapturedText
    // OPEN CAMERA ON CREATION OF THIS PAGE
    onCreationCompleted: {
        //  _mWebServiceinstance.ClearMapdata()
        camera.open()
        
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill

        layout: DockLayout {
        }

        //! [0]
        // The camera preview control
        Container {
            background: Color.DarkCyan
            preferredHeight: 1280
            preferredWidth: 768
            // SETUP CAMERA TO READ DATA 
            Camera {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                id: camera
                onCameraOpened: {
                    // Apply some settings after the camera was opened successfully
                    getSettings(cameraSettings)
                    cameraSettings.focusMode = CameraFocusMode.ContinuousAuto
                    cameraSettings.shootingMode = CameraShootingMode.Stabilization
                    applySettings(cameraSettings)
                    _mWebServiceinstance.ClearMapdata()
                    // Start the view finder as it is needed by the barcode detector
                    camera.startViewfinder()
                }
            }
        }
        Container {
            verticalAlignment: VerticalAlignment.Bottom
            Label {
                id: resultLabel
                visible: false
            }
        }
    }
    
    // BARCODE FUNCTION TO GET AND VALUES AND PASS TO WEBSERVICE AND SHOW THAT IN MAP
    attachedObjects: [
        BarcodeDetector {
            id: barcodeDetector
            camera: camera
            formats: BarcodeFormat.Any
            onDetected: {
                //console.log("bar code scan value" + data);
                if (resultLabel.text != data) {
                    resultLabel.text = data;
                    
                    resultLabel.text = resultLabel.text.substring( resultLabel.text.lastIndexOf("=")+ 1 );
                    
                    console.log("sptted value scan" + resultLabel.text);

                    var myResult = _mWebServiceinstance.checkInvalid(resultLabel.text.replace(" ", ""))
                    console.log("sptted value myResult" + myResult);
                    // var myResult = _mWebServiceinstance.checkScanResult(resultLabel.text.replace(" ", ""))

                    if (myResult == "number") {
                        _mWebServiceinstance.GetBuildingInfo(resultLabel.text)
                        camera.close()
                        mNavigationPaneMain.pop()
                        mainTabPaned.changeTab(0);

                    } else if (myResult == "UAENG") {

                        _mWebServiceinstance.ClearMapdata();
                        var  myUAENGValue = _mWebServiceinstance.ConvertToUAENG(resultLabel.text);
                        _mWebServiceinstance.UAENGtoCoordinates(myUAENGValue, "", "Search")

                        camera.close()
                        mNavigationPaneMain.pop()
                        mainTabPaned.changeTab(0);

                    } else if (myResult == "landnumber") {
                        _mWebServiceinstance.GetParcelOutline_New(resultLabel.text)
                        camera.close()
                        mNavigationPaneMain.pop()
                        mainTabPaned.changeTab(0);
                    } else {
                        mSystemDialog.body = mallstring.mqmlToastemptyValueUAENG
                        mSystemDialog.show()
                    }
                }
            }
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mallstring.mDialogOk
        },
        SystemSound {
            id: scannedSound

            sound: SystemSound.GeneralNotification
        },
        CameraSettings {
            id: cameraSettings
        },
        AllStrings {
            id: mallstring
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            onTriggered: {
                camera.close()
                mNavigationPaneMain.peekEnabled = true;
                mNavigationPaneMain.pop();
            }
        }
    }
}

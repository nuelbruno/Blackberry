import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
import bb.cascades 1.2
import bb.system 1.2

Page {
   // property int countPhoto
    property int countPhoto: 10;
   
    function inputData(myArray)
    {
        console.log("input----------------------- : " +myArray);
       
    }
    
    titleBar: TitleBar {
        title: "Take Photo"
    }
    
   
    
    content: Container {
        attachedObjects: [
            SystemToast {
                id: qmlToast
            }
        ]
        
        Container {
            // The QML Camera object.
            Camera {
                id: qmlCameraObj
                property bool photoBeingTaken
                
                attachedObjects: [
                    // Required to play the shutter sound.
                    SystemSound {
                        id: shutterSound
                        sound: SystemSound.CameraShutterEvent
                    },
                    CameraSettings {
                        id: camSettings
                        onFlashModeChanged: {
                            displayFlashMode(camSettings.flashMode);
                        }
                    }
                ]
                
                onTouch: {
                    if (photoBeingTaken == false) {
                        photoBeingTaken = true;
                        qmlCameraObj.capturePhoto();
                    }
                }
                
                // In many countries the law requires that a
                // shutter-sound be played when an app is taking
                // pictures. Further, if you're planning on
                // submitting your app to BlackBerry World, then
                // it's required that it must play the shutter
                // sound when taking photos.
                onShutterFired: {
                    shutterSound.play();
                }
                
                onCameraOpened: {
                    // Once the camera is opened, start
                    // the viewfinder.
                    qmlCameraObj.startViewfinder();
                   // qmlCameraObj.attachedObjects();
                    //qmlCameraObj.objectName();
                }
                
                onCameraOpenFailed: {
                    // Report the failure.
                    qmlToast.body = "Camera failed to open";
                    qmlToast.show();
                    
                    return;
                }
                
                onViewfinderStarted: {
                    photoBeingTaken = false;
                }
                
                onViewfinderStartFailed: {
                    qmlToast.body = "View finder could not start";
                    qmlToast.show();
                    
                    return;
                }
                
                onPhotoCaptureFailed: {
                    qmlToast.body = "Photo could not be taken";
                    qmlToast.show();
                    photoBeingTaken = false;
                    
                    return;
                }
                
                onPhotoSaveFailed: {
                    qmlToast.body = "Photo could not be saved";
                    qmlToast.show();
                    photoBeingTaken = false;
                }
                
                onPhotoSaved: {
                   
                    Qt.iamgecouny =  Qt.iamgecouny +1;
                    if(Qt.iamgecouny == 1)
                    {
                        Qt.image1upload = fileName;
                    }
                    else if(Qt.iamgecouny == 2)
                    {
                        Qt.image2upload = fileName;
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
                    
                   
                       
                    qmlToast.body = "Photo successfully saved";
                    console.debug(Qt.iamgecouny+"qmlCameraObj qmlCameraObj-2-------------------------------- :"+fileName);
                    
                    _ADNOC.manipulatePhoto(fileName, Qt.iamgecouny, delimage1, delimage2, 1);
                    
                    qmlToast.show();
                    photoBeingTaken = false;
                }
            }
            
            onCreationCompleted: {
                
                var cameraUnit =
                getCameraUnit(qmlCameraObj.supportedCameras);
                
                if (cameraUnit == null) {
                    qmlToast.body = "No camera units were found";
                    qmlToast.show();
                    
                    return;
                } else {
                    qmlCameraObj.open(cameraUnit);
                }
            }
        }
    }
    
    // Actions menu.
    actions: [
        ActionItem {
            title: "Flash Mode: Off"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                qmlCameraObj.getSettings(camSettings);
                camSettings.flashMode = CameraFlashMode.Off;
                qmlCameraObj.applySettings(camSettings);
            }
        },
        ActionItem {
            title: "Flash Mode: On"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                qmlCameraObj.getSettings(camSettings);
                camSettings.flashMode = CameraFlashMode.On;
                qmlCameraObj.applySettings(camSettings);
            }
        },
        ActionItem {
            title: "Flash Mode: Auto"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                qmlCameraObj.getSettings(camSettings);
                camSettings.flashMode = CameraFlashMode.Auto;
                qmlCameraObj.applySettings(camSettings);
            }
        },
        ActionItem {
            title: "Flash Mode: Light"
            ActionBar.placement: ActionBarPlacement.InOverflow
            onTriggered: {
                qmlCameraObj.getSettings(camSettings);
                camSettings.flashMode = CameraFlashMode.Light;
                qmlCameraObj.applySettings(camSettings);
            }
        }
    ]
    
    // This function returns an accessible camera unit. It
    // starts by first checking to see if the Rear camera
    // unit is available and if it's accessible, it's
    // returned. If not, then it checks to see if the front
    // camera unit is available, and again, if it's accessible
    // it's returned. If there are no accessible camera units,
    // this function returns null and shows a toast to the user.
    function getCameraUnit(camUnitList) {
        // Find a supported camera unit.
        if (camUnitList.length == 0 ||
        camUnitList[0] == CameraUnit.None) {
            // Show a message toast.
            qmlToast.body = "No camera units are accessible";
            qmlToast.show();
            
            return null;
        }
        
        // We prefer to have the Rear camera unit open first,
        // so we test for that one first, and if we find it, we
        // return it. Otherwise, we'll look for the Front camera
        // unit, and if we find it, we'll return it.
        for (var i = 0; i < camUnitList.length; ++ i) {
            if (camUnitList[i] == CameraUnit.Rear)
                return camUnitList[i];
        }
        
        for (var j = 0; j < camUnitList.length; ++ j) {
            if (camUnitList[i] == CameraUnit.Front)
                return camUnitList[i];
        }
    }
    
    // Displays the current flash mode in a system toast.
    function displayFlashMode(flashMode) {
        var newFlashMode = "Flash Mode: Error";
        
        switch (flashMode) {
            case 0:
                newFlashMode = "Flash Mode: Off";
                break;
            
            case 1:
                newFlashMode = "Flash Mode: On";
                break;
            
            case 2:
                newFlashMode = "Flash Mode: Auto";
                break;
            
            case 3:
                newFlashMode = "Flash Mode: Light";
                break;
        }
        
        // Show a message toast.
        qmlToast.body = newFlashMode;
        qmlToast.show();
    }
}
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0
import bb.cascades 1.2
import bb.system 1.2
import CustomTimer 1.0

Page {
    // ...
    property string mLanguageCode
    property int timerecord : 5;
    property int recordVideocount : 0;
    
    //property int recordingLimit : 0;
    
    onCreationCompleted: {
        recordVideocount = 0;
        
    }
    content: Container {    
        attachedObjects: [
            
            SystemToast {
                id: qmlToast
            },
            SystemSound {
                id: videoStartSnd
                sound: SystemSound.RecordingStartEvent
            },
            SystemSound {
                id: videoStopSnd
                sound: SystemSound.RecordingStopEvent
            },
            SystemDialog {
                id: maxlimitmediaV
                title: qsTr("Alert") + Retranslate.onLanguageChanged
                body: qsTr("Maximum Limit reached") + Retranslate.onLanguageChanged
                cancelButton.label: undefined
                confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                //buttons: [ok]
                onFinished: {
                
                }
            },
            SystemDialog {
                id: videorecortComalert
                title: qsTr("Alert") + Retranslate.onLanguageChanged
                body: qsTr("Recording Completed") + Retranslate.onLanguageChanged
                cancelButton.label: undefined
                confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
                //buttons: [ok]
                onFinished: {
                
                }
            },
            TimerCount {
                id: videoTimer
                
                
                interval: 1000
                onTimeout: {
                    console.debug("counter timer-+++++++++++++++++++++++++++++++++++++:");
                    // Decrement the counter and update the countdown text
                    
                    qmlCameraObj.initCount += 1;
                    if(timerecord != 0)
                    {
                        timerecord = timerecord -1;
                    }
                    
                    
                    timeshow.title = timerecord;
                    
                    
                    if (qmlCameraObj.initCount == 6) {
                        
                        videoTimer.stop();
                        qmlCameraObj.initCount = 0;
                        stopVideoRecording();
                        videorecortComalert.show();
                        aiRecordStop.title = (mLanguageCode == 'en')? "Record" : "سجل";
                        aiRecordStop.accessibility.name = "Record";
                        aiRecordStop.imageSource = "asset:///images/camersBigTab.png";
                                                             
                    }
                } // end of onTimeout signal handler
            } // end of Timer  
        ]
        
        Container {
            Camera {
                id: qmlCameraObj
                
                attachedObjects: [
                    CameraSettings {
                        id: cameraModeSetting
                    }
                ]
                property int initCount : 0    
                onCreationCompleted: {
                    open(CameraUnit.Rear)
                }
                onCameraOpened: {
                    qmlCameraObj.getSettings(cameraModeSetting)
                    cameraModeSetting.cameraMode = CameraMode.Video
                    qmlCameraObj.applySettings(cameraModeSetting)
                    
                    qmlCameraObj.startViewfinder()
                   
                    
                }
                onVideoCaptureStopped :{
                    recordVideocount = recordVideocount + 1;
                    Qt.videoRecordLimit =  Qt.videoRecordLimit + 1;
                    console.debug(recordVideocount+"video file name after stoping in qml file update------------------------------- :"+Qt.iamgecouny);
                    if(Qt.videoRecordLimit <= 3)
                    {
                        if(recordVideocount == 1)
                        {
                            Qt.iamgecouny =  Qt.iamgecouny +1; 
                            if(Qt.iamgecouny == 1)
                            {
                                Qt.video1upload = fileName;
                                //console.debug("video file name after stoping in qml file update------------------------------- :");
                            }
                            else if(Qt.iamgecouny == 2)
                            {
                                Qt.video2upload = fileName;
                            }
                            else if(Qt.iamgecouny == 3)
                            {
                                Qt.video3upload = fileName;
                            }
                            else if(Qt.iamgecouny == 4)
                            {
                                Qt.video4upload = fileName;
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
                            else if(Qt.DeleteImageCount3 != 0)
                            {
                                var delimage3 = 3;
                                Qt.DeleteImageCount3 = 0;
                            }
                            else if(Qt.DeleteImageCount4 != 0)
                            {
                                var delimage4 = 4;
                                Qt.DeleteImageCount4 = 0;
                            }
                            _MOL.manipulatePhoto(fileName, Qt.iamgecouny, delimage1, delimage2, delimage3, delimage4, 2);
                         } 
                     }
                    else {
                        maxlimitmediaV.show();
                    } 
                    
                   
                }
                onVideoCaptureStarted:{
                    
                }
                
                
                // ...
            
            } // End of Camera definition.
        } // End of Container definition.
    } // End of Container definition.
    actions: [
        ActionItem {
            id: aiRecordStop
            title: qsTr("Record")
            accessibility.name: "Record"
            
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/camersBigTab.png"
            onTriggered: {
                toggleRecordStopItems()
                
            }
         } ,  
        ActionItem {
            id: timeshow
            title: timerecord
            ActionBar.placement: ActionBarPlacement.OnBar
            imageSource: "asset:///images/Timer.png"
        }
        // ...
        ]
            
            // Toggles the Record/Stop action item title,
            // accessible name, and action.
            function toggleRecordStopItems() {
                mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");
                if (aiRecordStop.accessibility.name == "Record") {
                     if(Qt.videoRecordLimit <= 2)
                    {
                        if(recordVideocount == 0)
                        {
                        aiRecordStop.title = (mLanguageCode == 'en')? "Stop" : "توقف";
                        aiRecordStop.accessibility.name = "Stop";
                        aiRecordStop.imageSource = "asset:///images/camersBigTab.png";
                        startVideoRecording()
                        }
                        else 
                        {
                            videorecortComalert.show();  
                        }
                    } 
                     else {
                         maxlimitmediaV.show();
                     }  
                    
                    
                } else {
                    aiRecordStop.title = (mLanguageCode == 'en')? "Record" : "سجل";
                    aiRecordStop.accessibility.name = "Record";
                    aiRecordStop.imageSource = "asset:///images/camersBigTab.png";
                    
                    stopVideoRecording();
                }
            }
            
            function startVideoRecording() {
                videoStartSnd.play()
                videoTimer.start()
                qmlCameraObj.startVideoCapture()
                
            }
            
            function stopVideoRecording() {
                videoStopSnd.play()
                videoTimer.stop()
                qmlCameraObj.stopVideoCapture()
               
               
            }
            paneProperties: NavigationPaneProperties {
                backButton: ActionItem {
                    title: qsTr("Back") + Retranslate.onLanguageChanged
                    onTriggered: {
                        
                        navigationPane.peekEnabled = true;
                        navigationPane.pop();
                    }
                }
            }
              
} // End of Page definition.
/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb.system 1.0
import CustomTimer 1.0
import "common"

TabbedPane {
    showTabsOnActionBar: true
    property variant dynamicSheet;
    property variant langaugecode;
    property int countsheetopen;
    property int initCount;
    
    
    
    
    
    
    Tab { //First tab
        // Localized text with the dynamic translation and locale updates support
        id: tab1
        title: qsTr("About Us") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/tab/about.png"
        delegate: Delegate {
            id: tabDelegate1
            source: "About.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of first tab
    Tab { //Second tab
        id: tab2
        title: qsTr("Media") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/tab/news.png"
        delegate: Delegate {
            id: tabDelegate2
            source: "Media.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of second tab
    Tab { //Second tab
        id: tab3
        title: qsTr("Contact Us") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/tab/contact.png"
        
        delegate: Delegate {
            id: tabDelegate3
            source: "ContactUs.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of second tab
    Tab { //Second tab
        id: tab4
        title: qsTr("Report") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/tab/report.png"
        delegate: Delegate {
            id: tabDelegate4
            source: "Report.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of second tab
    Tab { //Second tab
        id: tab5
        title: qsTr("Useful Links") + Retranslate.onLocaleOrLanguageChanged
        imageSource: "asset:///images/tab/links.png"
        delegate: Delegate {
            id: tabDelegate5
            source: "UsefulLinks.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of second tab
    Tab { //Second tab
        id: tab6
        title: qsTr("Settings") + Retranslate.onLocaleOrLanguageChanged
        //imageSource: "asset:///images/links.png"
        delegate: Delegate {
            id: tabDelegate6
            source: "Settings.qml"
        }
        delegateActivationPolicy: TabDelegateActivationPolicy.None
    } //End of second tab
    
    
    
    
    onCreationCompleted: { 
        
           
        
           // _smsexample.sendSMS("fdsf", "2222");
       
        
        /*if(language == "false"){
        initCount = initCount+1;
        console.debug(' init count signal--------' );
        }
        else 
        {
            tabDelegate1.active = true;  
        }*/
       /* var language = _MOL.getValueFor("SelectLanguage", "false");
        var homeopen = _MOL.getValueFor("homechount", "false");
       
        if(homeopen=="false" && language != "true"){
            
           // mySheet.open();
             dynamicSheet = dynSheet.createObject();
             dynamicSheet.open();
             
             console.debug('langauge code set toture or not --------' +language );
             var homeopen1 = _MOL.getValueFor("homechount", "false");
             if(homeopen1 == "true")
             {
                 _MOL.saveValueFor("SelectLanguage", "true");
                 _MOL.saveValueFor("homechount", "false");
             }else 
             {
               _MOL.saveValueFor("homechount", "true");
             }
            
            
        }
        else 
        {
            tabDelegate1.active = true;  
        }
        
         //mySheet.open();
        
       
         //tabDelegate1.active = true;
        mLanguageCode = _MOL.getValueFor("mLanguageCode", "en");*/
        
    }
    
    onInitCountChanged: {
        console.debug(' init count signal--------' );
        
        if(!mySheet.opened)
        {
         // mySheet.open();
        }
        //dynamicSheet = dynSheet.createObject();
        //dynamicSheet.open();
       
        
    }
    
    function handleSheetClosed() {
               
           dynamicSheet.destroy(); // This is the culprit line.        
    }
    
   
    
    
    onActiveTabChanged: {
       
        if (activeTab == tab1) {
            tabDelegate1.active = true;
            tabDelegate2.active = false;
            tabDelegate3.active = false;
            tabDelegate4.active = false;
            tabDelegate5.active = false;
            tabDelegate6.active = false;
        }
        if (activeTab == tab2) {
            tabDelegate1.active = false;
            tabDelegate2.active = true;
            tabDelegate3.active = false;
            tabDelegate4.active = false;
            tabDelegate5.active = false;
            tabDelegate6.active = false;
        }
        if (activeTab == tab3) {
            tabDelegate1.active = false;
            tabDelegate2.active = false;
            tabDelegate3.active = true;
            tabDelegate4.active = false;
            tabDelegate5.active = false;
            tabDelegate6.active = false;
        }
        if (activeTab == tab4) {
            tabDelegate1.active = false;
            tabDelegate2.active = false;
            tabDelegate3.active = false;
            tabDelegate4.active = true;
            tabDelegate5.active = false;
            tabDelegate6.active = false;
        }
        if (activeTab == tab5) {
            tabDelegate1.active = false;
            tabDelegate2.active = false;
            tabDelegate3.active = false;
            tabDelegate4.active = false;
            tabDelegate5.active = true;
            tabDelegate6.active = false;
        }
        if (activeTab == tab6) {
            tabDelegate1.active = false;
            tabDelegate2.active = false;
            tabDelegate3.active = false;
            tabDelegate4.active = false;
            tabDelegate5.active = false;
            tabDelegate6.active = true;
        }
    }
     
    attachedObjects: [
        //ComponentDefinition {
            //id: dynSheet
        Sheet {
            id: mySheet
            property  bool finished : false
            
            content: Page {
                Container {
                    id: rootcon
                    //visible: false
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: DockLayout {
                    }
                    
                    
                    onCreationCompleted: {
                        
                        var loadlater = _MOL.getValueFor("loadlater", "false");
                    
                        if(loadlater == "true")
                          {
                              var language = _MOL.getValueFor("SelectLanguage", "false");
                              if(language == "false")
                              {
                                mySheet.open(); 
                               //_MOL.saveValueFor("SelectLanguage", "true");
                              }
                              else {
                                  tabDelegate1.active = true; 
                              }
                          }
                          _MOL.saveValueFor("loadlater", "true");    
                            
                        
                    }
                    
                    ImageView {
                        imageSource: "asset:///images/splash_bg.png"
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                    }
                    
                    Container {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                        topPadding: 220.0
                        leftPadding: 198.0
                        rightPadding: 198.0
                        layout: StackLayout {
                        }
                        
                        Container {
                            topPadding: 0.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            ImageButton {
                                id: mImageButtonArabic
                                horizontalAlignment: HorizontalAlignment.Left
                                defaultImageSource: "asset:///images/ar.png"
                                onClicked: {
                                    mySheet.finished = true;
                                    // If the Sheet is opened, we close it
                                    
                                    mySheet.close();
                                    //handleSheetClosed();
                                                                       
                                    _MOL.updateLocale("ar");
                                    _MOL.saveValueFor("mLanguageCode", "ar");
                                    console.debug('langage code --------'+_MOL.getValueFor("mLanguageCode", "en"));
                                    tabDelegate1.active = true;
                                    _MOL.saveValueFor("SelectLanguage", "true");
                                    
                                    
                                }
                            
                            }
                        }    
                        Container {
                            topPadding: 0.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            ImageButton {
                                id: mImageButtonEnglish                   
                                horizontalAlignment: HorizontalAlignment.Right
                                defaultImageSource: "asset:///images/en.png"
                                
                                onClicked: {
                                    mySheet.finished = true;
                                    // If the Sheet is opened, we close it
                                    
                                    mySheet.close();
                                    //handleSheetClosed();
                                    
                                    _MOL.updateLocale("en-US");
                                    _MOL.saveValueFor("mLanguageCode", "en");
                                    console.debug('langage code --------'+_MOL.getValueFor("mLanguageCode", "en"));
                                    tabDelegate1.active = true;
                                    _MOL.saveValueFor("SelectLanguage", "true");
                                    
                                }
                            }
                        }    
                    
                    } // end Container
                }
             }
             onOpened: {
                
                 //mySheet.close();
                 
                
             }
             onClosed: {
                 close();
                 destroy();
                 
             }
            }
     // }
    ]
}

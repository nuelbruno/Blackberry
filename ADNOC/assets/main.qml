/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
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
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"


NavigationPane {
    id: mNavigationPaneMain
Page {
    property string mLanguageBool
    property string mLanguageCode
    
   onCreationCompleted: {
       Qt.employeeIDset = '';
       mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
     
   }
  
    
    
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        layout: DockLayout {
        }
        
        
        ImageView {
            imageSource: "asset:///images/background/bgLanguage-568h@2x.png"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
        }
       
        Container {
            id: loginContentMain
            verticalAlignment: VerticalAlignment.Fill
            horizontalAlignment: HorizontalAlignment.Fill
            layout: DockLayout {
            }
            Container {
                id: loginContent
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
                // topPadding: 350.0
                //background: Color.create("#333333")
                bottomPadding: 90.0
                //minWidth: 500
                // maxWidth: minWidth
                preferredWidth: 300
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    id: engslihContainer
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Left
                    preferredWidth: 150
                    preferredHeight: 60
                    background: Color.create("#ffffff")
                    Label {
                        //rightMargin: 10
                        preferredWidth: 150
                        preferredHeight: 120
                        horizontalAlignment: HorizontalAlignment.Center
                        verticalAlignment: VerticalAlignment.Center
                        text: " English"
                        onTouch: {
                            if(event.isUp())
                            {
                                _ADNOC.updateLocale("en");
                                _ADNOC.saveValueFor("mLanguageCode", "en");
                                var landingPage = mLandingpagePush.createObject(); 
                                mNavigationPaneMain.pop(); 
                                mNavigationPaneMain.push(landingPage); 
                            } 
                        
                        }
                     }
                }
                Container {
                    id: arabicContainer
                    leftMargin: 10.0
                    leftPadding: 10.0
                    preferredWidth: 150
                    preferredHeight: 60
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Right
                    background: Color.create("#ffffff")
                    Label {
                        //leftMargin: 10
                        preferredWidth: 150
                        preferredHeight: 120
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Arabic"
                        onTouch: {
                            if(event.isUp())
                            {
                                    _ADNOC.updateLocale("ar");
                                    _ADNOC.saveValueFor("mLanguageCode", "ar");
                                    var landingPage = mLandingpagePush.createObject(); 
                                    mNavigationPaneMain.pop(); 
                                    mNavigationPaneMain.push(landingPage); 
                            } 
                        
                        }
                    }
                }
            

           
         } // login container
        } 
        
    }  
    
    
    
       
    // ###########  other list ######## //
    attachedObjects: [      
        
        ComponentDefinition {
            id: mLandingpagePush
            source: "Landingscreen.qml"
        }
    ]  
}
}

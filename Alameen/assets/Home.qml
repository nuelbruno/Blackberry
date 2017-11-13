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


Sheet {
            id: mySheet
            //property finished bool: false
            content: Page {
                Container {
                    id: rootcon
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: DockLayout {
                    }
                    onCreationCompleted: {
                        //mySheet.open(); 
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
                                    
                                    
                                    mySheet.close();
                                    
                                    _MOL.updateLocale("ar");
                                    _MOL.saveValueFor("mLanguageCode", "ar");
                                    console.debug('langage code --------'+_MOL.getValueFor("mLanguageCode", "en"));
                                    if (mySheet.opened) {
                                        mySheet.close();
                                    }
                                    tabDelegate1.active = true;
                                    
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
                                    
                                    mySheet.close();
                                    
                                    _MOL.updateLocale("en-US");
                                    _MOL.saveValueFor("mLanguageCode", "en");
                                    console.debug('langage code --------'+_MOL.getValueFor("mLanguageCode", "en"));
                                    if (mySheet.opened) {
                                        mySheet.close();
                                    }
                                    tabDelegate1.active = true;
                                    
                                }
                            }
                        }    
                    
                    } // end Container
                }
             }
             onOpened: {
                 //close();
             }
            }
        
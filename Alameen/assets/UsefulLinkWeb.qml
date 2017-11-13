/* Copyright (c) 2012, 2013  BlackBerry Limited.
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
import bb.cascades 1.0


Page {
    id: webUsefullink
    property  string  subCatValue
   
    titleBar: TitleBar {
        id: addBar
        title: qsTr("Useful Links") + Retranslate.onLanguageChanged
    
    }
    
    ScrollView {
        id: scrollView
        scrollViewProperties {
            scrollMode: ScrollMode.Both
            pinchToZoomEnabled: true
        }
        layoutProperties: StackLayoutProperties { spaceQuota: 1.0 }
    
    Container {
        
        Container {
            id: loadContainer
            bottomPadding: 2
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Bottom
            Label {
                id: reportLabel
                text: qsTr("loading..") + Retranslate.onLanguageChanged
                textStyle.color: Color.create("#666666")
                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Top
            }
            
            ProgressIndicator {
                id: progressIndicator
                maxHeight: 60
                minHeight: 60
                opacity: 1.0
            }
        }
        
        WebView {
            id: usefulLinkWEBview
            url: subCatValue
            //maxWidth: 750
            //settings.background: Color.Transparent
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            settings.webInspectorEnabled: true
            settings.zoomToFitEnabled: true
            settings.activeTextEnabled: true
            settings.defaultFontSize: 33
            onLoadProgressChanged: {
                // Update the ProgressBar while loading.
                progressIndicator.value = loadProgress / 100.0
            }
            onLoadingChanged: {
                if (loadRequest.status == WebLoadStatus.Started) {
                    // Show the ProgressBar when loading started.
                    progressIndicator.opacity = 1.0
                    loadContainer.visible = true;
                } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                    // Hide the ProgressBar when loading is complete.
                    progressIndicator.opacity = 0.0
                    loadContainer.visible = false;
                } else if (loadRequest.status == WebLoadStatus.Failed) {
                   
                    progressIndicator.opacity = 0.0
                    loadContainer.visible = false;
                }
            }
        
        }
        
       
        
        
    }
    
    
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
  
   
     
}

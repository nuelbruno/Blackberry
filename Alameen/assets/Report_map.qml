/* Copyright (c) 2013 BlackBerry Limited.
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
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import QtMobility.sensors 1.2

Page {
    titleBar: TitleBar {
        title: qsTr("Report Map") + Retranslate.onLanguageChanged
    }
    onCreationCompleted: {
        var longitude = _MOL.getValueFor("longitude", "")
        var latitude = _MOL.getValueFor("latitude", "")
        console.debug("lat :", latitude)
        console.debug("long :", longitude)
        mapview.latitude = latitude
        mapview.longitude = longitude
        
        //Qt.latitude_final =latitude;
        //Qt.longitude_final =longitude;
    }
    actions: [
        //! [0]
        ActionItem {
            title: qsTr("Drop Pin") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/pin.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                pinContainer.addPin(mapview.latitude, mapview.longitude);
            }
        },
        ActionItem {
            title: qsTr("Remove Pins") + Retranslate.onLanguageChanged
            imageSource: "asset:///images/clearpin.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                pinContainer.removeAll();
            }
        }
    ] 
    
    Container {
        id: mapcontainerLayout
        layout: AbsoluteLayout {
        }
        preferredWidth: 725
        preferredHeight: 1050
        background: Color.create(0.5, 0.5, 0.5)
        visible: true
        //! [1]
        
        MapView {
            id: mapview
            altitude: 3000
           // latitude: latitude //45.342614
            //longitude: longitude //-75.914991
            latitude: 45.342614 //45.342614
            longitude: -75.914991 //-75.914991
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
                marker.pinImageSource = "asset:///images/pin.png"
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
        } // pinContaioner contaioner
        
        Container {
            // File path of the pin image
            property string pinImageSource: "asset:///images/pin.png"
            // pointerOffsetX, pointerOffsetY is the position of the pixel in pin image that should point to the location. Change these to match your pin image.
            property int pointerOffsetX: 20
            property int pointerOffsetY: 58
            /////////////////////////////////////////////////////////
            id: root
            property int x: 0
            property int y: 0
            property double lat
            property double lon
            property alias animDrop: animDrop
            clipContentToBounds: false
            overlapTouchPolicy: OverlapTouchPolicy.Allow
            layoutProperties: AbsoluteLayoutProperties {
                id: position
                positionX: x - pointerOffsetX
                positionY: y - pointerOffsetY
            }
            ImageView {
                id: pinImage
                scaleX: .8
                scaleY: .8
                imageSource: pinImageSource
                focusPolicy: FocusPolicy.Touch
                overlapTouchPolicy: OverlapTouchPolicy.Allow
                onFocusedChanged: {
                    if (focused) {
                        animFocus.play();
                        root.parent.showBubble(root);
                    }
                    if (! focused) {
                        animUnfocus.play();
                    }
                }
                animations: [
                    ScaleTransition {
                        id: animFocus
                        fromX: .8
                        toX: 1
                        fromY: .8
                        toY: 1
                        duration: 300
                        easingCurve: StockCurve.BounceOut
                    },
                    ScaleTransition {
                        id: animUnfocus
                        fromX: 1
                        toX: .8
                        fromY: 1
                        toY: .8
                        duration: 300
                        easingCurve: StockCurve.BounceOut
                    }
                ]
            }
            animations: [
                TranslateTransition {
                    id: animDrop
                    fromY: - position.positionY
                    toY: 0
                    duration: 600
                    easingCurve: StockCurve.BounceOut
                }
            ]
        }
    }// main contaioner
    attachedObjects: [
        //! [5]
        ComponentDefinition {
            id: pin
            source: "pin.qml"
        }
    ] 
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
import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.cascades.maps 1.0
import QtMobilitySubset.location 1.1
import QtMobility.sensors 1.2

Page {
    function passNewsUniqName(data) {

        console.debug("news details page titlet show:" + data.getTitle);
        mLabelHome.text = data.title;
        newTitle.text = data.title;
        subtittle.text = data.sub_title;
        address.text = data.address;
        poBoxnumber.text = qsTr("P.O.Box:") + Retranslate.onLanguageChanged + "" + data.pobox;
        cityCountry.text = data.city + " " + data.country;
        telAddress.text = qsTr("Tel:") + Retranslate.onLanguageChanged + "" + data.phone;
        faxAddress.text = qsTr("Fax:") + Retranslate.onLanguageChanged + "" + data.fax;
        emailAddress.text = data.email;
        mapview.latitude = data.latitude;
        mapview.longitude = data.longitude;
        pinContainer.addPin(data.latitude, data.longitude);
        if(_ADNOC.isNetworkAvailable())
        {
            aADNOCwebservice.statisticsADNOC('', "Office Details-"+newTitle.text, "Get");
        }
    }
    Container {

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                id: mainContainer
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                minHeight: 120
                maxHeight: minHeight
                background: Color.create("#0088CE")
                //topMargin: 30.0
                topPadding: 32.0
                Label {
                    id: mLabelHome
                    text: qsTr("Contact us") + Retranslate.onLanguageChanged
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    //textStyle.fontWeight: FontWeight.Bold
                    textStyle.fontSize: FontSize.Large
                    textStyle.color: Color.create("#FFFFFF")
                }
            }
            ScrollView {
                scrollViewProperties.scrollMode: ScrollMode.Vertical
                id: mScrollViewTab

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    background: mBackgroundImage.imagePaint
                    preferredWidth: 800
                    //bottomPadding: 0
                    preferredHeight: 1500
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Fill
                        rightPadding: 60.0
                        leftPadding: 23.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        CommonLabel {
                            id: newTitle
                            horizontalAlignment: HorizontalAlignment.Left
                            textStyle.color: Color.create("#0083CA")
                        }
                        CommonLabel {
                            id: subtittle
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        CommonLabel {
                            id: address
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        CommonLabel {
                            id: poBoxnumber
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        CommonLabel {
                            id: cityCountry
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        CommonLabel {
                            id: telAddress
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        CommonLabel {
                            id: faxAddress
                            horizontalAlignment: HorizontalAlignment.Left
                            //text: "01:00 Am - 06-00Am"
                            textStyle.color: Color.create("#000000")
                        }
                        Container {
                            // topPadding: 10.0
                            topMargin: 10.0
                            bottomMargin: 20.0
                            preferredHeight: 60
                            leftPadding: 65.0
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            background: mImagePaintTextBoxborder.imagePaint
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            ImageView {
                                imageSource: "asset:///images/icons/icnEmail@2x.png"
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                            }
                            CommonLabel {
                                id: emailAddress
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                //text: "01:00 Am - 06-00Am"
                                textStyle.color: Color.create("#FFFFFF")
                            }
                            onTouch: {
                                if(event.isUp())
                                {
                                    if(_ADNOC.isNetworkAvailable())
                                    {
                                        aADNOCwebservice.statisticsADNOC('', "Office Send Email-"+newTitle.text, "Get");
                                    }
                                    _ADNOC.shareOnEmail("800ADNOC@adnoc-dist.ae");
                                }
                            }
                        }
                        Container {
                            id: mapcontainerLayout
                            layout: DockLayout {
                            }
                            preferredHeight: 600
                            background: Color.create(0.5, 0.5, 0.5)
                            visible: true

                            MapView {
                                id: mapview
                                altitude: 90000
                                visible: true

                                onRequestRender: {
                                    pinContainer.updateMarkers();
                                }
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
                                    //marker.distance = parseFloat(distance).toFixed(2);
                                    //console.log("add pin lat & long" + lat +"-" +lon);
                                    var xy = _mapViewTest.worldToPixelInvokable(mapview, marker.lat, marker.lon);
                                    marker.x = xy[0];
                                    marker.y = xy[1];
                                    pinContainer.add(marker);
                                    marker.animDrop.play();
                                }
                                function showMe() {
                                    var marker = pin.createObject();
                                    marker.pinImageSource = "asset:///images/icons/imgAnnotation@2x.png"
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
                            }

                        }
                        //  end of map container
                    }
                }
            }
        }

    }
    attachedObjects: [
        ComponentDefinition {
            id: pin
            source: "pin.qml"
        },
        ImagePaintDefinition {
            id: mImagePaintTextBoxborder
            imageSource: "asset:///images/common/button_grey.png"
        }
    ]
}

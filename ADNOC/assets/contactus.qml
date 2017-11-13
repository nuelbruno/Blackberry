import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import WebImageView 1.0
import bb.system.phone 1.0
import bb.DatabaseConnectionApi.data 1.0

Page {
    property string stationCode
    property string mLanguageBool
    property string mLanguageCode
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property int intLOAD: -1
  
    
    
    
    Container {
        onCreationCompleted: {
            mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
            mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
            //aADNOCwebservice.getContastusList( "1", mLanguageBool);
            //aADNOCwebservice.dataLoaded.connect(afterdatanewsList);
            if(_ADNOC.isNetworkAvailable())
            {
                aADNOCwebservice.statisticsADNOC('', "Contact List Home", "Get");
            }
            
            currentTask = intSELECT;
            mCustomeDataSource.query = "SELECT * FROM tbl_contact " 
            mCustomeDataSource.load();
        }
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
            Container {
                id: containerMain
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                layout: DockLayout {
                }
                
                LoadingDialog {
                    topMargin: 0
                    topPadding: 0
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    active: aADNOCwebservice.active
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
                        //rightPadding: 60.0
                        //leftPadding: 23.0
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }

                        Container {
                            id: bannerContainer
                            topPadding: 70.0
                            topMargin: 10.0
                            // leftPadding: 20.0
                            // leftMargin: 20.0
                            //preferredWidth: 250
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Fill
                            preferredHeight:350

                            //background:Color.create("#333333")
                            layout: StackLayout {
                                orientation: LayoutOrientation.TopToBottom
                            }

                            ImageView {
                                id: imageview1
                                preferredHeight: 150

                                preferredWidth: 450
                                horizontalAlignment: HorizontalAlignment.Center
                                verticalAlignment: VerticalAlignment.Center
                                imageSource: "asset:///images/imgContactBanner@2x.png"
                                //scalingMethod: ScalingMethod.AspectFill
                            }
                            onTouch: {
                                if(event.isUp())
                                {
                                    if(_ADNOC.isNetworkAvailable())
                                    {
                                        aADNOCwebservice.statisticsADNOC('', "Call 800300", "Get");
                                    }
                                    phone.requestDialpad("800300");
                                }
                            }

                        }
                        ListView {
                            id: listView
                            dataModel: groupdata
                            //scrollRole: ScrollRole.Default
                            
                            listItemComponents: [

                                ListItemComponent {
                                    type: "item"

                                    Container {
                                        id: rootContainer
                                        horizontalAlignment: HorizontalAlignment.Fill
                                        verticalAlignment: VerticalAlignment.Fill
                                        layout: StackLayout {
                                            orientation: LayoutOrientation.TopToBottom
                                        }
                                        Container {
                                            id: contactusContainer
                                            horizontalAlignment: HorizontalAlignment.Fill
                                            verticalAlignment: VerticalAlignment.Fill
                                            background: mRowBgNews.imagePaint
                                            minHeight: 110
                                            maxHeight: minHeight
                                            preferredWidth: 780
                                            //background: Color.create(0.5, 0.5, 0.5)
                                            topPadding: 8.0
                                            leftPadding: 20.0
                                            rightPadding: 20.0
                                            layout: DockLayout {
                                                //orientation: LayoutOrientation.LeftToRight
                                            }
   
                                            Label {
                                                id: contactTitle
                                                text: ListItemData.title
                                                horizontalAlignment: HorizontalAlignment.Left
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#0083CA")
                                                //multiline: true
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
                                            }
                                            Label {
                                                id: arrow
                                                text: ">"
                                                horizontalAlignment: HorizontalAlignment.Right
                                                verticalAlignment: VerticalAlignment.Center
                                                textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                                textStyle.color: Color.create("#000000")
                                                //multiline: true
                                                //horizontalAlignment: HorizontalAlignment.Left
                                                //verticalAlignment: VerticalAlignment.Bottom
                                            }
                                        }
                                        attachedObjects: [
                                            ImagePaintDefinition {
                                                id: mRowBgNews
                                                imageSource: "asset:///images/icons/imgNewsRowBg@2x.png"
                                            }
                                        ]
                                    }
                                }
                            ]
                            onTriggered: {
                                
                                var chosenItem = dataModel.data(indexPath);
                                console.debug(chosenItem.contactTitle+'qml list out put' + chosenItem.title);
                                
                                if(chosenItem.title == "Feedback")
                                {
                                    if(_ADNOC.isNetworkAvailable())
                                    {
                                       var mFeedbackFromPage = mFeedbackFrom.createObject();
                                       mNavigationPaneMain.push(mFeedbackFromPage);
                                    }else{
                                        customAlert.body = qsTr("No internet connection") + Retranslate.onLanguageChanged;
                                        customAlert.show();  
                                    }
                                }
                                else {
                                    var  mContactusDetailsPage = mContactusDetails.createObject();
                                    mContactusDetailsPage.passNewsUniqName(chosenItem);
                                    mNavigationPaneMain.push(mContactusDetailsPage);
                                }
                                //mFeedbackFrom
                                
                            }
                          

                        }

                    } //  content holding container
                }
            }

        } // main top to bottom stack layout
    }

    attachedObjects: [
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        Phone {
            id: phone
        },
        ComponentDefinition {
            id: mContactusDetails
            source: "contactDetails.qml"
        }, 
        ComponentDefinition {
            id: mFeedbackFrom
            source: "feedback.qml"
        },
        ImagePaintDefinition {
            id: mBackgroundImage
            imageSource: "asset:///images/background/bgView.png"
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        },
        SystemDialog {
            id: customAlert
            title: qsTr("Alert") + Retranslate.onLanguageChanged
            //body: qsTr("Request saved successfully.") + Retranslate.onLanguageChanged
            cancelButton.label: undefined
            confirmButton.label:qsTr("OK") + Retranslate.onLanguageChanged 
            //buttons: [ok]
            onFinished: {
            
            }
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/ADNOC.sqlite"
            //query: "SELECT * FROM tbl_favourite"
            connection: "mCustomeDataSourceInsert"
            onDataLoaded: {
                if (currentTask == intSELECT || currentTask == intLOAD) {
                    groupdata.clear();
                    //data.push("test");
                    console.log("sql data pass" + JSON.stringify(data));
                    groupdata.insertList(data);
                    //intTotalDataCount = data.length;
                    listView.dataModelChanged(groupdata);
                    var size = data.length;
                                
                }
                else if (currentTask == intDELETE) {
                
                }
            
            }
        }
    ]
}

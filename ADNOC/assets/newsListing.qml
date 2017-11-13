import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import WebImageView 1.0
import bb.DatabaseConnectionApi.data 1.0

Page {
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
            Qt.languageset = mLanguageCode;
            
            currentTask = intSELECT;
            mCustomeDataSource.query = "SELECT * FROM tbl_news " 
            mCustomeDataSource.load();
            if(_ADNOC.isNetworkAvailable())
            {
                aADNOCwebservice.statisticsADNOC('', "News List Home", "Get");
            }
            //aADNOCwebservice.getNewslistings( "1", mLanguageBool);
            //aADNOCwebservice.dataLoaded.connect(afterdatanewsList);
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
                    text: qsTr("News") + Retranslate.onLanguageChanged
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
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                background: mBackgroundImage.imagePaint
                preferredWidth: 800
                //bottomPadding: 0
                preferredHeight: 1500
                ListView {
                    id: listView
                    dataModel: groupdata
                    scrollRole: ScrollRole.Default

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
                                    id: leaveStatusContainer
                                    horizontalAlignment: HorizontalAlignment.Fill
                                    verticalAlignment: VerticalAlignment.Fill
                                    background: mRowBgNews.imagePaint
                                    minHeight: 160
                                    maxHeight: minHeight
                                    preferredWidth: 780
                                    //background: Color.create(0.5, 0.5, 0.5)
                                    topPadding: 8.0
                                    leftPadding: 20.0
                                    rightPadding: 20.0
                                    layout: StackLayout {
                                    orientation: (Qt.languageset != "en")?LayoutOrientation.RightToLeft : LayoutOrientation.LeftToRight
                                    }
                                    
                                    WebImageView {
                                        id: webViewImage
                                        url: "http://demoserver.tacme.net:3030/AdnocDistTacsoft/" + ListItemData.news_main_image
                                        //horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        scalingMethod: ScalingMethod.AspectFill
                                        maxWidth: 150
                                        minWidth: 150
                                        //maxHeight: 138
                                        //minHeight: 138
                                        visible: (webViewImage.loading == 1.0)
                                    }
                                    
                                    ImageView {
                                        imageSource: "asset:///images/background/imgWaterMark.png"
                                        horizontalAlignment: HorizontalAlignment.Center
                                        verticalAlignment: VerticalAlignment.Center
                                        scalingMethod: ScalingMethod.AspectFill
                                        maxWidth: 150
                                        minWidth: 150
                                        visible: (webViewImage.loading != 1.0)
                                    }
                               

                                    Label {
                                        id: newTitle
                                        text: ListItemData.news_title
                                        //horizontalAlignment: HorizontalAlignment.Left
                                        verticalAlignment: VerticalAlignment.Center
                                        textStyle.base: SystemDefaults.TextStyles.SubtitleText
                                        textStyle.color: Color.create("#000000")
                                        multiline: true
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
                        console.debug('qml list out put' + indexPath);
                        
                        var  mNewsDetailsViewPage = mNewsDetailsView.createObject();
                        mNewsDetailsViewPage.passNewsUniqName(chosenItem)
                        mNavigationPaneMain.push(mNewsDetailsViewPage)
                    }

                }
            }
        }

    }
    attachedObjects: [
        ImagePaintDefinition {
            id: mBgsearchImagePaint
            imageSource: "asset:///images/common/bgSearchBar.png"
        }, 
        ComponentDefinition {
            id: mNewsDetailsView
            source: "newsDetailsView.qml"
        },   
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
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

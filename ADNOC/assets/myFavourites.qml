import bb.cascades 1.2
import ADNOCwebservice 1.0
import bb.system 1.0
import "common"
import bb.DatabaseConnectionApi.data 1.0

Page {
    property int intSelectedDataCount: 0
    property int intTotalDataCount: 0
    property int currentTask: -1
    property int intSELECT: 0
    property int intUPDATE: 1
    property int intDELETE: 2
    property int intLOAD: -1
    property string mLanguageBool
    property string mLanguageCode
    Container {
        onCreationCompleted: {
            currentTask = intSELECT;
            mCustomeDataSource.query = "SELECT * FROM tbl_favourite"
            mCustomeDataSource.load();
            mLanguageCode = _ADNOC.getValueFor("mLanguageCode", "en");
            Qt.languageset = mLanguageCode;
            mLanguageBool =  (mLanguageCode == "en")? "1" : "2";
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
                    text: qsTr("Favourites") + Retranslate.onLanguageChanged
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
                    topMargin: 01
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
                    id: mListView
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    dataModel: groupdata
                    function checkAllChecked(isChecked, indexpath) {
                        isAllDataSelected(isChecked, indexpath);
                    }
                    function getModel() {
                        return groupdata;
                    }
                    function getLang() {
                        return "en";
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "item"
                            CommonListRow {
                                id: mCommonListRowArabic
                                isDistanceVisible: false
                                onTouch: {
                                    currentIndexpPath = ListItem.indexPath
                                    mCommonListRowArabic.setIndexPath(ListItem.indexPath)
                                }
                            }
                        }
                    ]
                    onTriggered: {
                        var chosenItem = dataModel.data(indexPath);
                        console.debug('qml list out put' + indexPath);
                        
                        var  stationDetailsPage = stationDetails.createObject();
                        stationDetailsPage.passMyfavouriteData(chosenItem)
                        mNavigationPaneMain.push(stationDetailsPage)
                        
                    }
                    attachedObjects: [
                        ComponentDefinition {
                            id: stationDetails
                            source: "asset:///stationDetails.qml"
                        }
                    ]
                }
                
           }
        }
    
    }
    
    function deleteSelectedData() {
        
        var queryDelete = "";
        var count = groupdata.childCount(0);
        for (var i = 0; i < count; i ++) {
            var indexPath = [ i ];
            var selectedItem = groupdata.data(indexPath);
            console.log("checked true or not" + JSON.stringify(selectedItem));
            if (selectedItem.getChecked == true) {
                if (queryDelete == "") {
                    queryDelete = selectedItem.station_code
                } else {
                    queryDelete = queryDelete + "," + selectedItem.station_code
                }
            }
        }
        console.log("checked true or not" + queryDelete);
        queryDelete = "DELETE FROM tbl_favourite WHERE station_code IN (" + queryDelete + ")"
        currentTask = intDELETE;
        mCustomeDataSource.query = queryDelete;
        mCustomeDataSource.load();
    }
    function isAllDataSelected(isCheck, indexPath) {
        var isChecked = ! isCheck;
        intTotalDataCount = groupdata.childCount(0);
        
        if (isChecked) {
            intSelectedDataCount = intSelectedDataCount + 1
        } else {
            intSelectedDataCount = intSelectedDataCount - 1
        }
       
        //For changed model's data
        var selectedItem = groupdata.data(indexPath);
        selectedItem.getChecked = isChecked;
        groupdata.updateItem(indexPath, selectedItem);
    }
    
    actions: [
        
        ActionItem {
            id: deleteFeed
            title: "Delete"
            accessibility.name: "Delete"
            imageSource: "asset:///images/common/icnDelete@2x.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                mSystemDialogDelete.show();
            }
        }
    ]
    attachedObjects: [
        ImagePaintDefinition {
            id: mBgsearchImagePaint
            imageSource: "asset:///images/common/bgSearchBar.png"
        },   
        ADNOCwebservice {
            id: aADNOCwebservice
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/ADNOC.sqlite"
            //query: "SELECT * FROM tbl_favourite"
            connection: "mCustomeDataSourceInsert"
            onDataLoaded: {
                if (currentTask == intSELECT || currentTask == intLOAD) {
                    groupdata.clear();
                    console.log("sql data pass" + data);
                    groupdata.insertList(data);
                    //intTotalDataCount = data.length;
                    mListView.dataModelChanged(groupdata);
                }
                else if (currentTask == intDELETE) {
                    currentTask = intLOAD;
                    mCustomeDataSource.query = "SELECT * FROM tbl_favourite"
                    mCustomeDataSource.load();
                }
                    
            }
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        },
        SystemDialog {
            id: mSystemDialogDelete
            title: undefined
            body: qsTr("Are you sure to Delete?") + Retranslate.onLanguageChanged
            cancelButton.label: qsTr("Cancel") + Retranslate.onLanguageChanged
            confirmButton.label: qsTr("Ok") + Retranslate.onLanguageChanged
            onFinished: {
                if (mSystemDialogDelete.result == SystemUiResult.ConfirmButtonSelection) {
                    //mTextFieldSearch.text = "";
                    deleteSelectedData();
                }
            }
        }
        
    ]
}

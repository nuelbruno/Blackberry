// ***********************************************************************************************************
//  NEAR BY SERVICES SHOWING PAGE
//
//
// ***********************************************************************************************************
import bb.cascades 1.2
import "common"
import bb.system 1.0

Page {
    property string mLatitude
    property string mLongitude
    property bool isFromMap: true
    // LANAGAUGE CHANGE ALIGNMENT SETUP
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mListViewArabic.visible = false
            mListView.visible = true
        } else {
            mListViewArabic.visible = true
            mListView.visible = false
        }
        callAllServices();
    }
    // GET ALL SERVICES NEAR BY WEB SERVICE CALL
    function callAllServices() {
        if (_mAppParentObj.isNetworkAvailable()) {
            _mWebServiceinstance.GetAllServices("GetAllServicesNearBy");
        }
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        onCreationCompleted: {
            setAlignMent();
            callAllServices();
        }
        layout: DockLayout {

        }
        Container {

            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            CommonTopBar {
                mText: mAllString.mSearchServices
            }
            ListView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                id: mListView
                dataModel: _mWebServiceinstance.mymodelservice
                function getLang() {
                    return "en"
                }
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            preferredHeight: 125
                            leftPadding: 30
                            horizontalAlignment: HorizontalAlignment.Fill
                            background: ListItem.indexPath % 2 == 0 ? Color.White : Color.create("#E8E8E8")
                            id: mContainerListItem
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.service_name
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                            }
                        }
                    }
                ]
                onTriggered: {
                    var data = dataModel.data(indexPath);
                    var mPage = mComponentDefinitionNearBy.createObject();
                    mPage.callNearBy(data.service_id, mLatitude, mLongitude);
                    mPage.isFromMap = isFromMap;
                    mNavigationPaneMain.push(mPage);
                }
            }
            ListView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                id: mListViewArabic
                dataModel: _mWebServiceinstance.mymodelservice
                function getLang() {
                    return "ar"
                }
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            preferredHeight: 125
                            leftPadding: 30
                            rightPadding: 30
                            horizontalAlignment: HorizontalAlignment.Fill
                            background: ListItem.indexPath % 2 == 0 ? Color.White : Color.create("#E8E8E8")
                            id: mContainerListItemArabic
                            layout: StackLayout {
                                orientation: LayoutOrientation.RightToLeft
                            }
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: ListItemData.service_name
                                horizontalAlignment: HorizontalAlignment.Fill
                                textStyle.textAlign: TextAlign.Right
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                            }
                        }
                    }
                ]
                onTriggered: {
                    var data = dataModel.data(indexPath);
                    var mPage = mComponentDefinitionNearBy.createObject();
                    mPage.callNearBy(data.service_id, mLatitude, mLongitude);
                    mPage.isFromMap = isFromMap;
                    mNavigationPaneMain.push(mPage);
                }
            }
        }
    }
    attachedObjects: [
        AllStrings {
            id: mAllString
        },
        ComponentDefinition {
            id: mComponentDefinitionNearBy
            source: "NearBy.qml"
        },
        SystemDialog {
            id: mSystemDialog
            title: undefined
            cancelButton.label: undefined
            confirmButton.label: mAllString.mDialogOk
        }
    ]
    paneProperties: NavigationPaneProperties {
        backButton: ActionItem {
            title: mAllString.mBack
            onTriggered: {
                mNavigationPaneMain.pop();
            }
        }
    }
}

import bb.cascades 1.2
import "common"
import bb.DatabaseConnectionApi.data 1.0
Container {
    id: mContainerFaviourites
    property int intSelectedDataCount: 0
    property int intTotalDataCount: 0
    property int currentTask: 0
    property int intSELECT: 0
    property string mFavData
    property TextField mTextFieldSetDataFav
    property bool isFrom
    property string fromwhere
    layout: DockLayout {
    }
    verticalAlignment: VerticalAlignment.Fill
    horizontalAlignment: HorizontalAlignment.Fill

    background: Color.create(0, 0, 0, 0.5)
    onCreationCompleted: {
        setAlignMent()
    }
    function setAlignMent() {
        if (_mWebServiceinstance.getValueFor("mLanguageCode", "en") == "en") {
            mcontainer.layout.orientation = LayoutOrientation.LeftToRight
            mTextFieldSearch.textStyle.textAlign = TextAlign.Left
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Right
            mListView1.visible = true
            mListViewArabic.visible = false

        } else {
            mcontainer.layout.orientation = LayoutOrientation.RightToLeft
            mTextFieldSearch.textStyle.textAlign = TextAlign.Right
            mImageViewInfoExit.horizontalAlignment = HorizontalAlignment.Left
            mListView1.visible = false
            mListViewArabic.visible = true
        }
        mCustomeDataSource.load()
    }
    rightPadding: 25
    leftPadding: 25
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        background: Color.White

        Container {
            layout: DockLayout {
            }
            background: Color.White
            horizontalAlignment: HorizontalAlignment.Fill
            CommonTopBar {
                mText: mAllStrings.mFavourites
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Fill
                rightPadding: 30
                leftPadding: 30
                ImageButton {
                    id: mImageViewInfoExit
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Right
                    defaultImageSource: "asset:///images/home/icon_close.png"
                    onClicked: {
                        mDialogFaviourites.close();
                    //    isFrom == true ? whenCancelButtonHit(true) : whenCancelButtonHit(false)
                    }
                }
            }

        }
        Container {
            id: mcontainer
            background: mImagePaintDefinition.imagePaint
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            horizontalAlignment: HorizontalAlignment.Fill
            topPadding: 20
            bottomPadding: 20
            rightPadding: 25
            leftPadding: 25

            TextField {
                id: mTextFieldSearch
                hintText: ""
                horizontalAlignment: HorizontalAlignment.Fill
                onTextChanging: {
                    {
                        mContainerFaviourites.currentTask = mContainerFaviourites.intSELECT;
                        mCustomeDataSource.query = "SELECT * FROM favourite where getpoiname  like \"%" + mTextFieldSearch.text + "%\""
                        mCustomeDataSource.load();
                    }
                }
            }
            Container {
                rightPadding: 20
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                visible: true
                ImageButton {
                    id: doneButton
                    defaultImageSource: "asset:///images/home/icon_search.png"
                    pressedImageSource: "asset:///images/home/icon_search.png"
                }
            }

        }
        ListView {
            id: mListView1
            preferredHeight: 300
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            dataModel: groupdata

            visible: false
            function getModel() {
                return groupdata;
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        leftPadding: 25
                        rightPadding: 25
                        background: Color.White
                        Label {
                            text: ListItemData.getpoiname
                            textStyle.fontSize: FontSize.Medium
                            textStyle.color: Color.Black
                            textStyle.textAlign: TextAlign.Left
                        }
                        Divider {

                        }
                    }
                }
            ]
            onTriggered: {
                var mData = dataModel.data(indexPath)

               /* if (isFrom) {
                    mdataFav = mData.location;
                    console.debug("data in favoutites isfrom:" + mdataFav)

                } else {
                    mdataFavTo = mData.location
                    console.debug("data in favoutites to:" + mdataFavTo)
                }*/
                if (fromwhere == "From") {
                    mdataFav = mData.location;
                    console.debug("data in favoutites isfrom:" + mdataFav)
                } else if (fromwhere == "To") {
                    mdataFavTo = mData.location
                    console.debug("data in favoutites to:" + mdataFavTo)
                } else if (fromwhere == "Via") {
                    console.debug("in via favourits")
                    mdataFavVia= mData.location
                }
                mTextFieldSetDataFav.text = mData.location
                mDialogFaviourites.close();
            }
        }
        ListView {
            id: mListViewArabic
            preferredHeight: 300
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Center
            dataModel: groupdata

            visible: false
            function getModel() {
                return groupdata;
            }
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    Container {
                        leftPadding: 25
                        rightPadding: 25
                        background: Color.White
                        //use name for arabic as stored
                        horizontalAlignment: HorizontalAlignment.Fill
                        Label {
                            horizontalAlignment: HorizontalAlignment.Fill
                            text: ListItemData.getpoiname
                            textStyle.fontSize: FontSize.Medium
                            textStyle.color: Color.Black
                            textStyle.textAlign: TextAlign.Right
                        }
                        Divider {

                        }
                    }
                }
            ]
            onTriggered: {
                //get name according to arbic name stored in
                var mData = dataModel.data(indexPath)
                if (isFrom)
                    mdataFav = mData.location;
                else
                    mdataFavTo = mData.location
                mTextFieldSetDataFav.text = mData.location
                mDialogFaviourites.close();

            }
        }
    }
    function getmyClickedValue() {

        return mFavData
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        ImagePaintDefinition {
            id: mImagePaintDefinition
            imageSource: "asset:///images/directions/search_bg.png"
        },
        DatabaseConnectionApi {
            id: mCustomeDataSource
            source: "sql/DM_App.sqlite"
            query: "SELECT * FROM favourite"
            connection: "mCustomeDataSource"
            onDataLoaded: {
                mCustomeDataSource.query = "SELECT * FROM favourite"
                groupdata.clear();

                groupdata.insertList(data)
                mListView1.dataModelChanged(groupdata);

            }
        },
        GroupDataModel {
            id: groupdata
            grouping: ItemGrouping.None
        }
    ]
}

import bb.cascades 1.2
import "common"
// ***********************************************************************************************************
//  MAIN HOME PAGE TO BE CALLED ON START OF THE APPLICATION
//
//
// ***********************************************************************************************************
TabbedPane {
    id: mainTabPaned
    peekEnabled: false
    property NavigationPane mnav
    onCreationCompleted: {
    // ########################  SPLASH SCREEN OPEN  #######################  //
        mDialogSplash.open()
    // ########################  CHECK TO SHOW TUTORIAL TABS #######################  //
        if (_mAppParentObj.getValueFor("mcheckboxSkipTu", "false") != "true") {
            //Show tutorial page

            mDialog.open()
        }
    }
    // ########################  TAB CONTROLES FOR OPTIONES #######################  //
    Tab {
        //  title: mAllStrings.mMap
        title: mAllStrings.mHomePane
        //imageSource: "asset:///images/home/ic_map.png"
        imageSource: "asset:///images/home/Home_icon.png"
        id: tabPaneMap
        Main {
            id: mMap
        }
        onTriggered: {

            mMap.resetData();
        }
    }
    Tab {
        id: mTabDirections
        title: mAllStrings.mDirections
        imageSource: "asset:///images/home/ic_direction.png"
        Directions {
            id: mDirections
        }
        onTriggered: {

            mDirections.resetData();
        }
    }
    Tab {
        id: mTabFavourite
        title: mAllStrings.mFavourites
        imageSource: "asset:///images/home/ic_favorite.png"
        MyFavourites {
            id: mFavourites
        }
        onTriggered: {
            console.debug("mTabFavourite calld")

            mFavourites.setAlignMent();
        }
    }
    Tab {
        id: mTabNearBy
        title: mAllStrings.mNeraby
        imageSource: "asset:///images/home/ic_nearby.png"

        NearByPane {
            id: mNearByPane
        }
        onTriggered: {

            mNearByPane.mLatitudes = _mWebServiceinstance.getValueFor("currentLatitude", "25.271139");
            mNearByPane.mLongitudes = _mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485");
            //   mNearByPane.mLatitudes = "25.271139";
            // mNearByPane.mLongitudes = "55.307485";

            mNearByPane.mFromMap = false;
            mNearByPane.setAlignMent()
            // mNearByPane.callGetAllServices();

        }
        /* NearBy {
         * id: mNearBy
         * }
         * onTriggered: {
         * mNearBy.setAlignMent()
         * mNearBy.mapLatitude = "25.271139"
         * mNearBy.mapLongitude = "55.307485"
         * //callNearBy("", _mWebServiceinstance.getValueFor("currentLatitude", "25.271139"), mWebServiceinstance.getValueFor("CurrentLongitude", "55.307485"))
         * mNearBy.isFromMap = false
         * 
         }*/
    }
    Tab {
        id: mTabMore
        title: mAllStrings.mMore
        imageSource: "asset:///images/home/ic_more.png"
        More {
            id: mMore
        }
    }
    // ########################  ENABLE OR DISBALE TABS ON CLICK OF FUNCTION #######################  //
    function changeTab(currentTab) {
        if (currentTab == 0) {
            mainTabPaned.activeTab = tabPaneMap;
            mMap.resetData();
        } else if (currentTab == 1) {
            mainTabPaned.activeTab = mTabDirections;
        } else if (currentTab == 2) {
            mainTabPaned.activeTab = mTabFavourite;
        } else if (currentTab == 3) {
            mainTabPaned.activeTab = mTabNearBy;
        } else if (currentTab == 4) {
            mainTabPaned.activeTab = mTabMore;
        }
    }
    // ########################  CURRETN LAT AND LONG FOR NEARY LOCATION SEARCH #######################  //
    function callNearBy(latitude, longitude, isFromMap) {
        mNearByPane.mLatitudes = latitude;
        mNearByPane.mLongitudes = longitude;
        mNearByPane.mFromMap = true;
        mNearByPane.setAlignMent()
        /* mNearBy.mapLatitude = latitude
         * mNearBy.mapLongitude = longitude
         * mNearBy.isFromMap = true
         * mNearByPane.mLatitudes=latitude
         * mNearByPane.mLongitudes-=longitude
         * mNearByPane.mFromMap=true
         */ //  mNearByPane.callGetAllServices();
    }

    function callDirections(passedBackValue, isfromhere) {
        mDirections.receiveValue(passedBackValue, isfromhere);
    }
    function changeAlignMent() {
        mMap.setAlignMent();
        mMap.clearOtherData()
        mMore.setAlignMent();
        //  mNearByPane.setAlignMent();
        mDirections.setAlignment();
    }
    attachedObjects: [
        AllStrings {
            id: mAllStrings
        },
        Dialog {
            id: mDialog
            LayoutTutorial {
                id: mlayout

            }
        },
        Dialog {
            id: mDialogSplash
            SplashScreen {
                id: mSplashScreen
            }
            onOpened: {
                _mWebServiceinstance.setmactive(false)
            }
            onClosed: {
                mlayout.checkInternetConnection()
                //                if(!mDialog.opened){
                //                    mMap.checkGPSOnOff()
                //                }
                mMap.checkGPSOnOff()
            }
        }
    ]
}

// ***********************************************************************************************************
//  NEAR BY TAB NAVIAGATION PANE CONTORLING CONTAIENR
//
//
// ***********************************************************************************************************

import bb.cascades 1.3

NavigationPane {
    id: mNavigationPaneMain
    property string mLatitudes
    property string mLongitudes
    property string mFromMap
    function setAlignMent() {

        mNearBy.setAlignMent();
        mNearBy.clearAllData()
    }
    function callGetAllServices(data1, data2, data3) {
        // mNearByServices.callAllServices();
        mNearBy.mapLatitude = data1
        mNearBy.mapLongitude = data2
        mNearBy.isFromMap = data3
    }
    /*NearByServices {
     * id: mNearByServices
     * mLatitude: mLatitudes
     * mLongitude: mLongitudes
     * isFromMap: mFromMap
     }*/
    // GET COORDINATES TO SHOW NEAR BY PAGE
    NearBy {
        id: mNearBy
        mapLatitude: mLatitudes
        mapLongitude: mLongitudes
        isFromMap: mFromMap
        onCreationCompleted: {
            mNearBy.mNavigationPane = mNavigationPane
            mNearBy.setmypage(mNavigationPaneMain)
            mNearBy.clearAllData()
        }
    }
}
import bb.cascades 1.0

// QtObject is the most basic non-visual type
QtObject {

    //common
    property string mSearchByMakaniNo: qsTr("Search By Makani No.") + Retranslate.onLanguageChanged
    property string mSearchByUAENAG: qsTr("Search By UAE NG") + Retranslate.onLanguageChanged
    property string mSearchByPlaceName: qsTr("Search By Place Name") + Retranslate.onLanguageChanged
    property string mSearchByBuildingAddress: qsTr("Search By Building Address") + Retranslate.onLanguageChanged
    property string mSearchByCategories: qsTr("Search By Categories") + Retranslate.onLanguageChanged
    property string mserachbyland: qsTr("Search by Land Number") + Retranslate.onLanguageChanged
    property string minfoTextbyland: qsTr("Land Number :") + Retranslate.onLanguageChanged
    property string mDubaiSportsCouncil: qsTr("Dubai Sports Council :") + Retranslate.onLanguageChanged
    property string mTime: qsTr("Time :") + Retranslate.onLanguageChanged
    property string mDistance: qsTr("DISTANCE") + Retranslate.onLanguageChanged
    property string mInfo: qsTr("Info") + Retranslate.onLanguageChanged
    property string mShare: qsTr("Share") + Retranslate.onLanguageChanged
    property string mAddtoFavourites: qsTr("Add to Favourites") + Retranslate.onLanguageChanged
    property string mCommonSearch: qsTr("Makani Number, UAE NG or Place") + Retranslate.onLanguageChanged
    property string mDropDownCategoryAddress: qsTr("Category Address") + Retranslate.onLanguageChanged
    property string mAddtoContacts: qsTr("Add to Contacts") + Retranslate.onLanguageChanged
    property string mDirectiontohere: qsTr("Direction to here") + Retranslate.onLanguageChanged
    property string mDirectionsfromhere: qsTr("Directions from here") + Retranslate.onLanguageChanged
    property string mNeraby: qsTr("Nearby") + Retranslate.onLanguageChanged
    property string mCoordinateconverter: qsTr("Coordinate converter") + Retranslate.onLanguageChanged
    property string mVoiceNavigation: qsTr("Voice Navigation ") + Retranslate.onLanguageChanged
    property string mShareCoordinateconverter: qsTr("Share Coordinate") + Retranslate.onLanguageChanged
    property string mCommunity: qsTr("Community") + Retranslate.onLanguageChanged
    property string mStreet: qsTr("Street") + Retranslate.onLanguageChanged
    property string mTapToContinue: qsTr("Tap To Continue") + Retranslate.onLanguageChanged
    
    property string mBuilding: qsTr("Building Number") + Retranslate.onLanguageChanged
    property string mSearch: qsTr("Search") + Retranslate.onLanguageChanged
    property string mCancel: qsTr("Cancel") + Retranslate.onLanguageChanged
    property string mYes: qsTr("Yes") + Retranslate.onLanguageChanged
    property string mOk: qsTr("OK") + Retranslate.onLanguageChanged
    property string mSearchPOIOnMap: qsTr("Search POI On Map") + Retranslate.onLanguageChanged

    property string mSearchServices: qsTr("Services") + Retranslate.onLanguageChanged
    property string mSearchCategories: qsTr("Categories") + Retranslate.onLanguageChanged
    property string mSearchPlace: qsTr("PLACE NAME") + Retranslate.onLanguageChanged

    property string mCoordinateConnverterTitle: qsTr("Coordinate Converter") + Retranslate.onLanguageChanged
    property string mDirectionsTitle: qsTr("Directions") + Retranslate.onLanguageChanged
    property string mMakaniNumber: qsTr("Makani Number") + Retranslate.onLanguageChanged
    property string mUAENAG: qsTr("UAE NG") + Retranslate.onLanguageChanged
    property string mUAENGNear: qsTr("UAE NG:") + Retranslate.onLanguageChanged

    property string mutm: qsTr("UTM") + Retranslate.onLanguageChanged
    property string mDLTM: qsTr("DLTM") + Retranslate.onLanguageChanged
    property string mDecimal: qsTr("LAT/LNG Decimal") + Retranslate.onLanguageChanged
    property string mLatLngDMS: qsTr("LAT/LNG DMS") + Retranslate.onLanguageChanged
    property string mGeographical: qsTr("Geographical (Datum WGS84)") + Retranslate.onLanguageChanged

    property string mDecimalDegrees: qsTr("[Decimal Degrees]") + Retranslate.onLanguageChanged
    property string mConvert: qsTr("Convert") + Retranslate.onLanguageChanged
    property string mSave: qsTr("Save") + Retranslate.onLanguageChanged
    property string mLongitude: qsTr("Longitude") + Retranslate.onLanguageChanged

    property string mSelectAll: qsTr("Select ALL") + Retranslate.onLanguageChanged
    property string mSearchFavourites: qsTr("Search favourites") + Retranslate.onLanguageChanged

    property string mNetworkCheck: qsTr("Please check your internet connections") + Retranslate.onLanguageChanged
    property string mValidationRouteNotFound: qsTr("No route found") + Retranslate.onLanguageChanged
    property string mValidationInputValue: qsTr("Please provide input value.") + Retranslate.onLanguageChanged
    property string mValidationUAENGNumber: qsTr("Please provide UAE NG value.") + Retranslate.onLanguageChanged
    property string mValidationPlaceName: qsTr("Please provide a place name.") + Retranslate.onLanguageChanged
    property string mValidationCommunity: qsTr("Please provide the Community Name.") + Retranslate.onLanguageChanged
    property string mValidationStreet: qsTr("Please provide the Street Name.") + Retranslate.onLanguageChanged
    property string mValidationBuilding: qsTr("Please provide the Builiding No.") + Retranslate.onLanguageChanged
    property string mValidationService: qsTr("Please enter Service.") + Retranslate.onLanguageChanged
    property string mValidationCategoryOrPOI: qsTr("Please enter Category or Poi") + Retranslate.onLanguageChanged
    property string mValidationPOI: qsTr("Please enter Place name") + Retranslate.onLanguageChanged
    property string mValidationCategory:qsTr("Please enter the category") + Retranslate.onLanguageChanged
    property string mValidationValue: qsTr("Please enter value.") + Retranslate.onLanguageChanged
    property string mValidationValidaMakaniValue: qsTr("Please provide a valid Makani Number") + Retranslate.onLanguageChanged
    property string mValidationNumericValue: qsTr("Please enter Numeric value") + Retranslate.onLanguageChanged
    property string mValidationValidUTMValue: qsTr("Please enter valid UTM") + Retranslate.onLanguageChanged
    property string mValidationValidDLTMValue: qsTr("Please enter valid DLTM") + Retranslate.onLanguageChanged
    property string mValidationValidLatitudeValue: qsTr("Please enter valid Latitude") + Retranslate.onLanguageChanged
    property string mValidationValidLongitudeValue: qsTr("Please enter valid Longitude") + Retranslate.onLanguageChanged
    property string mValidationValidUAENGValue: qsTr("Please provide valid UAE NG value") + Retranslate.onLanguageChanged
    property string mValidationtrywithanotherinput: qsTr("Please try with another input") + Retranslate.onLanguageChanged
    property string mValidationFromLocation: qsTr("Please enter From location") + Retranslate.onLanguageChanged
    property string mValidationToLocation: qsTr("Please enter To location") + Retranslate.onLanguageChanged
    property string mValidationSelectProperPOI: qsTr("Please select proper poi") + Retranslate.onLanguageChanged
    property string mValidationInvalidData: qsTr("Invalid data") + Retranslate.onLanguageChanged
    property string mValidationPleaseEnterName: qsTr("Please enter Name") + Retranslate.onLanguageChanged

    property string mValidationFavouriteAlreadyExist: qsTr("Already exists") + Retranslate.onLanguageChanged
    property string mValidationFavouriteAdded: qsTr("Favourite added successfully") + Retranslate.onLanguageChanged
    property string mValidationFavouriteEdited: qsTr("Favourite updated successfully") + Retranslate.onLanguageChanged
    property string mValidationFavouriteNotFound: qsTr("No Favourites Found") + Retranslate.onLanguageChanged
    property string mValidationFavouriteDelete: qsTr("Are you sure to delete record?") + Retranslate.onLanguageChanged
    property string mValidationCopyToClipboardSuccess: qsTr("Copied to clipboard successfully") + Retranslate.onLanguageChanged

    property string mValidationShareMakaniEmpty: qsTr("Makani number not available") + Retranslate.onLanguageChanged
    property string mValidationShareUAENGEmpty: qsTr("UAE NG is not available") + Retranslate.onLanguageChanged
    property string mValidationShareUTMEmpty: qsTr("UTM is not available") + Retranslate.onLanguageChanged
    property string mValidationShareDLTMEmpty: qsTr("DLTM is not available") + Retranslate.onLanguageChanged
    property string mValidationShareDecimalEmpty: qsTr("Decimal is not available") + Retranslate.onLanguageChanged
    property string mValidationShareDMSEmpty: qsTr("DMS is not available") + Retranslate.onLanguageChanged
    property string mValidationShareSelectAnyOne: qsTr("Please select any one") + Retranslate.onLanguageChanged
    property string mValidationParcelIdInputValue: qsTr("Please provide 7 digits value.") + Retranslate.onLanguageChanged
    property string mValidationprovideParcelIdInputValue: qsTr("Please provide a valid Land Number") + Retranslate.onLanguageChanged
    property string mDialogOk: qsTr("Ok") + Retranslate.onLanguageChanged
    property string mFavourites: qsTr("Favourites") + Retranslate.onLanguageChanged
    property string mMore: qsTr("More") + Retranslate.onLanguageChanged
    property string mTitleChangeLanguage: qsTr("اللغة\n Language") + Retranslate.onLanguageChanged
    property string mTitleDisclaimer: qsTr("Disclaimer") + Retranslate.onLanguageChanged
    property string mTitleMapLegend: qsTr("Map Legend") + Retranslate.onLanguageChanged
    property string mTitleCoordinateConverter: qsTr("Coordinate \nConverter") + Retranslate.onLanguageChanged
    property string mTitleContactUs: qsTr("Contact Us") + Retranslate.onLanguageChanged
    property string mTitleRatingmore: qsTr("Rating") + Retranslate.onLanguageChanged
    property string mTitleRateApp: qsTr("Rate Makani App") + Retranslate.onLanguageChanged
    property string mTitleRateIt: qsTr("Rate It") + Retranslate.onLanguageChanged
    property string mTitleScan: qsTr("Scan") + Retranslate.onLanguageChanged
    property string mTitleAboutus: qsTr("About Us") + Retranslate.onLanguageChanged
    property string mTitleTutorial: qsTr("Tutorial") + Retranslate.onLanguageChanged
    property string mTitleHelp: qsTr("Help") + Retranslate.onLanguageChanged
    property string mTitleFeedBack: qsTr("Feedback") + Retranslate.onLanguageChanged
    property string mFeedBackEmailId: qsTr("Email ID") + Retranslate.onLanguageChanged
    property string mFeedBackType: qsTr("Type") + Retranslate.onLanguageChanged
    property string mLatitudeN: qsTr("Latitude (N)") + Retranslate.onLanguageChanged
    property string mLongitudeN: qsTr("Longitude (E)") + Retranslate.onLanguageChanged
    property string mDecimalDegree: qsTr("[Decimal Degrees]") + Retranslate.onLanguageChanged
    property string mDDMMSS: qsTr("[DD:MM:SS]") + Retranslate.onLanguageChanged
    property string mFrom: qsTr("From :") + Retranslate.onLanguageChanged
    property string mDropDownSelectFrom: qsTr("Select From") + Retranslate.onLanguageChanged
    property string mDropDownSelectTo: qsTr("Select To") + Retranslate.onLanguageChanged
    property string mDropDownMyLocation: qsTr("My Location") + Retranslate.onLanguageChanged
    property string mDropDownMakaniNumber: qsTr("Makani Number") + Retranslate.onLanguageChanged
    property string mDropDownUAENG: qsTr("UAE NG") + Retranslate.onLanguageChanged
    property string mDropDownPlaceName: qsTr("Place Name") + Retranslate.onLanguageChanged
    property string mDropDownBuildingAddress: qsTr("Building Address") + Retranslate.onLanguageChanged
    property string mDropDownSelectFromFaviourites: qsTr("Select From Favourites") + Retranslate.onLanguageChanged
    property string mDropDownSelectFromContacts: qsTr("Select From Contacts") + Retranslate.onLanguageChanged
    property string mTo: qsTr("To :") + Retranslate.onLanguageChanged
    property string mGetDirections: qsTr("Get Directions") + Retranslate.onLanguageChanged
    property string mDirectionsvalidationtextfield: qsTr("Please enter destination") + Retranslate.onLanguageChanged

    property string mViewMap: qsTr("View Map") + Retranslate.onLanguageChanged
    property string mReset: qsTr("Reset") + Retranslate.onLanguageChanged
    property string mDirections: qsTr("Directions") + Retranslate.onLanguageChanged
    property string mTo1: qsTr("To:") + Retranslate.onLanguageChanged
    property string mTotalDuration: qsTr("Total Duration:") + Retranslate.onLanguageChanged
    property string mTotalLength: qsTr("Total Length:") + Retranslate.onLanguageChanged
    property string mSteps: qsTr("Steps") + Retranslate.onLanguageChanged
    property string mHome: qsTr("Home") + Retranslate.onLanguageChanged
    property string mBack: qsTr("Back") + Retranslate.onLanguageChanged

    property string mShareonFacebook: qsTr("Share On Facebook") + Retranslate.onLanguageChanged
    property string mShareonTwitter: qsTr("Share On Twitter") + Retranslate.onLanguageChanged
    property string mEmailToFriend: qsTr("Email To Friend") + Retranslate.onLanguageChanged
    property string mSMSToFriend: qsTr("SMS To Friend") + Retranslate.onLanguageChanged
    property string mCopyToClipboard: qsTr("Copy To Clipboard") + Retranslate.onLanguageChanged

    property string mqmlToast: qsTr("No matching data found!") + Retranslate.onLanguageChanged
    property string mqmlToastemptyValueUAENG: qsTr("Please provide valid value") + Retranslate.onLanguageChanged

    property string mHintNorthing: qsTr("Northing") + Retranslate.onLanguageChanged
    property string mHintEasting: qsTr("Easting") + Retranslate.onLanguageChanged
    property string mInfoMakaniNumber: qsTr("Makani Number : ") + Retranslate.onLanguageChanged
    property string mInfoUAENG: qsTr("UAE NG : ") + Retranslate.onLanguageChanged
    property string mInfoTelNo: qsTr("Tel No.: ") + Retranslate.onLanguageChanged
    property string mInfoFaxNo: qsTr("Fax No.: ") + Retranslate.onLanguageChanged
    property string mInfoLicenseNo: qsTr("License No.: ") + Retranslate.onLanguageChanged
    property string mInfoPoboxNo: qsTr("P.O.box No.: ") + Retranslate.onLanguageChanged
    property string mInfoUrl: qsTr("URL: ") + Retranslate.onLanguageChanged
    property string mInfoEmail: qsTr("Email: ") + Retranslate.onLanguageChanged
    property string mInfoBuildingNo: qsTr("Building No.: ") + Retranslate.onLanguageChanged
    property string mInfoNotice: qsTr("We are commited to provide high accuracy for location & building outline. Some areas are under study & we will update it soon with building outline & information.") + Retranslate.onLanguageChanged

    property string mValidationNoDataFound: qsTr("No Data Found") + Retranslate.onLanguageChanged
    property string mTitleAddToFavourites: qsTr("Add to favourites") + Retranslate.onLanguageChanged
    property string mName: qsTr("Name") + Retranslate.onLanguageChanged
    property string mLocation: qsTr("Location") + Retranslate.onLanguageChanged
    property string mMap: qsTr("Map") + Retranslate.onLanguageChanged
    property string mHomePane: qsTr("Home") + Retranslate.onLanguageChanged
    property string mSettings: qsTr("Settings") + Retranslate.onLanguageChanged
    property string mChangeLanguage: qsTr("Change Language") + Retranslate.onLanguageChanged
    property string mEnglish: qsTr("English") + Retranslate.onLanguageChanged
    property string mArabic: qsTr("العربي") + Retranslate.onLanguageChanged

    property int searchTextFiledWidth: 350
    property int searchTextFiledFullWidth: 600
    property int searchTextFiledWidthWithButton: 475
    property int searchListHeight: 70

    property variant lightBlueColor: Color.create("#00B6E8")
    property variant darkBlueColor: Color.create("#004C64")

    property string mShareURL: "http://www.makani.ae/geomob/?lang="

    property string mContactTitle: qsTr("Dubai Municipality - Main Building") + Retranslate.onLanguageChanged

    property string mTransitModebus: qsTr("transit") + Retranslate.onLanguageChanged
    property string mTransitModecar: qsTr("driving") + Retranslate.onLanguageChanged
    property string mTransitModewalk: qsTr("walking") + Retranslate.onLanguageChanged

    property string mDialogTilteCategory: qsTr("Category") + Retranslate.onLanguageChanged
    property string mNearByCategory: qsTr("Categories") + Retranslate.onLanguageChanged

    property string mFeebackResponseSuccess: qsTr("Feedback Submitted Successfully") + Retranslate.onLanguageChanged
    property string mFeebackResponseFailed: qsTr("Feedback Submition Failed") + Retranslate.onLanguageChanged
    property string mFeedBackinvalidEmail: qsTr("Enter valid email address") + Retranslate.onLanguageChanged
    property string mFeedBackenterFeddback: qsTr("Please Enter Feedback") + Retranslate.onLanguageChanged
    property string mFeedBackSelectType: qsTr("Please Select The Type") + Retranslate.onLanguageChanged
    

    property string mRatingsPoor: qsTr("POOR") + Retranslate.onLanguageChanged
    property string mRatingsAverage: qsTr("AVERAGE") + Retranslate.onLanguageChanged
    property string mRatingsGood: qsTr("GOOD") + Retranslate.onLanguageChanged
    property string mRatingsVeryGood: qsTr("VERY GOOD") + Retranslate.onLanguageChanged
    property string mRatingsExcellent: qsTr("EXCELLENT") + Retranslate.onLanguageChanged
    property string mRatingsSuccess: qsTr("Rating  submitted successfully") + Retranslate.onLanguageChanged
    property string mRatingsFail: qsTr("Rating not submitted successfully") + Retranslate.onLanguageChanged

    property string mTutorial: qsTr("Tutorial") + Retranslate.onLanguageChanged
    property string mFAQ: qsTr("FAQ") + Retranslate.onLanguageChanged
    property string mQuickTutorial: qsTr("Quick Tutorial") + Retranslate.onLanguageChanged
    property string mVideoTutorial: qsTr("Video Tutorial") + Retranslate.onLanguageChanged
    property string mQuickGuideTutorial: qsTr("Quick Guide") + Retranslate.onLanguageChanged
    property string mQuickUserGuideTutorial: qsTr("User Guide") + Retranslate.onLanguageChanged
    property string mDontshowatstartup: qsTr("Don't show at start up") + Retranslate.onLanguageChanged

    property string mMapLegend: qsTr("Map Legend") + Retranslate.onLanguageChanged
    property string mMapSelectedLocation: qsTr("Map Selected Location") + Retranslate.onLanguageChanged
    property string mMapPinEmergency: qsTr("Makani Emergency Entrance.") + Retranslate.onLanguageChanged
    property string mMapPinmakani: qsTr("Makani pin. Tap to know the Makani Number.") + Retranslate.onLanguageChanged
    property string mMapPinuaeng: qsTr("UAE NG pin. Press for 2 seconds to know the location.") + Retranslate.onLanguageChanged

    property string mshow_more: qsTr("show_more..") + Retranslate.onLanguageChanged
    property string mSelectDestination: qsTr("Select Destination") + Retranslate.onLanguageChanged

    property string mdirectionRouteoption: qsTr("Route Option") + Retranslate.onLanguageChanged
    property string mdirectionAvoidSalik: qsTr("Avoid salik/Toll") + Retranslate.onLanguageChanged
    property string mdirectionAvoidhighway: qsTr("Avoid Highway") + Retranslate.onLanguageChanged
    property string mdirectionSearchranges: qsTr("Search ranges :") + Retranslate.onLanguageChanged
    property string mdirectionDistanceWithin: qsTr("Distance Within") + Retranslate.onLanguageChanged
    property string mdirectionMeters: qsTr("Meters") + Retranslate.onLanguageChanged
    property string mdirectionsubmit: qsTr("Submit") + Retranslate.onLanguageChanged
    property string mDestination1: qsTr("Destination 1") + Retranslate.onLanguageChanged
    property string mDestination2: qsTr("Destination 2") + Retranslate.onLanguageChanged
    property string mpoihintText: qsTr("Dubai Municipality") + Retranslate.onLanguageChanged
    property string mInfoEntranceName: qsTr("Entrance Name :") + Retranslate.onLanguageChanged
    property string mInfoAddress: qsTr("Address") + Retranslate.onLanguageChanged
    property string mInfoCommunity: qsTr("Community :") + Retranslate.onLanguageChanged
    property string mInfoStreet: qsTr("Street : ") + Retranslate.onLanguageChanged
    property string mnearbyvalidation: qsTr("Please select Category") + Retranslate.onLanguageChanged
    property string mnearbyvalidationtype: qsTr("Please select Type") + Retranslate.onLanguageChanged
    property string mnearbyvalidationdistance: qsTr("Please enter Distance") + Retranslate.onLanguageChanged
    property string mRatingvalidationdstarts: qsTr("Please select stars") + Retranslate.onLanguageChanged
    property string mNearByNearest: qsTr("Nearest") + Retranslate.onLanguageChanged
    property string mDirectionAdddestination: qsTr("Add destination") + Retranslate.onLanguageChanged
    property string mNearByvalidationtype: qsTr("Please Select Proper Service") + Retranslate.onLanguageChanged
    property string mNearByvalidationdistancelessthan10: qsTr("Please enter distance less than 10 Km") + Retranslate.onLanguageChanged

    property string mGpsLocationMessage: qsTr("Turn On Location Services to Allow Makani to Determine Your Locatioin") + Retranslate.onLanguageChanged
    property string mAppName: qsTr("Makani") + Retranslate.onLanguageChanged
    property string mMAKANI: qsTr("MAKANI") + Retranslate.onLanguageChanged

    property string mFedbacktypeHint: qsTr("Select type") + Retranslate.onLanguageChanged

    property string mTextMakaniCC: qsTr("Makani") + Retranslate.onLanguageChanged
    
    property string mFaviouritesEdit: qsTr("Please select one record to edit")+Retranslate.onLanguageChanged
    property string mFaviouritesOneRecordEdit: qsTr("Please select one record to editing")+Retranslate.onLanguageChanged
    property string mFaviouritesOther: qsTr("Please select atleast one location")+Retranslate.onLanguageChanged
    property string mPleaseselectFromDestination: qsTr("Please select From and Destination(s)")+Retranslate.onLanguageChanged
    property string mOntwitterusercanshareonlyonemakaninumber: qsTr("On twitter user can share only one makani number")+Retranslate.onLanguageChanged
    property string mLastMapSelectedLocations: qsTr("Last Map Selected Locations")+Retranslate.onLanguageChanged
    
    
    

}
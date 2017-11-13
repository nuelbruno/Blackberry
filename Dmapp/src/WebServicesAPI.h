/*
 * WebServicesAPI.cpp
 *
 *  Created on: 05-Sep-2013
 *      Author: Rahul
 */

#ifndef WebServicesAPI_H_
#define WebServicesAPI_H_
#include <bb/ApplicationInfo>
#include <bb/platform/geo/Style>
#include "qtsoap/QtSoapHttpTransport.h"
#include <QtCore/QObject>
#include <QtCore/QFile>
#include <QtCore/QString>
#include <QtCore/QVariant>
#include <bb/cascades/QListDataModel>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/GroupDataModel>
#include <bb/system/SystemDialog>
#include <bb/system/LocaleHandler>
#include <bb/system/InvokeManager.hpp>
#include <bb/system/InvokeRequest.hpp>
#include <bb/platform/geo/GeoLocation.hpp>
#include <QtLocationSubset/QGeoCoordinate>
#include <QtLocationSubset/QGeoSearchManager>
#include <bb/data/XmlDataAccess>
#include <bps/bps.h>
#include <bps/geolocation.h>
#include <QDebug>
#include <QPointer>
#include <string.h>
#include "WebServicesAPI.h"
#include <bb/PpsObject>
#include <QtLocationSubset/qgeopositioninfo.h>
#include <QtLocationSubset/qgeopositioninfosource.h>

#include <math.h>
#include <QSize>
#include <bb/cascades/ArrayDataModel>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/ViewProperties>
#include <bb/platform/geo/Marker>
#include <bb/platform/geo/GeoLocation>
#include <bb/platform/geo/Coordinate>
#include <bb/platform/geo/Polyline>
#include <bb/platform/geo/GeoPolyline>
#include <bb/platform/geo/GeoPolygon>
#include <bb/platform/geo/Geographic>
#include <bb/platform/geo/Style>
#include <bb/platform/geo/StyleSheet>
#include <bb/platform/geo/EdgeSize>
#include <bb/platform/geo/EdgeStyle>
#include <bb/platform/geo/BoundingBox>
#include <bb/cascades/maps/MapData>
#include <bb/system/SystemToast>
#include "applicationui.hpp"
#include <bb/platform/geo/GeoLocation>
#include <QtLocationSubset/QGeoSearchReply>
#include <QtLocationSubset/QGeoServiceProvider>

#include <bb/system/SystemListDialog>
#include <bb/system/SystemDialog>
#include <bb/system/SystemListDialog>
#include <bb/system/SystemProgressDialog>
#include <bb/system/SystemPrompt>
#include <bb/system/SystemCredentialsPrompt>
#include <bb/system/SystemToast>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemUiButton>
#include <bb/system/SystemUiInputField>
#include <bb/system/SystemUiError>
#include <bb/system/SystemUiInputMode>
#include <bb/system/SystemUiModality>
#include <bb/system/SystemUiPosition>
#include <bb/system/SystemUiProgressState>
#include <bb/system/SystemUiResult>
#include <bb/system/SystemUiReturnKeyAction>
#include <bb/cascades/DropDown>
#include <bb/system/SystemToast>
#include <bb/pim/contacts/ContactService>
#include <bb/pim/contacts/ContactAttribute>
#include <bb/pim/contacts/ContactAttributeBuilder>
#include "PoiData.h"
#include <bb/cascades/ImageView>
using namespace bb::system;
using namespace bb::platform;
using namespace bb::cascades;
using namespace QtMobilitySubset;
using namespace bb::platform::geo;
using namespace bb::cascades::maps;
using bb::cascades::Application;
class WebServicesAPI: public QObject
{

    Q_OBJECT

    Q_PROPERTY(bool succeeded READ succeeded NOTIFY statusChanged)
    Q_PROPERTY(bool active READ active NOTIFY activeChanged)
    Q_PROPERTY(QString statusMessage READ statusMessage NOTIFY statusDone)
    Q_PROPERTY(bb::cascades::DataModel* model READ model CONSTANT)
    Q_PROPERTY(bb::cascades::DataModel* imageModel READ imageModel CONSTANT)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodel READ mymodel NOTIFY modelchanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelStreet READ mymodelStreet NOTIFY modelStreetchanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelBuiding READ mymodelBuiding NOTIFY modelBuidingchanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelcommunity READ mymodelcommunity NOTIFY modelcommunitychanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelcategory READ mymodelcategory NOTIFY modelcategorychanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelservice READ mymodelservice NOTIFY modelservicechanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelfeedbacktype READ mymodelfeedbacktype NOTIFY modelfeedbacktypechanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelNearBy READ mymodelNearBy NOTIFY modelNearBychanged)
    Q_PROPERTY(bb::cascades::GroupDataModel* mymodelTutorial READ mymodelTutorial NOTIFY modelTutorialchanged)

    Q_PROPERTY(bb::cascades::DataModel* mymodelpoinearby READ mymodelpoinearby NOTIFY modelpoinearbychanged)

    Q_PROPERTY(QString poiName READ poiName NOTIFY poiNameDone)

    Q_PROPERTY(QString poiMakaniUAENG READ poiMakaniUAENG NOTIFY poiMakaniUAENGDone)
    Q_PROPERTY(QString poiPhone READ poiPhone NOTIFY poiPhoneDone)
    Q_PROPERTY(QString poiFax READ poiFax NOTIFY poiFaxDone)
    Q_PROPERTY(QString poiEmail READ poiEmail NOTIFY poiEmailDone)
    Q_PROPERTY(QString poiLicense READ poiLicense NOTIFY poiLicenseDone)
    Q_PROPERTY(QString poiURL READ poiURL NOTIFY poiURLDone)
    Q_PROPERTY(QString poiPOBox READ poiPOBox NOTIFY poiPOBoxDone)
    Q_PROPERTY(QVariant mnearByLastIndex READ mnearByLastIndex NOTIFY mnearByLastIndexDone)
//	Q_PROPERTY(QString getMyLocation READ getMyLocation NOTIFY getMyLocationDone)
    Q_PROPERTY(QString mEntrance READ mEntrance NOTIFY mEntranceDone)
    Q_PROPERTY(QString mROADNAMEEN READ mROADNAMEEN NOTIFY mROADNAMEENDone)
    Q_PROPERTY(QString mBUILDING_NO READ mBUILDING_NO NOTIFY mBUILDING_NODone)
    Q_PROPERTY(QString mCOMM_EN READ mCOMM_EN NOTIFY mCOMM_ENDone)
    Q_PROPERTY(QString mPICTURE READ mPICTURE NOTIFY mPICTUREDone)
    Q_PROPERTY(QString mLandNumber READ mLandNumber NOTIFY mLandNumberDone)

public:

    WebServicesAPI(QObject* parent = 0);

    bool succeeded() const;
    bool active() const;
    QString error() const;
    QString statusMessage() const;
    QString poiName() const;
    QString poiMakaniUAENG() const;
    QString poiPhone() const;
    QString poiFax() const;
    QString poiEmail() const;
    QString poiLicense() const;
    QString poiURL() const;
    QString mEntrance() const;
    QString mROADNAMEEN() const;
    QString mBUILDING_NO() const;
    QString mCOMM_EN() const;
    QString mPICTURE() const;
    QString mLandNumber() const;
    QVariant mnearByLastIndex();

    bool isisfromMapselectedLocation();

    Q_INVOKABLE
    void setisfromMapselectedLocation(bool checkismapselected);

    // Added By Rahul
    Q_INVOKABLE
    QString getAboutUsHtml();Q_INVOKABLE
    QString getContactUsHtml();Q_INVOKABLE
    QString getDisclamerHtml();

    Q_INVOKABLE
    QString getAboutUsHtmlAR();Q_INVOKABLE
    QString getContactUsHtmlAR();Q_INVOKABLE
    QString getDisclamerHtmlAR();

    Q_INVOKABLE
    void shortingDataModel(QString keyword);

    QString poiPOBox() const;Q_INVOKABLE
    QString getMyLocation();

    QString dateFormate(QString mData);Q_INVOKABLE
    void saveValueFor(const QString &objectName, const QString &inputValue);Q_INVOKABLE
    QString getValueFor(const QString &objectName, const QString &defaultValue);Q_INVOKABLE
    QString imageToByte(const QString &imagePath);

    Q_INVOKABLE
    void startGPS();Q_INVOKABLE
    void drawCurrentLocation();Q_INVOKABLE
    void writeResponse(QString response, QString filename);Q_INVOKABLE
    void changeDataModelOrder(GroupDataModel *mm_model);

    Q_INVOKABLE
    QVariantList getQVariantListData();

    Q_INVOKABLE
    void GetParcelOutline(QString parcelId, QString token, QString remarks);Q_INVOKABLE
    void GetParcelOutline_New(QString parcelId);Q_INVOKABLE
    void getDirectionLatLon(QString value, QString type);Q_INVOKABLE
    void getCoordinateConversion(QString coordinateX, QString coordinateY, QString type, QString convertFrom, bool isFromMyLocation);Q_INVOKABLE
    void getCoordinateConversionLongPress(bb::platform::geo::Point point);Q_INVOKABLE
    void GetAllCommunities(QString lang);Q_INVOKABLE
    void GetAllServices(QString from);Q_INVOKABLE
    void GetBuildingAddress(QString communityname, QString streetname, QString buildingname, QString lang);Q_INVOKABLE
    void GetBuildingInfo(QString makaninumber);Q_INVOKABLE
    void GetBuildingOutLine_EntrancePoints(QString lat, QString lng, bool needConvert, bool fromMultiplePin);Q_INVOKABLE
    void GetBuildingsList(QString communityname, QString streetname, QString lang);Q_INVOKABLE
    void GetCategoriesByServiceID(QString serviceid);Q_INVOKABLE
    void GetPOIByServiceIDAndCategoryId(QString categoryid, QString serviceid);Q_INVOKABLE
    void GetPOIByServiceIDCategoryIdPOI(QString categoryid, QString serviceid, QString poiname, QString lang);Q_INVOKABLE
    void GetPOIFromNearestLocation(QString serviceid, QString lat, QString lng);Q_INVOKABLE
    void GetPOIInfo(QString poiname, QString lang, bool isAuto, QString mFrom);Q_INVOKABLE
    void GetStreetsFromCommunity(QString communityname, QString streetname, QString lang);Q_INVOKABLE
    void UAENGtoCoordinates(QString UAENG, QString token, QString convertFrom);Q_INVOKABLE
    void DMSToCoordinates(QString lat1, QString lat2, QString lat3, QString lon1, QString lon2, QString lon3);Q_INVOKABLE
    void GetMakaniNo(QString makaninumber);Q_INVOKABLE
    void CoordinateConversion1(QString type, QString coordinateX, QString coordinateY, QString token, QString convertFrom);Q_INVOKABLE
    void searchDataFilter(QString words, QString from);
    void dataFilter(QString words, QString from);Q_INVOKABLE
    void getPOI(QString serviceid, QString categoryid, QString noofrecords, QString withindistance, QString lat, QString lng, QString remarks);Q_INVOKABLE
    void setPoiInfoData(QString name, QString telephone, QString fax, QString email, QString license, QString url, QString pobox);Q_INVOKABLE
    void setPinFromFav(bool isNearBy, bool isFirst, QString location, QString lat, QString lon, QString name, QString telephone, QString fax, QString email, QString license, QString url, QString pobox);Q_INVOKABLE
    void GetFeedbackType();Q_INVOKABLE
    void InsertRatings(QString ratingId);

    Q_INVOKABLE
    void GetMakaniFeedback(QString typeId, QString remarks, QString emailid);

    Q_INVOKABLE
    bool searchDataFilterCommunity(QString words, QString from);
    bool dataFilterCommunity(QString words, QString from);

    Q_INVOKABLE
    void showAllPinOfPlacesByCategory();Q_INVOKABLE
    void searchDataFilterService(QString words, QString from);
    void dataFilterService(QString words, QString from);Q_INVOKABLE
    bool searchDataFilterStreet(QString words, QString from);
    bool dataFilterStreet(QString words, QString from);

    Q_INVOKABLE
    bool searchDataFilterBuilding(QString words, QString from);
    bool dataFilterBuilding(QString words, QString from);Q_INVOKABLE
    void searchDataFilterForService(QString words, QString from);
    void dataFilterForService(QString words, QString from);

    Q_INVOKABLE
    bool searchDataFilterCategory(QString words, QString from);
    bool dataFilterCategory(QString words, QString from);

    void showToast(bool hasMatch);Q_INVOKABLE
    QStringList getUAENGData();Q_INVOKABLE
    void searchDataFilterPOI(QString words, QString from);
    void dataFilterPOI(QString words, QString from);
//my web service response parse method
    void parseGetAllCommunities(QString data);
    void parseGetAllServices(QString data);
    void parseGetBuildingAddress(QString data);
    void parseGetBuildingInfo(QString data);
    void parseGetBuildingOutLine_EntrancePoints(QString data);
    void parseGetBuildingsList(QString data);
    void parseGetCategoriesByServiceID(QString data);
    void parseGetPOIByServiceIDAndCategoryId(QString data);
    void parseGetPOIFromNearestLocation(QString data);
    void parseGetPOIInfo(QString data);
    void parseGetPOILatLng(QString data);
    void parseGetStreetsFromCommunity(QString data);
    void parseUAENGtoCoordinates(QString data);
    void parseUAENGtoCoordinatesLongPress(QString data);

    void parseGetMakaniNo(QString data);
    void parseGetParcelOutline(QString data);
    void parseGetPOI(QString data);
    void parseGetFeedbackType(QString mdata);
    void parseMakaniFeedback(QString mdata);
    void parseGetParcelOutline_New(QString mdata);
    void parseGetPOIByServiceIDCategoryIdPOI(QString mdata);

    //my web service response parse method ends
    Q_INVOKABLE
    void ClearMapdata();
    void parseInsertRatings(QString mdata);Q_INVOKABLE
    void initMapData();
    bb::ApplicationInfo *minfo;Q_INVOKABLE
    void drawPinOnMap(QString image_name, QString latlng, QString title, qint64 pintype, QVariant dataMap);Q_INVOKABLE
    void getMyObject(QObject* mapObject);Q_INVOKABLE
    void setZoomLevelForMap(MapData* mMapData);
    void setZoomLevelForMap1(MapData* mMapData);

    Q_INVOKABLE
    void drawBulidingOutLineBlue(QList<float> listLat, QList<float> listLon, QString name, MapData* mMapData);Q_INVOKABLE
    void drawBulidingOutLineRed(QList<float> listLat, QList<float> listLon, QString name, MapData* mMapData);

    Q_INVOKABLE
    void mPICTUREValueNULL();

    void drawBulidingOutLine(QList<float> listLat, QList<float> listLon, QString name);
    void drawBulidingOutLineForPARCEL(QList<float> listLat, QList<float> listLon, QString name);Q_INVOKABLE
    void setFouceId(QString myfocuSId);
    const QString getFouceId();Q_INVOKABLE
    QString getMapCaptionText();Q_INVOKABLE
    QString getMapCaptionLatitude();Q_INVOKABLE
    QString getMapCaptionLongitude();Q_INVOKABLE
    bool getOutlineBuilding();
    void drawSingleBuilding(QString lat, QString lng);Q_INVOKABLE
    void ShowDialog(bool isCat);Q_INVOKABLE
    QStringList getCategoryDialogdata();Q_INVOKABLE
    QString getId(QString myIndex);Q_INVOKABLE
    void getDropDownServic(QObject* mapObject);Q_INVOKABLE
    QString getCatValueFromId(QString myIndex);Q_INVOKABLE
    QString getServiceId();Q_INVOKABLE
    QString setServiceId(QString myServiceId);Q_INVOKABLE
    QString getValueFromName(QString myCatName);Q_INVOKABLE
    QVariantList getBuildingListData();Q_INVOKABLE
    QString checkAdvanceSearchNumber(QString mAdvanceSearchText);Q_INVOKABLE
    QString checkInvalid(QString mValue);Q_INVOKABLE
    QString validateString(QString mValue);Q_INVOKABLE
    QString ConvertToUAENG(QString myStr);
    QString getConvertedValue(QRegExp checkrx, QString mydataStr, bool isFromFirst);Q_INVOKABLE
    bool isCharecteresOnly(QString myStr);Q_INVOKABLE
    bool isNumberOnly(QString myStr);Q_INVOKABLE
    bool isValidUTMNumber(QString myStr);Q_INVOKABLE
    QString getcontactNumber(qint64 id);Q_INVOKABLE
    QString getCCMakani();Q_INVOKABLE
    QString getCCUAENG();Q_INVOKABLE
    QString getCCUTM1();Q_INVOKABLE
    QString getCCUTM2();Q_INVOKABLE
    QString getCCDLTM1();Q_INVOKABLE
    QString getCCDLTM2();Q_INVOKABLE
    QString getCCLatitude();Q_INVOKABLE
    QString getCCLongitude();Q_INVOKABLE
    QString getCCDMSLatitude1();Q_INVOKABLE
    QString getCCDMSLatitude2();Q_INVOKABLE
    QString getCCDMSLatitude3();Q_INVOKABLE
    QString getCCDMSLongitude1();Q_INVOKABLE
    QString getCCDMSLongitude2();Q_INVOKABLE
    QString getCCDMSLongitude3();Q_INVOKABLE
    QString getNODATA();Q_INVOKABLE
    QString getBuildingToDirectionLatLng(QString isfrom);Q_INVOKABLE
    void setBuildingToDirectionLatLng(QString latlng, QString isfrom);
    QString checkisFrom();Q_INVOKABLE
    void setcheckisFrom(QString isfrom);

    bool checkisFromAdvanceSearch();Q_INVOKABLE
    void setcheckisFromAdvanceSearch(bool isfrom);Q_INVOKABLE
    QString getUrl(QString startLocation, QString endLocation, QString transitMode, bool isfromVia, QString via, bool isAvoidHighwayActivated, bool isAvoidSalikTollActivated);Q_INVOKABLE
    void callGoogleRoutes(QString url);Q_INVOKABLE
    void callGoogleApi(QString data, bool isFirst);Q_INVOKABLE
    void callGoogleReverceGeoCodeApi();Q_INVOKABLE
    QString getStepsData();Q_INVOKABLE
    QStringList getFromToData();Q_INVOKABLE
    QString myPolylineData();

    Q_INVOKABLE
    QString getStepsDataVia();Q_INVOKABLE
    QStringList getTotoViaData();

    Q_INVOKABLE
    QVariantList getDirectionStepList();

    void decodePoly(QString encoded);Q_INVOKABLE
    void myPOIgeoCodeData(QString mpoiAddress);Q_INVOKABLE
    QString getPOIlatlng();Q_INVOKABLE
    QString CommonSearchvalidation(QString mValue);Q_INVOKABLE
    QString getmapDataFromFocusId();Q_INVOKABLE
    bool hasGotResponse();Q_INVOKABLE
    void SetPOISearch(bool is);Q_INVOKABLE
    bool checkPOISearch();
    void setMulitple(QString labelMulitple);Q_INVOKABLE
    QString getMulitple();Q_INVOKABLE
    void getcontactNumberFromAdvanceSearch(qint64 id);Q_INVOKABLE
    void drawpinOnDecodedPoly(QString fromPlace, QString toPlace, QString toVia);Q_INVOKABLE
    void drawpinOnDecodedPolyNew(QVariantList mlist, QString fromplace, QString toplace, QString viaplace);Q_INVOKABLE
    void drawpinOnDecodedPolyForVia(QString fromPlace, QString toPlace, QString viaPlace);
    void drawRoute(QList<float> listLat, QList<float> listLon, QString name);

    Q_INVOKABLE
    void SetisPOITextChanging(bool isTextChanging);

    void showMySystemDialog(QString body);Q_INVOKABLE
    void longPressOnMap(bb::platform::geo::Point point);Q_INVOKABLE
    bool getcheckResponseNullResult();Q_INVOKABLE
    bool getCat();Q_INVOKABLE
    void setcat(bool arg1);

    Q_INVOKABLE
    bool checkLandNumberValidatoin(QString mStringToValidate);

    void setFeedbackValue(QString mvalue);Q_INVOKABLE
    QString getFeedbackValue();Q_INVOKABLE
    bool isIsfromNearByDetails() const;Q_INVOKABLE
    void setIsfromNearByDetails(bool isfromNearByDetailstemp);Q_INVOKABLE
    void SetMyCheckBoxList(QString myvalue, bool isChecked);Q_INVOKABLE
    QStringList getmylist();Q_INVOKABLE
    void loadDatamore(const QVariantList &indexPath);Q_INVOKABLE
    void callTUTORIAL();Q_INVOKABLE
    QVariantList getImages();Q_INVOKABLE
    void dropMapPinForSelectedData(QVariantList mStringList);Q_INVOKABLE
    void setMapSinglePinForSelectedData(QString lat, QString lng, QString location);Q_INVOKABLE
    QStringList getMapSinglePinForSelectedData();Q_INVOKABLE
    bool checkisdirectionbuilding();

    Q_INVOKABLE
    void setcheckisdirectionbuilding(bool isdirectionBuidingAddressarg);

    void parseViaGetJourneyPlannerDirectionStep(QString mData);Q_INVOKABLE
    void setpicturefromqml(QString url);
    void clearmyInfoPopupData();public Q_SLOTS:

    /**
     * Called when the current position is updated.
     */
    void positionUpdated(QGeoPositionInfo geoPositionInfo);

    void requestFinished(QNetworkReply* reply);
    void requestFinishedFaq(QNetworkReply* reply);

    void callWS(const QString &action, const QString &host, const QString &prefix, const QtSoapMessage &request, const bool &isSecure);
    void callAutoCompleteWS(const QString &action, const QString &host, const QString &prefix, const QtSoapMessage &request, const bool &isSecure);
    void callSVC(const QString &action, const QString &host, const QString &prefix, const QString &request, const bool &isSecure);
    void replyFinished(QNetworkReply* reply);
    void searchResults(QGeoSearchReply *reply);Q_INVOKABLE
    void reverseGeoCode();
    void readReverseGeocode(QGeoSearchReply *reply);
    void replyFinishedGoolgeApi(QNetworkReply* replyApi);
    void replyFinishedGoolgeReverceGeoCodeApi(QNetworkReply* replyApi);
    //	** List all post Web Services methods. **

    Q_SIGNALS:
    void statusChanged(); // for final responce
    void activeChanged(); // for activity indicator
    void statusDone(); // for set responce message
    void dataLoaded(); // for data loaded completion
    void noDataFound(); // for data loaded completion
    void modelchanged();
    void modelcommunitychanged();
    void modelStreetchanged();
    void modelBuidingchanged();
    void modelcategorychanged();
    void modelservicechanged();
    void modelpoinearbychanged();
    void modelfeedbacktypechanged();
    void modelNearBychanged();
    void modelTutorialchanged();
    void serviceDataLoad();
    void directionServiceDataLoaded();
    void routeDataLoaded();
    void poidataloaded();

    void poiNameDone();
    void poiMakaniUAENGDone();
    void feedbackNamedone();
    void poiPhoneDone();
    void poiFaxDone();
    void poiEmailDone();
    void poiLicenseDone();
    void poiURLDone();
    void poiPOBoxDone();
    void getMyLocationDone();
    void checkDataNull();
    void catdataload();
    void buildingDataLoaded(QString arg1);
    void feedbackSubmit(QString arg1);
    void mnearByLastIndexDone();
    void mEntranceDone();
    void mROADNAMEENDone();
    void mBUILDING_NODone();
    void mCOMM_ENDone();
    void mPICTUREDone();
    void mLandNumberDone();
    void insertRatingsDone(bool mValue);
    void onComplete(QByteArray, bool);
    void tutorialDone();public Q_SLOTS:
    /*
     * Handler for SOAP request response
     */
    void onServiceResponse();
    void onServiceResponsePOIAutoComplete();

public:
    bool m_succeeded; // flag to determine MOL request succeeded
    bool m_active; // flag to determine MOL a request is running
    QtSoapHttpTransport m_soap; // soap transport
    QtSoapHttpTransport m_soap_POIAutoComplete;

    QString mCurrentWS;
    QString mCurrentWSAuto;
    QString mWSHost;
    QString mWSPrefix;
    QString mTockenID;
    QString mResponseStatusValue;
    QString mDateValue;
    QString mErrorMessage;
    QString mResponceScript;

    QFile *mFile;

    QNetworkAccessManager *mNetworkAccessManager;
    QNetworkAccessManager *mNetworkAccessManagerFaq;
    QNetworkRequest request;

    QVariantList mQVariantListData;

    bb::cascades::DataModel* model() const;

    bb::cascades::GroupDataModel *mm_model;
    bb::cascades::GroupDataModel* mymodel();

    bb::cascades::GroupDataModel *mm_modelStreet;
    bb::cascades::GroupDataModel* mymodelStreet();

    bb::cascades::GroupDataModel *mm_modelBuiding;
    bb::cascades::GroupDataModel* mymodelBuiding();

    bb::cascades::GroupDataModel* mymodelcommunity();
    bb::cascades::GroupDataModel *mm_modelCommunity;

    bb::cascades::GroupDataModel* mymodelcategory();
    bb::cascades::GroupDataModel *mm_modelcategory;

    bb::cascades::GroupDataModel* mymodelservice();
    bb::cascades::GroupDataModel *mm_modelservice;

    bb::cascades::GroupDataModel* mymodelfeedbacktype();
    bb::cascades::GroupDataModel *mmodelfeedbacktype;

    bb::cascades::GroupDataModel* mymodelNearBy();
    bb::cascades::GroupDataModel *mm_modelNearBy;

    bb::cascades::GroupDataModel* mymodelTutorial();
    bb::cascades::GroupDataModel *mm_mymodelTutorial;

    bb::cascades::DataModel* mymodelpoinearby();
    bb::cascades::QListDataModel<QObject*>* mm_modelpoinearby;

    bb::cascades::DataModel* imageModel() const;

    Q_INVOKABLE
    QList<float>& getListLat();

    Q_INVOKABLE
    QList<float>& getListLng();

    Q_INVOKABLE
    bool isIsfromLandNumber() const;

    Q_INVOKABLE
    void setIsfromLandNumber(bool checkisfromLandNumber);

    Q_INVOKABLE
    QString isFaqResultUrl() const;

    Q_INVOKABLE
    void setFaqResultUrl(QString mfaqResultUrl);Q_INVOKABLE
    QString setQuickGuideUrl();Q_INVOKABLE
    void setmactive(bool mvalue);
    void callFaq(QString mfaqUrl);

    bb::cascades::QListDataModel<QObject*>* m_modelImageList;

    bb::platform::geo::GeoLocation* deviceLocation;
    QPointer<QGeoPositionInfoSource> locationDataSource;
    QGeoPositionInfo myPositionInfo;
    QVariantList mlistSearchCommunity;
    QVariantList mlistSearchStreet;
    QVariantList mlistSearchMakani;
    QVariantList mlistSearchBuilding;
    QVariantList mlistSearchPOI;
    QVariantList mlistSearchPlaceName;

    QVariantList mQVariantDirectionStepListData;

    QVariantList mQVariantRouteFromToVia;
    QVariantList mQVariantRouteFromToViaNew;

    MapView *myMapView;
    bb::cascades::Application *app;
    Marker mMarker;
    QString mapLabelText;
    QString mapLabelLatitude;
    QString mapLabelLongitude;
    bool isOutlineBuilding;
    QString latlng;
    QString mapFocusId;
    QList<float> mListLat;
    QList<float> mListLng;
    QStringList mLisToSend;
    bool isFromConverter;
    SystemListDialog *listCategory;
    SystemListDialog *listService;
    QStringList mListDialogData;
    QVariantList mServiceResponseId;
    QVariantList mCategoryResponseId;
    QVariantMap mMapForCurrentLocationTemp;
    QString mCCMakani;
    QString mCCUAENG;
    QString mCCUTM1;
    QString mCCUTM2;
    QString mCCDLTM1;
    QString mCCDLTM2;
    QString mCCLatitude;
    QString mCCLongitude;
    QString mCCDMSLatitude1;
    QString mCCDMSLatitude2;
    QString mCCDMSLatitude3;
    QString mCCDMSLongitude1;
    QString mCCDMSLongitude2;
    QString mCCDMSLongitude3;
    QString mNODATA;

    DropDown *ddTypeService;
    QString mServiceIdfromQml;
    QString mBuildingLATLNG;
    QString mBuildingLATLNGTo;
    QString mBuildingLATLNGVia;

    QString isFromBuilding;
    bool isFromDirectionBuilding;
    QString mStepsData;
    QString mStepsDataVia;
    QStringList mFromToDirectionData;
    QStringList mTotoViaDirectionData;
    QString mPolylineData;
    QString mPolylineDataVia;

    QGeoSearchManager *searchManager;
    QGeoAddress searchAddress;
    QGeoSearchReply *reply;
    QString mPOIdatalatng;
    QString mapDataFromFocusId;

    qint64 mPinType;
    qint64 mPinTypeMultiple;
    qint64 mPinTypeSingle;
    qint64 mPinTypeEntrance;
    qint64 mPinTypeEntranceSelected;
    qint64 mPinTypeRoutePoint;

//	bool isPinMultiple;
//	bool isEntrance;
    bool hasResponse;
    bool isPOISearch;
    bool isPOITextChanging;

    QString ismulipleLabel;
    QVariantList mListPOIPrevious;
    QString myPOILabel;
    QString quickGuideUrl;

    MapData* mMapData;
    QList<QVariant> decodedpolylat;
    QList<QVariant> decodedpolylng;

    QString poiNameValue;
    QString poiMakaniValue;
    QString poiPhoneValue;
    QString poiFaxValue;
    QString poiEmailValue;
    QString poiLicenseValue;
    QString poiURLValue;
    QString poiPOBoxValue;
    QString mEntranceValue;
    QString mROADNAMEEValue;
    QString mBUILDING_NOValue;
    QString mmCOMM_ENValue;
    QString mPICTUREValue;
    QString mLandNumberValue;
    QString mGetMyLocation;
    QString mFeedbackFirstValue;
    QString mPOIFrom;
    QString mConvertorFrom;

    bool isNeedConvertLatToUAENG;
    QString mPlaceLatitude;
    QString mPlaceLongitude;
    bool isPOIMultipleTap;

    QString mLastFocusID;
    bool checkResponseNull;
    bool isOutlineFromMultiplePin;
    bool isfromcateAddress;
    bool isfromNearByDetails;
    QStringList mQStringListForCheckBox;
    QStringList templist;
    QVariant mModelLastIndex;
    QVariantList mNearByList;
    QString faqResultUrl;
    ImageView *mImageView;
    QVariantList mListOfImages;
    QString isPoiPicture;
    StyleSheet styles;
    bool isdirectionBuidingAddress;
    QStringList mListForSinglePin;
    bool isfromauto;
    QString isPic;

    bool isfromLandNumber;

    // Added By Rahul
    QString mAboutUsHtml;
    QString mContactUsHtml;
    QString mDisclamerHtml;

    QString mAboutUsHtmlAR;
    QString mContactUsHtmlAR;
    QString mDisclamerHtmlAR;
    QGeoPositionInfoSource *positionInfoSource;
    QVariantList mlistentrance;
    bool isFromLongPress;
    bool isFromLongPresstemp;

    QString mPinUriRed;
    QString mPinUriGreen;
    QString mPinUriEmergencyAr;
    QString mPinUriEmergencyEn;
    QString mPinUriEntrance;
    QString mPinUriGreenNearBy;
    bool isfromentrance;
    bool isfromMapselectedLocation;
    bool isfromFoucs;
};

#endif /* MOLWebServices_H_ */

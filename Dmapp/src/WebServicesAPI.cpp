/*
 * WebServicesAPI.cpp
 *
 *  Created on: 05-Sep-2013
 *      Author: Rahul
 */
#include "WebServicesAPI.h"
#include "stdio.h"
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/ListView>
#include <math.h>
#include <string.h>
#include <bb/cascades/Application>
#include "PoiData.h"
#include <bb/UIToolkitSupport>
#include <sstream>
#include <iomanip>
#include <bb/cascades/Color>
using namespace bb::cascades;
using namespace bb::data;
using namespace QtMobilitySubset;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;

WebServicesAPI::WebServicesAPI(QObject* parent) :
        QObject(parent), m_succeeded(false), m_active(false), m_modelImageList(new QListDataModel<QObject*>())
{
    searchAddress = QGeoAddress();
    mMarker = Marker();
    mPinTypeMultiple = 0;
    mPinTypeEntrance = 1;
    mPinTypeEntranceSelected = 2;
    mPinTypeSingle = 3;
    mPinTypeRoutePoint = 4;

    mWSHost = "www.makani.ae";
    mWSPrefix = "/MakaniWCFService_ActivityLog/service.svc";
    mTockenID = "54F000E53AA3DB91BB938B274D6C3A18";

    mMapData = new MapData();

    request = QNetworkRequest();
    mm_model = new GroupDataModel();
    mm_modelBuiding = new GroupDataModel();
    mm_modelCommunity = new GroupDataModel();
    mm_modelStreet = new GroupDataModel();
    mm_modelcategory = new GroupDataModel();
    mm_modelservice = new GroupDataModel();
    mmodelfeedbacktype = new GroupDataModel();
    mm_modelNearBy = new GroupDataModel();
    mm_mymodelTutorial = new GroupDataModel();
    mm_modelpoinearby = new QListDataModel<QObject*>();
    myMapView = new MapView();

    minfo = new bb::ApplicationInfo(parent);
    mNetworkAccessManager = new QNetworkAccessManager(this);
    mNetworkAccessManagerFaq = new QNetworkAccessManager(this);
    mm_model->setGrouping(ItemGrouping::None);
    mm_modelBuiding->setGrouping(ItemGrouping::None);
    mm_modelCommunity->setGrouping(ItemGrouping::None);
    mm_modelStreet->setGrouping(ItemGrouping::None);
    mm_modelcategory->setGrouping(ItemGrouping::None);
    mm_modelservice->setGrouping(ItemGrouping::None);
    mmodelfeedbacktype->setGrouping(ItemGrouping::None);
    mm_modelNearBy->setGrouping(ItemGrouping::None);
    mm_mymodelTutorial->setGrouping(ItemGrouping::None);
    m_modelImageList->setParent(this);
    isPoiPicture = "";
    isFromLongPress = false;
    isFromLongPresstemp = false;
    isPic = "";
    isfromNearByDetails = false;
    isfromFoucs = false;
    listCategory = new SystemListDialog(QString::null, QString::null);
    listService = new SystemListDialog(QString::null, QString::null);
    QObject* mapObject = parent->findChild<ImageView*>("mimagePicture");
    mImageView = new ImageView();
    mImageView = qobject_cast<ImageView*>(mapObject);
    qmlRegisterType<PoiData>();
    positionInfoSource = QGeoPositionInfoSource::createDefaultSource(0);
    connect(&m_soap, SIGNAL(responseReady()), SLOT(onServiceResponse()));
    connect(&m_soap_POIAutoComplete, SIGNAL(responseReady()), SLOT(onServiceResponsePOIAutoComplete()));
    connect(mNetworkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
    connect(mNetworkAccessManagerFaq, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinishedFaq(QNetworkReply*)));

    isfromLandNumber = false;
    isdirectionBuidingAddress = false;
    startGPS();

    mPinUriRed = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/pin1.png";
    mPinUriGreen = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/map_entrance_selected.png";
    mPinUriEmergencyEn = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/Mappin_en.png";
    mPinUriEmergencyAr = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/Mappin_ar.png";
    mPinUriEntrance = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/pin2.png";
    mPinUriGreenNearBy = "/accounts/1000/appdata/com.example.Dmapp.testDev_ample_Dmappdd4f91a7/app/native/assets/images/map/map_pin_near_by.png";
}
bool WebServicesAPI::isisfromMapselectedLocation()
{
    return isfromMapselectedLocation;
}
void WebServicesAPI::setisfromMapselectedLocation(bool checkismapselected)
{
    isfromMapselectedLocation = checkismapselected;
}
QString WebServicesAPI::getAboutUsHtml()
{

    return mAboutUsHtml;
}
QString WebServicesAPI::getContactUsHtml()
{

    return mContactUsHtml;
}
QString WebServicesAPI::getDisclamerHtml()
{

    return mDisclamerHtml;
}
QString WebServicesAPI::getAboutUsHtmlAR()
{

    return mAboutUsHtmlAR;
}
QString WebServicesAPI::getContactUsHtmlAR()
{

    return mContactUsHtmlAR;
}
QString WebServicesAPI::getDisclamerHtmlAR()
{

    return mDisclamerHtmlAR;
}
/*
 *  A new value is saved to the application settings object.
 *  @param objectName Identifier to set in persistence storage.
 *  @param inputValue value to be stored in persistence storage.
 */
void WebServicesAPI::saveValueFor(const QString &objectName, const QString &inputValue)
{
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
}
/*
 *  Retrieve the value stored in persistence  settings object.
 *  @param objectName Identifier to get value from  persistence storage.
 *  @param defaultValue If no value has been saved return the specified default value.
 */
QString WebServicesAPI::getValueFor(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }
    return settings.value(objectName).toString();
}
/*  convertes any format date into specified date format.
 * @param mData date in string format
 *  returns the converted date with specified format.
 */
QString WebServicesAPI::dateFormate(QString mData)
{
    QString leftSide = mData.left(10);
    QDateTime mdate = QDateTime::fromString(leftSide, "yyyy-MM-dd");
    mDateValue = mdate.toString("dd/MM/yyyy");
    return mDateValue;
}
void WebServicesAPI::callTUTORIAL()
{
    m_active = true;
    emit activeChanged();

//    mNetworkAccessManager->get(QNetworkRequest(QUrl("http://demoserver.tacme.net:4040/makani/webservice/getfiles.php?platform=bb10")));
    mNetworkAccessManager->get(QNetworkRequest(QUrl("http://www.makani.ae/makaniadmin/Makani.xml")));
}
void WebServicesAPI::positionUpdated(QGeoPositionInfo geoPositionInfo)
{

    if (geoPositionInfo.isValid()) {

        // ensure location services are enabled

        // Save the position information into a member variable
        myPositionInfo = geoPositionInfo;

        // Get the current location as latitude and longitude
        QGeoCoordinate geoCoordinate = geoPositionInfo.coordinate();
        double latitude = geoCoordinate.latitude();
        double longitude = geoCoordinate.longitude();

        // Get and Set the current location as latitude and longitude

        QString strLatitude = QString("%1").arg(latitude);
        QString strLongitude = QString("%1").arg(longitude);

        saveValueFor("currentLatitude", strLatitude);
        saveValueFor("CurrentLongitude", strLongitude);
        // showMySystemDialog(strLatitude+strLongitude);
        //   drawCurrentLocation();
    }
}

void WebServicesAPI::drawCurrentLocation()
{
    ClearMapdata();

    bool isGPSOn = positionInfoSource->property("locationServicesEnabled").toBool();
    if (!isGPSOn) {
        saveValueFor("currentLatitude", "25.264637");
        saveValueFor("CurrentLongitude", "55.312168");

    }
    QString strLatitude = getValueFor("currentLatitude", "25.264637");
    QString strLongitude = getValueFor("CurrentLongitude", "55.312168");

    //qd
    m_active = true;
    emit activeChanged();
    //getCoordinateConversion(strLatitude, strLongitude, "LATLNG", "MyLocation", true); // old code
    getCoordinateConversion(strLongitude, strLatitude, "LATLNG", "MyLocation", true);  //new code
    //getCoordinateConversion("25.271139", "55.307485", "LATLNG", "MyLocation", true);

}

void WebServicesAPI::startGPS()
{

// Obtain the location data source if it is not obtained already
    if (!locationDataSource) {
        locationDataSource = QGeoPositionInfoSource::createDefaultSource(this);
        // Whenever the location data source signals that the current
        // position is updated, the positionUpdated function is called
        connect(locationDataSource, SIGNAL(positionUpdated(QGeoPositionInfo)), this, SLOT(positionUpdated(QGeoPositionInfo)));

        locationDataSource->setUpdateInterval(10000);
        //   locationDataSource->lastKnownPosition(true);
        //Start listening for position updates
        locationDataSource->startUpdates();
    }
}

bb::cascades::DataModel* WebServicesAPI::imageModel() const
{
    return m_modelImageList;
}

bb::cascades::DataModel* WebServicesAPI::model() const
{
    return mm_model;
}

void WebServicesAPI::changeDataModelOrder(GroupDataModel *mm_model)
{

    QVariantList indexPath = mm_model->last();
    QVariantList tempData;
    for (int i = 0; i < mm_model->size(); i++) {
        QVariantMap entry = mm_model->data(indexPath).toMap();
        indexPath = mm_model->before(indexPath);
        tempData.append(entry);
    }

    QVariantMap myMap;
    QVariantList newIndex;
    newIndex = mm_model->first();

    for (int i = 0; i < tempData.size(); i++) {
        myMap = tempData.value(i).toMap();
        mm_model->updateItem(newIndex, myMap);
        newIndex = mm_model->after(newIndex);
    }

}

/**
 * WebServicesAPI::succeeded()
 *
 * Return bool,  if the SOAP query was successful or not
 */
bool WebServicesAPI::succeeded() const
{
    return m_succeeded;
}
QString WebServicesAPI::statusMessage() const
{
    return mResponseStatusValue;
}

bool WebServicesAPI::active() const
{
    return m_active;
}

QVariantList WebServicesAPI::getQVariantListData()
{

    return mQVariantListData;
}

void WebServicesAPI::writeResponse(QString response, QString filename)
{
    QFile* mFile = new QFile("data/" + filename + ".txt");
    if (!mFile->open(QIODevice::ReadWrite)) {
        return;
    }
    mFile->write(response.toUtf8().constData());
    mFile->flush();
    mFile->close();

}
/*
 *Parses the response of place of interest Auto complete based on currentws.
 */
void WebServicesAPI::onServiceResponsePOIAutoComplete()
{

    const QtSoapMessage& response = m_soap_POIAutoComplete.getResponse();

    QString mData = response.returnValue().toString();
    if (mCurrentWSAuto == "GetMakaniNo") {

        parseGetMakaniNo(mData);

    } else if (mCurrentWSAuto == "GetPOIInfo") {
        qDebug() << "test  picture" <<  mPICTUREValue;
        m_active = true;
        emit activeChanged();
        mData = mData.replace("\\", "", Qt::CaseInsensitive);
        JsonDataAccess jda;
        QVariant listPoi = jda.loadFromBuffer(mData.toUtf8());
        mlistSearchPOI.clear();
        QVariantList mListPoi = listPoi.toMap().value("POI").toList();
        mm_model->clear();
        // mlistSearchPOI.append(mListPoi);
        QString lat;
        QString lng;
        QString name;

        mListLat.clear();
        mListLng.clear();

        QLocale c(QLocale::C);

        for (int i = 0; i < mListPoi.size(); i++) {
            QVariantMap entry;
            lat = mListPoi.value(i).toMap().value("attributes").toMap().value("X_COORD").toString();
            lng = mListPoi.value(i).toMap().value("attributes").toMap().value("Y_COORD").toString();

            if (getValueFor("mLanguageCode", "en") == "en") {
                name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_E").toString();
                entry["NAME_E"] = name;

            } else {
                name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_A").toString();
                entry["NAME_A"] = name;
            }

            entry["X_COORD"] = lat;
            entry["Y_COORD"] = lng;
            entry["TEL_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("TEL_NO").toString();
            entry["FAX_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("FAX_NO").toString();
            entry["EMAIL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("EMAIL").toString();
            entry["LICENSE_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("LICENSE_NO").toString();
            entry["URL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("URL").toString();
            entry["POBOX"] = mListPoi.value(i).toMap().value("attributes").toMap().value("POBOX").toString();
            entry["PICTURE"] = mListPoi.value(i).toMap().value("attributes").toMap().value("PICTURE").toString();
            entry["NAME_E"] = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_E").toString();
            entry["NAME_A"] = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_A").toString();
            mlistSearchPOI.append(entry);
        }
    } else if (mCurrentWSAuto == "getCoordinateConversion") {
        parseUAENGtoCoordinates(mData);
    } else if (mCurrentWSAuto == "getCoordinateConversionLongPress") {
        parseUAENGtoCoordinatesLongPress(mData);
    }

    m_active = false;
    m_succeeded = true;
    emit activeChanged();
    emit dataLoaded();

}

void WebServicesAPI::onServiceResponse()
{

    const QtSoapMessage& response = m_soap.getResponse();
    QString mData = response.returnValue().toString();
    if (response.isFault()) {
        m_active = false;
        m_succeeded = false;
        emit activeChanged();
        emit statusChanged();

        showMySystemDialog(tr("Error in response"));
        return;
    }

    if (mCurrentWS != "GetParcelOutline_New") {
        mLandNumberValue = "";
        emit mLandNumberDone();
    }
    if (mCurrentWS == "sendContactGmService") {
    } else if (mCurrentWS == "GetMakaniNo") {

        isPic = "";
        parseGetMakaniNo(mData);
    } else if (mCurrentWS == "GetBuildingInfo") {

        isPic = "";
        parseGetBuildingInfo(mData);
    } else if (mCurrentWS == "GetPOIInfo") {

        isPic = "";
        parseGetPOIInfo(mData);
    } else if (mCurrentWS == "GetBuildingOutLine_EntrancePoints") {

        parseGetBuildingOutLine_EntrancePoints(mData);
    } else if (mCurrentWS == "GetAllCommunities") {

        isPic = "";
        parseGetAllCommunities(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "GetStreetsFromCommunity") {

        isPic = "";
        parseGetStreetsFromCommunity(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "GetBuildingsList") {

        isPic = "";
        parseGetBuildingsList(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "UAENGtoCoordinates" || mCurrentWS == "DMSToCoordinates") {

        isPic = "";
        parseUAENGtoCoordinates(mData);
    } else if (mCurrentWS == "GetBuildingAddress") {

        isPic = "";
        parseGetBuildingAddress(mData);
    } else if (mCurrentWS == "GetAllServicesSearch" || mCurrentWS == "GetAllServicesNearBy") {

        isPic = "";
        parseGetAllServices(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "GetPOIByServiceIDAndCategoryId") {
        isPic = "";
        parseGetPOIByServiceIDAndCategoryId(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "GetCategoriesByServiceID") {

        isPic = "";
        parseGetCategoriesByServiceID(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "GetPOIFromNearestLocation") {

        isPic = "";
        parseGetPOIFromNearestLocation(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "getCoordinateConversion") {

        isPic = "";
        parseUAENGtoCoordinates(mData);
    } else if (mCurrentWS == "GetParcelOutline") {

        isPic = "";
        parseGetParcelOutline(mData);
    } else if (mCurrentWS == "GetParcelOutline_New") {

        isPic = "";
        parseGetParcelOutline_New(mData);
    } else if (mCurrentWS == "GetPOI") {

        isPic = "";
        parseGetPOI(mData);
    } else if (mCurrentWS == "GetFeedbackType") {

        isPic = "";
        parseGetFeedbackType(mData);
    } else if (mCurrentWS == "MakaniFeedback") {

        isPic = "";
        parseMakaniFeedback(mData);
    } else if (mCurrentWS == "InsertRatings") {

        isPic = "";
        parseInsertRatings(mData);
    } else if (mCurrentWS == "GetPOIByServiceIDCategoryIdPOI") {
        isPic = "";
        parseGetPOIByServiceIDCategoryIdPOI(mData);
        m_active = false;
        emit activeChanged();
    } else if (mCurrentWS == "getCoordinateConversionLongPress") {
//        parseUAENGtoCoordinates(mData);
        parseUAENGtoCoordinatesLongPress(mData);
    }
}

void WebServicesAPI::callSVC(const QString &action, const QString &host, const QString &prefix, const QString &request, const bool &isSecure)
{

    /*if (m_active)
     return;*/

    m_active = true;
    emit activeChanged();

    m_succeeded = false;

    m_soap.setAction(action);
    m_soap.setHost(host, isSecure);
    QtSoapMessage data;

    m_soap.submitRequest(data, prefix, request, true);

}

void WebServicesAPI::callAutoCompleteWS(const QString &action, const QString &host, const QString &prefix, const QtSoapMessage &request, const bool &isSecure)
{

    QtSoapMessage data = request;
    m_soap_POIAutoComplete.setAction(action);

    m_soap_POIAutoComplete.setHost(host, isSecure);
    m_soap_POIAutoComplete.submitRequest(data, prefix, "", false);

}
void WebServicesAPI::callWS(const QString &action, const QString &host, const QString &prefix, const QtSoapMessage &request, const bool &isSecure)
{
    m_active = true;
    emit activeChanged();
    m_active = true;
    emit activeChanged();

    QtSoapMessage data = request;
    m_soap.setAction(action);

    m_soap.setHost(host, isSecure);
    m_soap.submitRequest(data, prefix, "", false);

}

void WebServicesAPI::requestFinished(QNetworkReply* reply)
{
// Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {

        QByteArray response = reply->readAll();
        QString mData = mData.fromUtf8(response);

        JsonDataAccess jda;
        XmlDataAccess xda;
        QVariant list = xda.loadFromBuffer(mData);
        QVariantMap mMainMap = list.value<QVariantMap>();

        mAboutUsHtml.clear();
        mContactUsHtml.clear();
        mDisclamerHtml.clear();

        mAboutUsHtmlAR.clear();
        mContactUsHtmlAR.clear();
        mDisclamerHtmlAR.clear();
        quickGuideUrl.clear();

        // new code
        //mtempiamge.clear();
        mListOfImages.clear();

        if (mMainMap.size() == 0) {

            showMySystemDialog(tr("No Data Found"));

            m_active = false;
            emit activeChanged();
        } else {

            QString hosrURl = "http://www.makani.ae/makaniadmin";
            QVariantList mQuickTutorialList;

            QVariantMap mAboutUs = mMainMap.value("AboutUs").toMap();
            QVariantMap mAboutUsEn = mAboutUs.value("en").toMap();
            QVariantMap mAboutUsAr = mAboutUs.value("ar").toMap();

            QVariantMap mContactUs = mMainMap.value("ContactUs").toMap();
            QVariantMap mContactUsBB = mContactUs.value("BB10").toMap();
            QVariantMap mmContactUsBBEn = mContactUsBB.value("en").toMap();
            QVariantMap mmContactUsBBAr = mContactUsBB.value("ar").toMap();

            QVariantMap mDisclaimer = mMainMap.value("Disclaimer").toMap();
            QVariantMap mDisclaimerEn = mDisclaimer.value("en").toMap();
            QVariantMap mDisclaimerAr = mDisclaimer.value("ar").toMap();

            mAboutUsHtml = hosrURl + mAboutUsEn.value("file").toString();
            mAboutUsHtmlAR = hosrURl + mAboutUsAr.value("file").toString();

            mContactUsHtml = hosrURl + mmContactUsBBEn.value("file").toString();
            mContactUsHtmlAR = hosrURl + mmContactUsBBAr.value("file").toString();

            mDisclamerHtml = hosrURl + mDisclaimerEn.value("file").toString();
            mDisclamerHtmlAR = hosrURl + mDisclaimerAr.value("file").toString();

            QVariantMap mHelp = mMainMap.value("Help").toMap();
            QVariantMap mHelpBB = mHelp.value("BB10").toMap();

            //qDebug() <<  "file number x" << mHelpBB;

            if (getValueFor("mLanguageCode", "en") == "en") {
                int helpFileSize = mHelpBB.value("en").toMap().value("NoOfFile").toInt();

                QVariantMap mHelpBBHelpFile = mHelpBB.value("en").toMap();
                //mHelpBBHelpFile.
                QVariantList mtempiamge;
                for (int i = 1; i <= helpFileSize; i++) {
                    QString file = "file" + QString::number(i);
                    //qDebug() <<  "file number test" << mHelpBBHelpFile;
                    QVariantMap mMapRoot;
                    //QStringList splitstring = mHelpBBHelpFile.value(file).toString().split("/");
                    //qDebug() <<  "file number test" << splitstring.value(2);
                    mMapRoot["my_images"] = hosrURl + mHelpBBHelpFile.value(file).toString();
                    mtempiamge.append(mMapRoot);
                }
                mListOfImages = mtempiamge;
            } else {
                int helpFileSize = mHelpBB.value("ar").toMap().value("NoOfFile").toInt();

                QVariantMap mHelpBBHelpFile = mHelpBB.value("ar").toMap();
                QVariantList mtempiamge;
                for (int i = 1; i <= helpFileSize; i++) {
                    QString file = "file" + QString::number(i);
                    QVariantMap mMapRoot;
                    mMapRoot["my_images"] = hosrURl + mHelpBBHelpFile.value(file).toString();
                    mtempiamge.append(mMapRoot);
                }
                mListOfImages = mtempiamge;
            }

            setFaqResultUrl(hosrURl + mMainMap.value("FAQ").toMap().value("file").toString());
            quickGuideUrl = hosrURl + mMainMap.value("UserGuide").toMap().value("file").toString();

            m_succeeded = false;
            m_active = false;
            emit activeChanged();
        }
    }
}
QVariantList WebServicesAPI::getImages()
{
    return mListOfImages;
}
void WebServicesAPI::callFaq(QString mfaqUrl)
{
    mNetworkAccessManagerFaq->get(QNetworkRequest(QUrl(mfaqUrl)));
}
void WebServicesAPI::requestFinishedFaq(QNetworkReply* reply)
{
    XmlDataAccess mXmlDataAccess;
    QVariant mDataXml;
    QVariantMap mMapRoot;
    QVariantList mListQuestion;
    mm_mymodelTutorial->clear();
// Check the network reply for errors
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray response = reply->readAll();
        QString mData = mData.fromUtf8(response);
        mDataXml = mXmlDataAccess.loadFromBuffer(mData);
        mMapRoot = mDataXml.toMap();
        mListQuestion = mDataXml.toMap().value("question").toList();
//        for (int i = 0; i < mListQuestion.size(); i++) {
        for (int i = mListQuestion.size() - 1; i >= 0; i--) {
            mMapRoot["question"] = getValueFor("mLanguageCode", "en") == "en" ? mListQuestion.value(i).toMap().value("que_en").toString() : mListQuestion.value(i).toMap().value("que_ar").toString();
            mMapRoot["ans"] = getValueFor("mLanguageCode", "en") == "en" ? mListQuestion.value(i).toMap().value("ans_en").toString() : mListQuestion.value(i).toMap().value("ans_ar").toString();
            mm_mymodelTutorial->insert(mMapRoot);
        }
        emit modelTutorialchanged();
        emit tutorialDone();
    }
    m_active = false;
    emit activeChanged();

}
QString WebServicesAPI::isFaqResultUrl() const
{
    return faqResultUrl;
}

void WebServicesAPI::setFaqResultUrl(QString mfaqResultUrl)
{
    faqResultUrl = mfaqResultUrl;
    callFaq(mfaqResultUrl);

}
QString WebServicesAPI::setQuickGuideUrl()
{

    return quickGuideUrl;

}

QString WebServicesAPI::imageToByte(const QString &imagePath)
{

    QByteArray fileContent = imagePath.toUtf8();

    if (imagePath != "") {
        QFile* file = new QFile(imagePath);
        bool ok = file->open(QIODevice::ReadOnly);
        if (!ok) {
            return "error read image";
        }
        fileContent = file->readAll().toBase64();
        QString path = imagePath;
        QFileInfo info(path.replace("file://", ""));
    }
    QString imageBytes = fileContent;

    return imageBytes;

}
void WebServicesAPI::getCoordinateConversionLongPress(bb::platform::geo::Point point)
{
    m_active = true;
    emit activeChanged();
// getCoordinateConversion(QString::number(point.latitude()), QString::number(point.longitude()), mStringType, "Convertor", false);
//QString type = QString::number(point.latitude())+","+QString::number(point.longitude());
    QtSoapMessage request;
    request.setMethod(QtSoapQName("CoordinateConversion1", "http://tempuri.org/"));
    request.addMethodArgument("type", "http://tempuri.org/", "LATLNG");
//request.addMethodArgument("coordinateX", "http://tempuri.org/", QString::number(point.latitude()));
//request.addMethodArgument("coordinateY", "http://tempuri.org/", QString::number(point.longitude()));

    request.addMethodArgument("coordinateX", "http://tempuri.org/", QString::number(point.longitude()));
    request.addMethodArgument("coordinateY", "http://tempuri.org/", QString::number(point.latitude()));
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    QString action = "http://tempuri.org/IMakaniService/CoordinateConversion1";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    mCurrentWSAuto = "getCoordinateConversionLongPress";
    callAutoCompleteWS(action, host, prefix, request, false);
}
void WebServicesAPI::parseUAENGtoCoordinatesLongPress(QString data)
{
    clearmyInfoPopupData();
    JsonDataAccess jda;
    QVariant makani = jda.loadFromBuffer(data);
    mLisToSend.clear();
    mCCMakani = makani.toMap().value("MAKANI").toString();
    mCCUAENG = makani.toMap().value("UAENG").toString();
    mNODATA = makani.toMap().value("DATA").toString();

    QString spacePattern(" ");

    QStringList mListDLTM = makani.toMap().value("DLTM").toString().split(spacePattern);
    mCCDLTM1 = mListDLTM.value(0);
    mCCDLTM2 = mListDLTM.value(1);

    QStringList mListUTM = makani.toMap().value("UTM").toString().split(spacePattern);
    mCCUTM1 = mListUTM.value(0);
    mCCUTM2 = mListUTM.value(1);

    QString commaPattern(",");
    QStringList mListLATLON = makani.toMap().value("LATLNG").toString().split(commaPattern);
    mCCLatitude = mListLATLON.value(0);
    QString mFormateLat = QString("%1").arg(mCCLatitude);
    bool ok1 = true;
    QString str = QString("%5").arg(mFormateLat.toDouble(&ok1), 0, 'f', 6);

    mCCLatitude = str;
    mCCLongitude = mListLATLON.value(1);

    QString mFormateLon = QString("%1").arg(mCCLongitude);
    bool ok2 = true;
    QString str1 = QString("%5").arg(mFormateLon.toDouble(&ok2), 0, 'f', 6);

    mCCLongitude = str1;

    QStringList mListDMSLATLON = makani.toMap().value("D:M:S").toString().split(commaPattern);
    QString mDMSLat = mListDMSLATLON.value(0);
    QString mDMSLon = mListDMSLATLON.value(1);

    bool ok = false;
    Q_UNUSED(ok);
    QString colonPattern(":");
    QStringList mListDMSLAT = mDMSLat.split(colonPattern);
    mCCDMSLatitude1 = mListDMSLAT.value(0);
    mCCDMSLatitude2 = mListDMSLAT.value(1);
    mCCDMSLatitude3 = mListDMSLAT.value(2);
    QString msg = QString("%1").arg(mCCDMSLatitude3);
    msg = msg.left(msg.indexOf('.'));
    mCCDMSLatitude3 = msg;

    QStringList mListDMSLON = mDMSLon.split(colonPattern);
    mCCDMSLongitude1 = mListDMSLON.value(0);
    mCCDMSLongitude2 = mListDMSLON.value(1);
    mCCDMSLongitude3 = mListDMSLON.value(2);
    QString msg1 = QString("%1").arg(mCCDMSLongitude3);
    msg1 = msg1.left(msg1.indexOf('.'));
    mCCDMSLongitude3 = msg1;

    QVariantMap mMapForCurrentLocation;
    mMapForCurrentLocation["uaeng"] = mCCUAENG;
//drawPinOnMap("map_pin.png", mCCLongitude + "," + mCCLatitude, mCCUAENG, mPinTypeSingle, mMapForCurrentLocation);
    drawPinOnMap("map_pin.png", mCCLatitude + "," + mCCLongitude, mCCUAENG, mPinTypeSingle, mMapForCurrentLocation);
    isFromLongPress = true;
    GetBuildingOutLine_EntrancePoints(mCCLatitude, mCCLongitude, false, false);
//    GetBuildingOutLine_EntrancePoints(mCCLongitude, mCCLatitude, false, false);

    m_active = false;
    emit activeChanged();

}
void WebServicesAPI::getCoordinateConversion(QString coordinateX, QString coordinateY, QString type, QString convertFrom, bool isFromMyLocation)
{

    mConvertorFrom = convertFrom;
    QtSoapMessage request;
    request.setMethod(QtSoapQName("CoordinateConversion1", "http://tempuri.org/"));
    request.addMethodArgument("type", "http://tempuri.org/", type);
    request.addMethodArgument("coordinateX", "http://tempuri.org/", coordinateX);
    request.addMethodArgument("coordinateY", "http://tempuri.org/", coordinateY);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    QString action = "http://tempuri.org/IMakaniService/CoordinateConversion1";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    if (isFromMyLocation) {
        mCurrentWSAuto = "getCoordinateConversion";
        callAutoCompleteWS(action, host, prefix, request, false);
    } else {
        mCurrentWS = "getCoordinateConversion";
        callWS(action, host, prefix, request, false);
    }
}

void WebServicesAPI::GetAllCommunities(QString lang)
{
    mCurrentWS = "GetAllCommunities";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetAllCommunities", "http://tempuri.org/"));
    request.addMethodArgument("commname", "http://tempuri.org/", "");
    request.addMethodArgument("lang", "http://tempuri.org/", lang);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetAllCommunities";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::getPOI(QString serviceid, QString categoryid, QString noofrecords, QString withindistance, QString lat, QString lng, QString remarks)
{
    mCurrentWS = "GetPOI";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetPOI", "http://tempuri.org/"));
    request.addMethodArgument("serviceid", "http://tempuri.org/", serviceid);
    request.addMethodArgument("categoryid", "http://tempuri.org/", categoryid);
    request.addMethodArgument("noofrecords", "http://tempuri.org/", noofrecords);
    request.addMethodArgument("withindistance", "http://tempuri.org/", withindistance);

    request.addMethodArgument("lat", "http://tempuri.org/", lat);
    request.addMethodArgument("lng", "http://tempuri.org/", lng);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    request.addMethodArgument("remarks", "http://tempuri.org/", "bb10,169.254.0.1,GetPOI");

    QString action = "http://tempuri.org/IMakaniService/GetPOI";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::GetBuildingAddress(QString communityname, QString streetname, QString buildingname, QString lang)
{

    mCurrentWS = "GetBuildingAddress";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetBuildingAddress", "http://tempuri.org/"));
    request.addMethodArgument("communityname", "http://tempuri.org/", communityname);
    request.addMethodArgument("streetname", "http://tempuri.org/", streetname);
    request.addMethodArgument("buildingname", "http://tempuri.org/", buildingname);
    request.addMethodArgument("lang", "http://tempuri.org/", lang);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetBuildingAddress";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetAllServices(QString from)
{
    mCurrentWS = from;
    mm_modelservice->clear();

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetAllServices", "http://tempuri.org/"));
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    QString action = "http://tempuri.org/IMakaniService/GetAllServices";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetBuildingInfo(QString makaninumber)
{
    mCurrentWS = "GetBuildingInfo";
    QtSoapMessage request;
    if (makaninumber.length() == 10)
        makaninumber = makaninumber.mid(0, 5) + " " + makaninumber.mid(5, 5);

    request.setMethod(QtSoapQName("GetBuildingInfo", "http://tempuri.org/"));
    request.addMethodArgument("makaninumber", "http://tempuri.org/", makaninumber);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetBuildingInfo";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::GetBuildingOutLine_EntrancePoints(QString lat, QString lng, bool needConvert, bool fromMultiplePin)
{

    isNeedConvertLatToUAENG = needConvert;
    isOutlineFromMultiplePin = fromMultiplePin;
    mCurrentWS = "GetBuildingOutLine_EntrancePoints";
    mPlaceLatitude = lat;
    mPlaceLongitude = lng;

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetBuildingOutLine_EntrancePoints", "http://tempuri.org/"));
    request.addMethodArgument("lat", "http://tempuri.org/", lat);
    request.addMethodArgument("lng", "http://tempuri.org/", lng);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetBuildingOutLine_EntrancePoints";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetBuildingsList(QString communityname, QString streetname, QString lang)
{
    mCurrentWS = "GetBuildingsList";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetBuildingsList", "http://tempuri.org/"));
    request.addMethodArgument("communityname", "http://tempuri.org/", communityname);
    request.addMethodArgument("streetname", "http://tempuri.org/", streetname);
    request.addMethodArgument("lang", "http://tempuri.org/", lang);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetBuildingsList";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::GetCategoriesByServiceID(QString serviceid)
{
    mCurrentWS = "GetCategoriesByServiceID";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetCategoriesByServiceID", "http://tempuri.org/"));
    request.addMethodArgument("serviceid", "http://tempuri.org/", serviceid);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetCategoriesByServiceID";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}

void WebServicesAPI::GetPOIByServiceIDAndCategoryId(QString categoryid, QString serviceid)
{

    mCurrentWS = "GetPOIByServiceIDAndCategoryId";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetPOIByServiceIDAndCategoryId", "http://tempuri.org/"));
    request.addMethodArgument("categoryid", "http://tempuri.org/", categoryid);
    request.addMethodArgument("serviceid", "http://tempuri.org/", serviceid);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetPOIByServiceIDAndCategoryId";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetPOIByServiceIDCategoryIdPOI(QString categoryid, QString serviceid, QString poiname, QString lang)
{
    mCurrentWS = "GetPOIByServiceIDCategoryIdPOI";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetPOIByServiceIDCategoryIdPOI", "http://tempuri.org/"));
    request.addMethodArgument("categoryid", "http://tempuri.org/", categoryid);
    request.addMethodArgument("serviceid", "http://tempuri.org/", serviceid);
    request.addMethodArgument("poiname", "http://tempuri.org/", poiname);
    request.addMethodArgument("lang", "http://tempuri.org/", lang);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    request.addMethodArgument("remarks", "http://tempuri.org/", "");

    QString action = "http://tempuri.org/IMakaniService/GetPOIByServiceIDCategoryIdPOI";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::GetPOIFromNearestLocation(QString serviceid, QString lat, QString lng)
{
    mCurrentWS = "GetPOIFromNearestLocation";
    mm_modelpoinearby->clear();

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetPOIFromNearestLocation", "http://tempuri.org/"));
    request.addMethodArgument("serviceid", "http://tempuri.org/", serviceid);
    request.addMethodArgument("lat", "http://tempuri.org/", lat);
    request.addMethodArgument("lng", "http://tempuri.org/", lng);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetPOIFromNearestLocation";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetPOIInfo(QString poiname, QString lang, bool isAuto, QString mFrom)
{
    myPOILabel = poiname;
    QString langs = "E";
    if (getValueFor("mLanguageCode", "en") == "en") {
        langs = "E";
    } else {
        langs = "A";
    }
    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetPOIInfo", "http://tempuri.org/"));
    request.addMethodArgument("poiname", "http://tempuri.org/", poiname);
    request.addMethodArgument("lang", "http://tempuri.org/", langs);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetPOIInfo";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    mPOIFrom = mFrom;

    if (isAuto) {
        mCurrentWSAuto = "GetPOIInfo";
        callAutoCompleteWS(action, host, prefix, request, false);
    } else {
        mCurrentWS = "GetPOIInfo";
        callWS(action, host, prefix, request, false);
    }

}

void WebServicesAPI::GetStreetsFromCommunity(QString communityname, QString streetname, QString lang)
{
    mCurrentWS = "GetStreetsFromCommunity";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetStreetsFromCommunity", "http://tempuri.org/"));
    request.addMethodArgument("communityname", "http://tempuri.org/", communityname);
    request.addMethodArgument("streetname", "http://tempuri.org/", streetname);
    request.addMethodArgument("lang", "http://tempuri.org/", lang);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetStreetsFromCommunity";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::UAENGtoCoordinates(QString UAENG, QString token, QString convertFrom)
{
    mCurrentWS = "UAENGtoCoordinates";
    mConvertorFrom = convertFrom;
    QtSoapMessage request;
    request.setMethod(QtSoapQName("UAENGtoCoordinates", "http://tempuri.org/"));
    request.addMethodArgument("UAENG", "http://tempuri.org/", UAENG);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/UAENGtoCoordinates";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::DMSToCoordinates(QString lat1, QString lat2, QString lat3, QString lon1, QString lon2, QString lon3)
{
    mCurrentWS = "DMSToCoordinates";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("DMSToCoordinates", "http://tempuri.org/"));
    request.addMethodArgument("degLat", "http://tempuri.org/", lat1);
    request.addMethodArgument("minLat", "http://tempuri.org/", lat2);
    request.addMethodArgument("secLat", "http://tempuri.org/", lat3);
    request.addMethodArgument("degLng", "http://tempuri.org/", lon1);
    request.addMethodArgument("minLng", "http://tempuri.org/", lon2);
    request.addMethodArgument("secLng", "http://tempuri.org/", lon3);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/DMSToCoordinates";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetMakaniNo(QString makaninumber)
{
    mCurrentWSAuto = "GetMakaniNo";

    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetMakaniNo", "http://tempuri.org/"));
    request.addMethodArgument("makaninumber", "http://tempuri.org/", makaninumber);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);

    QString action = "http://tempuri.org/IMakaniService/GetMakaniNo";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callAutoCompleteWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetParcelOutline(QString parcelId, QString token, QString remarks)
{
    mCurrentWS = "GetParcelOutline";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetParcelOutline", "http://tempuri.org/"));
    request.addMethodArgument("parcelId", "http://tempuri.org/", parcelId);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    request.addMethodArgument("remarks", "http://tempuri.org/", remarks);

    QString action = "http://tempuri.org/IMakaniService/GetParcelOutline";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetParcelOutline_New(QString parcelId)
{
    mCurrentWS = "GetParcelOutline_New";
    QtSoapMessage request;
    mLandNumberValue = parcelId;
    emit mLandNumberDone();
    request.setMethod(QtSoapQName("GetParcelOutline_New", "http://tempuri.org/"));
    request.addMethodArgument("parcelId", "http://tempuri.org/", parcelId);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    request.addMethodArgument("remarks", "http://tempuri.org/", "");

    QString action = "http://tempuri.org/IMakaniService/GetParcelOutline_New";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);

}
void WebServicesAPI::GetFeedbackType()
{
    mCurrentWS = "GetFeedbackType";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("GetFeedbackType", "http://tempuri.org/"));
    QString action = "http://tempuri.org/IMakaniService/GetFeedbackType";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::InsertRatings(QString ratingId)
{
    mCurrentWS = "InsertRatings";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("InsertRatings", "http://tempuri.org/"));
    request.addMethodArgument("ratingId", "http://tempuri.org/", ratingId);
    request.addMethodArgument("devicetypeid", "http://tempuri.org/", "1");
    request.addMethodArgument("remarks", "http://tempuri.org/", "");
    QString action = "http://tempuri.org/IMakaniService/InsertRatings";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::GetMakaniFeedback(QString typeId, QString remarks, QString emailid)
{
    mCurrentWS = "MakaniFeedback";
    QtSoapMessage request;
    request.setMethod(QtSoapQName("MakaniFeedback", "http://tempuri.org/"));
    request.addMethodArgument("typeId", "http://tempuri.org/", typeId);
    request.addMethodArgument("remarks", "http://tempuri.org/", remarks);
    request.addMethodArgument("emailid", "http://tempuri.org/", emailid);
    QString action = "http://tempuri.org/IMakaniService/MakaniFeedback";
    QString host = mWSHost;
    QString prefix = mWSPrefix;
    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::CoordinateConversion1(QString type, QString coordinateX, QString coordinateY, QString token, QString convertFrom)
{
    mConvertorFrom = convertFrom;
    QtSoapMessage request;
    request.setMethod(QtSoapQName("CoordinateConversion1", "http://tempuri.org/"));
    request.addMethodArgument("type", "http://tempuri.org/", type);
    request.addMethodArgument("token", "http://tempuri.org/", mTockenID);
    request.addMethodArgument("coordinateX", "http://tempuri.org/", coordinateX);
    request.addMethodArgument("coordinateY", "http://tempuri.org/", coordinateY);

    QString action = "http://tempuri.org/IMakaniService/CoordinateConversion1";
    QString host = mWSHost;
    QString prefix = mWSPrefix;

    callWS(action, host, prefix, request, false);
}
void WebServicesAPI::parseMakaniFeedback(QString mdata)
{
    JsonDataAccess jda;
    QVariant mMakaniFeedbackData = jda.loadFromBuffer(mdata);
    m_active = false;
    emit activeChanged();
    emit feedbackSubmit(mMakaniFeedbackData.toMap().value("DATA").toString());
}
void WebServicesAPI::parseInsertRatings(QString mdata)
{
    JsonDataAccess jda;
    QVariant mInsertRatingsData = jda.loadFromBuffer(mdata);
    if (mInsertRatingsData.toMap().value("DATA").toString() == "SuccessA") {
        emit insertRatingsDone(true);
    } else if (mInsertRatingsData.toMap().value("DATA").toString() == "Error") {
        emit insertRatingsDone(false);
    }
    m_active = false;
    emit activeChanged();
}
void WebServicesAPI::parseGetAllCommunities(QString data)
{
    JsonDataAccess jda;
    QString communityA;
    QString communityE;

    mlistSearchCommunity.clear();
    QVariant mAllCommunitiesData = jda.loadFromBuffer(data);
    QVariantList mCommunityList = mAllCommunitiesData.toMap().value("COMMUNITY").toList();
    mm_modelCommunity->clear();
    for (int i = 0; i < mCommunityList.size(); i++) {
        QVariantMap entry;
        communityA = mCommunityList.value(i).toMap().value("COMMUNITY_A").toString();
        communityE = mCommunityList.value(i).toMap().value("COMMUNITY_E").toString();
        if (getValueFor("mLanguageCode", "en") == "en") {
            entry["COMMUNITY_E"] = communityE;
            mlistSearchCommunity.append(communityE);
        } else {
            entry["COMMUNITY_A"] = communityA;
            mlistSearchCommunity.append(communityA);
        }
        mm_modelCommunity->insert(entry);
    }
    emit modelcommunitychanged();
}
void WebServicesAPI::parseGetAllServices(QString data)
{
    JsonDataAccess jda;
    QString SERVICE_NAME_E;
    QVariant mService = jda.loadFromBuffer(data);
    QVariantList mServicesList = mService.toMap().value("SERVICES").toList();
    mm_modelservice->clear();

    for (int i = mServicesList.size() - 1; i >= 0; i--) {
        if (getValueFor("mLanguageCode", "en") == "en") {
            SERVICE_NAME_E = mServicesList.value(i).toMap().value("SERVICE_NAME_E").toString();
        } else {
            SERVICE_NAME_E = mServicesList.value(i).toMap().value("SERVICE_NAME_A").toString();
        }
        QVariantMap entry;
        entry["service_name"] = SERVICE_NAME_E;
        entry["service_id"] = mServicesList.value(i).toMap().value("SERVICE_ID").toString();
        mm_modelservice->insert(entry);
    }
    emit modelservicechanged();
    mServiceResponseId = mServicesList;
}

QString WebServicesAPI::getId(QString myIndex)
{
    QString serviceID;
    for (int i = 0; i < mServiceResponseId.size(); i++) {
        if (i == QVariant(myIndex).toInt()) {
            serviceID = mServiceResponseId.value(i).toMap().value("SERVICE_ID").toString();
            break;
        }
    }
    return serviceID;
}

QString WebServicesAPI::getCatValueFromId(QString myIndex)
{
    QString CategoryID;

    for (int i = 0; i < mCategoryResponseId.size(); i++) {
        if (i == QVariant(myIndex).toInt()) {

            CategoryID = mCategoryResponseId.value(i).toMap().value("CATEGORY_ID").toString();
            break;
        }
    }
    return CategoryID;
}

void WebServicesAPI::parseGetBuildingAddress(QString data)
{
    JsonDataAccess jda;
    QVariant mEntrance = jda.loadFromBuffer(data);
    QVariantList mBUILDING = mEntrance.toMap().value("BUILDING").toList();
    if (mBUILDING.size() > 1) {
        QString latlng;
        for (int i = 0; i < mBUILDING.size(); i++) {
            latlng = mBUILDING.value(i).toMap().value("LATLNG").toString();
            //    drawPinOnMap("map_pin.png", latlng, "", mPinTypeMultiple, NULL);
        }
    } else {
        //call web service entrance outline
        QString noData = mEntrance.toMap().value("DATA").toString();

        if (noData == "No Data Found") {
            m_active = false;
            emit activeChanged();
            checkResponseNull = true;
            showMySystemDialog(tr("No Data Found"));
        } else {
            checkResponseNull = false;
            latlng = mBUILDING.value(0).toMap().value("LATLNG").toString();
            QString makaniNumber = mBUILDING.value(0).toMap().value("MAKANIbuildingDataLoaded").toString();
            QString colonPattern(",");
            if (makaniNumber == "") {
                makaniNumber = mBUILDING.value(0).toMap().value("MAKANI").toString();
            }

            QStringList mlistlng = latlng.split(colonPattern);

            if (checkisFrom() == "from") {
                setBuildingToDirectionLatLng(latlng, "from");
            } else if (checkisFrom() == "to") {
                setBuildingToDirectionLatLng(latlng, "to");
            } else if (checkisFrom() == "via") {
                setBuildingToDirectionLatLng(latlng, "via");
            }
            if (checkisFromAdvanceSearch()) {
                GetBuildingInfo(makaniNumber);
            } else {
                m_active = false;
                m_succeeded = true;
                emit activeChanged();
                emit dataLoaded();
            }
        }
        emit checkDataNull();
    }
}
bool WebServicesAPI::getcheckResponseNullResult()
{
    return checkResponseNull;
}
void WebServicesAPI::parseGetBuildingInfo(QString data)
{
    JsonDataAccess jda;
    QString coords;
    QVariantMap entry;
    QVariant list = jda.loadFromBuffer(data);
    mm_model->clear();

    mMapData = new MapData();

    QVariantList mMakaniListEntrance = list.toMap().value("MakaniInfo").toMap().value("ENTRANCE").toList();

    isOutlineBuilding = true;
    clearmyInfoPopupData();
    if (mMakaniListEntrance.size() == 0) {
        showMySystemDialog(tr("No Data Found"));
        //if (getValueFor("mLanguageCode", "en") == "en") {
        //  showMySystemDialog(tr("No Data Found"));
        //} else {
        //  showMySystemDialog(tr("لا توجد بيانات"));
        //}
        m_active = false;
        emit activeChanged();
        return;
    } else {
        mlistentrance.clear();
        if (ismulipleLabel == "redmultiple") {
            ClearMapdata();
        }
        mLastFocusID = ""; // Clear last focus id
        for (int i = 0; i < mMakaniListEntrance.size(); i++) {
            QString mStrMakaniNo;
            QString mStrLatLon;
            QString ENTERANCEID;
            QString COMM_EN;
            QString COMM_AR;
            QString BUILDING_NO;
            QString PICTURE;
            QString ENT_NAME_A;
            QString ENT_NAME_E;
            QString ROADNAMEEN;
            QString ROADNAMEAR;
            QVariantMap mListData;
            QVariantMap mMapEntrance = mMakaniListEntrance.value(i).toMap();
            mStrMakaniNo = mMapEntrance.value("MAKANI").toString();
            mStrLatLon = mMapEntrance.value("LATLNG").toString();
            ENTERANCEID = mMapEntrance.value("ENTERANCEID").toString();
            COMM_EN = mMapEntrance.value("COMM_EN").toString();
            COMM_AR = mMapEntrance.value("COMM_AR").toString();
            BUILDING_NO = mMapEntrance.value("BUILDING_NO").toString();
            PICTURE = mMapEntrance.value("PICTURE").toString();
            ROADNAMEEN = mMapEntrance.value("ROADNAMEEN").toString();
            ROADNAMEAR = mMapEntrance.value("ROADNAMEAR").toString();
            ENT_NAME_A = mMapEntrance.value("ENT_NAME_A").toString();
            ENT_NAME_E = mMapEntrance.value("ENT_NAME_E").toString();

            mListData["ENT_NAME_E"] = ENT_NAME_E;
            mListData["BUILDING_NO"] = BUILDING_NO;
            mListData["ENT_NAME_A"] = ENT_NAME_A;
            mListData["ROADNAME"] = getValueFor("mLanguageCode", "en") == "en" ? ROADNAMEEN : ROADNAMEAR;
            mListData["mCOMM_EN"] = getValueFor("mLanguageCode", "en") == "en" ? COMM_EN : COMM_AR;
            mListData["MAKANI"] = mStrMakaniNo;
            mListData["LATLNG"] = mStrLatLon;
            mListData["PICTURE"] = PICTURE;
            if (ENT_NAME_E == "EMERGENCY ENTRANCE") {
                if (getValueFor("mLanguageCode", "en") == "en") {
                    drawPinOnMap("Mappin_en.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mListData);
                } else {
                    drawPinOnMap("Mappin_ar.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mListData);
                }
            } else {
                drawPinOnMap("pin1.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mListData);
            }
            mlistentrance.append(mListData);
        }

        QVariantList mMakaniListCoord = list.toMap().value("BuildingInfo").toMap().value("BUILDING").toList();

        for (int i = 0; i < mMakaniListCoord.size(); i++) {
            QString mStrLatCoord;
            QVariantMap mMapEntrance = mMakaniListCoord.value(i).toMap();
            mStrLatCoord = mMapEntrance.value("COORD").toString();
            QString mStrLatBLDIF;
            mStrLatBLDIF = mMapEntrance.value("BLDIF").toString();

            QString colonPattern(";");

            QStringList listLatLon = mStrLatCoord.split(colonPattern);
            QLocale c(QLocale::C);
            mListLat.clear();
            mListLng.clear();
            for (int j = 0; j < listLatLon.size(); j++) {
                QString currentCoord = listLatLon.value(j);
                if (currentCoord.length() > 0) {
                    QString commaPattern(",");
                    QStringList mListCoord = currentCoord.split(commaPattern);

                    QString templat = mListCoord.value(0);
                    QString templng = mListCoord.value(1);

                    entry["lat"] = mListCoord.value(0);
                    entry["lng"] = mListCoord.value(1);

                    mlistSearchMakani.append(entry);
                    mListLat.append(c.toDouble(templat));
                    mListLng.append(c.toDouble(templng));
                }
            }
            drawBulidingOutLine(mListLat, mListLng, mStrLatBLDIF);
        }

        m_active = false;
        m_succeeded = true;
        emit activeChanged();
        emit dataLoaded();
    }
}

void WebServicesAPI::parseGetBuildingsList(QString data)
{
    JsonDataAccess jda;
    QString coords;
    QVariant list = jda.loadFromBuffer(data);
    mm_modelBuiding->clear();
    QVariantList mBuildingList = list.toMap().value("BUILDING").toList();
    QString ADDRESS_E;
    QString ADDRESS_A;
    mlistSearchBuilding.clear();
    for (int i = 0; i < mBuildingList.size(); i++) {
        QVariantMap entry;

        if (getValueFor("mLanguageCode", "en") == "en") {
            ADDRESS_E = mBuildingList.value(i).toMap().value("ADDRESS_E").toString();
            mlistSearchBuilding.append(ADDRESS_E);
        } else {
            ADDRESS_A = mBuildingList.value(i).toMap().value("ADDRESS_A").toString();
            mlistSearchBuilding.append(ADDRESS_A);
        }
        mm_modelBuiding->insert(entry);
    }
    if (getValueFor("mLanguageCode", "en") == "en") {
        mm_modelBuiding->setSortingKeys(QStringList() << "ADDRESS_E");
    } else {
        mm_modelBuiding->setSortingKeys(QStringList() << "ADDRESS_A");
    }
    emit modelBuidingchanged();
}

void WebServicesAPI::parseGetBuildingOutLine_EntrancePoints(QString data)
{
    qDebug() << "outline data" << data;
    JsonDataAccess jda;
    QString coords;
    QVariant list = jda.loadFromBuffer(data);
    mm_model->clear();

    mMapData = new MapData();
    QVariantList mMakaniListEntrance = list.toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList();
    isOutlineBuilding = true;
    QString mStrMakaniNo;
    QString mStrLatLon;
    QString mStrEntranceID;
    QString PICTURE;
    QString ROADNAMEEN;
    QString ROADNAMEAR;
    QString COMM_EN;
    QString COMM_AR;
    if (list.toMap().value("DATA").toString() == "No Data Found") {

        if (isFromLongPress) {
            ClearMapdata();
            //drawPinOnMap("pin2.png", mCCLongitude + "," + mCCLatitude, mCCUAENG, mPinTypeSingle, NULL);
            drawPinOnMap("pin2.png", mCCLatitude + "," + mCCLongitude, mCCUAENG, mPinTypeSingle, NULL);
            isFromLongPresstemp = isFromLongPress;
            isFromLongPress = false;

        } else {
            //  showMySystemDialog(tr("No Data Found"));
            if (isfromFoucs) {
                Geographic *myGeo = myMapView->mapData()->geographic(getFouceId());
                GeoLocation *myLocation = 0;

                if (myGeo) {
                    myLocation = qobject_cast<GeoLocation*>(myGeo);

                }

                if (!myLocation) {
                    myLocation = new GeoLocation(getFouceId());
                    QString mtemp = myLocation->property("pin_name").toString();
                    if(checkInvalid(mtemp.replace(" ","")) !="text"){
                        setMulitple("fromuae");

                    }


                }
                isfromFoucs = false;
            }
        }

    } else {
        if (isFromLongPresstemp) {
            ClearMapdata();
            isFromLongPresstemp = false;
        }
        if (isfromNearByDetails) {

            mListPOIPrevious.clear();

        } else {
            mlistentrance.clear();
        }

        if (mMakaniListEntrance.size() == 0) {
            if (isNeedConvertLatToUAENG) {
                if (isOutlineFromMultiplePin)
                    getCoordinateConversion(mPlaceLongitude, mPlaceLatitude, "LATLNG", "NoOutLineMultiplePin", false);
                else
                    getCoordinateConversion(mPlaceLongitude, mPlaceLatitude, "LATLNG", "NoOutLine", false);
            } else {
                m_active = false;
                emit activeChanged();
            }
        } else {
            if (isfromFoucs) {
                Geographic *myGeo = myMapView->mapData()->geographic(getFouceId());
                GeoLocation *myLocation = 0;

                if (myGeo) {
                    myLocation = qobject_cast<GeoLocation*>(myGeo);

                }

                if (!myLocation) {
                    myLocation = new GeoLocation(getFouceId());
                    myLocation->setName(myLocation->property("pin_name").toString());

                    setMulitple("fromuae");
                }

                isfromFoucs = false;
            }
            QString ENT_NAME_E;
            QString ENT_NAME_TEMP;
            mLastFocusID = ""; // Clear last focus id
            for (int i = 0; i < mMakaniListEntrance.size(); i++) {
                QVariantMap mMapPinData;
                QVariantMap mMapEntrance = mMakaniListEntrance.value(i).toMap();
                mStrMakaniNo = mMapEntrance.value("MAKANI").toString();
                mStrLatLon = mMapEntrance.value("LATLNG").toString();

                mStrEntranceID = mMapEntrance.value("ENTERANCEID").toString();
                PICTURE = mMapEntrance.value("PICTURE").toString();
                //  emit mPICTUREDone();
                ROADNAMEEN = mMapEntrance.value("ROADNAMEEN").toString();
                ROADNAMEAR = mMapEntrance.value("ROADNAMEAR").toString();
                COMM_EN = mMapEntrance.value("COMM_EN").toString();
                COMM_AR = mMapEntrance.value("COMM_AR").toString();
                ENT_NAME_TEMP = mMapEntrance.value("ENT_NAME_E").toString();
                if (getValueFor("mLanguageCode", "en") == "en") {
                    ENT_NAME_E = mMapEntrance.value("ENT_NAME_E").toString();
                    mmCOMM_ENValue = mMapEntrance.value("COMM_EN").toString();
                    emit mCOMM_ENDone();
                } else {
                    ENT_NAME_E = mMapEntrance.value("ENT_NAME_A").toString();
                    mmCOMM_ENValue = mMapEntrance.value("COMM_AR").toString();
                    emit mCOMM_ENDone();
                }
                mMapPinData["MAKANI"] = mStrMakaniNo;
                mMapPinData["LATLNG"] = mStrLatLon;
                mMapPinData["ENT_NAME_E"] = ENT_NAME_E;
                mMapPinData["ROADNAME"] = getValueFor("mLanguageCode", "en") == "en" ? ROADNAMEEN : ROADNAMEAR;
                mMapPinData["PICTURE"] = PICTURE;

                mMapPinData["mCOMM_EN"] = getValueFor("mLanguageCode", "en") == "en" ? COMM_EN : COMM_AR;
                QString commaPattern(",");
                QStringList mListCoord = mStrLatLon.split(commaPattern);

                QString templat = mListCoord.value(0);
                QString templng = mListCoord.value(1);
                mMapPinData["X_COORD"] = templat;
                mMapPinData["Y_COORD"] = templng;
                mMapPinData["NAME_E"] = ENT_NAME_E;

                if (isIsfromNearByDetails()) {
                    if (ENT_NAME_E == "EMERGENCY ENTRANCE") {
                        if (getValueFor("mLanguageCode", "en") == "en") {
                            drawPinOnMap("Mappin_en.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                        } else {
                            drawPinOnMap("Mappin_ar.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                        }

                    } else {
                        drawPinOnMap("pin1.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                    }

                    mlistentrance.append(mMapPinData);
                } else {
                    if (ENT_NAME_TEMP == "EMERGENCY ENTRANCE") {

                        if (getValueFor("mLanguageCode", "en") == "en") {
                            drawPinOnMap("Mappin_en.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                        } else {
                            drawPinOnMap("Mappin_ar.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                        }

                    } else {
                        drawPinOnMap("pin1.png", mStrLatLon, mStrMakaniNo, mPinTypeEntrance, mMapPinData);
                    }
                    mlistentrance.append(mMapPinData);
                }

            }

            QVariantList mMakaniListCoord = list.toMap().value("EntranceInfo").toMap().value("BUILDING").toList();

            for (int i = 0; i < mMakaniListCoord.size(); i++) {
                QString mStrLatCoord;
                QVariantMap mMapEntrance = mMakaniListCoord.value(i).toMap();
                mStrLatCoord = mMapEntrance.value("COORD").toString();
                QString mStrLatBLDIF;
                mStrLatBLDIF = mMapEntrance.value("BLDIF").toString();

                QString colonPattern(";");

                QStringList listLatLon = mStrLatCoord.split(colonPattern);
                QLocale c(QLocale::C);
                mListLat.clear();
                mListLng.clear();
                for (int j = 0; j < listLatLon.size(); j++) {
                    QString currentCoord = listLatLon.value(j);
                    if (currentCoord.length() > 0) {
                        QString commaPattern(",");
                        QStringList mListCoord = currentCoord.split(commaPattern);

                        QString templat = mListCoord.value(0);
                        QString templng = mListCoord.value(1);

                        mListLat.append(c.toDouble(templat));
                        mListLng.append(c.toDouble(templng));
                    }
                }
                drawBulidingOutLine(mListLat, mListLng, mStrLatBLDIF);
            }
        }
    }
    m_active = false;
    emit activeChanged();
}
void WebServicesAPI::parseGetParcelOutline(QString data)
{
    JsonDataAccess jda;
    QString UAENG;
    QString COORD;
    QString CENTROID;
    QString PARCEL_ID;
    QVariantList mPARCELINFOList;
    QString no_data = jda.loadFromBuffer(data).toMap().value("DATA").toString();
    mPARCELINFOList = jda.loadFromBuffer(data).toMap().value("PARCELINFO").toList();
    mMapData->clear();
    ClearMapdata();
    if (no_data == "No Data Found") {
        //    showMySystemDialog("No Data Found");
        showMySystemDialog(tr("No Data Found"));

    } else {
        COORD = mPARCELINFOList.value(0).toMap().value("COORD").toString();

        UAENG = mPARCELINFOList.value(0).toMap().value("UAENG").toString();
        CENTROID = mPARCELINFOList.value(0).toMap().value("CENTROID").toString();
        PARCEL_ID = mPARCELINFOList.value(0).toMap().value("PARCEL_ID").toString();
        QString colonPattern(";");
        QStringList listLatLon = COORD.split(colonPattern);
        QLocale c(QLocale::C);
        mListLat.clear();
        mListLng.clear();
        for (int j = 0; j < listLatLon.size(); j++) {
            QString currentCoord = listLatLon.value(j);
            if (currentCoord.length() > 0) {
                QString commaPattern(",");
                QStringList mListCoord = currentCoord.split(commaPattern);
                QString templat = mListCoord.value(0);
                QString templng = mListCoord.value(1);
                mListLat.append(c.toDouble(templat));
                mListLng.append(c.toDouble(templng));
            }
        }
        drawBulidingOutLine(mListLat, mListLng, PARCEL_ID);
        drawPinOnMap("pin2.png", CENTROID, UAENG, mPinTypeSingle, NULL);
        mListLat.clear();
        mListLng.clear();

    } //else ends

    m_active = false;
    emit activeChanged();
}
void WebServicesAPI::parseGetParcelOutline_New(QString mdata)
{
    QString UAENG;
    QString COORD;
    QString CENTROID;
    QString PARCEL_ID;
    JsonDataAccess jds;
    QVariant mVariant = jds.loadFromBuffer(mdata);
    QVariantList mListBUILDINGS = mVariant.toMap().value("BUILDINGS").toList();
    QVariantList mListPARCELINFO = mVariant.toMap().value("PARCELINFO").toList();
    QString no_data = jds.loadFromBuffer(mdata).toMap().value("DATA").toString();
    QString mcount = mListBUILDINGS.value(0).toMap().value("COUNT").toString();
    QString mBUILDING = "BUILDING";
    qint64 mcountLoop = 1;
    QString ROADNAME;
    QString COMM;
    QString picture;
    clearmyInfoPopupData();

    if (no_data == "No Data Found" || jds.loadFromBuffer(mdata).toMap().value("DATA").toString() == "Invalid Parcel Id") {
        showMySystemDialog(tr("No data found"));

        /* if (getValueFor("mLanguageCode", "en") == "en") {
         showMySystemDialog("No data found");
         } else {
         showMySystemDialog(tr("لا توجد بيانات"));
         }*/
    } else {
        COORD = mListPARCELINFO.value(0).toMap().value("COORD").toString();
        UAENG = mListPARCELINFO.value(0).toMap().value("UAENG").toString();
        CENTROID = mListPARCELINFO.value(0).toMap().value("CENTROID").toString();
        PARCEL_ID = mListPARCELINFO.value(0).toMap().value("PARCEL_ID").toString();
        mLandNumberValue = PARCEL_ID;
        emit mLandNumberDone();
        if (isfromLandNumber) {

            QString commaPattern(",");
            QStringList mListCoord = CENTROID.split(commaPattern);
            //QString templat = mListCoord.value(0);
            //QString templng = mListCoord.value(1);
            mCCLatitude = mListCoord.value(0);
            mCCLongitude = mListCoord.value(1);
            emit directionServiceDataLoaded();
        } else {
            mlistentrance.clear();
            QString colonPattern(";");
            QStringList listLatLon = mListPARCELINFO.value(0).toMap().value("COORD").toString().split(colonPattern);
            QLocale c(QLocale::C);
            mListLat.clear();
            mListLng.clear();
            for (int j = 0; j < listLatLon.size(); j++) {
                QString currentCoord = listLatLon.value(j);
                if (currentCoord.length() > 0) {
                    QString commaPattern(",");
                    QStringList mListCoord = currentCoord.split(commaPattern);
                    QString templat = mListCoord.value(0);
                    QString templng = mListCoord.value(1);
                    mListLat.append(c.toDouble(templat));
                    mListLng.append(c.toDouble(templng));
                }
            }
            //drawBulidingOutLine(mListLat, mListLng, PARCEL_ID);
            drawBulidingOutLineBlue(mListLat, mListLng, PARCEL_ID, myMapView->mapData());

            mListLat.clear();
            mListLng.clear();

            for (int i = 0; i < mcount.toInt(); i++) {
                for (int j = 0; j < mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().size(); j++) {
                    QVariantMap mListData;
                    QString mMakani = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("MAKANI").toString();
                    picture = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("PICTURE").toString();
                    QString ENT_NAME;

                    if (getValueFor("mLanguageCode", "en") == "en") {
                        ENT_NAME = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("ENT_NAME_E").toString();

                        COMM = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("COMM_EN").toString();
                        ROADNAME = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("ROADNAMEEN").toString();
                    } else {
                        ENT_NAME = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("ENT_NAME_A").toString();
                        COMM = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("COMM_AR").toString();
                        ROADNAME = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("ROADNAMEAR").toString();
                    }

                    QString mLatLng = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("BuildingInfo").toMap().value("ENTERANCE").toList().value(j).toMap().value("LATLNG").toString();
                    mListData["ENT_NAME"] = ENT_NAME;
                    mListData["mCOMM_EN"] = COMM;
                    mListData["ROADNAME"] = ROADNAME;
                    mListData["PICTURE"] = picture;
                    mListData["MAKANI"] = mMakani;
                    mListData["LATLNG"] = mLatLng;
                    mlistentrance.append(mListData);
                    drawPinOnMap("pin1.png", mLatLng, mMakani, mPinTypeEntrance, mListData);
                }
                for (int k = 0; k < mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("EntranceInfo").toMap().value("BUILDING").toList().size(); k++) {
                    QString colonPattern1(";");
                    QStringList listLatLon1 = mListBUILDINGS.value(0).toMap().value(mBUILDING + QString::number(mcountLoop)).toMap().value("EntranceInfo").toMap().value("BUILDING").toList().value(0).toMap().value("COORD").toString().split(colonPattern1);
                    QLocale c1(QLocale::C);
                    mListLat.clear();
                    mListLng.clear();
                    for (int j = 0; j < listLatLon1.size(); j++) {
                        QString currentCoord = listLatLon1.value(j);
                        if (currentCoord.length() > 0) {
                            QString commaPattern(",");
                            QStringList mListCoord = currentCoord.split(commaPattern);
                            QString templat = mListCoord.value(0);
                            QString templng = mListCoord.value(1);
                            mListLat.append(c.toDouble(templat));
                            mListLng.append(c.toDouble(templng));
                        }

                    }
                    drawBulidingOutLineRed(mListLat, mListLng, "", myMapView->mapData());
                }
                mcountLoop = mcountLoop + 1;
//                drawBulidingOutLineRed(mListLat, mListLng, "", myMapView->mapData());
            } //main for loop ends
              // drawBulidingOutLineRed(mListLat, mListLng, "", myMapView->mapData());
            mListLat.clear();
            mListLng.clear();
        }
    } //else ends
    m_active = false;
    emit activeChanged();
}
bool WebServicesAPI::isIsfromLandNumber() const
{
    return isfromLandNumber;
}
void WebServicesAPI::setIsfromLandNumber(bool checkisfromLandNumber)
{
    isfromLandNumber = checkisfromLandNumber;
}
void WebServicesAPI::parseGetPOI(QString mdata)
{
    JsonDataAccess jds;
    QVariant mlistvarinat = jds.loadFromBuffer(mdata);
    QVariantList mListPOI = mlistvarinat.toMap().value("POI").toList();
    mNearByList = mListPOI;

    if (mListPOI.size() == 0) {

        emit noDataFound();
    } else {
        for (int i = 0; i < mListPOI.size(); i++) {
            if (i < 12) {
                QVariantMap mMap;
                mMap["NAME_E"] = mListPOI.value(i).toMap().value("NAME_E").toString();
                mMap["NAME_A"] = mListPOI.value(i).toMap().value("NAME_A").toString();
                mMap["PICTURE"] = mListPOI.value(i).toMap().value("PICTURE").toString();
                mMap["DISTANCE"] = mListPOI.value(i).toMap().value("DISTANCE").toString();
                mMap["X_COORD"] = mListPOI.value(i).toMap().value("X_COORD").toString();
                mMap["Y_COORD"] = mListPOI.value(i).toMap().value("Y_COORD").toString();
                mMap["UAENG"] = mListPOI.value(i).toMap().value("UAENG").toString();
                mm_modelNearBy->insert(mMap);
            }
        }
        mModelLastIndex = mm_modelNearBy->last();
        emit mnearByLastIndexDone();
        shortingDataModel("DISTANCE");
        // emit modelNearBychanged();
    }
    m_active = false;
    emit activeChanged();

}
void WebServicesAPI::shortingDataModel(QString keyword)
{
    QStringList mTitle;
    mTitle << keyword;
    mm_modelNearBy->setSortingKeys(mTitle);
    emit modelNearBychanged();
}
void WebServicesAPI::loadDatamore(const QVariantList &indexPath)
{
// Check whether the index path is valid
    if (indexPath.size() != 1)
        return;

// Retrieve position of marker in list
    const int position = indexPath[0].toInt() + 1;
// Append the new items
    for (int row = position; row < (position + 10); ++row) {

        if (mNearByList.size() == row) {
            mModelLastIndex = 0;
            break;
        } else {
            QVariantMap mMap;
            mMap["NAME_E"] = mNearByList.value(row).toMap().value("NAME_E").toString();
            mMap["NAME_A"] = mNearByList.value(row).toMap().value("NAME_A").toString();
            mMap["PICTURE"] = mNearByList.value(row).toMap().value("PICTURE").toString();
            mMap["DISTANCE"] = mNearByList.value(row).toMap().value("DISTANCE").toString();
            mMap["X_COORD"] = mNearByList.value(row).toMap().value("X_COORD").toString();
            mMap["Y_COORD"] = mNearByList.value(row).toMap().value("Y_COORD").toString();
            mMap["UAENG"] = mNearByList.value(row).toMap().value("UAENG").toString();
            mm_modelNearBy->insert(mMap);

        }
    }
    mModelLastIndex = mm_modelNearBy->last();
}

void WebServicesAPI::parseGetCategoriesByServiceID(QString data)
{
    JsonDataAccess jda;
    QVariantList mListSERVICE = jda.loadFromBuffer(data).toMap().value("SERVICE").toList();
    QVariantList mListPoi = mListSERVICE.value(0).toMap().value("POI").toList();
    QVariantList mListCategory = mListSERVICE.value(0).toMap().value("CATEGORY").toList();
    mListDialogData.clear();
    mCategoryResponseId.clear();
    QString CATEGORY;
    if (mListCategory.size() == 0) {
        emit noDataFound();
    } else {
        for (int i = 0; i < mListCategory.size(); i++) {
            mListDialogData.append(mListCategory.value(i).toMap().value("CATEGORY_NAME_E").toString());

            if (getValueFor("mLanguageCode", "en") == "en") {
                QVariantMap map;
                CATEGORY = mListCategory.value(i).toMap().value("CATEGORY_NAME_E").toString();
                map["Category"] = CATEGORY;
                map["CATEGORY_ID"] = mListCategory.value(i).toMap().value("CATEGORY_ID").toString();
                mm_modelcategory->insert(map);

            } else {
                QVariantMap map;
                CATEGORY = mListCategory.value(i).toMap().value("CATEGORY_NAME_A").toString();
                map["Category"] = CATEGORY;
                map["CATEGORY_ID"] = mListCategory.value(i).toMap().value("CATEGORY_ID").toString();
                mm_modelcategory->insert(map);
            }

            /*if (getValueFor("mLanguageCode", "en") == "en") {
             mListDialogData.append(
             mListCategory.value(i).toMap().value("CATEGORY_NAME_E").toString());
             QVariantMap map;
             map["CATEGORY_NAME_E"] =
             mListCategory.value(i).toMap().value("CATEGORY_NAME_E").toString();
             map["CATEGORY_ID"] = mListCategory.value(i).toMap().value("CATEGORY_ID").toString();
             mm_modelcategory->insert(map);

             } else {
             mListDialogData.append(
             mListCategory.value(i).toMap().value("CATEGORY_NAME_A").toString());
             QVariantMap map;
             map["CATEGORY_NAME_A"] =
             mListCategory.value(i).toMap().value("CATEGORY_NAME_A").toString();
             map["CATEGORY_ID"] = mListCategory.value(i).toMap().value("CATEGORY_ID").toString();
             mm_modelcategory->insert(map);

             }*/

        }
        mCategoryResponseId = mListCategory;
        emit modelcategorychanged();
        GetPOIByServiceIDAndCategoryId("", getServiceId());
    }
}

QString WebServicesAPI::getValueFromName(QString myCatName)
{
    QString categoryName;
    QString categoryId;
    for (int i = 0; i < mCategoryResponseId.size(); i++) {
        if (myCatName == mCategoryResponseId.value(i).toMap().value("CATEGORY_NAME_E").toString()) {
            categoryName = mCategoryResponseId.value(i).toMap().value("CATEGORY_NAME_E").toString();
            categoryId = mCategoryResponseId.value(i).toMap().value("CATEGORY_ID").toString();

            break;
        }
    }
    return categoryId;
}

void WebServicesAPI::parseGetPOIByServiceIDAndCategoryId(QString data)
{
    JsonDataAccess jda;
    QVariant mDataLList = jda.loadFromBuffer(data);
    QVariantList mListSERVICE = mDataLList.toMap().value("SERVICE").toList();

    mlistSearchPlaceName.clear();
    QVariantList mLisPOI;
    for (int i = 0; i < mListSERVICE.size(); i++) {
        QVariantMap entry;
        mLisPOI = mListSERVICE.value(i).toMap().value("POI").toList();

        for (int j = 0; j < mLisPOI.size(); j++) {
            entry["NAME_E"] = mLisPOI.value(j).toMap().value("NAME_E").toString();
            entry["NAME_A"] = mLisPOI.value(j).toMap().value("NAME_A").toString();

            entry["X_COORD"] = mLisPOI.value(j).toMap().value("X_COORD").toString();
            entry["Y_COORD"] = mLisPOI.value(j).toMap().value("Y_COORD").toString();
            mlistSearchPlaceName.append(entry);
        }
    }
}
void WebServicesAPI::parseGetPOIByServiceIDCategoryIdPOI(QString mdata)
{
    JsonDataAccess jda;
    QVariant mvarinat = jda.loadFromBuffer(mdata);
    QVariantList mServiceList = mvarinat.toMap().value("SERVICE").toList();
//QVariantList mPOIList = mvarinat.toMap().value("SERVICE").toList();

    mlistSearchPlaceName.clear();
    QVariantList mLisPOI;
    for (int i = 0; i < mServiceList.size(); i++) {
        mLisPOI = mServiceList.value(i).toMap().value("POI").toList();
        QVariantMap entry;
        for (int j = 0; j < mLisPOI.size(); j++) {

            entry["NAME_E"] = mLisPOI.value(j).toMap().value("NAME_E").toString();
            entry["NAME_A"] = mLisPOI.value(j).toMap().value("NAME_A").toString();

            entry["X_COORD"] = mLisPOI.value(j).toMap().value("X_COORD").toString();
            entry["Y_COORD"] = mLisPOI.value(j).toMap().value("Y_COORD").toString();
            mlistSearchPlaceName.append(entry);
        }
    }
//mlist in parseGetPOIByServiceIDCategoryIdPOI:  (QVariant(QVariantMap, QMap(("CATEGORY_ID", QVariant(QString, "19010000") ) ( "POI" ,  QVariant(QVariantList, (QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "المرابع العربية فندق و نادي الغولف   دبي") ) ( "NAME_E" ,  QVariant(QString, "ARABIAN RANCHES HOTEL & GOLF CLUB   DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.051257") ) ( "Y_COORD" ,  QVariant(QString, "55.268566") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ارماني دبي") ) ( "NAME_E" ,  QVariant(QString, "ARMANI HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.1971") ) ( "Y_COORD" ,  QVariant(QString, "55.2741") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق افاري دبي") ) ( "NAME_E" ,  QVariant(QString, "AVARI DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.260481") ) ( "Y_COORD" ,  QVariant(QString, "55.326532") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق سيتي ماكس بردبي") ) ( "NAME_E" ,  QVariant(QString, "CITY MAX BUR DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.250890") ) ( "Y_COORD" ,  QVariant(QString, "55.291907") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق كوبثورن دبي") ) ( "NAME_E" ,  QVariant(QString, "COPTHORNE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.254872") ) ( "Y_COORD" ,  QVariant(QString, "55.327979") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كورال ديرة دبي") ) ( "NAME_E" ,  QVariant(QString, "CORAL DEIRA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.266130") ) ( "Y_COORD" ,  QVariant(QString, "55.325668") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كورال اورينتال دبي") ) ( "NAME_E" ,  QVariant(QString, "CORAL ORIENTAL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.276081") ) ( "Y_COORD" ,  QVariant(QString, "55.313462") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كراون بلازا دبي ديره") ) ( "NAME_E" ,  QVariant(QString, "CROWNE PLAZA DUBAI DEIRA") ) ( "X_COORD" ,  QVariant(QString, "25.270627") ) ( "Y_COORD" ,  QVariant(QString, "55.327042") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق كراون بلازا") ) ( "NAME_E" ,  QVariant(QString, "CROWNE PLAZA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.2204") ) ( "Y_COORD" ,  QVariant(QString, "55.2805") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي جراند") ) ( "NAME_E" ,  QVariant(QString, "DUBAI GRAND HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.273540") ) ( "Y_COORD" ,  QVariant(QString, "55.381383") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "منتجع شاطيء دبي مارينا") ) ( "NAME_E" ,  QVariant(QString, "DUBAI MARINE BEACH RESORTS & SPA") ) ( "X_COORD" ,  QVariant(QString, "25.234581") ) ( "Y_COORD" ,  QVariant(QString, "55.262796") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي نوفا") ) ( "NAME_E" ,  QVariant(QString, "DUBAI NOVA HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.262417") ) ( "Y_COORD" ,  QVariant(QString, "55.295787") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي بالم") ) ( "NAME_E" ,  QVariant(QString, "DUBAI PALM HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.273261") ) ( "Y_COORD" ,  QVariant(QString, "55.319637") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "مجموعة فنادق دبي") ) ( "NAME_E" ,  QVariant(QString, "DUBAI PEARL HOTEL 01 LIMITED") ) ( "X_COORD" ,  QVariant(QString, "25.095208") ) ( "Y_COORD" ,  QVariant(QString, "55.157240") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فيرمونت دبي") ) ( "NAME_E" ,  QVariant(QString, "FAIRMONT DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.2263") ) ( "Y_COORD" ,  QVariant(QString, "55.2845") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "هيلتون دبي كريك") ) ( "NAME_E" ,  QVariant(QString, "HILTON DUBAI CREEK") ) ( "X_COORD" ,  QVariant(QString, "25.259966") ) ( "Y_COORD" ,  QVariant(QString, "55.318175") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "هوليداي ان بر دبي") ) ( "NAME_E" ,  QVariant(QString, "HOLIDAY INN BUR DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.257523") ) ( "Y_COORD" ,  QVariant(QString, "55.304634") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "حياة ريجينسي دبي") ) ( "NAME_E" ,  QVariant(QString, "HYATT REGENCY DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.278746") ) ( "Y_COORD" ,  QVariant(QString, "55.304089") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق جيه دبليو ماريوت") ) ( "NAME_E" ,  QVariant(QString, "JW MARRIOTT HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.268568") ) ( "Y_COORD" ,  QVariant(QString, "55.329527") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "جي دبليو ماريوت ماركيوز دبي") ) ( "NAME_E" ,  QVariant(QString, "JW MARRIOTT MARQUIS DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.185877") ) ( "Y_COORD" ,  QVariant(QString, "55.257818") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق مانهاتن دبي") ) ( "NAME_E" ,  QVariant(QString, "MANHATTAN HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.251538") ) ( "Y_COORD" ,  QVariant(QString, "55.290840") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "ماريوت دبي هاربور هوتيل اند سويتس") ) ( "NAME_E" ,  QVariant(QString, "MARRIOTT DUBAI HARBOUR HOTEL AND SUITES") ) ( "X_COORD" ,  QVariant(QString, "25.087667") ) ( "Y_COORD" ,  QVariant(QString, "55.145997") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ملينيوم بلازا دبي") ) ( "NAME_E" ,  QVariant(QString, "MILLENNIUM PLAZA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.217694") ) ( "Y_COORD" ,  QVariant(QString, "55.278531") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق موفنبيك مرسى دبي") ) ( "NAME_E" ,  QVariant(QString, "MOVENPICK HOTEL MARSA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.080161") ) ( "Y_COORD" ,  QVariant(QString, "55.136747") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "ون اند اونلي رويال ميراج دبي") ) ( "NAME_E" ,  QVariant(QString, "ONE & ONLY ROYAL MIRAGE DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.095016") ) ( "Y_COORD" ,  QVariant(QString, "55.150359") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "دا بالم دبي") ) ( "NAME_E" ,  QVariant(QString, "ONE & ONLY THE PALM DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.098968") ) ( "Y_COORD" ,  QVariant(QString, "55.132681") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق بارك ريجس كريسكين – دبي") ) ( "NAME_E" ,  QVariant(QString, "PARK REGIS KRIS KIN HOTEL  DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.249249") ) ( "Y_COORD" ,  QVariant(QString, "55.301442") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "برميرا إن مجمع دبي للاستثمار الأول") ) ( "NAME_E" ,  QVariant(QString, "PREMIER INN DUBAI INVESTMENT PARK FIRST") ) ( "X_COORD" ,  QVariant(QString, "25.008239") ) ( "Y_COORD" ,  QVariant(QString, "55.156595") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "راديسون بلو خور دبي") ) ( "NAME_E" ,  QVariant(QString, "RADISSON BLU HOTEL DUBAI CREEK") ) ( "X_COORD" ,  QVariant(QString, "25.264651") ) ( "Y_COORD" ,  QVariant(QString, "55.310847") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "راديسون فندق رويال دبي") ) ( "NAME_E" ,  QVariant(QString, "RADISSON ROYAL HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.223593") ) ( "Y_COORD" ,  QVariant(QString, "55.282631") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "رفلز دبي") ) ( "NAME_E" ,  QVariant(QString, "RAFFLES DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.227867") ) ( "Y_COORD" ,  QVariant(QString, "55.321049") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق رامادا دبي") ) ( "NAME_E" ,  QVariant(QString, "RAMADA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.255526") ) ( "Y_COORD" ,  QVariant(QString, "55.295268") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ريكسوس  النخلة دبي") ) ( "NAME_E" ,  QVariant(QString, "RIXOS THE PALM DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.121093") ) ( "Y_COORD" ,  QVariant(QString, "55.153987") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق شانغريلا دبي") ) ( "NAME_E" ,  QVariant(QString, "SHANGRILA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.208031") ) ( "Y_COORD" ,  QVariant(QString, "55.272064") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق تاج بالاس دبي") ) ( "NAME_E" ,  QVariant(QString, "TAJ PALACE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.262644") ) ( "Y_COORD" ,  QVariant(QString, "55.321420") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق العنوان") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS   DOWNTOWN DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.1942") ) ( "Y_COORD" ,  QVariant(QString, "55.2789") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "العنوان مرسى دبي") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS MARSA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.076876") ) ( "Y_COORD" ,  QVariant(QString, "55.141588") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "العنوان منتغمري دبي") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS MONTGOMERIE DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.067494") ) ( "Y_COORD" ,  QVariant(QString, "55.164408") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق المركز التجاري العالمي") ) ( "NAME_E" ,  QVariant(QString, "WORLD TRADE CENTRE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.226713") ) ( "Y_COORD" ,  QVariant(QString, "55.289025") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "زيكو للشقق الفندقية دبي") ) ( "NAME_E" ,  QVariant(QString, "ZIQOO HOTEL APARTMENTS DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.049081") ) ( "Y_COORD" ,  QVariant(QString, "55.130660") ) )  ) )  ) ) ( "SERVICE_ID" ,  QVariant(QString, "19000000") ) )  ) )

// QVariant(QVariantMap, QMap(("SERVICE", QVariant(QVariantList, (QVariant(QVariantMap, QMap(("CATEGORY_ID", QVariant(QString, "19010000") ) ( "POI" ,  QVariant(QVariantList, (QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "المرابع العربية فندق و نادي الغولف   دبي") ) ( "NAME_E" ,  QVariant(QString, "ARABIAN RANCHES HOTEL & GOLF CLUB   DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.051257") ) ( "Y_COORD" ,  QVariant(QString, "55.268566") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ارماني دبي") ) ( "NAME_E" ,  QVariant(QString, "ARMANI HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.1971") ) ( "Y_COORD" ,  QVariant(QString, "55.2741") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق افاري دبي") ) ( "NAME_E" ,  QVariant(QString, "AVARI DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.260481") ) ( "Y_COORD" ,  QVariant(QString, "55.326532") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق سيتي ماكس بردبي") ) ( "NAME_E" ,  QVariant(QString, "CITY MAX BUR DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.250890") ) ( "Y_COORD" ,  QVariant(QString, "55.291907") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق كوبثورن دبي") ) ( "NAME_E" ,  QVariant(QString, "COPTHORNE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.254872") ) ( "Y_COORD" ,  QVariant(QString, "55.327979") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كورال ديرة دبي") ) ( "NAME_E" ,  QVariant(QString, "CORAL DEIRA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.266130") ) ( "Y_COORD" ,  QVariant(QString, "55.325668") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كورال اورينتال دبي") ) ( "NAME_E" ,  QVariant(QString, "CORAL ORIENTAL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.276081") ) ( "Y_COORD" ,  QVariant(QString, "55.313462") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "كراون بلازا دبي ديره") ) ( "NAME_E" ,  QVariant(QString, "CROWNE PLAZA DUBAI DEIRA") ) ( "X_COORD" ,  QVariant(QString, "25.270627") ) ( "Y_COORD" ,  QVariant(QString, "55.327042") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق كراون بلازا") ) ( "NAME_E" ,  QVariant(QString, "CROWNE PLAZA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.2204") ) ( "Y_COORD" ,  QVariant(QString, "55.2805") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي جراند") ) ( "NAME_E" ,  QVariant(QString, "DUBAI GRAND HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.273540") ) ( "Y_COORD" ,  QVariant(QString, "55.381383") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "منتجع شاطيء دبي مارينا") ) ( "NAME_E" ,  QVariant(QString, "DUBAI MARINE BEACH RESORTS & SPA") ) ( "X_COORD" ,  QVariant(QString, "25.234581") ) ( "Y_COORD" ,  QVariant(QString, "55.262796") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي نوفا") ) ( "NAME_E" ,  QVariant(QString, "DUBAI NOVA HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.262417") ) ( "Y_COORD" ,  QVariant(QString, "55.295787") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق دبي بالم") ) ( "NAME_E" ,  QVariant(QString, "DUBAI PALM HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.273261") ) ( "Y_COORD" ,  QVariant(QString, "55.319637") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "مجموعة فنادق دبي") ) ( "NAME_E" ,  QVariant(QString, "DUBAI PEARL HOTEL 01 LIMITED") ) ( "X_COORD" ,  QVariant(QString, "25.095208") ) ( "Y_COORD" ,  QVariant(QString, "55.157240") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فيرمونت دبي") ) ( "NAME_E" ,  QVariant(QString, "FAIRMONT DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.2263") ) ( "Y_COORD" ,  QVariant(QString, "55.2845") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "هيلتون دبي كريك") ) ( "NAME_E" ,  QVariant(QString, "HILTON DUBAI CREEK") ) ( "X_COORD" ,  QVariant(QString, "25.259966") ) ( "Y_COORD" ,  QVariant(QString, "55.318175") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "هوليداي ان بر دبي") ) ( "NAME_E" ,  QVariant(QString, "HOLIDAY INN BUR DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.257523") ) ( "Y_COORD" ,  QVariant(QString, "55.304634") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "حياة ريجينسي دبي") ) ( "NAME_E" ,  QVariant(QString, "HYATT REGENCY DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.278746") ) ( "Y_COORD" ,  QVariant(QString, "55.304089") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق جيه دبليو ماريوت") ) ( "NAME_E" ,  QVariant(QString, "JW MARRIOTT HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.268568") ) ( "Y_COORD" ,  QVariant(QString, "55.329527") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "جي دبليو ماريوت ماركيوز دبي") ) ( "NAME_E" ,  QVariant(QString, "JW MARRIOTT MARQUIS DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.185877") ) ( "Y_COORD" ,  QVariant(QString, "55.257818") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق مانهاتن دبي") ) ( "NAME_E" ,  QVariant(QString, "MANHATTAN HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.251538") ) ( "Y_COORD" ,  QVariant(QString, "55.290840") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "ماريوت دبي هاربور هوتيل اند سويتس") ) ( "NAME_E" ,  QVariant(QString, "MARRIOTT DUBAI HARBOUR HOTEL AND SUITES") ) ( "X_COORD" ,  QVariant(QString, "25.087667") ) ( "Y_COORD" ,  QVariant(QString, "55.145997") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ملينيوم بلازا دبي") ) ( "NAME_E" ,  QVariant(QString, "MILLENNIUM PLAZA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.217694") ) ( "Y_COORD" ,  QVariant(QString, "55.278531") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق موفنبيك مرسى دبي") ) ( "NAME_E" ,  QVariant(QString, "MOVENPICK HOTEL MARSA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.080161") ) ( "Y_COORD" ,  QVariant(QString, "55.136747") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "ون اند اونلي رويال ميراج دبي") ) ( "NAME_E" ,  QVariant(QString, "ONE & ONLY ROYAL MIRAGE DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.095016") ) ( "Y_COORD" ,  QVariant(QString, "55.150359") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "دا بالم دبي") ) ( "NAME_E" ,  QVariant(QString, "ONE & ONLY THE PALM DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.098968") ) ( "Y_COORD" ,  QVariant(QString, "55.132681") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق بارك ريجس كريسكين – دبي") ) ( "NAME_E" ,  QVariant(QString, "PARK REGIS KRIS KIN HOTEL  DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.249249") ) ( "Y_COORD" ,  QVariant(QString, "55.301442") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "برميرا إن مجمع دبي للاستثمار الأول") ) ( "NAME_E" ,  QVariant(QString, "PREMIER INN DUBAI INVESTMENT PARK FIRST") ) ( "X_COORD" ,  QVariant(QString, "25.008239") ) ( "Y_COORD" ,  QVariant(QString, "55.156595") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "راديسون بلو خور دبي") ) ( "NAME_E" ,  QVariant(QString, "RADISSON BLU HOTEL DUBAI CREEK") ) ( "X_COORD" ,  QVariant(QString, "25.264651") ) ( "Y_COORD" ,  QVariant(QString, "55.310847") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "راديسون فندق رويال دبي") ) ( "NAME_E" ,  QVariant(QString, "RADISSON ROYAL HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.223593") ) ( "Y_COORD" ,  QVariant(QString, "55.282631") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "رفلز دبي") ) ( "NAME_E" ,  QVariant(QString, "RAFFLES DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.227867") ) ( "Y_COORD" ,  QVariant(QString, "55.321049") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق رامادا دبي") ) ( "NAME_E" ,  QVariant(QString, "RAMADA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.255526") ) ( "Y_COORD" ,  QVariant(QString, "55.295268") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق ريكسوس  النخلة دبي") ) ( "NAME_E" ,  QVariant(QString, "RIXOS THE PALM DUBAI HOTEL") ) ( "X_COORD" ,  QVariant(QString, "25.121093") ) ( "Y_COORD" ,  QVariant(QString, "55.153987") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق شانغريلا دبي") ) ( "NAME_E" ,  QVariant(QString, "SHANGRILA HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.208031") ) ( "Y_COORD" ,  QVariant(QString, "55.272064") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق تاج بالاس دبي") ) ( "NAME_E" ,  QVariant(QString, "TAJ PALACE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.262644") ) ( "Y_COORD" ,  QVariant(QString, "55.321420") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق العنوان") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS   DOWNTOWN DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.1942") ) ( "Y_COORD" ,  QVariant(QString, "55.2789") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "العنوان مرسى دبي") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS MARSA DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.076876") ) ( "Y_COORD" ,  QVariant(QString, "55.141588") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "العنوان منتغمري دبي") ) ( "NAME_E" ,  QVariant(QString, "THE ADDRESS MONTGOMERIE DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.067494") ) ( "Y_COORD" ,  QVariant(QString, "55.164408") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "فندق المركز التجاري العالمي") ) ( "NAME_E" ,  QVariant(QString, "WORLD TRADE CENTRE HOTEL DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.226713") ) ( "Y_COORD" ,  QVariant(QString, "55.289025") ) )  ) ,  QVariant(QVariantMap, QMap(("NAME_A", QVariant(QString, "زيكو للشقق الفندقية دبي") ) ( "NAME_E" ,  QVariant(QString, "ZIQOO HOTEL APARTMENTS DUBAI") ) ( "X_COORD" ,  QVariant(QString, "25.049081") ) ( "Y_COORD" ,  QVariant(QString, "55.130660") ) )  ) )  ) ) ( "SERVICE_ID" ,  QVariant(QString, "19000000") ) )  ) )  ) ) )  )

}
void WebServicesAPI::parseGetPOIFromNearestLocation(QString data)
{
    JsonDataAccess jda;
    QVariant mDataLList = jda.loadFromBuffer(data);
    QVariantList mListPOI = mDataLList.toMap().value("POI").toList();
    mm_modelpoinearby->clear();
    for (int i = 0; i < mListPOI.size(); i++) {
        QString name;
        if (getValueFor("mLanguageCode", "en") == "en") {
            name = mListPOI.value(i).toMap().value("NAME_E").toString();
        } else {
            name = mListPOI.value(i).toMap().value("NAME_A").toString();
        }
        QString lat = mListPOI.value(i).toMap().value("X_COORD").toString();
        QString lon = mListPOI.value(i).toMap().value("Y_COORD").toString();
        bool ok;
        double distance = mListPOI.value(i).toMap().value("DISTANCE").toString().replace(" Km", "", Qt::CaseInsensitive).toDouble(&ok);

        QString str = QString::number(distance, 'f', 1) + " Km";

        mm_modelpoinearby->append(new PoiData(name, lat, lon, str, this));

    }
    emit modelpoinearbychanged();
    if (mListPOI.size() == 0) {
        emit noDataFound();
    }
}

void WebServicesAPI::parseGetPOIInfo(QString data)
{
//json data had some whitespaces,extra slashes so we have to replace them by doing:
    clearmyInfoPopupData();

    mPICTUREValue = "";

    data = data.replace("\\", "", Qt::CaseInsensitive);
    JsonDataAccess jda;
    QVariant listPoi = jda.loadFromBuffer(data.toUtf8());
    mlistSearchPOI.clear();
    QVariantList mListPoi = listPoi.toMap().value("POI").toList();
    mm_model->clear();
    QString lat;
    QString lng;
    QString name;
    mListLat.clear();
    mListLng.clear();
    QLocale c(QLocale::C);



    if (mListPoi.size() == 0) {
        showMySystemDialog(tr("No data found"));
        m_active = false;
        emit activeChanged();
    } else {
        if (mPOIFrom == "autoComplete") {
            for (int i = 0; i < mListPoi.size(); i++) {
                QVariantMap entry;
                lat = mListPoi.value(i).toMap().value("attributes").toMap().value("X_COORD").toString();
                lng = mListPoi.value(i).toMap().value("attributes").toMap().value("Y_COORD").toString();

                if (getValueFor("mLanguageCode", "en") == "en") {
                    name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_E").toString();
                    entry["NAME_E"] = name;
                } else {
                    name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_A").toString();
                    entry["NAME_A"] = name;
                }

                entry["X_COORD"] = lat;
                entry["Y_COORD"] = lng;
                entry["TEL_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("TEL_NO").toString();
                entry["FAX_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("FAX_NO").toString();
                entry["EMAIL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("EMAIL").toString();
                entry["LICENSE_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("LICENSE_NO").toString();
                entry["URL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("URL").toString();
                entry["POBOX"] = mListPoi.value(i).toMap().value("attributes").toMap().value("POBOX").toString();
                entry["NAME_E"] = name;
                entry["PICTURE"] = mListPoi.value(i).toMap().value("attributes").toMap().value("PICTURE").toString();
                mlistSearchPOI.append(entry);
            }
        } else if (mPOIFrom == "searchOnMap") {

            ClearMapdata();
            if (mListPoi.size() > 1) {
                mPinType = mPinTypeMultiple;
                mListPOIPrevious.clear();
                mlistentrance.clear();
                for (int i = 0; i < mListPoi.size(); i++) {
                    QVariantMap entry = mListPoi.value(i).toMap().value("attributes").toMap();

                    lat = mListPoi.value(i).toMap().value("attributes").toMap().value("X_COORD").toString();
                    lng = mListPoi.value(i).toMap().value("attributes").toMap().value("Y_COORD").toString();
                    QVariantMap mListdata;
                    if (getValueFor("mLanguageCode", "en") == "en") {
                        name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_E").toString();
                    } else {
                        name = mListPoi.value(i).toMap().value("attributes").toMap().value("NAME_A").toString();
                    }

                    mListdata["NAME_E"] = name;
                    mListdata["X_COORD"] = lat;
                    mListdata["Y_COORD"] = lng;
                    mListdata["TEL_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("TEL_NO").toString();
                    mListdata["FAX_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("FAX_NO").toString();
                    mListdata["EMAIL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("EMAIL").toString();
                    mListdata["LICENSE_NO"] = mListPoi.value(i).toMap().value("attributes").toMap().value("LICENSE_NO").toString();
                    mListdata["URL"] = mListPoi.value(i).toMap().value("attributes").toMap().value("URL").toString();
                    mListdata["POBOX"] = mListPoi.value(i).toMap().value("attributes").toMap().value("POBOX").toString();
                    isPoiPicture = mListPoi.value(i).toMap().value("attributes").toMap().value("PICTURE").toString();

                    mListdata["PICTURE"] = mListPoi.value(i).toMap().value("attributes").toMap().value("PICTURE").toString();

                    mListPOIPrevious.append(mListdata);
                    //mlistentrance.append(mListdata);
                    drawPinOnMap("pin2.png", lat + "," + lng, name, mPinTypeMultiple, mListdata);
                }

                m_active = false;
                emit activeChanged();

            } else if (mListPoi.size() == 1) {
                QVariantMap entry = mListPoi.value(0).toMap().value("attributes").toMap();
                mPinType = mPinTypeEntrance;
                lat = mListPoi.value(0).toMap().value("attributes").toMap().value("X_COORD").toString();
                lng = mListPoi.value(0).toMap().value("attributes").toMap().value("Y_COORD").toString();

                poiNameValue = entry.value("NAME_E").toString();
                poiPhoneValue = entry.value("TEL_NO").toString();
                poiFaxValue = entry.value("FAX_NO").toString();
                poiEmailValue = entry.value("EMAIL").toString();
                poiLicenseValue = entry.value("LICENSE_NO").toString();
                poiURLValue = entry.value("URL").toString();
                poiPOBoxValue = entry.value("POBOX").toString();
                mPICTUREValue = entry.value("PICTURE").toString();
                qDebug() << "image cahce 1";
                emit mPICTUREDone();

                isPoiPicture = entry.value("PICTURE").toString();
                setPoiInfoData(poiNameValue, poiPhoneValue, poiFaxValue, poiEmailValue, poiLicenseValue, poiURLValue, poiPOBoxValue);

                GetBuildingOutLine_EntrancePoints(lat, lng, false, false);

            } else {
                callGoogleApi(myPOILabel, true);
            }

        } else if (mPOIFrom == "searchDirection") {
            if (mListPoi.size() > 0) {
                QVariantMap entry = mListPoi.value(0).toMap().value("attributes").toMap();
                lat = mListPoi.value(0).toMap().value("attributes").toMap().value("X_COORD").toString();
                lng = mListPoi.value(0).toMap().value("attributes").toMap().value("Y_COORD").toString();
                hasResponse = true;
                mPOIdatalatng = lat + "," + lng;
                if (getCat()) {
                    m_active = false;
                    emit activeChanged();
                    emit catdataload();
                } else {
                    m_active = false;
                    emit poidataloaded();
                    emit activeChanged();
                }
            } else {
                callGoogleApi(myPOILabel, true);
            }
        }
    }

}
void WebServicesAPI::setcat(bool arg1)
{
    isfromcateAddress = arg1;
}
bool WebServicesAPI::getCat()
{
    return isfromcateAddress;
}
void WebServicesAPI::setPoiInfoData(QString name, QString telephone, QString fax, QString email, QString license, QString url, QString pobox)
{
    poiNameValue = name.trimmed();
    emit poiNameDone();
    poiPhoneValue = telephone.trimmed();
    emit poiPhoneDone();
    poiFaxValue = fax.trimmed();
    emit poiFaxDone();
    poiEmailValue = email.trimmed();
    emit poiEmailDone();
    poiLicenseValue = license.trimmed();
    emit poiLicenseDone();
    poiURLValue = url.trimmed();
    emit poiURLDone();
    poiPOBoxValue = pobox.trimmed();
    emit poiPOBoxDone();
}

void WebServicesAPI::setPinFromFav(bool isNearBy, bool isFirst, QString location, QString lat, QString lon, QString name, QString telephone, QString fax, QString email, QString license, QString url, QString pobox)
{
    mPinType = mPinTypeMultiple;
    if (isFirst == true)
        mListPOIPrevious.clear();
    QVariantMap mListdata;
    mListdata["NAME_E"] = name;
    mListdata["Location"] = location;
    mListdata["X_COORD"] = lat;
    mListdata["Y_COORD"] = lon;
    mListdata["TEL_NO"] = telephone;
    mListdata["FAX_NO"] = fax;
    mListdata["EMAIL"] = email;
    mListdata["LICENSE_NO"] = license;
    mListdata["URL"] = url;
    mListdata["POBOX"] = pobox;
    QString mapPin;
    if (checkInvalid(location.replace(" ", "")) == "number")
        mapPin = "pin1.png";
    else
        mapPin = "pin2.png";

    if (isNearBy) {
        mListdata["isGreenPin"] = "true";
        drawPinOnMap("map_pin_near_by.png", lat + "," + lon, location, mPinTypeMultiple, mListdata);
    } else
        drawPinOnMap(mapPin, lat + "," + lon, location, mPinTypeEntrance, mListdata);
    mListPOIPrevious.append(mListdata);
}

QString WebServicesAPI::poiName() const
{
    return poiNameValue;
}
QVariant WebServicesAPI::mnearByLastIndex()
{
    return mModelLastIndex;
}
QString WebServicesAPI::getFeedbackValue()
{
    return mFeedbackFirstValue;
}
void WebServicesAPI::setFeedbackValue(QString mvalue)
{
    mFeedbackFirstValue = mvalue;

}
QString WebServicesAPI::poiMakaniUAENG() const
{
    return poiMakaniValue;
}
QString WebServicesAPI::poiPhone() const
{
    return poiPhoneValue;
}
QString WebServicesAPI::poiFax() const
{
    return poiFaxValue;
}
QString WebServicesAPI::poiEmail() const
{
    return poiEmailValue;
}
QString WebServicesAPI::poiLicense() const
{
    return poiLicenseValue;
}
QString WebServicesAPI::poiURL() const
{
    return poiURLValue;
}
QString WebServicesAPI::poiPOBox() const
{
    return poiPOBoxValue;
}
QString WebServicesAPI::mEntrance() const
{
    return mEntranceValue;
}
QString WebServicesAPI::mROADNAMEEN() const
{
    return mROADNAMEEValue;
}
QString WebServicesAPI::mBUILDING_NO() const
{
    return mBUILDING_NOValue;
}
QString WebServicesAPI::mCOMM_EN() const
{
    return mmCOMM_ENValue;
}
QString WebServicesAPI::mPICTURE() const
{
    return mPICTUREValue;
}

QString WebServicesAPI::mLandNumber() const
{
    return mLandNumberValue;
}
void WebServicesAPI::ClearMapdata()
{
    mLastFocusID = "";
    myMapView->mapData()->clear();
}
void WebServicesAPI::initMapData()
{
    mMapData = new MapData();
}
void WebServicesAPI::parseGetStreetsFromCommunity(QString data)
{
    JsonDataAccess jda;
    QVariant mStreetInfo = jda.loadFromBuffer(data);
    QVariantList mCommunity = mStreetInfo.toMap().value("COMMUNITY").toList();
    QString STREET_NAME_E;
    QString STREET_NAME_A;
    mm_modelStreet->clear();
    mlistSearchStreet.clear();
    for (int i = 0; i < mCommunity.size(); i++) {
        QVariantMap entry;

        STREET_NAME_A = mCommunity.value(i).toMap().value("STREET_NAME_A").toString();
        STREET_NAME_E = mCommunity.value(i).toMap().value("STREET_NAME_E").toString();

        if (getValueFor("mLanguageCode", "en") == "en") {
            mlistSearchStreet.append(STREET_NAME_E);
            entry["STREET_NAME_E"] = STREET_NAME_E;
        } else {
            mlistSearchStreet.append(STREET_NAME_A);
            entry["STREET_NAME_A"] = STREET_NAME_A;
        }

        mm_modelStreet->insert(entry);
        emit modelStreetchanged();
    }

}
void WebServicesAPI::parseUAENGtoCoordinates(QString data)
{
    qDebug() << "makani ="  << data;
    JsonDataAccess jda;
    QVariant makani = jda.loadFromBuffer(data);
    mLisToSend.clear();
    mCCMakani = makani.toMap().value("MAKANI").toString();
    mCCUAENG = makani.toMap().value("UAENG").toString();
    mNODATA = makani.toMap().value("DATA").toString();
    //qDebug() << "makani =" <<  mCCMakani << "| uaeng=" << mCCUAENG << "| nodata" << mNODATA;
    QString spacePattern(" ");

    QStringList mListDLTM = makani.toMap().value("DLTM").toString().split(spacePattern);
    mCCDLTM1 = mListDLTM.value(0);
    mCCDLTM2 = mListDLTM.value(1);

    QStringList mListUTM = makani.toMap().value("UTM").toString().split(spacePattern);
    mCCUTM1 = mListUTM.value(0);
    mCCUTM2 = mListUTM.value(1);

    QString commaPattern(",");
    QStringList mListLATLON = makani.toMap().value("LATLNG").toString().split(commaPattern);
    mCCLatitude = mListLATLON.value(0);
    QString mFormateLat = QString("%1").arg(mCCLatitude);
    bool ok1 = true;
    QString str = QString("%5").arg(mFormateLat.toDouble(&ok1), 0, 'f', 6);

    mCCLatitude = str;
    mCCLongitude = mListLATLON.value(1);

    QString mFormateLon = QString("%1").arg(mCCLongitude);
    bool ok2 = true;
    QString str1 = QString("%5").arg(mFormateLon.toDouble(&ok2), 0, 'f', 6);

    mCCLongitude = str1;

    QStringList mListDMSLATLON = makani.toMap().value("D:M:S").toString().split(commaPattern);
    QString mDMSLat = mListDMSLATLON.value(0);
    QString mDMSLon = mListDMSLATLON.value(1);

    bool ok = false;
    Q_UNUSED(ok);
    QString colonPattern(":");
    QStringList mListDMSLAT = mDMSLat.split(colonPattern);
    mCCDMSLatitude1 = mListDMSLAT.value(0);
    mCCDMSLatitude2 = mListDMSLAT.value(1);
    mCCDMSLatitude3 = mListDMSLAT.value(2);
    QString msg = QString("%1").arg(mCCDMSLatitude3);
    msg = msg.left(msg.indexOf('.'));
    mCCDMSLatitude3 = msg;

    QStringList mListDMSLON = mDMSLon.split(colonPattern);
    mCCDMSLongitude1 = mListDMSLON.value(0);
    mCCDMSLongitude2 = mListDMSLON.value(1);
    mCCDMSLongitude3 = mListDMSLON.value(2);
    QString msg1 = QString("%1").arg(mCCDMSLongitude3);
    msg1 = msg1.left(msg1.indexOf('.'));
    mCCDMSLongitude3 = msg1;
    QVariantMap mMapForCurrentLocation;
    mMapForCurrentLocation["uaeng"] = mCCUAENG;



    if (mConvertorFrom == "Convertor") {
        m_active = false;
        emit activeChanged();
        emit dataLoaded();
    } else if (mConvertorFrom == "MyLocation") {
        clearmyInfoPopupData();
        //drawPinOnMap("map_current.png", mCCLongitude + "," + mCCLatitude, mCCUAENG, mPinTypeSingle, mMapForCurrentLocation);  // old
        drawPinOnMap("map_current.png", mCCLatitude + "," + mCCLongitude, mCCUAENG, mPinTypeSingle, mMapForCurrentLocation); //new change
        m_active = false;
        emit activeChanged();
    } else if (mConvertorFrom == "Direction") {
        clearmyInfoPopupData();
        emit directionServiceDataLoaded();
        m_active = false;
        emit activeChanged();
    } else if (mConvertorFrom == "Nearbydetails") {

        setMulitple("Nearbydetails");
        drawPinOnMap("pin2.png", mCCLatitude + "," + mCCLongitude, mCCUAENG, mPinTypeSingle, NULL);
        m_active = false;
        emit activeChanged();
    } else if (mConvertorFrom == "Search" || mConvertorFrom == "Map" || mConvertorFrom == "NoOutLine") {
        if (mConvertorFrom != "NoOutLine")
            ClearMapdata();
           mMapData = new MapData();

        if (mCCMakani.length() > 5) {
            drawPinOnMap("pin2.png", mCCLatitude + "," + mCCLongitude, mCCMakani, mPinTypeSingle,
            NULL);
        } else {
            //  drawPinOnMap("pin2.png", mCCLatitude + "," + mCCLongitude, mCCUAENG, mPinTypeSingle,
            //  NULL);
        }

        if (mConvertorFrom != "NoOutLine") {
            GetBuildingOutLine_EntrancePoints(mCCLatitude, mCCLongitude, false, false);
        } else {
            m_active = false;
            emit activeChanged();
        }
    } else if (mConvertorFrom == "DirectionMyLocation") {
        clearmyInfoPopupData();
        mGetMyLocation = mCCUAENG;
        emit getMyLocationDone();

        m_active = false;
        emit activeChanged();
    } else if (mConvertorFrom == "NoOutLineMultiplePin") {
        myMapView->mapData()->geographic(mLastFocusID)->setProperty("clickDone", QVariant("false"));
        myMapView->mapData()->geographic(mLastFocusID)->setProperty("pintype", "singlepin");
        myMapView->mapData()->geographic(mLastFocusID)->setName(mCCUAENG);
        m_active = false;
        emit activeChanged();
    }
}
void WebServicesAPI::parseGetFeedbackType(QString mdata)
{
    JsonDataAccess jda;
    QVariant mResponseData = jda.loadFromBuffer(mdata);
    QVariantList mListFEEDBACK_TYPE = mResponseData.toMap().value("FEEDBACK_TYPE").toList();
    for (int i = 0; i < mListFEEDBACK_TYPE.size(); i++) {
        QVariantMap map;
        map["FEEDBACK_AR"] = mListFEEDBACK_TYPE.value(i).toMap().value("FEEDBACK_AR").toString();
        map["FEEDBACK_EN"] = mListFEEDBACK_TYPE.value(i).toMap().value("FEEDBACK_EN").toString();
        map["FEEDBACK_ID"] = mListFEEDBACK_TYPE.value(i).toMap().value("FEEDBACK_ID").toString();
        mmodelfeedbacktype->insert(map);
    }

    m_active = false;
    emit activeChanged();
    emit modelfeedbacktypechanged();
}
QString WebServicesAPI::getNODATA()
{
    return mNODATA;
}
QString WebServicesAPI::getCCMakani()
{
    return mCCMakani;
}
QString WebServicesAPI::getCCUAENG()
{
    return mCCUAENG;
}
QString WebServicesAPI::getCCUTM1()
{
    return mCCUTM1;
}
QString WebServicesAPI::getCCUTM2()
{
    return mCCUTM2;
}
QString WebServicesAPI::getCCDLTM1()
{
    return mCCDLTM1;
}
QString WebServicesAPI::getCCDLTM2()
{
    return mCCDLTM2;
}
QString WebServicesAPI::getCCLatitude()
{
    return mCCLatitude;
}
QString WebServicesAPI::getCCLongitude()
{
    return mCCLongitude;
}
QString WebServicesAPI::getCCDMSLatitude1()
{
    return mCCDMSLatitude1;
}
QString WebServicesAPI::getCCDMSLatitude2()
{
    return mCCDMSLatitude2;
}
QString WebServicesAPI::getCCDMSLatitude3()
{
    return mCCDMSLatitude3;
}
QString WebServicesAPI::getCCDMSLongitude1()
{
    return mCCDMSLongitude1;
}
QString WebServicesAPI::getCCDMSLongitude2()
{
    return mCCDMSLongitude2;
}
QString WebServicesAPI::getCCDMSLongitude3()
{
    return mCCDMSLongitude3;
}

void WebServicesAPI::parseGetMakaniNo(QString data)
{

// Load the JSON data
    JsonDataAccess jda;
    QVariant list = jda.loadFromBuffer(data);
    QVariantMap map;
    mm_model->clear();
    mlistSearchMakani.clear();
    mlistSearchMakani.append(list.toMap().value("MAKANI").toList());
    for (qint64 i = 0; i < list.Size; i++) {
        if (list.toMap().value("MAKANI").toList().value(i).toMap().value("MAKANINO").toString() == "") {
            break;
        } else {
            QVariantMap entry;
            entry["MAKANINO"] = list.toMap().value("MAKANI").toList().value(i).toMap().value("MAKANINO").toString();

            // mlistSearchMakani.append(list.toMap().value("MAKANI").toList().value(i).toMap().value("MAKANINO").toString());
        }
    }
    m_active = false;
    emit activeChanged();
}

GroupDataModel * WebServicesAPI::mymodel()
{
    return mm_model;
}
DataModel * WebServicesAPI::mymodelpoinearby()
{
    return mm_modelpoinearby;
}
GroupDataModel * WebServicesAPI::mymodelStreet()
{
    return mm_modelStreet;
}
GroupDataModel * WebServicesAPI::mymodelcommunity()
{
    return mm_modelCommunity;
}
GroupDataModel * WebServicesAPI::mymodelcategory()
{
    return mm_modelcategory;
}

GroupDataModel * WebServicesAPI::mymodelBuiding()
{
    return mm_modelBuiding;
}

GroupDataModel * WebServicesAPI::mymodelservice()
{
    return mm_modelservice;
}
GroupDataModel * WebServicesAPI::mymodelfeedbacktype()
{
    return mmodelfeedbacktype;
}

GroupDataModel * WebServicesAPI::mymodelNearBy()
{
    return mm_modelNearBy;
}
GroupDataModel * WebServicesAPI::mymodelTutorial()
{
    return mm_mymodelTutorial;
}

void WebServicesAPI::searchDataFilter(QString words, QString from)
{
    mm_model->clear();

    dataFilter(words, from);
}
void WebServicesAPI::dataFilter(QString words, QString from)
{
    QVariantMap entry;
    QString makaniNo;

    for (int i = 0; i < mlistSearchMakani.size(); i++) {
        if (getValueFor("mLanguageCode", "en") == "en") {
            makaniNo = mlistSearchMakani.value(i).toMap().value("MAKANINO").toString();

        } else {
            makaniNo = mlistSearchMakani.value(i).toMap().value("MAKANINO").toString();

        }
        if (words.length() > 3) {
            if (makaniNo.contains(words, Qt::CaseInsensitive)) {

                entry["Makani"] = makaniNo;
                mm_model->insert(entry);
                emit modelchanged();
            }
        }
    }
    m_active = false;
}
void WebServicesAPI::searchDataFilterForService(QString words, QString from)
{
    mm_modelservice->clear();

    dataFilterForService(words, from);
}
void WebServicesAPI::dataFilterForService(QString words, QString from)
{
    QVariantMap entry;
    QString mServiceName;
    QString mServiceId;

    for (int i = 0; i < mServiceResponseId.size(); i++) {
        if (getValueFor("mLanguageCode", "en") == "en") {
            mServiceName = mServiceResponseId.value(i).toMap().value("SERVICE_NAME_E").toString();
            mServiceId = mServiceResponseId.value(i).toMap().value("SERVICE_ID").toString();

        } else {
            mServiceName = mServiceResponseId.value(i).toMap().value("SERVICE_NAME_A").toString();
            mServiceId = mServiceResponseId.value(i).toMap().value("SERVICE_ID").toString();

        }
        if (words.length() > 0) {
            if (mServiceName.contains(words, Qt::CaseInsensitive)) {

                entry["Servicename"] = mServiceName;
                entry["ServiceId"] = mServiceId;
                mm_modelservice->insert(entry);
                emit modelservicechanged();
            }
        }
    }
    m_active = false;

}

bool WebServicesAPI::searchDataFilterCategory(QString words, QString from)
{
    mm_modelcategory->clear();
    return dataFilterCategory(words, from);
}
bool WebServicesAPI::dataFilterCategory(QString words, QString from)
{
    QVariantMap entry;
    if (mCategoryResponseId.size() == 0) {
        return false;
    }
    for (qint64 i = mCategoryResponseId.size() - 1; i >= 0; i--) {

        QString mName;
        if (getValueFor("mLanguageCode", "en") == "en") {
            mName = mCategoryResponseId.value(i).toMap().value("CATEGORY_NAME_E").toString();
        } else {
            mName = mCategoryResponseId.value(i).toMap().value("CATEGORY_NAME_A").toString();
        }

        if (words.length() > 0 && mName.contains(words, Qt::CaseInsensitive)) {

            entry["CategoryId"] = mCategoryResponseId.value(i).toMap().value("CATEGORY_ID").toString();
            entry["Category"] = mName;
            mm_modelcategory->insert(entry);
            emit modelcategorychanged();

        } else {

            entry["CategoryId"] = mCategoryResponseId.value(i).toMap().value("CATEGORY_ID").toString();
            entry["Category"] = mName;

            mm_modelcategory->insert(entry);
            emit modelcategorychanged();

        }
    }
    return true;

}
/*
 * Sets the number into contacts and invoke the contacts view.
 * @param image_name image to be set on marker
 * @param latlng latitude,logitude to where pin should be drop.
 * @param title title to be set on caption label
 * @param pintype type of image single,multiple...
 * @param dataMap set of data to be set on mapdata.
 */
void WebServicesAPI::drawPinOnMap(QString image_name, QString latlng, QString title, qint64 pintype, QVariant dataMap)
{
    QString commaPattern(",");
    QStringList mListCoord = latlng.split(commaPattern);

    QString lat = mListCoord.value(0);
    QString lng = mListCoord.value(1);

    QLocale c(QLocale::C);
    GeoLocation* newDropPin = new GeoLocation();
    newDropPin->setLatitude(c.toDouble(lat));
    newDropPin->setLongitude(c.toDouble(lng));

    newDropPin->setAltitude(0);
    mListLat.append(c.toDouble(lat));
    mListLng.append(c.toDouble(lng));

    if (pintype == mPinTypeMultiple) {
        mMarker = Marker(QDir::currentPath() + "/app/native/assets/images/map/" + image_name, QSize(60, 60), QPoint(c.toDouble(lat), c.toDouble(lng)), QPoint(c.toDouble(lat) + 5, c.toDouble(lng) - 70));
        newDropPin->setMarker(mMarker);
        QVariant data("multiple");
        newDropPin->setProperty("pintype", data);
        newDropPin->setProperty("clickDone", QVariant("false"));
        qDebug() << "dataMap :" << dataMap;
        newDropPin->setProperty("attributes", dataMap);
        newDropPin->setProperty("pin_name", title);

        myMapView->mapData()->add(newDropPin);
        setZoomLevelForMap(NULL);

    } else if (pintype == mPinTypeEntrance) {

        mMarker = Marker(QDir::currentPath() + "/app/native/assets/images/map/" + image_name, QSize(60, 60), QPoint(c.toDouble(lat), c.toDouble(lng)), QPoint(c.toDouble(lat) + 5, c.toDouble(lng) - 70));
        newDropPin->setMarker(mMarker);

        QVariant data("entrancepin");
        newDropPin->setProperty("pintype", data);
        newDropPin->setProperty("clickDone", QVariant("false"));
        newDropPin->setProperty("attributes", dataMap);
        newDropPin->setProperty("pin_name", title);
        mMapData->add(newDropPin);
        newDropPin->setName(title);
        myMapView->mapData()->add(newDropPin);
        //setZoomLevelForMap(myMapView->mapData());
        setZoomLevelForMap(NULL);
    } else if (pintype == mPinTypeSingle) {
        mMarker = Marker(QDir::currentPath() + "/app/native/assets/images/map/" + image_name, QSize(60, 60), QPoint(c.toDouble(lat), c.toDouble(lng)), QPoint(c.toDouble(lat) + 5, c.toDouble(lng) - 70));
        newDropPin->setMarker(mMarker);
        QVariant data("singlepin");
        newDropPin->setProperty("pintype", data);
        newDropPin->setProperty("pin_name", title);
        mMapData->add(newDropPin);
        newDropPin->setName(title);
        myMapView->mapData()->add(newDropPin);
        setZoomLevelForMap(NULL);

    } else if (pintype == mPinTypeRoutePoint) {

        mMarker = Marker(QDir::currentPath() + "/app/native/assets/images/map/" + image_name, QSize(60, 60), QPoint(c.toDouble(lat), c.toDouble(lng)), QPoint(c.toDouble(lat) + 5, c.toDouble(lng) - 70));
        newDropPin->setMarker(mMarker);
        QVariant data("routepin");
        newDropPin->setProperty("pintype", data);
        newDropPin->setProperty("clickDone", QVariant("false"));
        newDropPin->setProperty("pin_name", title);
        newDropPin->setProperty("attributes", dataMap);

        mMapData->add(newDropPin);
        myMapView->mapData()->add(newDropPin);
        setZoomLevelForMap(mMapData);

    }
    myMapView->setCaptionGoButtonVisible(true);

}

/*
 * Assigning a reference to a qml mapview object name in order to be used from c++.
 * @param mapObject mapview object name form qml.
 */
void WebServicesAPI::getMyObject(QObject* mapObject)
{
    myMapView = qobject_cast<MapView*>(mapObject);

}

/**
 * Calculates the appropriate altitude for a map to show the entire bounding
 * box within the given window dimensions.
 *
 * @param box The box containing everything that should be visible on the map's
 * viewport.
 * @param windowDimensions The pixel size of the map's viewport.
 */
void WebServicesAPI::setZoomLevelForMap(MapData* mMapData)
{
    /* BoundingBox Box = mMapData->boundingBox();

     myMapView->setLocationOnVisible();
     myMapView->setLocation(Box);

     double w = Box.width();
     double h = Box.height();

     double dim = (w > h) ? w : h;
     double newAlt = dim * 240000.0;
     myMapView->setAltitude(newAlt);*/
    BoundingBox box;
    if (mMapData == NULL) {
        box = myMapView->mapData()->boundingBox(true);
    } else {
        try {

            box = mMapData->boundingBox(true);

        } catch (const std::bad_exception &) {
            box = myMapView->mapData()->boundingBox(true);
        }
    }
    myMapView->setLocation(box.center());
    QSize windowDimensions = myMapView->viewProperties().windowSize();
    double calculatedAltitude;
    double widthDensity = box.width() / windowDimensions.width();
    double altFromWidth = 158899028.4 * widthDensity;
    double heightDensity = box.height() / windowDimensions.height();
    double altFromHeight = 226293941.69 * heightDensity;
    calculatedAltitude = qMax(altFromWidth, altFromHeight);
    myMapView->setAltitude(calculatedAltitude);
}
/**
 * Calculates the appropriate altitude for a map to show the entire bounding
 * box within the given window dimensions.
 *
 * @param box The box containing everything that should be visible on the map's
 * viewport.
 * @param windowDimensions The pixel size of the map's viewport.
 */
void WebServicesAPI::setZoomLevelForMap1(MapData* mMapData)
{

    if (mMapData != NULL) {
        /**if (mMapView->mapData()->provider(ORDER_DATA_PROVIDER)->count() > 1) {
         mMapView->setLocation(
         mMapView->mapData()->provider(ORDER_DATA_PROVIDER)->boundingBox());
         mMapView->setAltitude(mMapView->altitude() * 1.3);
         }**/
        if (mMapData->providerCount() > 1) {
            BoundingBox Box = mMapData->boundingBox(true);
            myMapView->setLocationOnVisible();
            myMapView->setLocation(Box);
            double w = Box.width();
            double h = Box.height();
            double dim = (w > h) ? w : h;
            double newAlt = dim * 240000.0;
            myMapView->setAltitude(newAlt);
        }

    }

}
/*
 *buidding outline will be drawn based on Geolocation data with prespecified zoom.
 *@param listlat will contain List of different latitudes.
 *@param listlon will contain List of different longitude.
 *@param  name   optional...
 */
void WebServicesAPI::drawBulidingOutLine(QList<float> listLat, QList<float> listLon, QString name)
{
    isOutlineBuilding = true;

    Polyline mPolylineBuildingInfo;
    for (qint64 i = 0; i < listLat.size(); i++) {
        mPolylineBuildingInfo.append(Coordinate(listLat.value(i), listLon.value(i)));
        isOutlineBuilding = false;

    }
    GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
    mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
//StyleSheet styles;

    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::XLarge);
//    polylines.setEdgeColor(0x8F00B7FF);
    polylines.setEdgeColor(0xFF0000FF);

    polylines.setFillColor(0x3B00B7FF);

// polylines.setFillColor(Color::fromRGBA(0.5f, 1.0f, 0.2f, 0.8f));
//    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    styles.addStyleForId(mGeoPolygonBuildingInfo->geoId(), polylines);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);
    myMapView->mapData()->setStyles(styles);
    mMapData->add(mGeoPolygonBuildingInfo);
    setZoomLevelForMap(mMapData);
}
void WebServicesAPI::drawBulidingOutLineForPARCEL(QList<float> listLat, QList<float> listLon, QString name)
{

    Polyline mPolylineBuildingInfo;
    for (qint64 i = 0; i < listLat.size(); i++) {
        mPolylineBuildingInfo.append(Coordinate(listLat.value(i), listLon.value(i)));
        isOutlineBuilding = false;
    }
    GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
    mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
// StyleSheet styles;
    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::XLarge);

//polylines.setEdgeColor(0x8F00B7FF);
    polylines.setEdgeColor(0xFFFF0000);
    polylines.setFillColor(0x3B00B7FF);
//  styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    styles.addStyleForId(mGeoPolygonBuildingInfo->geoId(), polylines);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);
    myMapView->mapData()->setStyles(styles);

    mMapData->add(mGeoPolygonBuildingInfo);
//  setZoomLevelForMap(mMapData);
}
void WebServicesAPI::drawBulidingOutLineBlue(QList<float> listLat, QList<float> listLon, QString name, MapData* mMapData)
{

// isOutlineBuilding = true;
    Polyline mPolylineBuildingInfo;
    for (qint64 i = 0; i < listLat.size(); i++) {
        mPolylineBuildingInfo.append(Coordinate(listLat.value(i), listLon.value(i)));
        isOutlineBuilding = false;
    }
    /**GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
     mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
     // StyleSheet styles;
     Style polylines;
     polylines.setEdgeStyle(EdgeStyle::Solid);
     polylines.setEdgeSize(EdgeSize::XLarge);

     polylines.setEdgeColor(0xFFFF0000);
     polylines.setFillColor(0x3B00B7FF);
     //  styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
     styles.addStyleForId(mGeoPolygonBuildingInfo->geoId(), polylines);
     myMapView->mapData()->add(mGeoPolygonBuildingInfo);
     myMapView->mapData()->setStyles(styles);

     mMapData->add(mGeoPolygonBuildingInfo);**/

    GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
    mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
//StyleSheet styles;

    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::XLarge);
//    polylines.setEdgeColor(0x8F00B7FF);
    polylines.setEdgeColor(0xFF0000FF);

    polylines.setFillColor(0x3B00B7FF);

// polylines.setFillColor(Color::fromRGBA(0.5f, 1.0f, 0.2f, 0.8f));
//    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    styles.addStyleForId(mGeoPolygonBuildingInfo->geoId(), polylines);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);
    myMapView->mapData()->setStyles(styles);
    mMapData->add(mGeoPolygonBuildingInfo);

    setZoomLevelForMap1(mMapData);
}
void WebServicesAPI::drawBulidingOutLineRed(QList<float> listLat, QList<float> listLon, QString name, MapData* mMapData)
{

    Polyline mPolylineBuildingInfo;
    for (qint64 i = 0; i < listLat.size(); i++) {
        mPolylineBuildingInfo.append(Coordinate(listLat.value(i), listLon.value(i)));
        isOutlineBuilding = false;
    }
    GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
    mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::XLarge);
    polylines.setEdgeColor(0xFFFF0000);
// polylines.setFillColor(0x3B00B7FF);
    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    mMapData->add(mGeoPolygonBuildingInfo);
    mMapData->setStyles(styles);

    setZoomLevelForMap1(mMapData);
}
/* Draws the route from source to destination in map with prespecified zoom.
 * @param listlat will contain List of different latitudes.
 * @param listlon will contain List of different longitudes.
 * @param name optional...
 */
void WebServicesAPI::drawRoute(QList<float> listLat, QList<float> listLon, QString name)
{
    isOutlineBuilding = true;
    Polyline mPolylineBuildingInfo;

    for (qint64 i = 0; i < listLat.size(); i++) {
        mPolylineBuildingInfo.append(Coordinate(listLat.value(i), listLon.value(i)));
        isOutlineBuilding = false;
    }

    GeoPolyline* mGeoPolygonBuildingInfo = new GeoPolyline();
    mGeoPolygonBuildingInfo->setLine(mPolylineBuildingInfo);

    myMapView->mapData()->add(mGeoPolygonBuildingInfo);

    mMapData->add(mGeoPolygonBuildingInfo);

    setZoomLevelForMap(mMapData);
}

QList<float>& WebServicesAPI::getListLat()
{
    return mListLat;
}
QList<float>& WebServicesAPI::getListLng()
{
    return mListLng;
}
bool WebServicesAPI::searchDataFilterCommunity(QString words, QString from)
{
    mm_modelCommunity->clear();
    return dataFilterCommunity(words, from);
}
bool WebServicesAPI::dataFilterCommunity(QString words, QString from)
{
    QVariantMap entry;
    if (mlistSearchCommunity.size() == 0) {
        return false;
    }
    for (qint64 i = mlistSearchCommunity.size() - 1; i >= 0; i--) {
        if (words.length() > 0) {
            if (mlistSearchCommunity.value(i).toString().contains(words, Qt::CaseInsensitive)) {
                entry["common" + from] = mlistSearchCommunity.value(i).toString();
                mm_modelCommunity->insert(entry);
                emit modelcommunitychanged();
            }
        } else {
            entry["common" + from] = mlistSearchCommunity.value(i).toString();
            mm_modelCommunity->insert(entry);
            emit modelcommunitychanged();
        }
    }
    return true;
}
/*
 *  Set of pins will be droped for places by category.
 */
void WebServicesAPI::showAllPinOfPlacesByCategory()
{
    mPinType = mPinTypeMultiple;
    mListPOIPrevious.clear();
    ClearMapdata();

    if (mlistSearchPlaceName.size() == 1) {
        QVariantMap entry = mlistSearchPlaceName.value(0).toMap();

        QString lat = entry.value("X_COORD").toString();
        QString lng = entry.value("Y_COORD").toString();
        QString name;
        QVariantMap mListdata;
        if (getValueFor("mLanguageCode", "en") == "en") {
            name = entry.value("NAME_E").toString();
        } else {
            name = entry.value("NAME_A").toString();
        }
        mListdata["NAME_E"] = name;
        mListdata["X_COORD"] = lat;
        mListdata["Y_COORD"] = lng;
        mListdata["TEL_NO"] = "";
        mListdata["FAX_NO"] = "";
        mListdata["EMAIL"] = "";
        mListdata["LICENSE_NO"] = "";
        mListdata["URL"] = "";
        mListdata["POBOX"] = "";
        mListPOIPrevious.append(mListdata);
        setPoiInfoData(name, "", "", "", "", "", "");
        GetBuildingOutLine_EntrancePoints(lat, lng, true, false);

    } else {
        for (int i = 0; i < mlistSearchPlaceName.size(); i++) {
            QVariantMap entry = mlistSearchPlaceName.value(i).toMap();

            QString lat = entry.value("X_COORD").toString();
            QString lng = entry.value("Y_COORD").toString();
            QString name;
            QVariantMap mListdata;
            if (getValueFor("mLanguageCode", "en") == "en") {
                name = entry.value("NAME_E").toString();
            } else {
                name = entry.value("NAME_A").toString();
            }

            mListdata["NAME_E"] = name;
            mListdata["X_COORD"] = lat;
            mListdata["Y_COORD"] = lng;
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";
            mListPOIPrevious.append(mListdata);
            drawPinOnMap("pin2.png", lat + "," + lng, name, mPinTypeMultiple, mListdata);
        }
    }
}

void WebServicesAPI::searchDataFilterService(QString words, QString from)
{
    mm_model->clear();
    dataFilterService(words, from);
}
void WebServicesAPI::dataFilterService(QString words, QString from)
{

    QVariantMap entry;

    for (qint64 i = mlistSearchPlaceName.size() - 1; i >= 0; i--) {
        QVariantMap mMap = mlistSearchPlaceName.value(i).toMap();
        QString name;
        if (getValueFor("mLanguageCode", "en") == "en") {
            name = mMap.value("NAME_E").toString();
        } else {
            name = mMap.value("NAME_A").toString();
        }
        if (name.contains(words, Qt::CaseInsensitive)) {
            mm_model->insert(mMap);
            emit modelchanged();
        }
    }
}
bool WebServicesAPI::searchDataFilterStreet(QString words, QString from)
{
    mm_modelStreet->clear();
    return dataFilterStreet(words, from);
}
bool WebServicesAPI::dataFilterStreet(QString words, QString from)
{
    QVariantMap entry;
    if (mlistSearchStreet.size() == 0) {
        return false;
    }
    for (qint64 i = mlistSearchStreet.size() - 1; i >= 0; i--) {
        if (words.length() > 0) {
            if (mlistSearchStreet.value(i).toString().contains(words, Qt::CaseInsensitive)) {
                entry["common" + from] = mlistSearchStreet.value(i).toString();
                mm_modelStreet->insert(entry);
            }
        } else {
            entry["common" + from] = mlistSearchStreet.value(i).toString();
            mm_modelStreet->insert(entry);
        }
    }
    return true;
    emit modelStreetchanged();
}
void WebServicesAPI::searchDataFilterPOI(QString words, QString from)
{
    mm_model->clear();
    dataFilterPOI(words, from);
}

void WebServicesAPI::dataFilterPOI(QString words, QString from)
{
    QVariantMap entry;

    for (qint64 i = 0; i < mlistSearchPOI.size(); i++) {
        QVariantMap mMap = mlistSearchPOI.value(i).toMap();

        if (getValueFor("mLanguageCode", "en") == "en") {

            QString name = mMap.value("NAME_E").toString();
            if (name.contains(words, Qt::CaseInsensitive)) {

                mm_model->insert(mMap);
            }
        } else {

            QString name = mMap.value("NAME_A").toString();
            if (name.contains(words, Qt::CaseInsensitive)) {

                mm_model->insert(mMap);

            }
        }
    }
    emit modelchanged();

}
bool WebServicesAPI::searchDataFilterBuilding(QString words, QString from)
{
    mm_modelBuiding->clear();
    return dataFilterBuilding(words, from);

}
bool WebServicesAPI::dataFilterBuilding(QString words, QString from)
{
    QVariantMap entry;
    if (mlistSearchBuilding.size() == 0) {
        return false;
    }
    bool ok = true;
    QStringList listbuilding;
    for (qint64 i = 0; i < mlistSearchBuilding.size(); i++) {
        if (words.length() > 0) {
            if (mlistSearchBuilding.value(i).toString().contains(words, Qt::CaseInsensitive)) {
                entry["ADDRESS_E"] = mlistSearchBuilding.value(i).toInt(&ok);
                //entry["ADDRESS_E"] = mlistSearchBuilding.value(i).toDouble()

                mm_modelBuiding->insert(entry);
            }
        } else {
            entry["ADDRESS_E"] = mlistSearchBuilding.value(i).toString();
            mm_modelBuiding->insert(entry);
        }
    }
    emit modelBuidingchanged();
    return true;

}
/*
 *Notification with a message to be displayed if hasmatch is true  otherwise invisible.
 *@param hasMatch value true or false
 */
void WebServicesAPI::showToast(bool hasMatch)
{
    SystemToast *toast = new SystemToast(this);
    toast->setPosition(SystemUiPosition::MiddleCenter);

    if (hasMatch) {
        toast->setBody("No matching data found");
        toast->show();

    }
}
/* Extracts geographical information data from focusid & drops pin on previous and current geolocation with differrnt pin types.
 *
 *@param myfocusId Id of the Geolocation that was tapped from qml.
 */
void WebServicesAPI::mPICTUREValueNULL()
{
    mPICTUREValue = "";

}
void WebServicesAPI::setFouceId(QString myfocuSId)
{
    isfromFoucs = true;
    mapFocusId.clear();

    mapFocusId = myfocuSId;

    Geographic *myGeo = myMapView->mapData()->geographic(getFouceId());
    GeoLocation *myLocation = 0;

    if (myGeo) {
        myLocation = qobject_cast<GeoLocation*>(myGeo);

    }

    if (!myLocation) {
        myLocation = new GeoLocation(getFouceId());
    }

    QString name = myLocation->name();
    double lat = myLocation->latitude();
    double lng = myLocation->longitude();

    mapLabelText = name;
    QString mtempname = name;
    if (mtempname.length() > 0) {
        if (checkInvalid(mtempname.replace(" ", "")) == "number" || checkInvalid(ConvertToUAENG(mtempname)) == "UAENG") {
            saveValueFor("lastselectedlocation", mtempname);
        }
    }
    myLocation->setName(myLocation->property("pin_name").toString());
    mapLabelLatitude = QString::number(lat);
    mapLabelLongitude = QString::number(lng);
    QString propertyPintType = myLocation->property("pintype").toString();

    isPOIMultipleTap = false;

    QString currentPin = myLocation->marker().iconUri();
    if (myLocation->property("clickDone") == "true") {
        setMulitple("previous");

        ClearMapdata();

        mPinType = mPinTypeMultiple;

        for (int i = 0; i < mListPOIPrevious.size(); i++) {

            QVariant entry = mListPOIPrevious.value(i).toMap();
            QString lat = mListPOIPrevious.value(i).toMap().value("X_COORD").toString();
            QString lng = mListPOIPrevious.value(i).toMap().value("Y_COORD").toString();
            QString name = mListPOIPrevious.value(i).toMap().value("NAME_E").toString();

            QString location = mListPOIPrevious.value(i).toMap().value("Location").toString();
            QString isGreenPin = mListPOIPrevious.value(i).toMap().value("isGreenPin").toString();
            QString mapPin;
            if (checkInvalid(location.replace(" ", "")) == "number")
                mapPin = "pin1.png";
            else
                mapPin = "pin2.png";
            if (isGreenPin == "true")
                drawPinOnMap("map_pin_near_by.png", lat + "," + lng, name, mPinTypeMultiple, entry);
            else
                drawPinOnMap(mapPin, lat + "," + lng, name, mPinTypeMultiple, entry);
        }
    } else {
        if (propertyPintType == "multiple") {
            mLastFocusID = myfocuSId;

            if (currentPin == mPinUriEmergencyEn || currentPin == mPinUriEmergencyAr) {
                if (isfromentrance) {
                    setMulitple("entrancepin");

                    isfromentrance = false;
                } else {
                    setMulitple("redmultiple");
                }
            } else if (currentPin == mPinUriRed || currentPin == mPinUriGreen) {
                setMulitple("redmultiple");
            } else if (currentPin == mPinUriEntrance) {
                /*if (isfromentrance) {
                 setMulitple("entrancepin");

                 isfromentrance = false;
                 } else {
                 setMulitple("multiple");

                 }*/
                setMulitple("multiple");

                myLocation->setProperty("clickDone", QVariant("true"));
                QVariantMap mMapInfoData = myLocation->property("attributes").toMap();
                poiNameValue = mMapInfoData.value("NAME_E").toString().trimmed();
                emit poiNameDone();
                poiPhoneValue = mMapInfoData.value("TEL_NO").toString().trimmed();
                emit poiPhoneDone();
                poiFaxValue = mMapInfoData.value("FAX_NO").toString().trimmed();
                emit poiFaxDone();
                poiEmailValue = mMapInfoData.value("EMAIL").toString().trimmed();
                emit poiEmailDone();
                poiLicenseValue = mMapInfoData.value("LICENSE_NO").toString().trimmed();
                emit poiLicenseDone();
                poiURLValue = mMapInfoData.value("URL").toString().trimmed();
                emit poiURLDone();
                poiPOBoxValue = mMapInfoData.value("POBOX").toString().trimmed();
                emit poiPOBoxDone();
                mPICTUREValue = mMapInfoData.value("PICTURE").toString().trimmed();
                qDebug() << "image cahce 2";
                emit mPICTUREDone();

                mapLabelText = myLocation->property("pin_name").toString();
                isPOIMultipleTap = true;
                myMapView->mapData()->remove("route_line");
                QString locationName = mMapInfoData.value("Location").toString().trimmed();
            } else if (currentPin == mPinUriGreenNearBy) {
                setMulitple("multiple");
                myLocation->setProperty("clickDone", QVariant("true"));
            }

            //    myLocation->setProperty("clickDone", QVariant("true"));

            QVariantMap mMapInfoData = myLocation->property("attributes").toMap();

            poiNameValue = mMapInfoData.value("NAME_E").toString().trimmed();
            emit poiNameDone();
            poiPhoneValue = mMapInfoData.value("TEL_NO").toString().trimmed();
            emit poiPhoneDone();
            poiFaxValue = mMapInfoData.value("FAX_NO").toString().trimmed();
            emit poiFaxDone();
            poiEmailValue = mMapInfoData.value("EMAIL").toString().trimmed();
            emit poiEmailDone();
            poiLicenseValue = mMapInfoData.value("LICENSE_NO").toString().trimmed();
            emit poiLicenseDone();
            poiURLValue = mMapInfoData.value("URL").toString().trimmed();
            emit poiURLDone();
            poiPOBoxValue = mMapInfoData.value("POBOX").toString().trimmed();
            emit poiPOBoxDone();
            mPICTUREValue = mMapInfoData.value("PICTURE").toString().trimmed();
            qDebug() << "image cahce 3";
            emit mPICTUREDone();

            mapLabelText = myLocation->property("pin_name").toString();
            isPOIMultipleTap = true;
            myMapView->mapData()->remove("route_line");
            QString locationName = mMapInfoData.value("Location").toString().trimmed();
            /* if (checkInvalid(locationName.replace(" ", "")) == "number") {
             Marker mMarker = Marker(QDir::currentPath() + "/app/native/assets/images/map/pin2.png", QSize(60, 60), QPoint(lat, lng), QPoint(lat + 5, lng - 70));

             myLocation->setMarker(mMarker);

             }
             */
        } else if (propertyPintType == "entrancepin") {
            setMulitple("entrancepin");
            isfromentrance = true;
            QVariantMap mMapInfoData = myLocation->property("attributes").toMap();

            mEntranceValue = getValueFor("mLanguageCode", "en") == "en" ? mMapInfoData.value("ENT_NAME_E").toString() : mMapInfoData.value("ENT_NAME_A").toString();
            emit mEntranceDone();
            mROADNAMEEValue = getValueFor("mLanguageCode", "en") == "en" ? mMapInfoData.value("ROADNAME").toString() : mMapInfoData.value("ROADNAME").toString();
            QString ank = getValueFor("mLanguageCode", "en") == "en" ? mMapInfoData.value("ROADNAME").toString() : mMapInfoData.value("ROADNAME").toString();
            emit mROADNAMEENDone();

            mmCOMM_ENValue = getValueFor("mLanguageCode", "en") == "en" ? mMapInfoData.value("COMM_EN").toString() : mMapInfoData.value("COMM_AR").toString();
            emit mCOMM_ENDone();

            mBUILDING_NOValue = mMapInfoData.value("BUILDING_NO").toString();
            emit mBUILDING_NODone();

            //qDebug() << "image cahce 4" << mMapInfoData.value("PICTURE").toString();;

            if (isPic != "") {
                mPICTUREValue = isPic;
                qDebug() << "image cahce 4";
                emit mPICTUREDone();
            } else {

                mPICTUREValue = mMapInfoData.value("PICTURE").toString();
                qDebug() << "image cahce 5";
                emit mPICTUREDone();
            }
            qDebug() << "image cahce 4" <<  mPICTUREValue;
            mPICTUREValue = "";
            isPic = "";
            //emit mPICTUREDone();

            mmCOMM_ENValue = mMapInfoData.value("mCOMM_EN").toString();
            emit mCOMM_ENDone();

            QString latlng = mMapInfoData.value("LATLNG").toString();

            QString commaPattern(",");

            QString makani = mMapInfoData.value("MAKANI").toString();
            QLocale c(QLocale::C);
            QString lastlat;
            QString lastlng;
            QString lastmakani;
            QVariant lastentry;
            for (int i = 0; i < mlistentrance.size(); i++) {

                QVariant entry = mlistentrance.value(i).toMap();
                QString commaPattern(",");
                QString latlng = mlistentrance.value(i).toMap().value("LATLNG").toString();
                QStringList mListCoord = latlng.split(commaPattern);

                QString lat = mListCoord.value(0);
                QString lng = mListCoord.value(1);
                QString mMAKANI = mlistentrance.value(i).toMap().value("MAKANI").toString();

                QString mCOMM_EN = mlistentrance.value(i).toMap().value("mCOMM_EN").toString();
                QString mPICTURE = mlistentrance.value(i).toMap().value("PICTURE").toString();
                QString mBUILDING_NO = mlistentrance.value(i).toMap().value("BUILDING_NO").toString();
                if (makani == mMAKANI) {
                    lastlat = lat;
                    lastlng = lng;
                    lastmakani = mMAKANI;
                    lastentry = entry;
                    if (currentPin != mPinUriEmergencyEn || currentPin != mPinUriEmergencyAr) {
                        if (currentPin == mPinUriGreen) {
                            drawPinOnMap("pin1.png", lat + "," + lng, mMAKANI, mPinTypeEntrance, entry);

                        } else if (currentPin == mPinUriRed) {
                            drawPinOnMap("map_entrance_selected.png", lat + "," + lng, mMAKANI, mPinTypeEntrance, entry);
                        }
                        // break;
                    }
                } else {
                    //      drawPinOnMap("pin1.png", lastlat + "," + lastlng, lastmakani, mPinTypeEntrance, lastentry);
                    if (currentPin != mPinUriEmergencyEn || currentPin != mPinUriEmergencyAr) {
                        drawPinOnMap("pin1.png", lat + "," + lng, mMAKANI, mPinTypeEntrance, entry);
                    }
                }

            }

        } else if (propertyPintType == "singlepin") {
            setMulitple("singlepin");

        } else if (propertyPintType == "routepin") {

            mLastFocusID = myfocuSId;
            mapLabelText = myLocation->property("pin_name").toString();
            setMulitple("routepin");
        }
    }
    mapDataFromFocusId = mapLabelLatitude + "," + mapLabelLongitude;
    mLastFocusID = myfocuSId;
}

const QString WebServicesAPI::getFouceId()
{
    return mapFocusId;
}
QString WebServicesAPI::getMapCaptionText()
{
    return mapLabelText;
}
QString WebServicesAPI::getMapCaptionLatitude()
{
    return mapLabelLatitude;
}
QString WebServicesAPI::getMapCaptionLongitude()
{
    return mapLabelLongitude;
}
bool WebServicesAPI::getOutlineBuilding()
{
    return isOutlineBuilding;
}
QStringList WebServicesAPI::getUAENGData()
{
    return mLisToSend;
}
void WebServicesAPI::drawSingleBuilding(QString lat, QString lng)
{
    Polyline mPolylineBuildingInfo;
    QLocale c(QLocale::C);

    GeoPolygon* mGeoPolygonBuildingInfo = new GeoPolygon();
    mGeoPolygonBuildingInfo->setName("");
    mGeoPolygonBuildingInfo->setOuterBoundary(mPolylineBuildingInfo);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);
    myMapView->setAltitude(50);
    myMapView->setLatitude(c.toDouble(lat));
    myMapView->setLongitude(c.toDouble(lng));
}
/*
 * Shows dialog for category if true otherwise dialog for service if false.
 */
void WebServicesAPI::ShowDialog(bool isCat)
{
    if (isCat) {
        listCategory->show();
    } else {
        listService->show();
    }
}
QStringList WebServicesAPI::getCategoryDialogdata()
{

    return mListDialogData;
}
void WebServicesAPI::getDropDownServic(QObject* serviceObject)
{
    ddTypeService = qobject_cast<DropDown*>(serviceObject);
}

QString WebServicesAPI::getServiceId()
{
    return mServiceIdfromQml;
}
QString WebServicesAPI::setServiceId(QString myServiceId)
{
    mServiceIdfromQml = myServiceId;
    return mServiceIdfromQml;
}
QVariantList WebServicesAPI::getBuildingListData()
{
    return mlistSearchBuilding;
}
/*
 *Returns the input text whether it is number or charecter null if none of the criteria matches.
 *@params mAdvanceSearchText text input to be checked
 */
QString WebServicesAPI::checkAdvanceSearchNumber(QString mAdvanceSearchText)
{

    QString isNumOrChr;
    QString mtemp = mAdvanceSearchText;
    QString strWithoutSpace = mAdvanceSearchText.replace(" ", "");
    QRegExp mQRegExpForNumber("^[0-9]{2,10}$");
    QRegExp mQRegExpForText("^[A-Za-z]{2,10}$");
    QRegExp mRegexpForUAENG40R("^(?:40R|40R |40r|40r )(?:CN |CN|cn|cn )(( )?\\d){6,10}$");
    QRegExp mRegExpForUAENGCN("^(?:CN |CN|cn|cn )(( )?\\d){6,10}$");

    if (mQRegExpForNumber.exactMatch(strWithoutSpace)) {
        if (strWithoutSpace.length() == 3) {
            GetMakaniNo(strWithoutSpace);
        }

        isNumOrChr = "number";
    } else {

        if (mtemp.length() == 3 || mtemp.length() == 5 || mtemp.length() == 7 || mtemp.length() == 9) {
            //GetPOIInfo(strWithoutSpace, "E", true, "autoComplete");
            GetPOIInfo(mtemp, "E", true, "autoComplete");

        }

        isNumOrChr = "charecter";
    }
    return isNumOrChr;
}
/*
 *Returns the input text whether it is number,charecter,POI null if none of the criteria matches.
 *@params mValue text input to be checked
 */
QString WebServicesAPI::checkInvalid(QString mValue)
{
    QString isValid = "";
    QRegExp mQRegExpForNumber("^[0-9]{10}$");
    QRegExp mQRegExpForText("^[A-Za-z ]+$");
    QRegExp mRegexpForUAENG40R("^(?:40R|40R |40r|40r )(?:CN |CN|cn|cn )(( )?\\d){6,10}$");
    QRegExp mRegExpForUAENGCN("^(?:CN |CN|cn|cn )(( )?\\d){6,10}$");
    QRegExp mQRegExpForText1("^[0-9]{6,7}$");
    QRegExp mQRegExpForText2("(\\d{3})-(\\d{1})(\\d{2,3})");

    if (mQRegExpForNumber.exactMatch(mValue)) {
        return isValid = "number";
    } else if (mQRegExpForText.exactMatch(mValue)) {
        return isValid = "text";
    } else if (mRegexpForUAENG40R.exactMatch(mValue) || mRegExpForUAENGCN.exactMatch(mValue)) {
        return isValid = "UAENG";
    } else if (mQRegExpForText1.exactMatch(mValue) || mQRegExpForText2.exactMatch(mValue)) {
        return isValid = "landnumber";
    } else {
        return isValid = "";
    }

// return isValid;
}
/*
 *Returns  checks input text whether it is valid makani number or UAENG ,POI null if none of the criteria matches.
 *@params mValue text input to be checked
 */

QString WebServicesAPI::CommonSearchvalidation(QString mValue)
{
    QString isValid = "";
    QRegExp mQRegExpForOnlyNumber("^[0-9]{0,100}$");
    QRegExp mQRegExpForNumber("^[0-9]{10,10}$");
    QRegExp mQRegExpForText("^[A-Za-z ]+$");
    QRegExp mRegexpForUAENG40R("^(?:40R|40R |40r|40r )(?:CN |CN|cn|cn )(( )?\\d){6,10}$");
    QRegExp mRegExpForUAENGCN("^(?:CN |CN|cn|cn )(( )?\\d){6,10}$");
    QRegExp mQRegExpForAlphaNumber("^(a-zA-Z0-9\\s*)*$");

    if (mQRegExpForOnlyNumber.exactMatch(mValue)) {
        if (mQRegExpForNumber.exactMatch(mValue)) {
            return isValid = "number";

        } else {
            return isValid = "notvalid";
        }
    } else if (mRegexpForUAENG40R.exactMatch(mValue) || mRegExpForUAENGCN.exactMatch(mValue)) {

        return isValid = "UAENG";

    } else if (mQRegExpForText.exactMatch(mValue)) {
        return isValid = "text";

    } else {
        return isValid = "";

    }

}

QString WebServicesAPI::validateString(QString mValue)
{
    QString isValid = "";
    QRegExp mQRegExpForNumber("^[0-9]{10}$");
    QRegExp mQRegExpForText("^[A-Za-z ]+$");
    QString myPatternWithZone = "^(?:[0-9]\\s*){2}(?:[A-Za-z ]{1}\\s*)(?:[A-za-z]\\s*){2}(( )?\\d\\s*){6,10}$";
    QRegExp mRegexpWithZone(myPatternWithZone);
    QRegExp mQRegExpForText1("^[0-9]{6,7}$");
    QRegExp mQRegExpForText2("(\\d{3})-(\\d{1})(\\d{2,3})");

    if (mQRegExpForNumber.exactMatch(mValue)) {
        isValid = "number";
    } else if (mRegexpWithZone.exactMatch(mValue)) {
        isValid = "UAENG";
    } else if (mQRegExpForText.exactMatch(mValue)) {
        isValid = "text";
    } else if (mQRegExpForText1.exactMatch(mValue) || mQRegExpForText2.exactMatch(mValue))

    {
        isValid = "landnumber";
    }
    return isValid;
}
/*
 * Return and Convert  any  valid string into UAENG value
 */
QString WebServicesAPI::ConvertToUAENG(QString myStr)
{
    QRegExp rxfor40R;
    QRegExp rxforCN;
    QString finalStr;
    QString myPattern = "^(?:40R|40R |40r|40r )(?:CN |CN|cn|cn )(( )?\\d){6,10}$";
    QString myPattern2 = "^(?:CN |CN|cn|cn )(( )?\\d){6,10}$";

    QString myPatternWithZone = "^(?:[0-9]\\s*){2}(?:[A-Za-z ]{1}\\s*)(?:[A-za-z]\\s*){2}(( )?\\d\\s*){6,10}$";
    QRegExp mRegexpWithZone(myPatternWithZone);

    rxfor40R.setPattern(myPattern);
    rxforCN.setPattern(myPattern2);
    rxfor40R.setMinimal(true);
    rxforCN.setMinimal(true);

    if (rxfor40R.exactMatch(myStr.replace(" ", ""))) {
        finalStr = getConvertedValue(rxfor40R, myStr.replace(" ", ""), true);
    } else {
        //if starts with CN then append 40R
        if (rxforCN.exactMatch(myStr.replace(" ", ""))) {
            finalStr = getConvertedValue(rxforCN, myStr, false);
        } else if (mRegexpWithZone.exactMatch(myStr)) {
            finalStr = myStr;
        } else {
            finalStr = "";
        }

    }

    return finalStr;
}
/*
 * returns the converted value of uaeng
 * @Param checkrx Regular expression to be matched with mydatastr.
 * @param mydatastr string value to be matched against.
 * @param isFromFirst True Indicates string args tarts with zone 40R otherwise without Zone(CN).
 */
QString WebServicesAPI::getConvertedValue(QRegExp checkrx, QString mydataStr, bool isFromFirst)
{
    QString mWholeString, finalStr;
    if (checkrx.indexIn(mydataStr) != -1) {
        mWholeString = checkrx.cap(0);
    }
//starts  with 40R so isFromFirst true
    if (isFromFirst) {
        QString mymid, myEndStr, myStrfirstPart, myStrLastPart, myNumber;
        myNumber = mWholeString.replace(" ", "").mid(5);
        mymid = mWholeString.replace(" ", "").mid(5);

        if (myNumber.length() == 6) {
            //divide by two then append remaining equally to easting northing
            myStrfirstPart = myNumber.right(3);
            myStrLastPart = myNumber.left(3);
            for (int i = 0; i < 2; i++) {
                myStrfirstPart.append("5");
                myStrLastPart.append("5");
            }
            myEndStr = "40R CN " + myStrLastPart + " " + myStrfirstPart;
            finalStr = myEndStr;
        } else if (myNumber.length() == 8) {
            //divide by two then append remaining equally to easting and northing
            myStrfirstPart = myNumber.right(4);
            myStrLastPart = myNumber.left(4);
            for (int i = 0; i < 1; i++) {
                myStrfirstPart.append("5");
                myStrLastPart.append("5");
            }
            myEndStr = "40R CN " + myStrLastPart + " " + myStrfirstPart;
            finalStr = myEndStr;

        } else if (myNumber.length() == 10) {
            myEndStr = "40R CN " + mWholeString.mid(5).left(5) + " " + mWholeString.right(5);
            finalStr = myEndStr;
        }
    } else {
        //CN part
        QString mymid, myEndStr, myStrfirstPart, myStrLastPart, myNumber;
        myNumber = mWholeString.replace(" ", "").mid(2);
        mymid = mWholeString.replace(" ", "").mid(2);

        if (myNumber.length() == 6) {
            //divide by two then append remaining equally to easting northing
            myStrfirstPart = myNumber.right(3);
            myStrLastPart = myNumber.left(3);
            for (int i = 0; i < 2; i++) {
                myStrfirstPart.append("5");
                myStrLastPart.append("5");
            }
            myEndStr = "40R CN " + myStrLastPart + " " + myStrfirstPart;
            finalStr = myEndStr;
        } else if (myNumber.length() == 8) {
            //divide by two then append remaining equally to easting northing
            myStrfirstPart = myNumber.right(4);
            myStrLastPart = myNumber.left(4);
            for (int i = 0; i < 1; i++) {
                myStrfirstPart.append("5");
                myStrLastPart.append("5");
            }
            myEndStr = "40R CN " + myStrLastPart + " " + myStrfirstPart;
            finalStr = myEndStr;
        } else if (myNumber.length() == 10) {
            myEndStr = "40R CN " + myNumber.mid(0, 5) + " " + myNumber.mid(5, 5);
            finalStr = myEndStr;
        }
    }
    return finalStr;
}

bool WebServicesAPI::isCharecteresOnly(QString myStr)
{
    QRegExp mQRegExpForCharectres("^[A-Za-z]$");
    return mQRegExpForCharectres.exactMatch(myStr);
}

bool WebServicesAPI::isNumberOnly(QString myStr)
{
    QRegExp mQRegExpForCharectres("^[0-9]*");
    return mQRegExpForCharectres.exactMatch(myStr);
}
bool WebServicesAPI::isValidUTMNumber(QString myStr)
{
    QRegExp mQRegExpForCharectres("[0-9]+([,\\.][0-9]+)?");
    return mQRegExpForCharectres.exactMatch(myStr);
}
/*
 * Returns the contact details data based on id.
 * @param id contact id from qml when contact selected.
 */
QString WebServicesAPI::getcontactNumber(qint64 id)
{
    QString placeNumber = "";
    contacts::ContactService mservice;
    contacts::Contact contact_info = mservice.contactDetails(id);
    QString firstName = contact_info.firstName();

    QList<contacts::ContactAttribute> phoneno_list = contact_info.filteredAttributes(contacts::AttributeKind::OrganizationAffiliation);
    QString data = phoneno_list.value(0).value();
    QString datatemp = data;
    if (data.length() > 0) {
        placeNumber = data;
    }

    return data;
}
/*
 * Extracts the contact details with the provided contact id and checks the type of data is makani or UAEG shows dilog if no macth/data found.
 * @param id contact id from qml when contact selected.
 */
void WebServicesAPI::getcontactNumberFromAdvanceSearch(qint64 id)
{
    QString placeNumber = "";
    contacts::ContactService mservice;
    contacts::Contact contact_info = mservice.contactDetails(id);
    QString firstName = contact_info.firstName();

    QList<contacts::ContactAttribute> phoneno_list = contact_info.filteredAttributes(contacts::AttributeKind::OrganizationAffiliation);
    QString data = phoneno_list.value(0).value();
    if (data.length() > 0) {
        placeNumber = data;
        ClearMapdata();
        if (checkInvalid(data.replace(" ", "")) == "number") {
            GetBuildingInfo(placeNumber);
        } else if (validateString(data.replace(" ", "")) == "UAENG") {
            //UAENG
            UAENGtoCoordinates(placeNumber, "54F000E53AA3DB91BB938B274D6C3A18", "Map");
        }
        setPoiInfoData("", "", "", "", "", "", "");
    } else {
        //showMySystemDialog(tr("No Data Found"));
        showMySystemDialog(tr("No Data Found"));

    }
}
/*
 * Called from direction qml to call web service based on value and type.
 * @param value combination of latitude and logitude with space.
 * @param type type of value makni or UAENG.
 */
void WebServicesAPI::getDirectionLatLon(QString value, QString type)
{
    QString coordinateX;
    QString coordinateY;
    if (type == "UAENG") {
        UAENGtoCoordinates(value, "54F000E53AA3DB91BB938B274D6C3A18", "Direction");
    } else if (type == "MAKANI") {
        if (isfromMapselectedLocation) {

            coordinateX = value.left(5);
            coordinateY = value.right(5);

            isfromMapselectedLocation = false;
        } else {
            QString spacePattern(" ");
            QStringList mListCoord = value.split(spacePattern);
            coordinateX = mListCoord.value(0);
            coordinateY = mListCoord.value(1);
        }
        isFromConverter = true;

        getCoordinateConversion(coordinateX, coordinateY, "MAKANI", "Direction", false);
    }

}
QString WebServicesAPI::getBuildingToDirectionLatLng(QString isfrom)
{
    QString mdata;
    if (isfrom == "from") {
        mdata = mBuildingLATLNG;
        //  return mBuildingLATLNG;
    } else if (isfrom == "to") {
        mdata = mBuildingLATLNGTo;
        //  return mBuildingLATLNGTo;
    } else if (isfrom == "via") {
        mdata = mBuildingLATLNGVia;
        //  return mBuildingLATLNGVia;
    }
    return mdata;
}
void WebServicesAPI::setBuildingToDirectionLatLng(QString latlng, QString isfrom)
{
    if (isfrom == "from") {
        mBuildingLATLNG = latlng;
    } else if (isfrom == "to") {
        mBuildingLATLNGTo = latlng;
    } else if (isfrom == "via") {
        mBuildingLATLNGVia = latlng;
    }
    emit buildingDataLoaded(isfrom);
}

QString WebServicesAPI::checkisFrom()
{
    return isFromBuilding;
}
void WebServicesAPI::setcheckisFrom(QString isfrom)
{

    isFromBuilding = isfrom;
}
void WebServicesAPI::setcheckisFromAdvanceSearch(bool isfrom)
{
    isFromDirectionBuilding = isfrom;
}
bool WebServicesAPI::checkisFromAdvanceSearch()
{
    return isFromDirectionBuilding;
}
/*
 * Returns the contructed url with starting location, end location and transit mode.
 * @param startLocation latitude,logitude.
 * @param endLoaction latitude,logitude.
 * @param transitMode mode of transit.
 */
QString WebServicesAPI::getUrl(QString startLocation, QString endLocation, QString transitMode, bool isfromVia, QString via, bool isAvoidHighwayActivated, bool isAvoidSalikTollActivated)
{
    QString mStringRouteURL = "";
    QString mStringLanguage = "";

    if (getValueFor("mLanguageCode", "en") == "en") {
        mStringLanguage = "";
    } else {
        mStringLanguage = "&language=ar";
    }
    if (transitMode == "transit" || transitMode == "driving" || transitMode == "walking") {

        qint64 msec = QDateTime::currentMSecsSinceEpoch() / 1000;
        mStringRouteURL = "http://maps.googleapis.com/maps/api/directions/json?";
        mStringRouteURL.append("origin=");
        mStringRouteURL.append(startLocation);
        mStringRouteURL.append("&destination=");
        mStringRouteURL.append(endLocation);
        if (isfromVia) {
            mStringRouteURL.append("&waypoints=");
            mStringRouteURL.append(via);
        }
        mStringRouteURL.append("&sensor=false&units=metric&mode=");
        mStringRouteURL.append(transitMode);
        if (transitMode == "transit") {
            mStringRouteURL.append("&departure_time=");
            mStringRouteURL.append(QString::number(msec));
        }
        /* mStringRouteURL.append("&departure_time=");
         mStringRouteURL.append(QString::number(msec));*/
        mStringRouteURL.append(mStringLanguage);

    } else {

        mStringRouteURL = "http://maps.googleapis.com/maps/api/directions/json?";
        mStringRouteURL.append("origin=");
        mStringRouteURL.append(startLocation);
        mStringRouteURL.append("&destination=");
        mStringRouteURL.append(endLocation);

        mStringRouteURL.append("&sensor=false&units=metric&mode=");
        mStringRouteURL.append(transitMode);
        mStringRouteURL.append(mStringLanguage);
    }
    mStringRouteURL = mStringRouteURL.replace(" ", "%20");

    if (!mStringRouteURL.startsWith("http://maps.googleapis.com")) {
        mStringRouteURL = mStringRouteURL.prepend("http://maps.googleapis.com").trimmed();
    }
    if (isAvoidSalikTollActivated) {
        mStringRouteURL = mStringRouteURL + "&avoid=tolls";
    }
    if (isAvoidHighwayActivated) {
        mStringRouteURL = mStringRouteURL + "&#448;highways";
    }
    /* if (isAvoidHighwayActivated) {
     if (isAvoidSalikTollActivated)
     mStringRouteURL = mStringRouteURL + "&#448;highways";
     else
     mStringRouteURL = mStringRouteURL + "&avoid=highways";
     }*/

//"http://maps.googleapis.com/maps/api/directions/json?origin=25.200788,55.238235&destination=24.79904,56.13244&sensor=false&units=metric&mode=driving"
//  QString temp = "http://maps.googleapis.com/maps/api/directions/json?origin=25.200788,55.238235&destination=24.7990410360032,56.1324350238528&sensor=false&units=metric&mode=driving&waypoints=25.255516,55.283355";
// return temp;
    return mStringRouteURL;
}
/*
 * web service to get the response of google routes.
 * @param url url to pass in.
 */
void WebServicesAPI::callGoogleRoutes(QString url)
{
    m_active = true;
    emit activeChanged();
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinished(QNetworkReply*)));

    manager->get(QNetworkRequest(QUrl(url)));
}

void WebServicesAPI::replyFinished(QNetworkReply* reply)
{
    QByteArray replyBytes = reply->readAll();

    QString fromSource;
    QString ToDestination;
    QString TotalDuration;
    QString TotalDistance;
    mStepsData.clear();
    mFromToDirectionData.clear();

    QString fromSourcevia;
    QString ToDestinationvia;
    QString TotalDurationvia;
    QString TotalDistancevia;
    mStepsDataVia.clear();
    mTotoViaDirectionData.clear();
    mFromToDirectionData.clear();

    mPolylineData.clear();
    decodedpolylat.clear();
    decodedpolylng.clear();

    QString mData = mData.fromUtf8(replyBytes);

    parseViaGetJourneyPlannerDirectionStep(mData);

    m_active = false;
    emit activeChanged();
    emit routeDataLoaded();
}
void WebServicesAPI::parseViaGetJourneyPlannerDirectionStep(QString mData)
{

    setmactive(true);
    mQVariantDirectionStepListData.clear();
    JsonDataAccess jda;
    QVariant mRouteDataResponse = jda.loadFromBuffer(mData);
    QVariantList mRoutesList = mRouteDataResponse.toMap().value("routes").toList();
    QVariantList mListLegs = mRoutesList.value(0).toMap().value("legs").toList();

    mQVariantRouteFromToVia.clear();
    mQVariantRouteFromToViaNew.clear();
    for (int i = 0; i < mListLegs.size(); i++) {

        QVariantMap mMapDirectionStep;

        mMapDirectionStep.insert("distance", mListLegs.value(i).toMap().value("distance").toMap().value("text").toString());
        mMapDirectionStep.insert("duration", mListLegs.value(i).toMap().value("duration").toMap().value("text").toString());
        mMapDirectionStep.insert("start_address", mListLegs.value(i).toMap().value("start_address").toString());
        mMapDirectionStep.insert("start_location_lat", mListLegs.value(i).toMap().value("start_location").toMap().value("lat").toString());
        mMapDirectionStep.insert("start_location_lng", mListLegs.value(i).toMap().value("start_location").toMap().value("lng").toString());

        mMapDirectionStep.insert("end_address", mListLegs.value(i).toMap().value("end_address").toString());
        mMapDirectionStep.insert("end_location_lat", mListLegs.value(i).toMap().value("end_location").toMap().value("lat").toString());
        mMapDirectionStep.insert("end_location_lng", mListLegs.value(i).toMap().value("end_location").toMap().value("lng").toString());

        QVariantList mStepListData;
        QVariantList mStepListRouteData;
        QVariantList mStepListRouteDataVia;
        QVariantList mListSteps = mListLegs.value(i).toMap().value("steps").toList();
        for (int j = 0; j < mListSteps.size(); j++) {
            QVariantMap mListStepsMap;
            mListStepsMap.insert("html_instructions", mListSteps.value(j).toMap().value("html_instructions").toString());
            mListStepsMap.insert("travel_mode", mListSteps.value(j).toMap().value("travel_mode").toString());
            mListStepsMap.insert("maneuver", mListSteps.value(j).toMap().value("maneuver").toString());
            mListStepsMap.insert("step_distance", mListSteps.value(j).toMap().value("distance").toMap().value("text").toString());
            mListStepsMap.insert("step_duration", mListSteps.value(j).toMap().value("duration").toMap().value("text").toString());

            QString endLocationLat = mListSteps.value(j).toMap().value("end_location").toMap().value("lat").toString();
            QString endLocationLng = mListSteps.value(j).toMap().value("end_location").toMap().value("lng").toString();
            QString startLocationLat = mListSteps.value(j).toMap().value("start_location").toMap().value("lat").toString();
            QString startLocationLng = mListSteps.value(j).toMap().value("start_location").toMap().value("lng").toString();

            mListStepsMap.insert("step_end_location_lat", endLocationLat);
            mListStepsMap.insert("step_end_location_lng", endLocationLng);
            mListStepsMap.insert("step_start_location_lat", startLocationLat);
            mListStepsMap.insert("step_start_location_lng", startLocationLng);

            if (i == 0) {

                QVariantMap mListRouteData;
                mListRouteData.insert("end_location_lat", endLocationLat);
                mListRouteData.insert("end_location_lng", endLocationLng);
                mListRouteData.insert("start_location_lat", startLocationLat);
                mListRouteData.insert("start_location_lng", startLocationLng);
                mStepListRouteData.append(mListRouteData);

            }
            if (i == 1) {
                QVariantMap mListRouteData;
                mListRouteData.insert("end_location_lat", endLocationLat);
                mListRouteData.insert("end_location_lng", endLocationLng);
                mListRouteData.insert("start_location_lat", startLocationLat);
                mListRouteData.insert("start_location_lng", startLocationLng);
                mStepListRouteDataVia.append(mListRouteData);
            }

            mPolylineData.append(mListSteps.value(i).toMap().value("polyline").toMap().value("points").toString());
            decodePoly(mListSteps.value(i).toMap().value("polyline").toMap().value("points").toString());

            mStepListData.append(mListStepsMap);
        }
        mQVariantRouteFromToVia.append(mStepListRouteData);
        mQVariantRouteFromToViaNew.append(mStepListRouteDataVia);

        mMapDirectionStep.insert("StepList", mStepListData);
        mQVariantDirectionStepListData.append(mMapDirectionStep);
    }

//    m_succeeded = true;
//    emit directionDataLoaded();

    m_active = false;
    emit activeChanged();
    emit routeDataLoaded();

}
QVariantList WebServicesAPI::getDirectionStepList()
{
    return mQVariantDirectionStepListData;
}
QString WebServicesAPI::getStepsData()
{
    return mStepsData;
}
QStringList WebServicesAPI::getFromToData()
{
    return mFromToDirectionData;
}

QString WebServicesAPI::getStepsDataVia()
{
    return mStepsDataVia;
}
QStringList WebServicesAPI::getTotoViaData()
{
    return mTotoViaDirectionData;
}
QString WebServicesAPI::myPolylineData()
{
    return mPolylineData;
}
/*
 *decode  Data from call google route response.
 *@param encoded data from webs ervice response.
 */
void WebServicesAPI::decodePoly(QString encoded)
{

    int index = 0, len = encoded.length();
    int lat = 0, lng = 0;
    while (index < len) {
        int b, shift = 0, result = 0;
        do {
            b = encoded.at(index++).toAscii() - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = encoded.at(index++).toAscii() - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        QString valueAsStringlat = QString::number((double) lat / 1E5);
        QString valueAsStringlng = QString::number((double) lng / 1E5);
        decodedpolylat.append((double) lat / 1E5);
        decodedpolylng.append((double) lng / 1E5);
    }

}
/*
 * Gets the geolocation data from address
 * @param mpoiAddress address string to get geolocation data.
 */

void WebServicesAPI::myPOIgeoCodeData(QString mpoiAddress)
{
    m_active = true;
    emit activeChanged();
    QStringList serviceProviders = QGeoServiceProvider::availableServiceProviders();

    if (serviceProviders.size()) {
        QGeoServiceProvider *serviceProvider = new QtMobilitySubset::QGeoServiceProvider(serviceProviders.at(0));
        searchManager = serviceProvider->searchManager();
    }
    connect(searchManager, SIGNAL(finished(QGeoSearchReply*)), this, SLOT(searchResults(QGeoSearchReply*)));
    searchAddress.setText(mpoiAddress);

    reply = searchManager->geocode(searchAddress);

}
void WebServicesAPI::searchResults(QGeoSearchReply *reply)
{
    QString lat;
    QString lng;

    m_active = false;
    emit activeChanged();

    lat = QString::number(reply->places().value(0).coordinate().latitude());
    lng = QString::number(reply->places().value(0).coordinate().longitude());
    if (lat == "nan" || lng == "nan") {
        hasResponse = false;
        if (mPOIFrom == "searchOnMap") {
            showMySystemDialog(tr("No Data Found"));
            m_active = false;
            emit activeChanged();
        }
    } else {
        hasResponse = true;
        reply->deleteLater();
        mPOIdatalatng = lat + "," + lng;
        if (mPOIFrom == "searchOnMap") {
            drawPinOnMap("pin2.png", lat + "," + lng, "temp", mPinTypeSingle, NULL);
        }
    }
    if (mPOIFrom == "searchDirection") {
        emit poidataloaded();
    }
}
/* convertes from geolocation data to get latitude,logitude,name etc...
 */
void WebServicesAPI::reverseGeoCode()
{
    m_active = true;
    emit activeChanged();
    QStringList serviceProviders = QGeoServiceProvider::availableServiceProviders();
    QGeoSearchManager* mGeoSearchManager;
    if (serviceProviders.size()) {
        QGeoServiceProvider *serviceProvider = new QtMobilitySubset::QGeoServiceProvider(serviceProviders.at(0));
        mGeoSearchManager = serviceProvider->searchManager();
    }
    QGeoCoordinate mGeoCoordinate;
    QString lat = getValueFor("currentLatitude", "25.271139");
    QString lon = getValueFor("CurrentLongitude", "55.307485");
    mGeoCoordinate.setLatitude(lat.toDouble());
    mGeoCoordinate.setLongitude(lon.toDouble());
    QGeoSearchReply *reply = mGeoSearchManager->reverseGeocode(mGeoCoordinate);

    bool finished_connected = QObject::connect(mGeoSearchManager, SIGNAL(finished(QGeoSearchReply*)), this, SLOT(readReverseGeocode(QGeoSearchReply*)));
    if (finished_connected) {
    } else {
        m_active = false;
        emit activeChanged();
    }
}
/*
 * Retrieve the geocoded values.
 */
void WebServicesAPI::readReverseGeocode(QGeoSearchReply *reply)
{

    m_active = false;
    emit activeChanged();
    QString address = reply->places().value(0).address().text();
    mGetMyLocation = address;
    if (mGetMyLocation.trimmed().length() > 0) {
        emit getMyLocationDone();
    } else {
        QString lat = getValueFor("currentLatitude", "25.271139");
        QString lon = getValueFor("CurrentLongitude", "55.307485");
        getCoordinateConversion(lon, lat, "LATLNG", "DirectionMyLocation", false);
    }
}
QString WebServicesAPI::getMyLocation()
{
    return mGetMyLocation;
}
QString WebServicesAPI::getPOIlatlng()
{

    return mPOIdatalatng;
}
QString WebServicesAPI::getmapDataFromFocusId()
{

    return mapDataFromFocusId;

}
bool WebServicesAPI::hasGotResponse()
{
    return hasResponse;

}
void WebServicesAPI::SetPOISearch(bool is)
{
    isPOISearch = is;
}
bool WebServicesAPI::checkPOISearch()
{
    return isPOISearch;
}
void WebServicesAPI::setMulitple(QString labelMulitple)
{
    ismulipleLabel = labelMulitple;
}

QString WebServicesAPI::getMulitple()
{
    return ismulipleLabel;
}
/*
 *drops pin on from place to desired place by checking the type of data.
 *@param fromPlace Geolocation
 *@param toPlace Geolocation
 */

void WebServicesAPI::drawpinOnDecodedPoly(QString fromPlace, QString toPlace, QString toVia)
{

    mMapData = new MapData();
    Polyline mPolylineBuildingInfo;
    mListPOIPrevious.clear();
    qDebug() << "mQVariantRouteFromToVia :" << mQVariantRouteFromToVia.size();
    qDebug() << "mQVariantRouteFromToViaNew :" << mQVariantRouteFromToViaNew.size();
// start From TO Route
    for (int i = 0; i < mQVariantRouteFromToVia.size(); i++) {
        QVariantMap mListdatamap;
        mListdatamap = mQVariantRouteFromToVia.value(i).toMap();
        double lat = mListdatamap.value("end_location_lat").toDouble();
        double lng = mListdatamap.value("end_location_lng").toDouble();
        mPolylineBuildingInfo.append(Coordinate(lat, lng));

        if (i == 0) {
            QString mType = checkInvalid(fromPlace.replace(" ", ""));
            QVariantMap mListdata;
            mListdata["NAME_E"] = fromPlace;
            mListdata["Location"] = fromPlace;
            mListdata["X_COORD"] = mListdatamap.value("end_location_lat").toString();
            mListdata["Y_COORD"] = mListdatamap.value("end_location_lng").toString();
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";
            if (mType == "number") {
                drawPinOnMap("pin1.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);

            } else {
                drawPinOnMap("pin2.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);

            }

            mListPOIPrevious.append(mListdata);

            qDebug() << "Rahul I==0";

        } else if (i == mQVariantRouteFromToVia.size() - 1) {
            qDebug() << "i==SIZE" << i;
            QString mType = checkInvalid(toPlace.replace(" ", ""));
            QVariantMap mListdata;
            mListdata["NAME_E"] = toPlace;
            mListdata["Location"] = toPlace;

            mListdata["X_COORD"] = mListdatamap.value("end_location_lat").toString();
            mListdata["Y_COORD"] = mListdatamap.value("end_location_lng").toString();
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";

            if (mType == "number")
                drawPinOnMap("pin1.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), toPlace, mPinTypeMultiple, mListdata);
            else
                drawPinOnMap("pin2.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), toPlace, mPinTypeMultiple, mListdata);

            mListPOIPrevious.append(mListdata);

        }
    }

// End From TO Route

// start loop for draw route  From TO Route via
    for (int i = 0; i < mQVariantRouteFromToViaNew.size(); i++) {
        QVariantMap mListdatamap;
        mListdatamap = mQVariantRouteFromToViaNew.value(i).toMap();
        double lat = mListdatamap.value("end_location_lat").toDouble();
        double lng = mListdatamap.value("end_location_lng").toDouble();
        mPolylineBuildingInfo.append(Coordinate(lat, lng));

//        if (i == 0) {
//
//            QString mType = checkInvalid(toVia.replace(" ", ""));
//            QVariantMap mListdata;
//            mListdata["NAME_E"] = toVia;
//            mListdata["Location"] = toVia;
//
//            mListdata["X_COORD"] = mListdatamap.value("end_location_lat").toString();
//            mListdata["Y_COORD"] = mListdatamap.value("end_location_lng").toString();
//            mListdata["TEL_NO"] = "";
//            mListdata["FAX_NO"] = "";
//            mListdata["EMAIL"] = "";
//            mListdata["LICENSE_NO"] = "";
//            mListdata["URL"] = "";
//            mListdata["POBOX"] = "";
//
//            if (mType == "number")
//                drawPinOnMap("pin1.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
//            else
//                drawPinOnMap("pin2.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
//
//            mListPOIPrevious.append(mListdata);
//
//        } else

        if (i == mQVariantRouteFromToViaNew.size() - 1) {
            QString mType = checkInvalid(toVia.replace(" ", ""));
            QVariantMap mListdata;
            mListdata["NAME_E"] = toVia;
            mListdata["Location"] = toVia;

            mListdata["X_COORD"] = mListdatamap.value("end_location_lat").toString();
            mListdata["Y_COORD"] = mListdatamap.value("end_location_lng").toString();
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";

            if (mType == "number")
                drawPinOnMap("pin1.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), toVia, mPinTypeMultiple, mListdata);
            else
                drawPinOnMap("pin2.png", mListdatamap.value("end_location_lat").toString() + "," + mListdatamap.value("end_location_lng").toString(), toVia, mPinTypeMultiple, mListdata);

            mListPOIPrevious.append(mListdata);

        }

    }

    GeoPolyline* innovFarrar = new GeoPolyline();
    innovFarrar->setGeoId("route_line");
    innovFarrar->setLine(mPolylineBuildingInfo);
    myMapView->mapData()->add(innovFarrar);

// Styles
    StyleSheet styles;
    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::Large);
//    polylines.setEdgeColor(0x8F00FF00);
    polylines.setFillColor(0x00FF0000);
    styles.addStyleForClass(innovFarrar, polylines);

    myMapView->mapData()->setStyles(styles);

    setZoomLevelForMap(myMapView->mapData());
//    myMapView->setCaptionGoButtonVisible(false);

}
void WebServicesAPI::drawpinOnDecodedPolyNew(QVariantList mGeoCodeList, QString fromplace, QString toplace, QString viaplace)
{

    mMapData = new MapData();
    Polyline mPolylineBuildingInfo;
    mListPOIPrevious.clear();
    for (int i = 0; i < mGeoCodeList.size(); i++) {

        if (i == 0) {
            QString type = checkInvalid(fromplace.replace(" ", ""));
            QVariantMap mMapData = mGeoCodeList.value(i).toMap();
            QString fromPlace = mMapData.value("start_address").toString();
            QString endPlace = mMapData.value("end_address").toString();
            QVariantList mstrplist = mMapData.value("StepList").toList();
            for (int j = 0; j < mstrplist.size(); j++) {
                QVariantMap mMapData = mstrplist.value(j).toMap();
                QVariantMap mListdata;

                if (j == 0) {
                    mListdata["NAME_E"] = fromPlace;
                    mListdata["Location"] = fromPlace;
                } else if (j == mstrplist.size() - 1) {
                    mListdata["NAME_E"] = endPlace;
                    mListdata["Location"] = endPlace;
                } else {
                    mListdata["NAME_E"] = fromPlace;
                    mListdata["Location"] = fromPlace;
                }

                mListdata["X_COORD"] = mMapData.value("step_start_location_lat").toString();
                mListdata["Y_COORD"] = mMapData.value("step_start_location_lng").toString();
                mListdata["TEL_NO"] = "";
                mListdata["FAX_NO"] = "";
                mListdata["EMAIL"] = "";
                mListdata["LICENSE_NO"] = "";
                mListdata["URL"] = "";
                mListdata["POBOX"] = "";

                if (j == 0) {

                    if (type == "number")
                        drawPinOnMap("pin1.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
                    else
                        drawPinOnMap("pin2.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);

                } else if (j == mstrplist.size() - 1) {
                    if (type == "number")
                        drawPinOnMap("pin1.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
                    else
                        drawPinOnMap("pin2.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
                }
                mListPOIPrevious.append(mListdata);

                mPolylineBuildingInfo.append(Coordinate(mMapData.value("step_start_location_lat").toDouble(), mMapData.value("step_start_location_lng").toDouble()));
            }

        }
        if (i == 1) {

            QVariantMap mMapData = mGeoCodeList.value(i).toMap();
            QString fromPlace = mMapData.value("start_address").toString();
            QVariantList mstrplist = mMapData.value("StepList").toList();
            QString type = checkInvalid(viaplace.replace(" ", ""));
            for (int j = 0; j < mstrplist.size(); j++) {
                QVariantMap mMapData = mstrplist.value(j).toMap();
                QVariantMap mListdata;
                mListdata["NAME_E"] = fromPlace;
                mListdata["Location"] = fromPlace;
                mListdata["X_COORD"] = mMapData.value("step_start_location_lat").toString();
                mListdata["Y_COORD"] = mMapData.value("step_start_location_lng").toString();
                mListdata["TEL_NO"] = "";
                mListdata["FAX_NO"] = "";
                mListdata["EMAIL"] = "";
                mListdata["LICENSE_NO"] = "";
                mListdata["URL"] = "";
                mListdata["POBOX"] = "";

                if (j == mstrplist.size() - 1) {
                    if (type == "number")
                        drawPinOnMap("pin1.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
                    else
                        drawPinOnMap("pin2.png", mMapData.value("step_start_location_lat").toString() + "," + mMapData.value("step_start_location_lng").toString(), fromPlace, mPinTypeMultiple, mListdata);
                }
                mListPOIPrevious.append(mListdata);

                mPolylineBuildingInfo.append(Coordinate(mMapData.value("step_start_location_lat").toDouble(), mMapData.value("step_start_location_lng").toDouble()));
            }

        }
    }

    GeoPolyline* mGeoPolygonBuildingInfo = new GeoPolyline();
    mGeoPolygonBuildingInfo->setGeoId("route_line");

    mGeoPolygonBuildingInfo->setLine(mPolylineBuildingInfo);
    StyleSheet styles;
    Style polylines;
    polylines.setEdgeStyle(EdgeStyle::Solid);
    polylines.setEdgeSize(EdgeSize::Large);
    polylines.setFillColor(0x00FF0000);
    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    myMapView->mapData()->setStyles(styles);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);

    mMapData->add(mGeoPolygonBuildingInfo);
    mPolylineData.clear();
    setZoomLevelForMap(mMapData);

//    for (qint64 i = 0; i < decodedpolylat.size(); i++) {
//        if (i == 0) {
////            QString mType = checkInvalid(fromPlace.replace(" ", ""));
//            QVariantMap mListdata;
//            mListdata["NAME_E"] = fromPlace;
//            mListdata["Location"] = fromPlace;
//            mListdata["X_COORD"] = decodedpolylat.value(i).toString();
//            mListdata["Y_COORD"] = decodedpolylng.value(i).toString();
//            mListdata["TEL_NO"] = "";
//            mListdata["FAX_NO"] = "";
//            mListdata["EMAIL"] = "";
//            mListdata["LICENSE_NO"] = "";
//            mListdata["URL"] = "";
//            mListdata["POBOX"] = "";
//
//            if (type == "number")
//                drawPinOnMap("pin1.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);
//            else
//                drawPinOnMap("map_pin.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);
//
//            mListPOIPrevious.append(mListdata);
//        }
//        mPolylineBuildingInfo.append(Coordinate(decodedpolylat.value(i).toDouble(), decodedpolylng.value(i).toDouble()));
//    }
//    QVariantMap mListdataTO;
//    mListdataTO["NAME_E"] = toPlace;
//    mListdataTO["Location"] = toPlace;
//    mListdataTO["X_COORD"] = decodedpolylat.value(decodedpolylat.size() - 1).toString();
//    mListdataTO["Y_COORD"] = decodedpolylng.value(decodedpolylat.size() - 1).toString();
//    mListdataTO["TEL_NO"] = "";
//    mListdataTO["FAX_NO"] = "";
//    mListdataTO["EMAIL"] = "";
//    mListdataTO["LICENSE_NO"] = "";
//    mListdataTO["URL"] = "";
//    mListdataTO["POBOX"] = "";
//    mListPOIPrevious.append(mListdataTO);
//
//    QString mType = checkInvalid(toPlace.replace(" ", ""));
//
//    if (mType == "number") {
//        drawPinOnMap("pin1.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
//    } else {
//        drawPinOnMap("map_pin.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
//    }
//
//    GeoPolyline* mGeoPolygonBuildingInfo = new GeoPolyline();
//    mGeoPolygonBuildingInfo->setGeoId("route_line");
//
//    mGeoPolygonBuildingInfo->setLine(mPolylineBuildingInfo);
//    StyleSheet styles;
//    Style polylines;
//    polylines.setEdgeSize(EdgeSize::Small);
//    polylines.setFillColor(0x00FF0000);
//    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
//    myMapView->mapData()->setStyles(styles);
//    myMapView->mapData()->add(mGeoPolygonBuildingInfo);
//
//    mMapData->add(mGeoPolygonBuildingInfo);
//    mPolylineData.clear();
//    setZoomLevelForMap(mMapData);
}
void WebServicesAPI::drawpinOnDecodedPolyForVia(QString fromPlace, QString toPlace, QString viaPlace)
{
    mMapData = new MapData();
    Polyline mPolylineBuildingInfo;
    mListPOIPrevious.clear();

    for (qint64 i = 0; i < decodedpolylat.size(); i++) {
        if (i == 0) {
            QString mType = checkInvalid(fromPlace.replace(" ", ""));
            QVariantMap mListdata;
            mListdata["NAME_E"] = fromPlace;
            mListdata["Location"] = fromPlace;
            mListdata["X_COORD"] = decodedpolylat.value(i).toString();
            mListdata["Y_COORD"] = decodedpolylng.value(i).toString();
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";

            if (mType == "number")
                drawPinOnMap("pin1.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);
            else
                drawPinOnMap("pin2.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);

            mListPOIPrevious.append(mListdata);
        }
        if (i == 3) {
            QString mType = checkInvalid(viaPlace.replace(" ", ""));
            QVariantMap mListdata;
            mListdata["NAME_E"] = viaPlace;
            mListdata["Location"] = viaPlace;
            mListdata["X_COORD"] = decodedpolylat.value(i).toString();
            mListdata["Y_COORD"] = decodedpolylng.value(i).toString();
            mListdata["TEL_NO"] = "";
            mListdata["FAX_NO"] = "";
            mListdata["EMAIL"] = "";
            mListdata["LICENSE_NO"] = "";
            mListdata["URL"] = "";
            mListdata["POBOX"] = "";

            if (mType == "number")
                drawPinOnMap("pin1.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), viaPlace, mPinTypeMultiple, mListdata);
            else
                drawPinOnMap("pin2.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), viaPlace, mPinTypeMultiple, mListdata);

            mListPOIPrevious.append(mListdata);
        }
        mPolylineBuildingInfo.append(Coordinate(decodedpolylat.value(i).toDouble(), decodedpolylng.value(i).toDouble()));
    }
    QVariantMap mListdataTO;
    mListdataTO["NAME_E"] = toPlace;
    mListdataTO["Location"] = toPlace;
    mListdataTO["X_COORD"] = decodedpolylat.value(decodedpolylat.size() - 1).toString();
    mListdataTO["Y_COORD"] = decodedpolylng.value(decodedpolylat.size() - 1).toString();
    mListdataTO["TEL_NO"] = "";
    mListdataTO["FAX_NO"] = "";
    mListdataTO["EMAIL"] = "";
    mListdataTO["LICENSE_NO"] = "";
    mListdataTO["URL"] = "";
    mListdataTO["POBOX"] = "";
    mListPOIPrevious.append(mListdataTO);

    QString mType = checkInvalid(toPlace.replace(" ", ""));

    if (mType == "number") {
        drawPinOnMap("pin1.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
    } else {
        drawPinOnMap("pin2.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
    }

    GeoPolyline* mGeoPolygonBuildingInfo = new GeoPolyline();
    mGeoPolygonBuildingInfo->setGeoId("route_line");

    mGeoPolygonBuildingInfo->setLine(mPolylineBuildingInfo);
    StyleSheet styles;
    Style polylines;
    polylines.setEdgeSize(EdgeSize::Small);
    polylines.setFillColor(0x00FF0000);
    styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
    myMapView->mapData()->setStyles(styles);
    myMapView->mapData()->add(mGeoPolygonBuildingInfo);

    mMapData->add(mGeoPolygonBuildingInfo);
    mPolylineData.clear();
    setZoomLevelForMap(mMapData);
}
/*
 void WebServicesAPI::drawpinOnDecodedPolyForVia(QString fromPlace, QString toPlace,QString viaPlace)
 {
 mMapData = new MapData();
 Polyline mPolylineBuildingInfo;
 mListPOIPrevious.clear();

 for (qint64 i = 0; i < decodedpolylat.size(); i++) {
 if (i == 0) {
 QString mType = checkInvalid(fromPlace.replace(" ", ""));
 QVariantMap mListdata;
 mListdata["NAME_E"] = fromPlace;
 mListdata["Location"] = fromPlace;
 mListdata["X_COORD"] = decodedpolylat.value(i).toString();
 mListdata["Y_COORD"] = decodedpolylng.value(i).toString();
 mListdata["TEL_NO"] = "";
 mListdata["FAX_NO"] = "";
 mListdata["EMAIL"] = "";
 mListdata["LICENSE_NO"] = "";
 mListdata["URL"] = "";
 mListdata["POBOX"] = "";

 if (mType == "number")
 drawPinOnMap("pin1.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);
 else
 drawPinOnMap("map_pin.png", decodedpolylat.value(i).toString() + "," + decodedpolylng.value(i).toString(), fromPlace, mPinTypeMultiple, mListdata);

 mListPOIPrevious.append(mListdata);
 }
 mPolylineBuildingInfo.append(Coordinate(decodedpolylat.value(i).toDouble(), decodedpolylng.value(i).toDouble()));
 }
 QVariantMap mListdataTO;
 mListdataTO["NAME_E"] = toPlace;
 mListdataTO["Location"] = toPlace;
 mListdataTO["X_COORD"] = decodedpolylat.value(decodedpolylat.size() - 1).toString();
 mListdataTO["Y_COORD"] = decodedpolylng.value(decodedpolylat.size() - 1).toString();
 mListdataTO["TEL_NO"] = "";
 mListdataTO["FAX_NO"] = "";
 mListdataTO["EMAIL"] = "";
 mListdataTO["LICENSE_NO"] = "";
 mListdataTO["URL"] = "";
 mListdataTO["POBOX"] = "";
 mListPOIPrevious.append(mListdataTO);

 QString mType = checkInvalid(toPlace.replace(" ", ""));

 if (mType == "number") {
 drawPinOnMap("pin1.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
 } else {
 drawPinOnMap("map_pin.png", decodedpolylat.value(decodedpolylat.size() - 1).toString() + "," + decodedpolylng.value(decodedpolylat.size() - 1).toString(), toPlace, mPinTypeMultiple, mListdataTO);
 }

 GeoPolyline* mGeoPolygonBuildingInfo = new GeoPolyline();
 mGeoPolygonBuildingInfo->setGeoId("route_line");

 mGeoPolygonBuildingInfo->setLine(mPolylineBuildingInfo);
 StyleSheet styles;
 Style polylines;
 polylines.setEdgeSize(EdgeSize::Small);
 polylines.setFillColor(0x00FF0000);
 styles.addStyleForClass(mGeoPolygonBuildingInfo, polylines);
 myMapView->mapData()->setStyles(styles);
 myMapView->mapData()->add(mGeoPolygonBuildingInfo);

 mMapData->add(mGeoPolygonBuildingInfo);
 mPolylineData.clear();
 setZoomLevelForMap(mMapData);
 }
 */

void WebServicesAPI::SetisPOITextChanging(bool isTextChanging)
{
    isPOITextChanging = isTextChanging;
}

void WebServicesAPI::showMySystemDialog(QString body)
{
    SystemDialog *dialog = new SystemDialog(tr("Ok"));

    dialog->setBody(body);

    dialog->setEmoticonsEnabled(true);

    dialog->show();
}
/*
 * call google api  from ae if isFirst is true otherwise from all over the world.
 */
void WebServicesAPI::callGoogleReverceGeoCodeApi()
{

    m_active = true;
    emit activeChanged();

    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedGoolgeReverceGeoCodeApi(QNetworkReply*)));
    QString mURL;
    QString strLatitude = getValueFor("currentLatitude", "25.264637");
    QString strLongitude = getValueFor("CurrentLongitude", "55.312168");
    QString strLatLng = strLatitude + "," + strLongitude;
    QString mLanguage = getValueFor("mLanguageCode", "en");
//    mURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=23.022056,72.558729&language=en";
    mURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + strLatLng + "&language=" + mLanguage;
    manager->get(QNetworkRequest(QUrl(mURL)));

}
void WebServicesAPI::replyFinishedGoolgeReverceGeoCodeApi(QNetworkReply* replyApi)
{

    QByteArray replyBytes = replyApi->readAll();
    JsonDataAccess jda;

    QVariant mRouteDataResponse = jda.loadFromBuffer(replyBytes);

    QString lat = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("geometry").toMap().value("location").toMap().value("lat").toString();
    QString lng = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("geometry").toMap().value("location").toMap().value("lng").toString();

    QString isPartialMatch = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("formatted_address").toString();

    mGetMyLocation = isPartialMatch;

    emit getMyLocationDone();
    m_active = false;
    emit activeChanged();
}
/*
 * call google api  from ae if isFirst is true otherwise from all over the world.
 */
void WebServicesAPI::callGoogleApi(QString data, bool isFirst)
{
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    connect(manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(replyFinishedGoolgeApi(QNetworkReply*)));
    QString mURL;

    if (isFirst) {
        mURL = "https://maps.googleapis.com/maps/api/geocode/json?address=" + data + "&sensor=false&components=country:ae";
    } else {
        mURL = "https://maps.googleapis.com/maps/api/geocode/json?address=" + data + "&sensor=false";
    }

    manager->get(QNetworkRequest(QUrl(mURL)));

}
void WebServicesAPI::replyFinishedGoolgeApi(QNetworkReply* replyApi)
{

    QByteArray replyBytes = replyApi->readAll();
    JsonDataAccess jda;

    QVariant mRouteDataResponse = jda.loadFromBuffer(replyBytes);

    QString lat = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("geometry").toMap().value("location").toMap().value("lat").toString();
    QString lng = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("geometry").toMap().value("location").toMap().value("lng").toString();
    QString isPartialMatch = mRouteDataResponse.toMap().value("results").toList().value(0).toMap().value("partial_match").toString();
    if (lat == "23.424076" && lng == "53.847818" && isPartialMatch.length() > 0 && isPartialMatch == "true") {
        callGoogleApi(myPOILabel, false);
    } else {
        if (lat == "nan" || lng == "nan") {
            hasResponse = false;
            if (mPOIFrom == "searchOnMap") {
                showMySystemDialog(tr("No Data Found"));
            }
            m_active = false;
            emit activeChanged();
        } else {
            hasResponse = true;

            replyApi->deleteLater();
            mPOIdatalatng = lat + "," + lng;
            if (mPOIFrom == "searchOnMap") {
                setPoiInfoData(myPOILabel, "", "", "", "", "", "");
                GetBuildingOutLine_EntrancePoints(lat, lng, true, false);
            }
        }
        if (mPOIFrom == "searchDirection") {
            emit poidataloaded();
        }
    }
}
/*
 * draws outline when user long pressed on geolocation on map based on location point.
 * @param point location point when use long pressed location.
 */
void WebServicesAPI::longPressOnMap(bb::platform::geo::Point point)
{
    ClearMapdata();
    setPoiInfoData("", "", "", "", "", "", "");
// getCoordinateConversion(QString::number(point.latitude()), QString::number(point.longitude()), mStringType, "Convertor", false);
// GetBuildingOutLine_EntrancePoints(QString::number(point.latitude()), QString::number(point.longitude()), true, false);
}
bool WebServicesAPI::checkLandNumberValidatoin(QString mStringToValidate)
{
    /*QRegExp mexp("^(?:[0-9]{3}[-][0-9]{3,4})$");
     QRegExp mexp2("^(?:[0-9]{6,7})$");*/

    QRegExp mQRegExpForText1("^[0-9]{6,7}$");
    QRegExp mQRegExpForText2("(\\d{3})-(\\d{1})(\\d{2,3})");

    if (mQRegExpForText1.exactMatch(mStringToValidate) || mQRegExpForText2.exactMatch(mStringToValidate))
        return true;

    return false;

}
bool WebServicesAPI::isIsfromNearByDetails() const
{
    return isfromNearByDetails;
}

void WebServicesAPI::setIsfromNearByDetails(bool isfromNearByDetailstemp)
{
    isfromNearByDetails = isfromNearByDetailstemp;
}

QStringList WebServicesAPI::getmylist()
{
    templist.removeDuplicates();
    return templist;
}
void WebServicesAPI::SetMyCheckBoxList(QString myvalue, bool isChecked)
{
    templist.removeDuplicates();
    QVariantList mvarintlist;
    bool oks = true;
    bool *ok = &oks;

    mvarintlist.append(myvalue);

    if (isChecked) {
        mQStringListForCheckBox.append(myvalue);
        templist.append(mm_modelNearBy->data(mvarintlist).toMap().value("UAENG").toString() + "," + mm_modelNearBy->data(mvarintlist).toMap().value("X_COORD").toString() + "," + mm_modelNearBy->data(mvarintlist).toMap().value("Y_COORD").toString());

    } else {
        for (int i = 0; i < templist.length(); i++) {
            if (templist.at(i).contains(templist.value(myvalue.toInt(ok, 10)))) {
                templist.removeAt(i);
            }
        }

    }
}
void WebServicesAPI::dropMapPinForSelectedData(QVariantList mStringList)
{
    QString uaeng;
    QString lat;
    QString lng;

    mPinType = mPinTypeMultiple;
    mListPOIPrevious.clear();
    for (int i = 0; i < mStringList.size(); i++) {
        QVariantMap mmap = mStringList.value(i).toMap();
        QVariantMap myPinDatamap;

        myPinDatamap["X_COORD"] = mmap.value("lat").toString();
        myPinDatamap["Y_COORD"] = mmap.value("lng").toString();
        myPinDatamap["Location"] = mmap.value("title").toString();

        QString isFromMap = mmap.value("isFromMap").toString();
        myPinDatamap["isGreenPin"] = mmap.value("isFromMap").toString();
        mListPOIPrevious.append(myPinDatamap);

        if (isFromMap == "true") {
            drawPinOnMap("map_pin_near_by.png", mmap.value("lat").toString() + "," + mmap.value("lng").toString(), mmap.value("title").toString(), mPinTypeMultiple, myPinDatamap);
        } else {
            drawPinOnMap("pin2.png", mmap.value("lat").toString() + "," + mmap.value("lng").toString(), mmap.value("title").toString(), mPinTypeMultiple, myPinDatamap);
        }
    }
}
bool WebServicesAPI::checkisdirectionbuilding()
{
    return isdirectionBuidingAddress;
}

void WebServicesAPI::setcheckisdirectionbuilding(bool isdirectionBuidingAddressarg)
{
    isdirectionBuidingAddress = isdirectionBuidingAddressarg;
}
void WebServicesAPI::setmactive(bool mvalue)
{
    m_active = mvalue;
    emit activeChanged();
}
void WebServicesAPI::setMapSinglePinForSelectedData(QString lat, QString lng, QString location)
{

    mListForSinglePin.append(lat + lng + location);

}
QStringList WebServicesAPI::getMapSinglePinForSelectedData()
{
    return mListForSinglePin;
}
void WebServicesAPI::setpicturefromqml(QString url)
{
    isPic = url;

}
void WebServicesAPI::clearmyInfoPopupData()
{
    mapLabelText = "";
    emit getMapCaptionText();
    poiNameValue = "";
    emit poiNameDone();
    poiPhoneValue = "";
    emit poiPhoneDone();
    poiFaxValue = "";
    emit poiFaxDone();
    poiEmailValue = "";
    emit poiEmailDone();
    poiLicenseValue = "";
    emit poiLicenseDone();
    poiURLValue = "";
    emit poiURLDone();
    poiPOBoxValue = "";
    mPICTUREValue = "";
    emit mPICTUREDone();
    mLandNumberValue = "";
    emit mLandNumberDone();
    mEntranceValue = "";
    emit mEntranceDone();
    mROADNAMEEValue = "";
    QString ank = "";
    emit mROADNAMEENDone();

    mmCOMM_ENValue = "";
    emit mCOMM_ENDone();

    mmCOMM_ENValue = "";
    emit mCOMM_ENDone();

    mBUILDING_NOValue = "";
    emit mBUILDING_NODone();
}

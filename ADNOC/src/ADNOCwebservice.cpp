/*
 * ADNOCwebservice.cpp
 *
 *  Created on: Nov 6, 2014
 *      Author: tacme
 */

#include "ADNOCwebservice.hpp"
#include <QHttpMultiPart>
#include "StationListData.h"

#include "stdio.h"
#include <bb/cascades/QListDataModel>
#include <bb/data/DataSource>
#include <bb/cascades/XmlDataModel>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/ListView>
#include <bb/data/JsonDataAccess>
#include <QtCore/QFile>
#include <bb/system/SystemDialog>
#include <QtLocationSubset/QGeoCoordinate>
#include <bb/PpsObject>
#include <bb/system/LocaleHandler>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/ViewProperties>
#include <bb/platform/geo/BoundingBox.hpp>

#include <bb/cascades/ActivityIndicator>

#include <bb/cascades/Container>
#include <bb/cascades/DockLayout>
#include <bb/cascades/Page>
#include <bb/cascades/TitleBar>
#include <bb/cascades/TitleBarScrollBehavior>
#include <bb/cascades/Option>
#include <bb/cascades/Color>
#include <bb/cascades/Button>
#include <bb/cascades/StackLayout>
#include <bb/cascades/StackLayoutProperties>
#include <bb/cascades/DropDown>
#include <bb/cascades/ScrollView>
#include <bb/cascades/LayoutOrientation>
#include <bb/cascades/BaseObject>

using namespace bb::cascades;
using namespace bb::data;
using namespace QtMobilitySubset;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;

ADNOCwebservice::ADNOCwebservice(QObject* parent) :
        QObject(parent), m_succeeded(false), m_active(false), m_networkAccessManager(
                new QNetworkAccessManager(this)), m_modelAuctionList(
                new QListDataModel<QObject*>()), mm_model(
                new GroupDataModel(
                        QStringList() << "getTitle" << "getStationID" << "getArea" << "getZoneNo"
                                << "getDistance" << "getDescription" << "getID"
                                << "getGeoCoordinateX" << "getGeoCoordinateY" << "getPublished"
                                << "getCreatedDate" << "getCreatedBy" << "getUniqueName"))
{

    qmlRegisterType<StationListData>();

    bb::data::DataSource::registerQmlTypes();

    m_modelAuctionList->setParent(this);
    mm_model->setParent(this);
    bool ok = connect(&m_soap, SIGNAL(responseReady()), SLOT(onServiceResponse()));

    request = QNetworkRequest();
    mNetworkAccessManager = new QNetworkAccessManager(this);

    connect(mNetworkAccessManager, SIGNAL(finished(QNetworkReply*)), this,
            SLOT(requestFinished(QNetworkReply*)));

    Q_ASSERT(ok);
    Q_UNUSED(ok);

}
//! [0]

/**
 * PMOwebservice::temperature()
 *
 * Return QString, the currently set temperature for a selected city
 */
QString ADNOCwebservice::temperature() const
{
    return m_temperature;
}

/**
 * PMOwebservice::description()
 *
 * Return QString, the currently set description
 */
QString ADNOCwebservice::description() const
{
    return m_description;
}
bool ADNOCwebservice::succeeded() const
{
    return m_succeeded;
}

/**
 * PMOwebservice::error()
 *
 * Return QString, the error if the SOAP query wasn't successful
 */
QString ADNOCwebservice::error() const
{
    return m_error;
}

bool ADNOCwebservice::active() const
{
    return m_active;
}
bb::cascades::DataModel* ADNOCwebservice::model() const
{
    return mm_model;
}
bb::cascades::DataModel* ADNOCwebservice::modelPlateList() const
{
    return m_modelAuctionList;
}
QVariantList ADNOCwebservice::getQVariantListData()
{
    return mQVariantListData;
}
QVariantList ADNOCwebservice::getQVfacilityData()
{
    return mQVfacilityData;
}

void ADNOCwebservice::reset()
{
    m_temperature.clear();
    m_description.clear();

    emit temperatureChanged();
    emit descriptionChanged();
}

void ADNOCwebservice::getAllFacilitiesParent(const QString &language, const QString &notused, const QString &facilityType)
{
       currentWS = "getAllFacilitiesParent";

        QVariantList paramKeys;
        paramKeys.append("websiteID");
        paramKeys.append("languageID");
        paramKeys.append("facilityType");

        QVariantList paramValues;
        paramValues.append("1");
        paramValues.append(language);
        paramValues.append(facilityType);

        QString message = getWCFMessageString("GetAllFacilitiesParent", paramKeys, paramValues);
        QString action = "http://tempuri.org/ILocationService/GetAllFacilitiesParent";

        //QString host = "alameen.gov.ae";
        //QString prefix = "/mobileservices/NewsService.svc";

        QString host = "demoserver.tacme.net";
        QString prefix = "/AdnocDistTacsoft/Services/LocationService.svc";

        callSVC(action, host, prefix, message, false);
}

void ADNOCwebservice::parseAllFacilitiesParent(const QtSoapType &data)
{
     qDebug() << "parseAllFacilitiesParent";

      QVariantMap mListData;
      mQVfacilityData.clear();
      QString facilityString;
      facilityString.clear();
      facilityString = "";
      QString facilityStringUniq;
      facilityStringUniq.clear();
      facilityStringUniq = "";

      QtSoapStruct &soapStruct = (QtSoapStruct &) data;
      //int version = soapStruct["Version"].toInt();
      QtSoapArray &attributes = (QtSoapArray &) soapStruct["GetAllFacilitiesParentResult"];

      qDebug() << "facoility attributes" << attributes.count();

      for (int i = 0; i < attributes.count(); ++i) {
          //QtSoapStruct item = (QtSoapStruct&) attributes[i];
          QtSoapStruct &item = (QtSoapStruct &) attributes[i];
          qDebug() << "facility responce title: " << item["Title"].toString();
          qDebug() << "facility responce UniqueName: " << item["UniqueName"].toString();
          QtSoapStruct &dimention = (QtSoapStruct &) item["SubFacilities"];

                  qDebug() << "soap response facilities: " << dimention.count();
                  mListData.insert("hasSub", "false");
                  if(dimention.count()> 0)
                  {
                      mListData.insert("hasSub", "true");
                  }
                  facilityString = "";
                  facilityStringUniq = "";
                  for (int i = 0; i < dimention.count(); ++i) {
                      //QtSoapStruct &mainsubitem = (QtSoapStruct &) dimention[i];
                      QtSoapStruct &subItems = (QtSoapStruct &) dimention[i];
                      //QtSoapStruct &subItemsM = (QtSoapStruct &) subItems[i];
                      qDebug() << "soap response sub facilities : " <<subItems["Title"].toString();

                      facilityString += subItems["Title"].toString() +", ";
                      facilityStringUniq += subItems["UniqueName"].toString() +", ";
                  }


                  mListData.insert("facilityListString", facilityString);

                  mListData.insert("facilityListUniqe", facilityStringUniq);

                  mListData.insert("Title", item["Title"].toString());

                  mListData.insert("UniqueName", item["UniqueName"].toString());

                  mQVfacilityData.insert(0, mListData);
      }

      m_active = false;
      m_succeeded = true;
      emit activeChanged();
      emit dataLoadedthird();
}

void ADNOCwebservice::searchNearByLocation(const QString &latitude, const QString &longitude,
        const QString &language, const QString &category, const QString &viewType)
{
    currentWS = "searchNearByLocation";

    m_ServiceStationLISTVIEW = viewType;

    QVariantList paramKeys;
    paramKeys.append("Latitude");
    paramKeys.append("Longitude");
    paramKeys.append("count");
    paramKeys.append("LanguageID");
    paramKeys.append("websiteID");
    paramKeys.append("keyword");
    paramKeys.append("CategoryUniqueName");

    QVariantList paramValues;
    paramValues.append(latitude);
    paramValues.append(longitude);
    paramValues.append("1000");
    paramValues.append(language);
    paramValues.append("1");
    paramValues.append("");
    paramValues.append(category);

    QString message = getWCFMessageString("SearchNearByLocations", paramKeys, paramValues);
    QString action = "http://tempuri.org/ILocationService/SearchNearByLocations";

    //QString host = "alameen.gov.ae";
    //QString prefix = "/mobileservices/NewsService.svc";

    QString host = "demoserver.tacme.net";
    QString prefix = "/AdnocDistTacsoft/Services/LocationService.svc";

    callSVC(action, host, prefix, message, false);
}
void ADNOCwebservice::parseSearchNearByLocation(const QtSoapType &data)
{
    qDebug() << "parseSearchNearByLocation";

    QVariantMap mListData;
    mQVariantListData.clear();
    QString facilityString;
    facilityString.clear();
    facilityString = "";

    QVariantList facilityList;
    facilityList.clear();

    QtSoapStruct &soapStruct = (QtSoapStruct &) data;
    //int version = soapStruct["Version"].toInt();
    QtSoapArray &attributes = (QtSoapArray &) soapStruct["SearchNearByLocationsResult"];

    for (int i = 0; i < attributes.count(); ++i) {
        //QtSoapStruct item = (QtSoapStruct&) attributes[i];
        QtSoapStruct &item = (QtSoapStruct &) attributes[i];

        QtSoapStruct &dimention = (QtSoapStruct &) item["Facilities"];

        //qDebug() << "soap response facilities: " << dimention.count();
        facilityString = ""; facilityList.clear();
        for (int i = 0; i < dimention.count(); ++i) {
            //QtSoapStruct &mainsubitem = (QtSoapStruct &) dimention[i];
            QtSoapStruct &subItems = (QtSoapStruct &) dimention[i];
            //QtSoapStruct &subItemsM = (QtSoapStruct &) subItems[i];
            //qDebug() << "soap response facilities: " <<subItems["Title"].toString();
            facilityList.append(subItems["Title"].toString());
            facilityString += subItems["Title"].toString() +", ";
        }

        mListData.insert("facilityList", facilityList);

        mListData.insert("facilityListString", facilityString);


        QtSoapStruct &shifts = (QtSoapStruct &) item["Shifts"];
        QtSoapStruct &shiftsMain = (QtSoapStruct &) shifts["WorkingHours"];
       // qDebug() << "soap working hours: " <<shiftsMain["FromDay"].toString();
        mListData.insert("CloseTime", shiftsMain["CloseTime"].toString());
        mListData.insert("FromDay", shiftsMain["FromDay"].toString());
        mListData.insert("OpenTime", shiftsMain["OpenTime"].toString());
        mListData.insert("ToDay", shiftsMain["ToDay"].toString());


        mListData.insert("GeoCoordinateX", item["GeoCoordinateX"].toString());
        mListData.insert("GeoCoordinateY", item["GeoCoordinateY"].toString());
        mListData.insert("ID", item["ID"].toString());
        mListData.insert("UniqueName", item["UniqueName"].toString());
        mListData.insert("CategoriesUniqueNameList", item["CategoriesUniqueNameList"].toString());
        mListData.insert("CategoryDescription", item["CategoryDescription"].toString());
        mListData.insert("CategoryMainImage", item["CategoryMainImage"].toString());
        mListData.insert("CategoryMainImageFullURL", item["CategoryMainImageFullURL"].toString());
        mListData.insert("Distance", item["Distance"].toString());
        mListData.insert("Title", item["Title"].toString());
        mListData.insert("StationCode", item["StationCode"].toString());
        mListData.insert("Keywords", item["Keywords"].toString());
        mListData.insert("Phone", item["Phone"].toString());
        mQVariantListData.insert(0, mListData);
        //mlistSearchPOI.append(entry);
        mServiceStationSearchdata.insert(0,mListData);

        m_modelAuctionList->append(
                           new StationListData(item["GeoCoordinateX"].toString(), item["GeoCoordinateY"].toString(), item["ID"].toString(), item["UniqueName"].toString(), item["CategoriesUniqueNameList"].toString(),  item["CategoryDescription"].toString(),
                                   item["Phone"].toString(), item["CategoryMainImage"].toString(), item["CategoryMainImageFullURL"].toString(), item["Distance"].toString(), item["Title"].toString(), item["StationCode"].toString(), item["Keywords"].toString(), shiftsMain["CloseTime"].toString(), shiftsMain["FromDay"].toString(), shiftsMain["OpenTime"].toString(), shiftsMain["ToDay"].toString(), facilityString, "", "", "", "", "", "", "", "", "", "", this));

    }
    facilityString = "";

    mServiceStationData = mQVariantListData;

    qDebug() << "station stored data" << mServiceStationData;

    m_active = false;
    m_succeeded = true;
    emit activeChanged();
    emit dataLoadedSec();
}

void ADNOCwebservice::searchDataNearBylocation(QString words, const QString &searchType)
{
     //QVariantMap entry; // masfout
    //qDebug() << "searchDataNearBylocation called";
    //qDebug() << "searchDataNearBylocation called" +mServiceStationData.size();
    m_modelAuctionList->clear();
    mQVariantListData.clear();
    //qDebug() << "searchDataNearBylocation called" +mServiceStationData.size();
        for (qint64 i = 0; i < mServiceStationData.size(); i++) {
            QVariantMap mMap = mServiceStationData.value(i).toMap();

            QString name = mMap.value("Title").toString();
            QString stCode = mMap.value("StationCode").toString();

            qDebug() << "print all name from satation stored data" << stCode;

            if (name.contains(words, Qt::CaseInsensitive) || stCode.contains(words, Qt::CaseInsensitive)) {

                mQVariantListData.insert(0, mMap);
                m_modelAuctionList->append( new StationListData(mMap.value("GeoCoordinateX").toString(), mMap.value("GeoCoordinateY").toString(), mMap.value("ID").toString(), mMap.value("UniqueName").toString(), mMap.value("CategoriesUniqueNameList").toString(),  mMap.value("CategoryDescription").toString(),
                mMap.value("Phone").toString(), mMap.value("CategoryMainImage").toString(), mMap.value("CategoryMainImageFullURL").toString(), mMap.value("Distance").toString(), mMap.value("Title").toString(), mMap.value("StationCode").toString(), mMap.value("Keywords").toString(), mMap.value("CloseTime").toString(), mMap.value("FromDay").toString(), mMap.value("OpenTime").toString(), mMap.value("ToDay").toString(), mMap.value("facilityListString").toString(), "", "", "", "", "", "", "", "", "", "", this));
            }
        }

     if(searchType == "search")
     {
       emit dataLoadedSec();
     }
     else
     {
       emit dataLoaded();
     }
}
void ADNOCwebservice::searchNearByLocationFacilities(const QString &latitude, const QString &longitude,
        const QString &language, const QString &facilityArr, const QString &category, const QString &viewType)
{
    currentWS = "searchNearByLocationFacilities";

    m_ServiceStationLISTVIEW = viewType;

//split("/");
    QString facilityMessage;

    QStringList facilitySplit = facilityArr.split(",");

    qDebug() << "faclility array split" << facilitySplit;
    for (qint64 i = 0; i < facilitySplit.size(); i++) {
        if(facilitySplit[i] != "")
        {
        facilityMessage = facilityMessage + "<arr:string>"+facilitySplit[i]+"</arr:string>";
        }
    }

    QString methodName = "GetNearByLocationByFacilities";

    QString message;

                 message = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\" xmlns:arr=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\">";
                 message = message + "<soapenv:Header/>";
                 message = message + "<soapenv:Body>";
                 message = message + "<tem:GetNearByLocationByFacilities>";
                 message = message + "<tem:websiteID>1</tem:websiteID>";
                 message = message + "<tem:languageID>"+language+"</tem:languageID>";
                 message = message + "<tem:Facilities>" +facilityMessage+"</tem:Facilities>";
                 message = message + "<tem:Latitude>"+latitude+"</tem:Latitude>";
                 message = message + "<tem:Longitude>"+longitude+"</tem:Longitude>";
                 message = message + "<tem:count>1000</tem:count>";
                 message = message + "<tem:Keyword></tem:Keyword>";
                 message = message + "<tem:CategoryUniqueName>"+category+"</tem:CategoryUniqueName>";
                 message = message + "</tem:GetNearByLocationByFacilities>";
                 message = message + "</soapenv:Body>";
                 message = message + "</soapenv:Envelope>";


    QString action = "http://tempuri.org/ILocationService/GetNearByLocationByFacilities";

    QString host = "demoserver.tacme.net";
    QString prefix = "/AdnocDistTacsoft/Services/LocationService.svc";

    callSVC(action, host, prefix, message, false);
}

void ADNOCwebservice::parseSearchNearByLocationLIST()
{
    qDebug() << "parseSearchNearByLocation" +  mServiceStationData.size();

    qDebug() << mServiceStationData[0];


}

void ADNOCwebservice::getNewslistings(const QString &websiteID, const QString &languageID )
{
    currentWS = "getNewslistings";

    //m_ServiceStationLISTVIEW = viewType;

    QVariantList paramKeys;
    paramKeys.append("websiteID");
    paramKeys.append("languageID");
    paramKeys.append("keyword");

    QVariantList paramValues;
    paramValues.append(websiteID);
    paramValues.append(languageID);
    paramValues.append("");

    QString message = getWCFMessageString("SearchNews", paramKeys, paramValues);
    QString action = "http://tempuri.org/INewsService/SearchNews";

    QString host = "demoserver.tacme.net";
    QString prefix = "/AdnocDistTacsoft/Services/NewsService.svc";

    callSVC(action, host, prefix, message, false);
}
void ADNOCwebservice::parseNewslistings(const QtSoapType &data)
{
    qDebug() << "parseNewslistings";

    QVariantMap mListData;
    m_modelAuctionList->clear();
    mQVariantListData.clear();

    QtSoapStruct &soapStruct = (QtSoapStruct &) data;
    //int version = soapStruct["Version"].toInt();
    QtSoapArray &attributes = (QtSoapArray &) soapStruct["SearchNewsResult"];

    for (int i = 0; i < attributes.count(); ++i) {
        //QtSoapStruct item = (QtSoapStruct&) attributes[i];  //
        QtSoapStruct &item = (QtSoapStruct &) attributes[i];

        qDebug() << "soap response item EmplOnBehalfWS: " << item["MainImage"].toString();

               mListData.insert("Title", item["Title"].toString());
               mListData.insert("Summary", item["Summary"].toString());
               mListData.insert("NewsDate", item["NewsDate"].toString());
               mListData.insert("MainImage", item["MainImage"].toString());
               mListData.insert("MainImageFullURL", item["MainImageFullURL"].toString());
               mListData.insert("ID", item["ID"].toString());
               mQVariantListData.insert(0, mListData);
    }

    m_active = false;
    m_succeeded = true;
    emit activeChanged();
    emit dataLoadedfour();
}
void ADNOCwebservice::getContastusList(const QString &websiteID, const QString &languageID )
{
    currentWS = "getContastusList";

    //m_ServiceStationLISTVIEW = viewType;

    QVariantList paramKeys;
    paramKeys.append("languageID");
    paramKeys.append("websiteID");
   // paramKeys.append("keyword");

    QVariantList paramValues;
    paramValues.append(websiteID);
    paramValues.append(languageID);
    //paramValues.append("");

    QString message = getWCFMessageString("GetAllEmergencyContact", paramKeys, paramValues);
    QString action = "http://tempuri.org/IEmergencyContactService/GetAllEmergencyContact";

    QString host = "demoserver.tacme.net";
    QString prefix = "/AdnocDistTacsoft/Services/EmergencyContactService.svc";

    callSVC(action, host, prefix, message, false);
}
void ADNOCwebservice::parseContastusList(const QtSoapType &data)
{
    qDebug() << "parseContastusList";

    QVariantMap mListData;
    m_modelAuctionList->clear();
    mQVariantListData.clear();

    QtSoapStruct &soapStruct = (QtSoapStruct &) data;
    //int version = soapStruct["Version"].toInt();
    QtSoapArray &attributes = (QtSoapArray &) soapStruct["GetAllEmergencyContactResult"];

    QVariantList contactusKeys;
    contactusKeys.append("Head Office - Al Salam"); contactusKeys.append("Al Ain Office - Head Office"); contactusKeys.append("Western Region Office - Beda Zayad");
    contactusKeys.append("Sharjah Office - Buaira Corniche");contactusKeys.append("Feedback");

    //QtSoapArray &contactTitle = "<a:city z:Id='17'>Abu Dhabi</a:city>";
    m_modelAuctionList->append(
                               new StationListData("", "", "", "", "",  "",
                                       "", "", "", "", "", contactusKeys[4].toString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this));


    for (int i = 0; i < attributes.count()+1; ++i) {
        //QtSoapStruct item = (QtSoapStruct&) attributes[i];
        QtSoapStruct &item = (QtSoapStruct &) attributes[i];

            if (i == attributes.count()) {
                mListData.insert("Title", contactusKeys[4].toString());

                mQVariantListData.insert(0, mListData);
            } else {
                qDebug() << "soap response item contact us door: " << item["Title"].toString();
                mListData.insert("Title", item["Title"].toString());
                mListData.insert("SubTitle", item["SubTitle"].toString());
                mListData.insert("ContactAddress", item["ContactAddress"].toString());
                mListData.insert("POBOX", item["POBOX"].toString());
                mListData.insert("city", item["city"].toString());
                mListData.insert("country", item["country"].toString());
                mListData.insert("Phone", item["Phone"].toString());
                mListData.insert("Fax", item["Fax"].toString());
                mListData.insert("Email", item["Email"].toString());
                mListData.insert("GeoCoordinateX", item["GeoCoordinateX"].toString());
                mListData.insert("GeoCoordinateY", item["GeoCoordinateY"].toString());
                mQVariantListData.insert(0, mListData);
            }


        // m_modelAuctionList->append(
        //                   new StationListData(item["Title"].toString(), item["SubTitle"].toString(), item["ContactAddress"].toString(), item["POBOX"].toString(), item["city"].toString(),  item["country"].toString(),
        //                          item["Phone"].toString(), item["Fax"].toString(), item["Email"].toString(), item["GeoCoordinateX"].toString(), item["GeoCoordinateY"].toString(), contactusKeys[i].toString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", this));

    }


    m_active = false;
    m_succeeded = true;
    emit activeChanged();
    emit dataLoadFinal();
}

void ADNOCwebservice::statisticsADNOC(const QString &postData, const QString &category, const QString &action)
{
         currentWS = "statisticsADNOC";

        QVariantList paramKeys;
        paramKeys.append("category");
        paramKeys.append("action");
        paramKeys.append("value");

        QVariantList paramValues;
        paramValues.append(category);
        paramValues.append(action);
        paramValues.append(postData);

        QString message = getWCFMessageString("LogNewEventTrack", paramKeys, paramValues);
        QString action1 = "http://tempuri.org/IHelperService/LogNewEventTrack";

        //QString action1 = "http://tempuri.org/IHelperService/SendFeedbackToClient";

        //QString host = "alameen.gov.ae";
        //QString prefix = "/mobileservices/NewsService.svc";

        QString host = "demoserver.tacme.net";
        QString prefix = "/AdnocDistTacsoft/Services/HelperService.svc";

        callSVC(action1, host, prefix, message, false);
} //parseMediagalleryImages

void ADNOCwebservice::getMediagalleryImages(const QString &language)
{
         currentWS = "getMediagalleryImages";

        QVariantList paramKeys;
        paramKeys.append("websiteID");
        paramKeys.append("languageID");
        paramKeys.append("uniqueName");

        QVariantList paramValues;
        paramValues.append("1");
        paramValues.append(language);
        paramValues.append("home.screen.images");

        QString message = getWCFMessageString("GetMediaGalleryByCategoryUniqueName", paramKeys, paramValues);
        QString action = "http://tempuri.org/IMediaGalleryVadService/GetMediaGalleryByCategoryUniqueName";

        //QString host = "alameen.gov.ae";
        //QString prefix = "/mobileservices/NewsService.svc";

        QString host = "demoserver.tacme.net";
        QString prefix = "/AdnocDistTacsoft/Services/MediaGalleryVadService.svc";

        callSVC(action, host, prefix, message, false);
} //parseMediagalleryImages

void ADNOCwebservice::parseMediagalleryImages(const QtSoapType &data)
{
    qDebug() << "parseMediagalleryImages";

    QVariantMap mListData;
    m_modelAuctionList->clear();
    mQVariantListData.clear();

    QtSoapStruct &soapStruct = (QtSoapStruct &) data;
    //int version = soapStruct["Version"].toInt();
    QtSoapArray &attributes = (QtSoapArray &) soapStruct["GetMediaGalleryByCategoryUniqueNameResult"];

    for (int i = 0; i < attributes.count(); ++i) {
        //QtSoapStruct item = (QtSoapStruct&) attributes[i];
        QtSoapStruct &item = (QtSoapStruct &) attributes[i];

        qDebug() << "soap response item MainImageFullURL: " << item["MainImageFullURL"].toString();
        mListData.insert("MainImageFullURL", item["MainImageFullURL"].toString());
        mQVariantListData.insert(0, mListData);

    }

    m_active = false;
    m_succeeded = true;
    emit activeChanged();
    emit dataLoaded();
}
void ADNOCwebservice::submitFeedbackForm(const QString &fileIMG1, const QString &fileIMG2, const QString &fileVide1, const QString &name, const QString &email, const QString &phone, const QString &feedType, const QString &location, const QString &subject, const QString &description, const QString &language)
{
         currentWS = "submitFeedbackForm";

         QByteArray fileContent;
         QString data1="";
         QString data2="";
         QString data3 ="";
         QString uploadMessage;


         QString workingDir = QDir::currentPath();

         if(fileIMG1 == "" && fileIMG2 == "" && fileVide1 == "")
         {
                                uploadMessage = "<prod:InfoFile>";
                                uploadMessage = uploadMessage + "<prod:FileExtension></prod:FileExtension>";
                                uploadMessage = uploadMessage + "<prod:bytestream></prod:bytestream>";
                                uploadMessage = uploadMessage + "</prod:InfoFile>";
         }

         if(fileIMG1 != "")
         {
            QFile* file = new QFile(fileIMG1);
            bool ok = file->open(QIODevice::ReadOnly);
            if (!ok) {
                qDebug() << "error read image";
                return;
            }
            fileContent = file->readAll().toBase64();

            data1 = fileContent;

            uploadMessage = uploadMessage +"<prod:InfoFile>";
            uploadMessage = uploadMessage +"<prod:FileExtension>png</prod:FileExtension>";
            uploadMessage = uploadMessage +"<prod:bytestream>"+data1+"</prod:bytestream>";
            uploadMessage = uploadMessage +"</prod:InfoFile>";

         }

        if (fileIMG2 != "") {

            QFile* file = new QFile(fileIMG2);
            bool ok = file->open(QIODevice::ReadOnly);
            if (!ok) {
                qDebug() << "error read image";
                return;
            }
            fileContent = file->readAll().toBase64();

            data2 = fileContent;

            uploadMessage = uploadMessage + "<prod:InfoFile>";
            uploadMessage = uploadMessage + "<prod:FileExtension>png</prod:FileExtension>";
            uploadMessage = uploadMessage + "<prod:bytestream>"+data2+"</prod:bytestream>";
            uploadMessage = uploadMessage + "</prod:InfoFile>";

        }

        if (fileVide1 != "") {

            QFile* file = new QFile(fileVide1);
            bool ok = file->open(QIODevice::ReadOnly);
            if (!ok) {
                qDebug() << "error read image";
                return;
            }
            fileContent = file->readAll().toBase64();

            data3 = fileContent;

            uploadMessage = uploadMessage + "<prod:InfoFile>";
            uploadMessage = uploadMessage + "<prod:FileExtension>png</prod:FileExtension>";
            uploadMessage = uploadMessage + "<prod:bytestream>"+data3+"</prod:bytestream>";
            uploadMessage = uploadMessage + "</prod:InfoFile>";

        }





         QString methodName = "SendFeedbackToClient";

         QString message;
         /* message =
                     "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\" xmlns:prod=\"http://schemas.datacontract.org/2004/07/Prodigy.Services\">";
             message = message + "<soap:Header/>";
             message = message + "<soap:Body><tem:" + methodName + ">";
             message = message + "<tem:infoFiles>"+uploadMessage+"</tem:infoFiles>";
             message = message + "<tem:clientToNotify>1</tem:clientToNotify>";
             message = message + "<tem:Name>"+name+"</tem:Name>";
             message = message + "<tem:Email>"+email+"</tem:Email>";
             message = message + "<tem:Phone>"+phone+"</tem:Phone>";
             message = message + "<tem:FeedType>"+feedType+"</tem:FeedType>";
             message = message + "<tem:Location>"+location+"</tem:Location>";
             message = message + "<tem:subject>"+subject+"</tem:subject>";
             message = message + "<tem:description>"+description+"</tem:description>";
             message = message + "<tem:LanguageID>"+language+"</tem:LanguageID>";
             message = message + "<tem:WebsiteID>1</tem:WebsiteID>";
             message = message + "</tem:" + methodName + "></soap:Body></soap:Envelope>";*/

             message ="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\" xmlns:prod=\"http://schemas.datacontract.org/2004/07/Prodigy.Services\">";
             message = message + "<soapenv:Header/>";
             message = message + "<soapenv:Body>";
             message = message + "<tem:SendFeedbackToClient>";
             message = message + "<tem:infoFiles>"+uploadMessage+"</tem:infoFiles>";
             message = message + "<tem:clientToNotify>1</tem:clientToNotify>";
             message = message + "<tem:Name>"+name+"</tem:Name>";
             message = message + "<tem:Email>"+email+"</tem:Email>";
             message = message + "<tem:Phone>"+phone+"</tem:Phone>";
             message = message + "<tem:FeedType>"+feedType+"</tem:FeedType>";
             message = message + "<tem:Location>"+location+"</tem:Location>";
             message = message + "<tem:subject>"+subject+"</tem:subject>";
             message = message + "<tem:description>"+description+"</tem:description>";
             message = message + "<tem:LanguageID>"+language+"</tem:LanguageID>";
             message = message + "<tem:WebsiteID>1</tem:WebsiteID>";
             message = message + "</tem:SendFeedbackToClient>";
             message = message + "</soapenv:Body>";
             message = message + "</soapenv:Envelope>";
        // QString message = getWCFMessageString("SendFeedbackToClient", paramKeys, paramValues);
        QString action = "http://tempuri.org/IHelperService/SendFeedbackToClient";

        QString host = "demoserver.tacme.net";
        QString prefix = "/AdnocDistTacsoft/Services/HelperService.svc";

        callSVC(action, host, prefix, message, false);
} //parseMediagalleryImages



QString ADNOCwebservice::getWCFMessageString(const QString &methodName,
        const QVariantList &paramKeys, const QVariantList &paramValues)
{

    QString message;
    message =
            "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://tempuri.org/\">";
    message = message + "<soap:Header/>";
    message = message + "<soap:Body><" + methodName + ">";

    for (int i = 0; i < paramKeys.size(); i++) {
        QString key = paramKeys[i].toString();
        QString val = paramValues[i].toString();
        message = message + "<" + key + ">" + val + "</" + key + ">";
    }
    message = message + "</" + methodName + "></soap:Body></soap:Envelope>";

    setParcebleString = message;

    return setParcebleString;

}  //

void ADNOCwebservice::callSVC(const QString &action, const QString &host, const QString &prefix,
        const QString &request, const bool &isSecure)
{

    qDebug() << " action = " << action;
    qDebug() << " host = " << host;
    qDebug() << " prefix = " << prefix;
    qDebug() << " request = " << request + '/n';

    if (m_active)
        return;

    m_active = true;
    emit activeChanged();

    m_succeeded = false;

    m_soap.setAction(action);
    m_soap.setHost(host, isSecure);
   // m_soap.setHost(host,8085);

    //QtSoapMessage request;

    QtSoapMessage data;

    // Submit the method request to the web service.
    //   m_soap.submitRequest(request, "/WeatherWS/Weather.asmx");

    m_soap.submitRequest(data, prefix, request, true);

}
void ADNOCwebservice::onServiceResponse()
{
    const QtSoapMessage& response = m_soap.getResponse();

    qDebug() << "Responce Data main= >" << response.returnValue().toString();
    qDebug() << "Responce currentWS = >" << currentWS;
    QString mData = response.returnValue().toString();

    if (currentWS == "searchNearByLocation") {

        if(m_ServiceStationLISTVIEW == "MAP")
        {
          parseSearchNearByLocation(response.method());
        }
    }
    else if(currentWS == "getAllFacilitiesParent")
    {
        parseAllFacilitiesParent(response.method());
    } //getNewslistings
    else if(currentWS == "getNewslistings")
    {
        parseNewslistings(response.method());
    } //getContastusList
    else if(currentWS == "getContastusList")
    {
        parseContastusList(response.method());
    } //getMediagalleryImages
    else if(currentWS == "getMediagalleryImages")
    {
        parseMediagalleryImages(response.method());
    } //searchNearByLocationFacilities
    else if(currentWS == "submitFeedbackForm")
    {
           m_active = false;
           m_succeeded = true;
           emit activeChanged();
           emit dataLoaded();
    }
    else if (currentWS == "searchNearByLocationFacilities") {
        parseSearchNearByLocation(response.method());
    } //submitFeedbackForm
    if (response.isFault()) {
        m_error = tr("Query failed: %1").arg(response.faultString().value().toString());
        emit statusChanged();

        m_active = false;
        emit activeChanged();

        emit complete();
        return;
    }

    // Extract the return value from this method response, check for
    // errors.
    const QtSoapType& responseValue = response.returnValue();
    if (!responseValue.isValid()) {
        m_error = tr("Query failed: invalid return value");
        emit statusChanged();

        m_active = false;
        emit activeChanged();

        emit complete();
        return;
    }

    // response.returnValue();

    if (QString::compare("true", responseValue["Success"].toString(), Qt::CaseInsensitive) == 0) {

        m_succeeded = true;
        m_error.clear();

        qDebug() << "Responce Data = >" << response.returnValue().toString();

        emit descriptionChanged();

    } else {
        m_succeeded = false;
        m_error = responseValue["ResponseText"].toString();
    }

    emit statusChanged();

    m_active = false;
    emit activeChanged();

    emit complete();
}


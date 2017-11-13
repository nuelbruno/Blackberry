/*
 * ADNOCwebservice.hpp
 *
 *  Created on: Nov 6, 2014
 *      Author: tacme
 */

#ifndef ADNOCWEBSERVICE_HPP_
#define ADNOCWEBSERVICE_HPP_

#include "qtsoap/qtsoap.h"



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
#include <bb/data/XmlDataAccess>
#include <bps/bps.h>
#include <bps/geolocation.h>
#include <QDebug>

#include <bb/cascades/Container>
#include <bb/cascades/Button>
#include <bb/cascades/StackLayoutProperties>

#include <QPointer>
#include <bb/PpsObject>

#include <QtLocationSubset/qgeopositioninfo.h>
#include <QtLocationSubset/qgeopositioninfosource.h>

#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/ViewProperties>


using namespace bb::system;
using namespace QtMobilitySubset;

#include <QtCore/QObject>

class ADNOCwebservice : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(bool succeeded READ succeeded NOTIFY statusChanged)
    Q_PROPERTY(QString error READ error NOTIFY statusChanged)
    Q_PROPERTY(bool active READ active NOTIFY activeChanged)

    Q_PROPERTY(bb::cascades::DataModel* model READ model CONSTANT)
    Q_PROPERTY(bb::cascades::DataModel* modelPlateList READ modelPlateList CONSTANT)


public:
       ADNOCwebservice(QObject* parent = 0);

       /*
        * Retrieves the temperature from the previous request
        */
       QString temperature() const;

       /*
        * Retrieves the description from the previous request
        */
       QString description() const;

       /*
        * Returns whether the previous request succeeded or failed
        */
       bool succeeded() const;

       /*
        * Retrieves the error string from the previous request if one occurred
        * Check getSucceeded() first
        */
       QString error() const;

       bool active() const;
       Q_INVOKABLE QVariantList getQVariantListData();
       Q_INVOKABLE QVariantList getQVfacilityData();
       Q_INVOKABLE QString getWCFMessageString(const QString &methodName,const QVariantList &paramKeys,const QVariantList &paramValues);



public Q_SLOTS:
    /*
     * Retrieves the weather information for the specified zip code (US only)
     *
     */
    //void requestAboutusTab(const QString &uniqueName,const QString &langId);

     /*
     * Clears the internal state of the weather service object.
     */
    void reset();

    // New data
    void getAllFacilitiesParent(const QString &language, const QString &notused, const QString &facilityType);

    void searchNearByLocation(const QString &latitude, const QString &longitude, const QString &language,
            const QString &category, const QString &viewType);
    void parseSearchNearByLocation(const QtSoapType &data);

    void parseSearchNearByLocationLIST();

    void parseAllFacilitiesParent(const QtSoapType &data);

    void searchDataNearBylocation(QString words, const QString &searchType);

    void getNewslistings(const QString &websiteID, const QString &languageID );

    void parseNewslistings(const QtSoapType &data);

    void getContastusList(const QString &websiteID, const QString &languageID );

    void parseContastusList(const QtSoapType &data);

    void getMediagalleryImages(const QString &language);

    void parseMediagalleryImages(const QtSoapType &data);

    void submitFeedbackForm(const QString &fileIMG1, const QString &fileIMG2, const QString &fileVide1, const QString &Name, const QString &Email, const QString &Phone, const QString &FeedType, const QString &Location, const QString &subject, const QString &description, const QString &language);

    void searchNearByLocationFacilities(const QString &latitude, const QString &longitude,
            const QString &language, const QString &facilityArr, const QString &category, const QString &viewType);

    void statisticsADNOC(const QString &postData, const QString &category, const QString &action);

Q_SIGNALS:
    /*
     * The complete signal is emitted when the request to the webservice is done
     */
    void complete();

    void dataLoaded();


        void dataLoadedSec();

        void dataLoadedthird();

        void dataLoadedfour();

        void dataLoadAlert();

        void dataLoadFinal();


    void temperatureChanged();
    void descriptionChanged();
    void statusChanged();
    void activeChanged();

private Q_SLOTS:
    /*
     * Handler for SOAP request response
     */
    void onServiceResponse();

    //void postFinished();

    //void requestFinished(QNetworkReply* reply);
    void callSVC(const QString &xmlData, const QString &host,
                       const QString &prefix, const QString &request,
                       const bool &isSecure);

private:

    QString setParcebleString ;
    QString currentWS;
    QString strAuctionNo;

    //Container *rootContainer;

    bb::cascades::DataModel* modelPlateList() const;
    bb::cascades::QListDataModel<QObject*>* m_modelAuctionList;

    bb::cascades::DataModel* model() const;
    bb::cascades::GroupDataModel *mm_model;

    QNetworkAccessManager *mNetworkAccessManager;
    QNetworkRequest request;

    QVariantList mQVariantListData;

    QVariantList mQVfacilityData;

    QNetworkAccessManager* m_networkAccessManager;



    QString m_temperature;       // temperature in F and C
    QString m_description;       // description of the weather
    QString m_error;             // error string if one occurred
    bool m_succeeded;            // flag to determine whether request succeeded
    bool m_active;               // flag to determine whether a request is running
    QtSoapHttpTransport m_soap;  // soap transport
    QString responseStatusValue;

    QString m_ServiceStationLISTVIEW;

    QVariantList mServiceStationData;

    QVariantList mServiceStationSearchdata;

    //AbstractPane *root;
    bb::cascades::maps::MapView* mapView;
    //MapView *myMapView;

};





#endif /* ADNOCWEBSERVICE_HPP_ */

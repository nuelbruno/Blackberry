/*
 * ADNOC.cpp
 *
 *  Created on: Nov 6, 2014
 *      Author: tacme
 */

#include "ADNOC.hpp"


#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/UIToolkitSupport>
#include <bb/data/DataSource>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/MapData>
#include <bb/cascades/maps/DataProvider>
#include <bb/platform/geo/Point>
#include <bb/platform/geo/GeoLocation>
#include <bb/platform/geo/Marker>
#include <bb/platform/geo/Polyline>
#include <bb/platform/geo/GeoPolyline>
#include <bb/platform/geo/GeoPolygon>
#include <bb/platform/geo/Geographic>

#include <bb/system/InvokeAction>
#include <bb/system/InvokeQueryTargetsReply>
#include <bb/system/InvokeQueryTargetsRequest>
#include <bb/system/InvokeReply>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeTarget>
#include <bb/system/InvokeTargetReply>
#include <bb/system/SystemToast>

#include <bb/cascades/Invocation>

using namespace bb::cascades;
using namespace QtMobilitySubset;
using namespace bb::data;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;


ADNOC::ADNOC(QObject *parent) {
    // prepare the localization
    //m_pTranslator = new QTranslator(this);
   // m_pLocaleHandler = new LocaleHandler(this);



    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("_ADNOC", this);

    QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_mapViewTest", new MapViewDemo());


    // Create root object for the UI
    root = qml->createRootObject<AbstractPane>();
    //AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    mInvokeManager = new InvokeManager(this);

    initNetworkConnection();
    startGPS();
}

void ADNOC::clearPins(QObject* mapObject) {

    //MapView* myMapView = qobject_cast<MapView*>(mapObject);

    QObject* mapViewAsQObject = root->findChild<QObject*>("mapview");
    if (mapViewAsQObject) {
                mapView = qobject_cast<bb::cascades::maps::MapView*>(mapViewAsQObject);
                qDebug()<< "mapview cpp" << mapView->mapData();
                mapView->mapData()->defaultProvider()->clear();
    }

}

// ####### NEtwork connection checking ############  //
void ADNOC::initNetworkConnection() {
    statusEventHandler = new StatusEventHandler();
    connect(statusEventHandler, SIGNAL(networkStatusUpdated(bool, QString)),this, SLOT(networkStatusUpdateHandler(bool, QString)));
}
void ADNOC::networkStatusUpdateHandler(bool status, QString type) {

    if (status) {
        m_Network = status;
    } else {
        m_Network = status;
    }
    emit networkStateChanged();
    qDebug() << "Network Status:" << m_Network;
    qDebug() << "Network Type:" << type;

}
bool ADNOC::isNetworkAvailable() {

    qDebug() << "isNetworkAvailable :" << m_Network;
    return m_Network;

}
// ###### language change code ###################   //
void ADNOC::initLocalization(QTranslator* translator) {
    // remember current locale set
    mCurrentLocale = QLocale().name();
    qDebug() << "initLocalization: " << mCurrentLocale;
    mTranslator = translator;
    // watch if user changes locale from device settings
    LocaleHandler* mLocaleHandler;
    mLocaleHandler = new LocaleHandler(this);
    // connect the handler
    connect(mLocaleHandler, SIGNAL(systemLanguageChanged()), this,
            SLOT(localeChanged()));
    updateLocale(getValueFor("mLanguageCode", "en"));

}
QString ADNOC::getCurrentLanguage() {
    qDebug() << "OpenDataSpaceApp getCurrentLanguage: " << mCurrentLocale;
    QLocale *loc = new QLocale(mCurrentLocale);
    return loc->languageToString(loc->language());
}
/**
 * App::updateLocale(QString locale)
 *
 * Update view content basing on the given locale.
 *
 */
void ADNOC::updateLocale(QString locale) {

    // if locale is empty - refresh current. otherwise change the local
    if (!locale.trimmed().isEmpty() && mCurrentLocale != locale) {
        mCurrentLocale = locale;

        qDebug() << "updating UI to language: " << mCurrentLocale;
        QString filename = QString("ADNOC_%1").arg(mCurrentLocale);

        if (mTranslator->load(filename, "app/native/qm")) {
            Application::instance()->removeTranslator(mTranslator);
            Application::instance()->installTranslator(mTranslator);
        }
        qDebug() << "after init locale: " << mCurrentLocale;
    }

    if (mCurrentLocale == "ar_EG" || mCurrentLocale == "ar") {
        saveValueFor("mLanguageCode", "ar");
        qDebug() << "tacme...2 ar";
    }
    if (mCurrentLocale == "en_US" || mCurrentLocale == "en") {
        saveValueFor("mLanguageCode", "en");
        qDebug() << "tacme...2 en";
    }

}
/**
 *
 * App::getCurrentLocale()
 *
 * Retrieve the current locale.
 */
QString ADNOC::getCurrentLocale() {
    qDebug() << "getCurrentLocale: " << mCurrentLocale;
    return mCurrentLocale;
}

// handles SLOT from Locale Chaned by user at Device
void ADNOC::localeChanged() {

    updateLocale(QLocale().name());
}

void ADNOC::saveValueFor(const QString &objectName, const QString &inputValue) {
    QSettings settings; // A new value is saved to the application settings object.
    settings.setValue(objectName, QVariant(inputValue));
}
QString ADNOC::getValueFor(const QString &objectName,
        const QString &defaultValue) {
    QSettings settings;
    if (settings.value(objectName).isNull()) { // If no value has been saved return the value.
        return defaultValue;
    }

    return settings.value(objectName).toString(); // Otherwise return the value stored in the settings object.
}

void ADNOC::onFullscreen() {
    qDebug() << "full  :" << getCurrentLocale();
//  qDebug() <<"full sreen 2 :" << getValueFor("mCurrentLanguage","") ;
//  if(getValueFor("mCurrentLanguage","")==getCurrentLocale()){
    QString mLastLang = getValueFor("mLastLang", "ar_EG");

    if (mLastLang == getCurrentLocale()) {

    }
    else {
        saveValueFor("mLastLang", getCurrentLocale());
        QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
        qml->setContextProperty("_ADNOC", this);
        // create root object for the UI
        root = qml->createRootObject<AbstractPane>();
        // set created root object as a scene
        Application::instance()->setScene(root);
        mInvokeManager = new InvokeManager(this);
        // Check Network connection in Background
        initNetworkConnection();
        startGPS();
    }
}
void ADNOC::positionUpdated(QGeoPositionInfo geoPositionInfo) {

//  qDebug() << "Position updated :" << geoPositionInfo;

    if (geoPositionInfo.isValid()) {
        // We've got the position. No need to continue the listening.
        locationDataSource->stopUpdates();

        // Save the position information into a member variable
        myPositionInfo = geoPositionInfo;

        // Get the current location as latitude and longitude
        QGeoCoordinate geoCoordinate = geoPositionInfo.coordinate();
        qreal latitude = geoCoordinate.latitude();
        qreal longitude = geoCoordinate.longitude();

        qDebug()
                << QString("Latitude: %1 Longitude: %2").arg(latitude).arg(
                        longitude);

        saveValueFor("latitude", QString("%1").arg(latitude));
        saveValueFor("longitude", QString("%1").arg(longitude));

    }

}
void ADNOC::startGPS() {

    qDebug() << "startGPS.....";

    // Obtain the location data source if it is not obtained already
    if (!locationDataSource) {
        locationDataSource = QGeoPositionInfoSource::createDefaultSource(this);

        // position is updated, the positionUpdated function is called
        connect(locationDataSource, SIGNAL(positionUpdated(QGeoPositionInfo)),
                this, SLOT(positionUpdated(QGeoPositionInfo)));

        // Start listening for position updates
        locationDataSource->startUpdates();
    }
}

/*void ADNOC::manipulateMapView()
{
        Polyline marchPoly;
        marchPoly.append( Coordinate( 45.34160960994857,
                                     -75.91488771580505 ) );
        marchPoly.append( Coordinate( 45.34187180699856,
                                     -75.91444157785021 ) );
        marchPoly.append( Coordinate( 45.34213741045421,
                                     -75.9147878149265 ) );
        marchPoly.append( Coordinate( 45.3418633664853,
                                     -75.91522259607544 ) );
        GeoPolygon* march = new GeoPolygon( "bb march" );
        march->setName( "BB March" );
        march->setOuterBoundary( marchPoly );
        //QObject *newcontaioner1 = root->findChild<QObject*>("mapviewVehicle");
        //MapView* mapview = qobject_cast<MapView*>(mapObject);
        //mapview->setProperty("mapData", "");
        //mapview->mapData()->add( march );
}*/

/*
 * Shares the any data by invoking facebook .
 * @param data data to share on facebook.
 */
void ADNOC::shareOnFB(QString data)
{

    qDebug() << "share data : " << data;
    InvokeRequest invokeRequest;
    invokeRequest.setTarget("Facebook");
    invokeRequest.setAction("bb.action.SHARE");
//  invokeRequest.setUri("data://"+data);
    invokeRequest.setData(data.toUtf8());
    invokeRequest.setMimeType("text/plain");
    mInvokeManager->invoke(invokeRequest);
}
/*
 * Shares the any data by invoking Twitter .
 * @param data data to share on Twitter.
 */
void ADNOC::shareOnTwitter(QString data)
{
    InvokeRequest invokeRequest;
    invokeRequest.setTarget("Twitter");
    invokeRequest.setAction("bb.action.SHARE");
    invokeRequest.setData(data.toUtf8());
    invokeRequest.setMimeType("text/plain");
    mInvokeManager->invoke(invokeRequest);
}
/*
 * opens email composer view the any specified data .
 * @param data data to share on Email.
 */
void ADNOC::shareOnEmail(QString data)
{
    InvokeRequest invokeRequest;
    invokeRequest.setTarget("sys.pim.uib.email.hybridcomposer");
    invokeRequest.setAction("bb.action.SHARE");
    invokeRequest.setData(data.toUtf8());
    invokeRequest.setMimeType("text/plain");
    mInvokeManager->invoke(invokeRequest);
}

void ADNOC::manipulatePhoto(const QString &fileName, int imageCount, int typeMedia)
{


    qDebug() << "fileName test setup---------:" << fileName;
    qDebug() << "fileName timagecount---------:" << imageCount;
    qDebug() << "fileName dele imag count1---------:" << typeMedia;

    QString workingDir = QDir::currentPath();


        if(imageCount == 1)
        {
            QObject *newcontaioner1 = root->findChild<QObject*>("photo1Container");
            //qDebug() << "child container---------:" << newcontaioner1;
            newcontaioner1->setProperty("visible", "true");
            QObject *newButton = root->findChild<QObject*>("photoImageview1");
            (typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png") :newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png");
            //newButton->setProperty("imageSource", "file://"+fileName);
            QObject *newDelte = root->findChild<QObject*>("photoDeleteImg3");
            newDelte->setProperty("imageSource", "asset:///images/common/imgRemove@2x.png");
            qDebug() << "fileName test setup---------:" << imageCount;
        }
        else if(imageCount == 2)
        {
                QObject *newcontaioner1 = root->findChild<QObject*>("photo2Container");
                newcontaioner1->setProperty("visible", "true");
                QObject *newButton = root->findChild<QObject*>("photoImageview2");
                (typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png") :newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png");
                qDebug() << "fileName test setup---------:" << imageCount;
        }
        else if(typeMedia == 2)
        {
                    QObject *newcontaioner1 = root->findChild<QObject*>("photo3Container");
                    newcontaioner1->setProperty("visible", "true");
                    QObject *newButton = root->findChild<QObject*>("photoImageview3");
                    (typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png") :newButton->setProperty("imageSource", "asset:///images/common/icnVideoPlay@2x.png");
                    qDebug() << "fileName test setup---------:" << imageCount;
        }



}



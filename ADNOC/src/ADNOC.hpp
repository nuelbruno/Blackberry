/*
 * ADNOC.hpp
 *
 *  Created on: Nov 6, 2014
 *      Author: tacme
 */

#ifndef ADNOC_HPP_
#define ADNOC_HPP_
#include <QObject>

#include <bb/cascades/Application>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <QtCore/QObject>
#include "StatusEventHandler.h"
#include <QtLocationSubset/qgeopositioninfo.h>
#include <QtLocationSubset/qgeopositioninfosource.h>
#include <bb/platform/geo/GeoLocation.hpp>
#include <QtLocationSubset/QGeoCoordinate>
#include <bps/geolocation.h>
#include <QPointer>
#include <bb/system/InvokeManager.hpp>
#include <bb/system/InvokeRequest.hpp>
#include <QtCore/qmap.h>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/Button>
#include <bb/cascades/Container>

#include <bb/cascades/multimedia/CameraSettings>

#include "MapViewDemo.hpp"

using namespace QtMobilitySubset;
using namespace bb::system;

using namespace bb::cascades;
namespace bb {
namespace cascades {
class Application;
namespace maps {
class MapView;
}
}
namespace platform {
namespace geo {
class GeoLocation;
}
}
}

class ADNOC : public QObject
{
    Q_OBJECT
public:
    ADNOC(QObject *parent = 0);
    virtual ~ADNOC() {}

    Q_INVOKABLE
        void shareOnFB(QString data);Q_INVOKABLE
        void shareOnEmail(QString data);Q_INVOKABLE
        void shareOnTwitter(QString data);Q_INVOKABLE

    Q_INVOKABLE void initLocalization(QTranslator* translator);
    Q_INVOKABLE void startGPS();
    Q_INVOKABLE void updateLocale(QString locale);
    Q_INVOKABLE QString getCurrentLocale();
    Q_INVOKABLE QString getCurrentLanguage();

    Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);
    Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);

    Q_INVOKABLE bool isNetworkAvailable();

    Q_INVOKABLE void clearPins(QObject* mapObject);

private slots:
    //void onSystemLanguageChanged();
public slots:

    void networkStatusUpdateHandler(bool status, QString type);

public Q_SLOTS:

     void positionUpdated(QGeoPositionInfo geoPositionInfo);

     void localeChanged();

     void onFullscreen();

     void manipulatePhoto(const QString &fileName, int imageCount,  int typeMedia);

     Q_SIGNALS:
             /*
              * The change notification signals of the properties
              */
         void networkStateChanged();
        //void manipulateMapView();

private:

     void initNetworkConnection();

     QString mCurrentLocale;
     QString mCurrentLanguageTemp;
     QTranslator* mTranslator;
     bb::system::InvokeManager *mInvokeManager;

     StatusEventHandler  *statusEventHandler;
     bool m_Network;// flag to determine whether a network is running

     bb::platform::geo::GeoLocation* deviceLocation;
     QPointer<QGeoPositionInfoSource> locationDataSource;
     QGeoPositionInfo myPositionInfo;
     AbstractPane *root;
     bb::cascades::maps::MapView* mapView;
   // QTranslator* m_pTranslator;
    //bb::cascades::LocaleHandler* m_pLocaleHandler;
};





#endif /* ADNOC_HPP_ */

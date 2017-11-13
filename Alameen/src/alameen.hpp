/*
 * alameen.hpp
 *
 *  Created on: Mar 11, 2014
 *      Author: tacme
 */

#ifndef ALAMEEN_HPP_
#define ALAMEEN_HPP_

#include <QObject>

#include <bb/cascades/Application>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <QtCore/QObject>

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

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class alameen : public QObject
{
    Q_OBJECT

public:
    alameen(QObject *parent = 0);
    virtual ~alameen() {}

    Q_INVOKABLE void initLocalization(QTranslator* translator);

	Q_INVOKABLE void updateLocale(QString locale);

	Q_INVOKABLE QString getCurrentLanguage();


	Q_INVOKABLE QString getCurrentLocale();


	Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);
	Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);


public Q_SLOTS:



	void localeChanged();


private:


	QString mCurrentLocale;
	QString mCurrentLanguageTemp;
	QTranslator* mTranslator;



	AbstractPane *root;

//	Button *btnSave;

};


#endif /* ALAMEEN_HPP_ */

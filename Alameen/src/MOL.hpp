// Default empty project template
#ifndef MOL_HPP_
#define MOL_HPP_

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

#include "Messages.hpp"
#include "MessageComposer.hpp"
#include "MessageViewer.hpp"
#include "SocialInvocation.hpp"

#include "SMSexample.hpp"

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

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class MOL : public QObject
{
    Q_OBJECT

public:
    MOL(QObject *parent = 0);
    virtual ~MOL() {}
    Q_INVOKABLE void sendEmail(QString toMail,QString subject,QString description);
    Q_INVOKABLE void startGPS();
    Q_INVOKABLE void addPinAtCurrentMapCenter(QObject* mapObject , const QString &mFrom , const QString title);
    Q_INVOKABLE	void clearPins(QObject* mapObject);
    Q_INVOKABLE void shareFileWithBBM(QString filename);
    Q_INVOKABLE void initLocalization(QTranslator* translator);
    Q_INVOKABLE void createButton(QObject* mContainerButton,QString title);
    Q_INVOKABLE void openURL(QString url);
    Q_INVOKABLE void shareFaceBookLink(QString shareLink);
	/*
	 * Refreshes the UI with the specified locale
	 *
	 * @param locale - the locale to change to
	 */
	Q_INVOKABLE void updateLocale(QString locale);
	/*
	 * Allows the current language to be retrieved from QML
	 *
	 * @return the current language (translated)
	 */
	Q_INVOKABLE QString getCurrentLanguage();

	/*
	 * Allows the current locale to e retrieved from QML
	 *
	 * @return the current locale
	 */
	Q_INVOKABLE QString getCurrentLocale();


	Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);
	Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);
	Q_INVOKABLE bool isNetworkAvailable();
	Q_INVOKABLE QVariantList getENetwasalData();


	Q_INVOKABLE void manipulatePhoto(const QString &fileName, int imageCount , int DeleteimageCount1, int DeleteimageCount2, int DeleteimageCount3, int DeleteimageCount4, int typeMedia);

public slots:


	void networkStatusUpdateHandler(bool status, QString type);



public Q_SLOTS:

	/**
     * Called when the current position is updated.
     */
	void positionUpdated(QGeoPositionInfo geoPositionInfo);

	void localeChanged();
	void onMyButtonClicked(QString title);

	void onThumbnail();
	void onFullscreen();


	void networkToatShow();





Q_SIGNALS:
		/*
		 * The change notification signals of the properties
		 */
	void networkStateChanged();



	// MAP calls files

	// Q_INVOKABLE QVariantList worldToPixelInvokable(QObject* mapObject, double latitude, double longitude) const;
	// Q_INVOKABLE void updateMarkers(QObject* mapObject, QObject* containerObject) const;

private:

	void initNetworkConnection();

	QString mCurrentLocale;
	QString mCurrentLanguageTemp;
	QTranslator* mTranslator;
	StatusEventHandler  *statusEventHandler;
	bool m_Network;// flag to determine whether a network is running

	int countPhoto;

	//Messages* m_pMessagesObject;

	SMSexample* m_smsexamplepoint;

	//QVariantList m_messagecomposeSetcontent;

	//bb::system::InvokeManager *m_messagecomposeSetcontent;


	bb::platform::geo::GeoLocation* deviceLocation;
	QPointer<QGeoPositionInfoSource> locationDataSource;
	QGeoPositionInfo myPositionInfo;
	bb::system::InvokeManager *mInvokeManager;
	AbstractPane *root;
	QVariantList mQVariantListENetwasalData;
//	Button *btnSave;

	// MAP class file
	//QPoint worldToPixel(QObject* mapObject, double latitude, double longitude) const;

};


#endif /* ApplicationUI_HPP_ */

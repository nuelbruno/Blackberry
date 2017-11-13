// Default empty project template
#include "MOL.hpp"


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

#include <bb/system/InvokeAction>
#include <bb/system/InvokeQueryTargetsReply>
#include <bb/system/InvokeQueryTargetsRequest>
#include <bb/system/InvokeReply>
#include <bb/system/InvokeRequest>
#include <bb/system/InvokeTarget>
#include <bb/system/InvokeTargetReply>
#include <bb/system/SystemToast>


using namespace bb::cascades;
using namespace QtMobilitySubset;
using namespace bb::data;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;

//myButtons = new Array(new Array(), new Array());

MOL::MOL(QObject *parent) {
//    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	QmlDocument *qml = 	QmlDocument::create("asset:///main.qml").parent(this);

	  qml->setContextProperty("_MOL", this);

	//m_pMessagesObject = new Messages(this);

	//qml->setContextProperty("_messages", m_pMessagesObject);
	   //qml->setContextProperty("_messages", new Messages(this));

	   //qml->setContextProperty("_socialInvocation", new SocialInvocation());

	//new MapViewDemo(this);
	    //qml->setContextProperty("_mapViewTest", new MapViewDemo());
	//m_messagecomposeSetcontent = new SMSexample(this);
	  QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_messages", new Messages(this));
	  QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_socialInvocation", new SocialInvocation());
	  QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_mapViewTest", new MapViewDemo());
	    m_smsexamplepoint = new SMSexample(this);
	  QmlDocument::defaultDeclarativeEngine()->rootContext()->setContextProperty("_smsexample",  m_smsexamplepoint);
	//new SMSexample(this);

	QString workingDir = QDir::currentPath();

	QDeclarativePropertyMap* dirPaths = new QDeclarativePropertyMap;
	dirPaths->insert("voice", QVariant(QString("file://" + workingDir + "/shared/voice/")));
	qml->setContextProperty("dirPaths", dirPaths);

	//qDebug() << "image path dirPaths--------------- 2: " << dirPaths;


	// create root object for the UI
	root = qml->createRootObject<AbstractPane>();
	// set created root object as a scene
	Application::instance()->setScene(root);

	 mInvokeManager = new InvokeManager(this);
	// Check Network connection in Background
    // saveValueFor("mLanguageCode", "en");

	countPhoto =0;
	initNetworkConnection();
	startGPS();
}
// MAP calass


void MOL::createButton(QObject* mContainerButton, QString title) {
	Container* mContainer = qobject_cast<Container*>(mContainerButton);
	qDebug() << "title 1: " << title;
	Button *btnSave = Button::create();
	btnSave->setText(title);
	qDebug() << "title 2: " << title;
	mContainer->add(btnSave);
	qDebug() << "title 3: " << title;
	connect(btnSave, SIGNAL(clicked()), this, SLOT(onMyButtonClicked("Rahul")));
}
void MOL::onMyButtonClicked(QString title) {
	qDebug() << "title in slot: " << title;
}
void MOL::initNetworkConnection() {
	statusEventHandler = new StatusEventHandler();
	connect(statusEventHandler, SIGNAL(networkStatusUpdated(bool, QString)),this, SLOT(networkStatusUpdateHandler(bool, QString)));
}

QVariantList MOL::getENetwasalData(){

	QVariantMap mENetwasal;
//	mENetwasal.

//	<listitem qml="CompanyDetails.qml" title="Company Information" file="PersonCompanyList.qml" title_ar="معلومات الشركة" imageIcon="../images/etasheel/work_permitstatus_icon.png" label="Company Number" label_ar="رقم شركة" />

	return mQVariantListENetwasalData;
}

void MOL::manipulatePhoto(const QString &fileName, int imageCount, int DeleteimageCount1, int DeleteimageCount2, int DeleteimageCount3, int DeleteimageCount4, int typeMedia)
{
	countPhoto++;

	qDebug() << "fileName test setup---------:" << fileName;
	qDebug() << "fileName timagecount---------:" << imageCount;
	qDebug() << "fileName dele imag count1---------:" << DeleteimageCount1;
	qDebug() << "fileName dele imag count2---------:" << DeleteimageCount2;
	qDebug() << "fileName dele imag count3---------:" << DeleteimageCount3;

	//QObject *deleLable1 = root->findChild<QObject*>("deleLable1");
	//deleLable1->setProperty("text", countPhoto);
	 if(DeleteimageCount1 == 0 && DeleteimageCount2 == 0 && DeleteimageCount3 == 0 && DeleteimageCount4 == 0)
	 {
		if(imageCount == 1)
		{
			QObject *newcontaioner1 = root->findChild<QObject*>("photo1Container");
			newcontaioner1->setProperty("visible", "true");
			QObject *newButton = root->findChild<QObject*>("photoImageview1");
			(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
			//newButton->setProperty("imageSource", "file://"+fileName);
			qDebug() << "fileName test setup---------:" << imageCount;
		}
		else if(imageCount == 2)
		{
				QObject *newcontaioner1 = root->findChild<QObject*>("photo2Container");
				newcontaioner1->setProperty("visible", "true");
				QObject *newButton = root->findChild<QObject*>("photoImageview2");
				(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
				qDebug() << "fileName test setup---------:" << imageCount;
		}
		else if(imageCount == 3)
		{
					QObject *newcontaioner1 = root->findChild<QObject*>("photo3Container");
					newcontaioner1->setProperty("visible", "true");
					QObject *newButton = root->findChild<QObject*>("photoImageview3");
					(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
					qDebug() << "fileName test setup---------:" << imageCount;
		}
		else if(imageCount == 4)
		{
		                    QObject *newcontaioner1 = root->findChild<QObject*>("photo4Container");
		                    newcontaioner1->setProperty("visible", "true");
		                    QObject *newButton = root->findChild<QObject*>("photoImageview4");
		                    (typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
		                    qDebug() << "fileName test setup---------:" << imageCount;
		 }
	 }
	 else
	 {
		      if(DeleteimageCount1 == 1)
		 		{
		 			QObject *newcontaioner1 = root->findChild<QObject*>("photo1Container");
		 			newcontaioner1->setProperty("visible", "true");
		 			QObject *newButton = root->findChild<QObject*>("photoImageview1");
		 			(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
		 			qDebug() << "fileName del setup---------:" << DeleteimageCount1;
		 		}
		 		else if(DeleteimageCount2 == 2)
		 		{
		 				QObject *newcontaioner1 = root->findChild<QObject*>("photo2Container");
		 				newcontaioner1->setProperty("visible", "true");
		 				QObject *newButton = root->findChild<QObject*>("photoImageview2");
		 				(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
		 				qDebug() << "fileName del setup---------:" << DeleteimageCount2;
		 		}
		 		else if(DeleteimageCount3 == 3)
		 		{
		 					QObject *newcontaioner1 = root->findChild<QObject*>("photo3Container");
		 					newcontaioner1->setProperty("visible", "true");
		 					QObject *newButton = root->findChild<QObject*>("photoImageview3");
		 					(typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
		 					qDebug() << "fileName del setup---------:" << DeleteimageCount3;
		 		}
		 		else if(DeleteimageCount4 == 4)
		 		{
		 		                            QObject *newcontaioner1 = root->findChild<QObject*>("photo4Container");
		 		                            newcontaioner1->setProperty("visible", "true");
		 		                            QObject *newButton = root->findChild<QObject*>("photoImageview4");
		 		                            (typeMedia == 2) ? newButton->setProperty("imageSource", "asset:///images/videobackground.jpeg") :newButton->setProperty("imageSource", "file://"+fileName);
		 		                            qDebug() << "fileName del setup---------:" << DeleteimageCount3;
		 		}
	 }


	//newButton->setProperty("imageSource", "asset:///images/delete.png");
	//QObject *newButton1 = root->findChild<QObject*>("submitLabel3");
	//newButton1->setProperty("visible", "false");
}

void MOL::networkStatusUpdateHandler(bool status, QString type) {

	if (status) {
		m_Network = status;
	} else {
		m_Network = status;
	}
	emit networkStateChanged();
	qDebug() << "Network Status:" << m_Network;
	qDebug() << "Network Type:" << type;

}
bool MOL::isNetworkAvailable() {

	qDebug() << "isNetworkAvailable :" << m_Network;
	return m_Network;

}

void MOL::networkToatShow(){



}
/**
 *
 * This method initializes translation engine based on current locale
 * at runtime.
 *
 */
void MOL::initLocalization(QTranslator* translator) {
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

/**
 * App::updateLocale(QString locale)
 *
 * Update view content basing on the given locale.
 *
 */
void MOL::updateLocale(QString locale) {

	// if locale is empty - refresh current. otherwise change the local
	if (!locale.trimmed().isEmpty() && mCurrentLocale != locale) {
		mCurrentLocale = locale;

		qDebug() << "updating UI to language: " << mCurrentLocale;
		QString filename = QString("Alameen_%1").arg(mCurrentLocale);

		if (mTranslator->load(filename, "app/native/qm")) {
			Application::instance()->removeTranslator(mTranslator);
			Application::instance()->installTranslator(mTranslator);
		}
		qDebug() << "after init locale: " << mCurrentLocale;
	}
//	QString lang = getCurrentLocale();
//	saveValueFor("mCurrentLanguage",lang);

	if (mCurrentLocale == "ar_EG" || mCurrentLocale == "ar") {
		saveValueFor("mLanguageCode", "ar");
		qDebug() << "Rahul...2 ar";
	}
	if (mCurrentLocale == "en_US" || mCurrentLocale == "en") {
		saveValueFor("mLanguageCode", "en");
		qDebug() << "Rahul...2 en";
	}

}
void MOL::onThumbnail() {
	QString lang = getCurrentLocale();
	saveValueFor("mCurrentLanguage",lang);
	qDebug() << "BG :" << getCurrentLocale();
}
void MOL::onFullscreen() {
	qDebug() << "full  :" << getCurrentLocale();
//	qDebug() <<"full sreen 2 :" << getValueFor("mCurrentLanguage","") ;
//	if(getValueFor("mCurrentLanguage","")==getCurrentLocale()){
	QString mLastLang = getValueFor("mLastLang", "ar_EG");

	if (mLastLang == getCurrentLocale()) {

	}
	else {
		saveValueFor("mLastLang", getCurrentLocale());
		QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
		qml->setContextProperty("_MOL", this);
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

/**
 * App::getCurrentLanguage()
 *
 * Retrieve the language name corresponding to the current locale.
 */
QString MOL::getCurrentLanguage() {
	qDebug() << "OpenDataSpaceApp getCurrentLanguage: " << mCurrentLocale;
	QLocale *loc = new QLocale(mCurrentLocale);
	return loc->languageToString(loc->language());
}

/**
 *
 * App::getCurrentLocale()
 *
 * Retrieve the current locale.
 */
QString MOL::getCurrentLocale() {
	qDebug() << "getCurrentLocale: " << mCurrentLocale;
	return mCurrentLocale;
}

// handles SLOT from Locale Chaned by user at Device
void MOL::localeChanged() {

	updateLocale(QLocale().name());
}

void MOL::saveValueFor(const QString &objectName, const QString &inputValue) {
	QSettings settings; // A new value is saved to the application settings object.
	settings.setValue(objectName, QVariant(inputValue));
}
QString MOL::getValueFor(const QString &objectName,
		const QString &defaultValue) {
	QSettings settings;
	if (settings.value(objectName).isNull()) { // If no value has been saved return the value.
		return defaultValue;
	}

	return settings.value(objectName).toString(); // Otherwise return the value stored in the settings object.
}
void MOL::positionUpdated(QGeoPositionInfo geoPositionInfo) {

//	qDebug() << "Position updated :" << geoPositionInfo;

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

		// Get and Set the current location as latitude and longitude
//		qDebug() << "QString()lat = " << latitude;
//		qDebug() << "QString()long = " << longitude;
		saveValueFor("latitude", QString("%1").arg(latitude));
		saveValueFor("longitude", QString("%1").arg(longitude));

	}

}
void MOL::startGPS() {

	qDebug() << "startGPS.....";

	// Obtain the location data source if it is not obtained already
	if (!locationDataSource) {
		locationDataSource = QGeoPositionInfoSource::createDefaultSource(this);
		// Whenever the location data source signals that the current
		// position is updated, the positionUpdated function is called
		connect(locationDataSource, SIGNAL(positionUpdated(QGeoPositionInfo)),
				this, SLOT(positionUpdated(QGeoPositionInfo)));

		// Start listening for position updates
		locationDataSource->startUpdates();
	}
}
void MOL::addPinAtCurrentMapCenter(QObject* mapObject, const QString &mFrom,
		const QString title) {

	MapView* myMapView = qobject_cast<MapView*>(mapObject);

//	if (mapView)
//	{

//		mapView->setLongitude(55.13213);
//		mapView->setLatitude(25.156464);

//		qDebug()<<"lat: "<<myMapView->latitude();
//		qDebug()<<"lon: "<<myMapView->longitude();

	if (mFrom == "ContactUs") {

		GeoLocation* newDrop = new GeoLocation();
		newDrop->setLatitude(myMapView->latitude());
		newDrop->setLongitude(myMapView->longitude());
//			QString desc = QString("Coordinates: %1, %2").arg(myMapView->latitude(), 0,'f', 3).arg(myMapView->longitude(), 0, 'f', 3);
//			QString desc = QString("Coordinates: %1, %2").arg(myMapView->latitude(), 0,'f', 2).arg(myMapView->longitude(), 0, 'f', 2);
		myMapView->setCaptionGoButtonVisible(false);

		QString desc = title;
//			newDrop->setDescription(desc);
		newDrop->setName(desc);

		// use the marker in the assets, as opposed to the default marker
		//		Marker flag;
		//		flag.setIconUri(UIToolkitSupport::absolutePathFromUrl(QUrl("asset:///images/pin.png")));
		//		flag.setIconSize(QSize(60, 60));
		//		flag.setLocationCoordinate(QPoint(20, 59));
		//		flag.setCaptionTailCoordinate(QPoint(20, 1));
		//		qDebug()<<"create marker";
		//		newDrop->setMarker(flag);
		//		qDebug()<<"set marker";

		myMapView->mapData()->add(newDrop);

	} else {

	}

//	}
}
void MOL::clearPins(QObject* mapObject) {

	MapView* myMapView = qobject_cast<MapView*>(mapObject);
	// this will remove all pins, except the "device location" pin, as it's in a different data provider
	myMapView->mapData()->defaultProvider()->clear();
}
void MOL::shareFileWithBBM(QString filename) {

	InvokeRequest invokeRequest;
//	QFileInfo info(filename.replace("/appdata/com.example.bb10samples.multimedia.dictaphone.testDev__dictaphonef1064291",""));
//	invokeRequest.setUri("file://" + info.filePath());
//	qDebug() << "file://" << "file://" + info.filePath();

	invokeRequest.setTarget("sys.bbm.sharehandler");
	invokeRequest.setAction("bb.action.OPEN");
	mInvokeManager->invoke(invokeRequest);

}
void MOL::sendEmail(QString toMail, QString subject, QString description) {

	qDebug() << "toMail :" << toMail;
	qDebug() << "subject :" << subject;
	qDebug() << "description :" << description;

	InvokeRequest invokeRequest;
	invokeRequest.setTarget("sys.pim.uib.email.hybridcomposer");
	invokeRequest.setAction("bb.action.COMPOSE");
	invokeRequest.setUri(
			"mailto:" + toMail + "?subject=" + subject + "&body="
					+ description);
//	invokeRequest.setUri("mailto:apps@perceptionsystem.com?subject=Report a  Bug");
	invokeRequest.setMimeType("message/rfc822");
	mInvokeManager->invoke(invokeRequest);

//	mailto:address@domain.com?cc=address2@domain.com&bcc=
//	address3@domain.com&subject=A%20Subject&body=That%20body

}
void MOL::openURL(QString url) {
	InvokeRequest invokeRequest;
	invokeRequest.setTarget("sys.browser");
	invokeRequest.setAction("bb.action.OPEN");
	invokeRequest.setUri(url);
	invokeRequest.setMimeType("text/html");
	mInvokeManager->invoke(invokeRequest);
}
void MOL::shareFaceBookLink(QString shareLink) {
	InvokeRequest invokeRequest;
	invokeRequest.setTarget("Facebook");
	invokeRequest.setAction("bb.action.SHARE");
	invokeRequest.setUri("https://" + shareLink);
	mInvokeManager->invoke(invokeRequest);
}

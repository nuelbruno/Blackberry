// Default empty project template
#include "alameen.hpp"
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/UIToolkitSupport>
#include <bb/data/DataSource>



using namespace bb::cascades;


alameen::alameen(QObject *parent) {
//    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	//QmlDocument *qml = 	QmlDocument::create("asset:///Report.qml").parent(this);
	QmlDocument *qml = QmlDocument::create("asset:///Report.qml").parent(this);
	if (!qml->hasErrors()) {
		    qml->setContextProperty("_MOL", this);

			// create root object for the UI
			AbstractPane* root = qml->createRootObject<AbstractPane>();
			// set created root object as a scene
			Application::instance()->setScene(root);
	}


	//mInvokeManager = new InvokeManager(this);
	// Check Network connection in Background
//    saveValueFor("mLanguageCode", "en");

}

/**
 *
 * This method initializes translation engine based on current locale
 * at runtime.
 *
 */
void alameen::initLocalization(QTranslator* translator) {
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
void alameen::updateLocale(QString locale) {

	// if locale is empty - refresh current. otherwise change the local
	if (!locale.trimmed().isEmpty() && mCurrentLocale != locale) {
		mCurrentLocale = locale;

		qDebug() << "updating UI to language: " << mCurrentLocale;
		QString filename = QString("MOL_%1").arg(mCurrentLocale);

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
		qDebug() << "Rahul...2";
	}
	if (mCurrentLocale == "en_US" || mCurrentLocale == "en") {
		saveValueFor("mLanguageCode", "en");
		qDebug() << "Rahul...2";
	}

}

/**
 * App::getCurrentLanguage()
 *
 * Retrieve the language name corresponding to the current locale.
 */
QString alameen::getCurrentLanguage() {
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
QString alameen::getCurrentLocale() {
	qDebug() << "getCurrentLocale: " << mCurrentLocale;
	return mCurrentLocale;
}

// handles SLOT from Locale Chaned by user at Device
void alameen::localeChanged() {

	updateLocale(QLocale().name());
}

void alameen::saveValueFor(const QString &objectName, const QString &inputValue) {
	QSettings settings; // A new value is saved to the application settings object.
	settings.setValue(objectName, QVariant(inputValue));
}
QString alameen::getValueFor(const QString &objectName,
		const QString &defaultValue) {
	QSettings settings;
	if (settings.value(objectName).isNull()) { // If no value has been saved return the value.
		return defaultValue;
	}

	return settings.value(objectName).toString(); // Otherwise return the value stored in the settings object.
}


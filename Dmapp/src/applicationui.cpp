#include "applicationui.hpp"
#include "WebServicesAPI.h"
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/pickers/ContactPicker>
#include <bb/cascades/Invocation>
#include <bb/system/Clipboard>
#include "BarcodeScannerApp.hpp"
#include <QTimer>

using namespace bb::cascades;
using namespace bb::cascades::pickers;
using namespace bb::data;

static void log_to_stderr(QtMsgType type, const char *msg)
{
    //in this function, you can write the message to any stream!
    const QScriptContextInfo context;
    switch (type) {
        case QtDebugMsg:
            fprintf(stderr, "DebugTestError: %s\n", msg);
//      qDebug()<<"DebugTestError fileName"<<context.fileName();
//      qDebug()<<"DebugTestError functionName"<<context.functionName();
//      qDebug()<<"DebugTestError lineNumber"<<context.lineNumber();
            break;
        case QtWarningMsg:
            fprintf(stderr, "WarningTestError: %s\n", msg);
//      qDebug()<<"WarningTestError lineNumber"<<context.lineNumber();
//      qDebug()<<"WarningTestError functionName"<<context.functionName();
//      qDebug()<<"WarningTestError fileName"<<context.fileName();
            break;
        case QtCriticalMsg:
            fprintf(stderr, "CriticalTestError: %s\n", msg);
//      qDebug()<<"CriticalTestError lineNumber"<<context.lineNumber();
//      qDebug()<<"CriticalTestError functionName"<<context.functionName();
//      qDebug()<<"CriticalTestError fileName"<<context.fileName();
            break;
        case QtFatalMsg:
            fprintf(stderr, "FatalTestError: %s\n", msg);

//      qDebug()<<"FatalTestError lineNumber"<<context.lineNumber();
//      qDebug()<<"FatalTestError functionName"<<context.functionName();
//      qDebug()<<"FatalTestError fileName"<<context.fileName();
            abort();
            break;
        default:
            fprintf(stderr, "default Error: %s\n", msg);
            break;
    }
}

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app), mContactService(new contacts::ContactService(this))
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    mInvokeManager = new InvokeManager(this);
    initNetworkConnection();
    // m_pLocaleHandler = new LocaleHandler(this);
    /*if (!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()),
     this, SLOT(onSystemLanguageChanged()))) {
     // This is an abnormal situation! Something went wrong!
     // Add own code to recover here
     qWarning() << "Recovering from a failed connect()";
     }*/
    // initial load
    onSystemLanguageChanged();
    qmlRegisterType < ContactPicker > ("bb.cascades.pickers", 1, 0, "ContactPicker");
    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml;
    qDebug() << "checkboxSkip" << getValueFor("mcheckboxSkipTu", "false");
    qml = QmlDocument::create("asset:///Home.qml").parent(this);
    /* if (getValueFor("mcheckboxSkipTu", "false") == "true") {
     qml = QmlDocument::create("asset:///Home.qml").parent(this);
     } else {
     qml = QmlDocument::create("asset:///tutorial2.qml").parent(this);
     }
     */
    // Create root object for the UI
    qml->setContextProperty("_mAppParentObj", this);
    qml->setContextProperty("_mWebServiceinstance", new WebServicesAPI(this));
    BarcodeScannerApp* barcodeScanner = new BarcodeScannerApp(this);

    // expose BarcodeScannerApp object in QML as an variable
    qml->setContextProperty("_barcodeScanner", barcodeScanner);

    AbstractPane *root = qml->createRootObject<AbstractPane>();
    // Set created root object as the application scene
    mInvokeManager = new InvokeManager(this);
    QObject* mapObject = root->findChild<MapView*>("mMapView");
    mMapView = qobject_cast<MapView*>(mapObject);
    app->setScene(root);

    initLocalization(m_pTranslator);

    QSettings settings;
    if (settings.value("mLanguageCode").isNull() || settings.value("mLanguageCode") == "en") {
        updateLocale("en-US");
    } else {
        updateLocale("ar");
    }
    qInstallMsgHandler(log_to_stderr);
}
void ApplicationUI::saveValueFor(const QString &objectName, const QString &inputValue)
{
    QSettings settings;
    settings.setValue(objectName, QVariant(inputValue));
}
/*
 *  Retrieve the value stored in persistence  settings object.
 *  @param objectName Identifier to get value from  persistence storage.
 *  @param defaultValue If no value has been saved return the specified default value.
 */
QString ApplicationUI::getValueFor(const QString &objectName, const QString &defaultValue)
{
    QSettings settings;
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }
    return settings.value(objectName).toString();
}
bool ApplicationUI::checkGPS()
{

//  QGeoSearchReply *reply = searchManager->search(searchString);
    QGeoPositionInfoSource *positionInfoSource = QGeoPositionInfoSource::createDefaultSource(0);
    // ensure location services are enabled

    bool isGPSOn = positionInfoSource->property("locationServicesEnabled").toBool();
    qDebug() << "Check GPS : " << isGPSOn;
    /*if (!isGPSOn) {

     // Checking GPD On/Off and open locaton setting
     InvokeRequest request;
     request.setAction("bb.action.OPEN");
     request.setMimeType("text/html");
     request.setUri("settings://location");
     request.setTarget("sys.settings.target");

     mInvokeManager->invoke(request);

     }*/

    return isGPSOn;
}
/**
 * It will update the locale based on persistence object's value.
 */
void ApplicationUI::onFullscreen()
{
    QSettings setting;
    updateLocale(setting.value("mLanguageCode", "en-US").toString());
}
void ApplicationUI::initNetworkConnection()
{
    statusEventHandler = new StatusEventHandler();
    connect(statusEventHandler, SIGNAL(networkStatusUpdated(bool, QString)), this, SLOT(networkStatusUpdateHandler(bool, QString)));
}

void ApplicationUI::networkStatusUpdateHandler(bool status, QString type)
{
    if (status) {
        m_Network = status;
    } else {
        m_Network = status;
    }
    emit networkStateChanged();
    qDebug() << "Network Status:" << m_Network;
    qDebug() << "Network Type:" << type;
}
/**
 *Return's the result of network availability status containing true or false.
 */
bool ApplicationUI::isNetworkAvailable()
{
    return m_Network;
}
/*
 * Sets the number into contacts and invoke the contacts view.
 * @param number Number could be Makani ,UAENG etc...
 */
void ApplicationUI::AddContact(QString number)
{
    contacts::ContactBuilder mbuider;
    contacts::Contact mcontactId;
    contacts::ContactAttributeBuilder mAttributeBuilder;
//	mbuider.addAttribute(
//			contacts::ContactAttributeBuilder().setKind(
//					contacts::AttributeKind::Phone).setSubKind(
//					contacts::AttributeSubKind::PhoneMobile).setKind(
//					contacts::AttributeKind::Name).setSubKind(
//					contacts::AttributeSubKind::Home).setLabel("MAKANI").setValue(
//					number));
//createContact() will return contact object.So from that object we can extract contact id.
    mAttributeBuilder.setKind(contacts::AttributeKind::OrganizationAffiliation).setSubKind(contacts::AttributeSubKind::OrganizationAffiliationTitle).setValue(number);
    mbuider.addAttribute(mAttributeBuilder);
    mcontactId = mContactService.createContact(mbuider, false);

    openContactView(mcontactId.id());

}
/**
 *  Initiate, load and install the application translation files.
 */
void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    QString locale_string = QLocale().name();
    QString file_name = QString("Dmapp_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

/**
 *  Open's the contacts view based on the contact id.
 *
 * @param mcontactId contact id from contact object.
 */
void ApplicationUI::openContactView(contacts::ContactId mcontactId)
{
    InvokeRequest mInvokeRequest;
    mInvokeRequest.setTarget("sys.pim.contacts.app");
    mInvokeRequest.setAction("bb.action.OPEN");
    mInvokeRequest.setMimeType("application/vnd.blackberry.contact.id");
    QVariant mdata = QVariant::fromValue(mcontactId);
    mInvokeRequest.setData(mdata.toByteArray());
    mInvokeManager->invoke(mInvokeRequest);
}

/**
 *
 * This method initializes translation engine based on current locale
 * at runtime.
 *
 */
void ApplicationUI::initLocalization(QTranslator* translator)
{
    // remember current locale set
    mCurrentLocale = QLocale().name();
    qDebug() << "initLocalization: " << mCurrentLocale;
    m_pTranslator = translator;

    // watch if user changes locale from device settings
//	LocaleHandler* mLocalHandlers;
    bb::cascades::LocaleHandler* mLocaleHandler;
    mLocaleHandler = new bb::cascades::LocaleHandler(this);
    // connect the handler
    connect(mLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(localeChanged()));

}

/*
 * Refreshes the UI with the specified locale
 *
 * @param locale - the locale to change to
 */
void ApplicationUI::updateLocale(QString locale)
{

    // if locale is empty - refresh current. otherwise change the local
    if (!locale.trimmed().isEmpty() && mCurrentLocale != locale) {
        mCurrentLocale = locale;

        qDebug() << "updating UI to language: " << mCurrentLocale;
        QString filename = QString("Dmapp_%1").arg(mCurrentLocale);

        if (m_pTranslator->load(filename, "app/native/qm")) {
            Application::instance()->removeTranslator(m_pTranslator);
            Application::instance()->installTranslator(m_pTranslator);
        }
        qDebug() << "after init locale: " << mCurrentLocale;
    }
}

/*
 * Allows the current language to be retrieved from QML
 *
 * @return the current language (translated)
 */
QString ApplicationUI::getCurrentLanguage()
{
    // TODO get language name from QLocale - we have now more languages
    QLocale *loc = new QLocale(mCurrentLocale);
    return loc->languageToString(loc->language());
}
/*
 * Allows the current locale to be retrieved from QML
 *
 * @return the current locale
 */
QString ApplicationUI::getCurrentLocale()
{
    return mCurrentLocale;
}

// handles SLOT from Locale Chaned by user at Device
void ApplicationUI::localeChanged()
{
    updateLocale(QLocale().name());
}
/*
 * Shares the any data by invoking facebook .
 * @param data data to share on facebook.
 */
void ApplicationUI::shareOnFB(QString data)
{

    qDebug() << "share data : " << data;
    InvokeRequest invokeRequest;
    invokeRequest.setTarget("Facebook");
    invokeRequest.setAction("bb.action.SHARE");
//	invokeRequest.setUri("data://"+data);
    invokeRequest.setData(data.toUtf8());
    invokeRequest.setMimeType("text/plain");
    mInvokeManager->invoke(invokeRequest);
}
/*
 * Shares the any data by invoking Twitter .
 * @param data data to share on Twitter.
 */
void ApplicationUI::shareOnTwitter(QString data)
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
void ApplicationUI::shareOnEmail(QString data)
{
    InvokeRequest invokeRequest;
    invokeRequest.setTarget("sys.pim.uib.email.hybridcomposer");
    invokeRequest.setAction("bb.action.SHARE");
    invokeRequest.setData(data.toUtf8());
    invokeRequest.setMimeType("text/plain");
    mInvokeManager->invoke(invokeRequest);
}
/*
 * Opens the composer view with message  using the data provided.
 *
 * @param data sets the data to share.
 */
void ApplicationUI::shareOnMessage(QString data)
{
    QVariantMap requestData;

    requestData["body"] = data;
    requestData["send"] = false;

    bool ok = true;
    QByteArray encodedRequestData = bb::PpsObject::encode(requestData, &ok);

    InvokeRequest invokeRequest;
    invokeRequest.setTarget("sys.pim.text_messaging.composer");
    invokeRequest.setAction("bb.action.COMPOSE");
    invokeRequest.setData(encodedRequestData);
    invokeRequest.setMimeType("application/text_messaging");
    mInvokeManager->invoke(invokeRequest);
}
/*
 * Adds the new data to clip board to the specified type.
 * @param data data to put on clip board.
 * returns true if successfully copied fasle other wise.
 */
bool ApplicationUI::copyDataToClipboard(QString data)
{
    bb::system::Clipboard clipboard;
    return clipboard.insert("text/plain", data.toUtf8());
}

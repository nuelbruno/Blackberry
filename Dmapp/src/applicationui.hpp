#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/MapData>
#include <bb/pim/contacts/ContactService>
#include <bb/pim/contacts/ContactAttribute>
#include <bb/pim/contacts/ContactAttributeBuilder>
#include <bb/system/InvokeManager.hpp>
#include <bb/system/InvokeRequest.hpp>
#include <bb/pim/contacts/ContactBuilder>
#include <bb/system/SystemToast>
#include <bb/cascades/LocaleHandler>
#include <QRegExp>
#include "StatusEventHandler.h"
using namespace bb::cascades;
using namespace bb::cascades::maps;
using namespace bb::pim;
using namespace bb::system;
namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class ApplicationUI: public QObject
{
Q_OBJECT
public:
    ApplicationUI(bb::cascades::Application *app);Q_INVOKABLE
    void AddContact(QString number);
    void openContactView(contacts::ContactId mcontactId);
    virtual ~ApplicationUI()
    {
    }
    Q_INVOKABLE
    void initLocalization(QTranslator* translator);Q_INVOKABLE
    void shareOnFB(QString data);Q_INVOKABLE
    void shareOnEmail(QString data);Q_INVOKABLE
    void shareOnTwitter(QString data);Q_INVOKABLE
    void shareOnMessage(QString data);Q_INVOKABLE
    bool copyDataToClipboard(QString data);Q_INVOKABLE
    bool isNetworkAvailable();

    Q_INVOKABLE
    void updateLocale(QString locale);

    Q_INVOKABLE
    QString getCurrentLanguage();

    Q_INVOKABLE
    QString getCurrentLocale();Q_INVOKABLE
    bool checkGPS();
    Q_INVOKABLE void saveValueFor(const QString &objectName, const QString &inputValue);
    Q_INVOKABLE QString getValueFor(const QString &objectName, const QString &defaultValue);
private slots:
    void onSystemLanguageChanged();

public Q_SLOTS:
    void networkStatusUpdateHandler(bool status, QString type);
    void localeChanged();
    void onFullscreen();

Q_SIGNALS:
    void networkStateChanged();
public:
    void initNetworkConnection();
    QString mCurrentLocale;
    QTranslator* m_pTranslator;
    MapView *mMapView;
    contacts::ContactService mContactService;
    InvokeManager *mInvokeManager;
    StatusEventHandler *statusEventHandler;
    bool m_Network;
    Application *mapp;
};

#endif /* ApplicationUI_HPP_ */

#include <bb/cascades/Application>

#include <QLocale>
#include <QTranslator>
#include "applicationui.hpp"
#include "WebServicesAPI.h"
#include "DatabaseConnectionApi.h"
#include <Qt/qdeclarativedebug.h>
#include "BarcodeDecoder.hpp"
#include "WebImageView.h"
#include <bb/platform/RouteMapInvoker>
using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);
    qmlRegisterType<bb::community::barcode::BarcodeDecoderControl>("bb.community.barcode", 1, 0,
            "BarcodeDecoder");
    qmlRegisterType<WebServicesAPI>("WebServicesAPI", 1, 0, "WebServicesAPI");
    qmlRegisterType<WebImageView>("WebImageView", 1, 0, "WebImageView");
    qmlRegisterType<QTimer>("my.library", 1, 0, "QTimer");
    qmlRegisterType<QTimer>("my.timer", 1, 0, "QTimer");
    qmlRegisterType<DatabaseConnectionApi>("bb.DatabaseConnectionApi.data", 1, 0,
            "DatabaseConnectionApi");
    qmlRegisterType<bb::platform::RouteMapInvoker>("bb.platform", 1, 0, "RouteMapInvoker");
    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.

    ApplicationUI mAppui(&app);
    QObject::connect(&app, SIGNAL(fullscreen()), &mAppui, SLOT(onFullscreen()));

    // Enter the application main event loop.
    return Application::exec();
}

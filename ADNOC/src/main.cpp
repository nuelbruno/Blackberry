/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#include "ADNOC.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>


#include <QLocale>
#include <QTranslator>

#include <Qt/qdeclarativedebug.h>
#include <bb/cascades/pickers/FilePicker>

// Added class
#include "ADNOCwebservice.hpp"

#include "WebImageView.h"
#include "DatabaseConnectionApi.h"
#include <bb/system/phone/Phone>

#include "TimerCount.hpp"

#include <bb/platform/RouteMapInvoker>

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
        qmlRegisterType<ADNOCwebservice>("ADNOCwebservice", 1, 0, "ADNOCwebservice");
        qmlRegisterType<QTimer>("my.timer", 1, 0, "QTimer");
        qmlRegisterType<WebImageView>("WebImageView", 1, 0, "WebImageView");
        qmlRegisterType<bb::system::phone::Phone>("bb.system.phone", 1, 0, "Phone");
        qmlRegisterType<Timer>("CustomTimer", 1, 0, "TimerCount");
        qmlRegisterType<DatabaseConnectionApi>("bb.DatabaseConnectionApi.data", 1, 0,
                    "DatabaseConnectionApi");

        Application app(argc, argv);

                 QTranslator translator;
                 QString locale_string = QLocale().name();
                 qDebug() << "tlocal string---------------test= >" << locale_string;
                 QString filename = QString( "ADNOC_%1" ).arg( locale_string );
                 if (translator.load(filename, "app/native/qm")) {
                     app.installTranslator( &translator );
                 }

        // Create the Application UI object, this is where the main.qml file
        // is loaded and the application scene is set.
        ADNOC appui;
        appui.initLocalization(&translator);

        // Enter the application main event loop.
        return Application::exec();
}

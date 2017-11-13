/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
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

//#include "AlameenWebservice.hpp"
#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/Application>

#include <bb/multimedia/AudioRecorder>
#include <bb/cascades/pickers/FilePicker>



#include <QLocale>
#include <QTranslator>
#include "applicationui.hpp"

#include <Qt/qdeclarativedebug.h>



#include "WeatherService.hpp"

#include "TimerCount.hpp"
//#include "ImageExample.hpp"
//#include "alameen.hpp"

//#include "twitterFeed.hpp"

//#include "MapViewDemo.hpp"



#include <bb/pim/message/MessageUpdate>





#include <bb/system/phone/Phone>
#include <bb/data/DataSource>

#include "MOL.hpp"

#include "WebImageView.h"




using namespace bb::cascades;



Q_DECL_EXPORT int main(int argc, char **argv)
{
	// qmlRegisterType<WeatherService>("AlameenWebservice", 1, 0, "AlameenWebservice");
	 qmlRegisterType<WeatherService>("WeatherService", 1, 0, "WeatherService");
	 qmlRegisterType<bb::system::phone::Phone>("bb.system.phone", 1, 0, "Phone");
	 qmlRegisterType<WebImageView>("WebImageView", 1, 0, "WebImageView");
	 qmlRegisterType<Timer>("CustomTimer", 1, 0, "TimerCount");
	 qmlRegisterUncreatableType<MessageComposer>("com.example.bb10samples.pim.messages", 1, 0, "MessageComposer", "Usage as property type and access to enums");


	     Application app(argc, argv);
	     // localization support
	     QTranslator translator;
	     QString locale_string = QLocale().name();
	     qDebug() << "tlocal string---------------test= >" << locale_string;
	     QString filename = QString( "Alameen_%1" ).arg( locale_string );
	     if (translator.load(filename, "app/native/qm")) {
	         app.installTranslator( &translator );
	     }
	     MOL mMol;
	     mMol.initLocalization(&translator);

	     QObject::connect(&app, SIGNAL( thumbnail() ), &mMol, SLOT( onThumbnail() ));
	     QObject::connect(&app, SIGNAL( fullscreen() ),&mMol, SLOT( onFullscreen() ));
	 //  ChangeLanguage mChangeLanguage;
	 //  mChangeLanguage.initLocalization(&translator);


	         // Make the Messages object available to the UI as context property



	     //new ImageExample(&app);

	     return Application::exec();

//	Application app(argc, argv);
//
//    // Create the Application UI object, this is where the main.qml file
//    // is loaded and the application scene is set.
//    //new ApplicationUI(&app);
//	QmlDocument* qml = QmlDocument::create("asset:///main.qml").parent(&app);
//
//	qml->setContextProperty("_messages", new Messages(&app));

//	qml->setContextProperty("_socialInvocation", new SocialInvocation(&app));
//
//	new ImageExample(&app);
//
//	new SMSexample(&app);
//
//	 // localization support
//	    QTranslator translator;
//	    QString locale_string = QLocale().name();
//	    QString filename = QString( "MOL_%1" ).arg( locale_string );
//	    if (translator.load(filename, "app/native/qm")) {
//	        app.installTranslator( &translator );
//	    }
//
//	qml->setContextProperty("_LangMol", new MOL(&app));
//
//
//
//
//
//
//	AbstractPane* root = qml->createRootObject<AbstractPane>();
//	Application::instance()->setScene(root);
//
//    // Enter the application main event loop.
//    return Application::exec();
}

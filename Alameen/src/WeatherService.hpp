/* Copyright (c) 2012, 2013  BlackBerry Limited.
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

#ifndef WEATHERSERVICE_HPP
#define WEATHERSERVICE_HPP

#include "qtsoap/qtsoap.h"



#include <QtCore/QObject>
#include <QtCore/QFile>
#include <QtCore/QString>
#include <QtCore/QVariant>
#include <bb/cascades/QListDataModel>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/GroupDataModel>
#include <bb/system/SystemDialog>
#include <bb/system/LocaleHandler>
#include <bb/system/InvokeManager.hpp>
#include <bb/system/InvokeRequest.hpp>
#include <bb/platform/geo/GeoLocation.hpp>
#include <QtLocationSubset/QGeoCoordinate>
#include <bb/data/XmlDataAccess>
#include <bps/bps.h>
#include <bps/geolocation.h>
#include <QDebug>

#include <QPointer>
#include <bb/PpsObject>

#include <QtLocationSubset/qgeopositioninfo.h>
#include <QtLocationSubset/qgeopositioninfosource.h>


using namespace bb::system;
using namespace QtMobilitySubset;

#include <QtCore/QObject>

class WeatherService : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString description READ description NOTIFY descriptionChanged)
    Q_PROPERTY(bool succeeded READ succeeded NOTIFY statusChanged)
    Q_PROPERTY(QString error READ error NOTIFY statusChanged)
    Q_PROPERTY(bool active READ active NOTIFY activeChanged)

    Q_PROPERTY(bb::cascades::DataModel* model READ model CONSTANT)
    Q_PROPERTY(bb::cascades::DataModel* modelPlateList READ modelPlateList CONSTANT)


public:
    WeatherService(QObject* parent = 0);

    /*
     * Retrieves the temperature from the previous request
     */
    QString temperature() const;

    /*
     * Retrieves the description from the previous request
     */
    QString description() const;

    /*
     * Returns whether the previous request succeeded or failed
     */
    bool succeeded() const;

    /*
     * Retrieves the error string from the previous request if one occurred
     * Check getSucceeded() first
     */
    QString error() const;

    /*
     * Returns whether there is currently a lookup running.
     */
    bool active() const;
   // news detail
    Q_INVOKABLE QString getNewDetailTitle();
    Q_INVOKABLE QString getNewDetailDescribtion();
    Q_INVOKABLE QString getNewDetailConetent();
    Q_INVOKABLE QString getNewDetailDate();
    Q_INVOKABLE QString getNewDetailImagePath();
    Q_INVOKABLE QString getNewDetailCurUnniquename();
    Q_INVOKABLE QString getNewDetailpreUnqName();
    Q_INVOKABLE QString getNewDetailNextUnqName();

    Q_INVOKABLE QString getTwitterAccesstoken();
    Q_INVOKABLE QString getFacebookAccesstoken();
    Q_INVOKABLE QString getInstagramAccesstoken();


    Q_INVOKABLE QVariantList getAboutustabcontent();
    //new data
    Q_INVOKABLE
    	QString getWCFMessageString(const QString &methodName,const QVariantList &paramKeys,const QVariantList &paramValues);

public Q_SLOTS:
    /*
     * Retrieves the weather information for the specified zip code (US only)
     *
     */
   void requestAboutusTab(const QString &uniqueName,const QString &langId);

    void requestWeatherInformation(const QString &langid,const QString &CatUniqueName, const QString &length);

    void requestNewlistData(const QString &langid,const QString &ItemCount);

    void requestNewlistDetail(const QString &strUniqueName,const QString &langid);

    void submitReport(const QString &report,const QString &contact, int conMethod,const QString &latitdue, const QString &longitude, bool audioRecord , const QString &image1, const QString &image2, const QString &image3, const QString &image4, const QString &video1, const QString &video2, const QString &video3, const QString &video4);

    void submitRortComments();
    void doPOST_image(const QString &filesName);
    void doPOST_video(const QString &filesName);
    void doPOST_audio();
    /*
     * Clears the internal state of the weather service object.
     */
    void reset();

    // New data
    void callSVC(const QString &xmlData, const QString &host,
    				const QString &prefix, const QString &request,
    				const bool &isSecure);

    void callWS(const QString &action, const QString &host,const QString &prefix, const QtSoapMessage &request,const bool &isSecure);


    void parsegetFinesbyTrafficFileNumberImpl(QString data);

    void parseAboutTablist(QString data);

    void parseNewsList(QString data);

    void parseNewsDetails(QString data);

    void parseMediaEnableOptions(QString data);

    void getMediaFeedsEnable();
    void getTweetsToken(QString accesstoken);

    void getFacebookFeed(QString accesstoken);

    void getInstagramFeed(const QString &accesstoken);

       void parsegetTweetsToken(QString data);

       void getTweetsList(QString tocken);
       void parsegetTweetsList(QString data);

       void pasrseFacebookFeed(QString data);

       void pasrseInstagramFeed(QString data);

    void parseimageUpload(const QtSoapType &data);

Q_SIGNALS:
    /*
     * The complete signal is emitted when the request to the webservice is done
     */
    void complete();

    void dataLoaded();
    /*
     * The change notification signals of the properties
     */
    void temperatureChanged();
    void descriptionChanged();
    void statusChanged();
    void activeChanged();

private Q_SLOTS:
    /*
     * Handler for SOAP request response
     */
    void onServiceResponse();

    void postFinished();

    void requestFinished(QNetworkReply* reply);

private:
    QString setParcebleString ;
    QString currentWS;
	QString strAuctionNo;

	bb::cascades::DataModel* modelPlateList() const;
	bb::cascades::QListDataModel<QObject*>* m_modelAuctionList;

	bb::cascades::DataModel* model() const;
	bb::cascades::GroupDataModel *mm_model;

	QNetworkAccessManager *mNetworkAccessManager;
	QNetworkRequest request;


    QNetworkAccessManager* m_networkAccessManager;

	// ##### NEWS details page ####### //
	    QString strTitle;
	    QString strDescribtion;
	    QString strConetent;
		QString strDate;
		QString strImagepath;
		QString strcurrentUniq;
		QString strpreUniq;
		QString strNextUniq;

		QString strTwitAccess;
		QString strFacebookAccess;
		QString strInstagramAccess;

    QString m_temperature;       // temperature in F and C
    QString m_description;       // description of the weather
    QString m_error;             // error string if one occurred
    bool m_succeeded;            // flag to determine whether request succeeded
    bool m_active;               // flag to determine whether a request is running
    QtSoapHttpTransport m_soap;  // soap transport
    QString responseStatusValue;

    QVariantList aboutTabcontents;

    QString m_reportComment;
    QString m_contactComment;
    QString m_conMethodComment;
    QString m_latitdueComment;
    QString m_longitudeComment;
    int m_contactMethod;
    bool audioRecordSet;
    bool imageRecordSet;

    QString m_image1;
    QString m_image2;
    QString m_image3;

    QString instagramAccesstoken;

    QString u_imagePath [4];
    QString u_audioPath [1];
    QString u_videoPath [4];


    int totalMediaCount;
    int imageTotalCount;
    int audioTotalcount;
    int videoTotalcount;

    //QString image_arr_soap;

    int m_uploadCount;
    int m_resposeSend;
    int m_uploadCountActual;
    bool executeset;
};

#endif

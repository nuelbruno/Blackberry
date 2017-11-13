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

#include "WeatherService.hpp"
#include <QHttpMultiPart>
#include "StationListData.h"

#include "stdio.h"
#include <bb/cascades/QListDataModel>
#include <bb/data/DataSource>
#include <bb/cascades/XmlDataModel>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/ListView>
#include <bb/data/JsonDataAccess>
#include <QtCore/QFile>
#include <bb/system/SystemDialog>
#include <QtLocationSubset/QGeoCoordinate>
#include <bb/PpsObject>
#include <bb/system/LocaleHandler>
#include <bb/cascades/maps/MapView>
#include <bb/cascades/maps/ViewProperties>
#include <bb/platform/geo/BoundingBox.hpp>

#include <bb/cascades/ActivityIndicator>

using namespace bb::cascades;
using namespace bb::data;
using namespace QtMobilitySubset;
using namespace bb::cascades::maps;
using namespace bb::platform::geo;

/**
 * WeatherService
 *
 * In this class you will learn the following:
 * -- Interface with a SOAP C++ library
 */

/**
 * WeatherService::WeatherService(QObject* parent)
 *
 * Initialize member variables and connect the SOAP response signal to our onServiceResponse() slot
 */
//! [0]
WeatherService::WeatherService(QObject* parent) :
		QObject(parent), m_succeeded(false), m_active(false), m_networkAccessManager(
				new QNetworkAccessManager(this)), m_modelAuctionList(
				new QListDataModel<QObject*>()), mm_model(
				new GroupDataModel(
						QStringList() << "getTitle" << "getStationID"
								<< "getArea" << "getZoneNo" << "getDistance"
								<< "getDescription" << "getID"
								<< "getGeoCoordinateX" << "getGeoCoordinateY"
								<< "getPublished" << "getCreatedDate"
								<< "getCreatedBy" << "getUniqueName")) {

	qmlRegisterType<StationListData>();

	bb::data::DataSource::registerQmlTypes();

	m_modelAuctionList->setParent(this);
	mm_model->setParent(this);
	bool ok = connect(&m_soap, SIGNAL(responseReady()),
			SLOT(onServiceResponse()));

	request = QNetworkRequest();
	mNetworkAccessManager = new QNetworkAccessManager(this);

	connect(mNetworkAccessManager, SIGNAL(finished(QNetworkReply*)), this,
			SLOT(requestFinished(QNetworkReply*)));

	Q_ASSERT(ok);
	Q_UNUSED(ok);

}
//! [0]

/**
 * WeatherService::temperature()
 *
 * Return QString, the currently set temperature for a selected city
 */
QString WeatherService::temperature() const {
	return m_temperature;
}

/**
 * WeatherService::description()
 *
 * Return QString, the currently set description
 */
QString WeatherService::description() const {
	return m_description;
}

/**
 * WeatherService::succeeded()
 *
 * Return bool, whether the SOAP query was successful or not
 */
bool WeatherService::succeeded() const {
	return m_succeeded;
}

/**
 * WeatherService::error()
 *
 * Return QString, the error if the SOAP query wasn't successful
 */
QString WeatherService::error() const {
	return m_error;
}

bool WeatherService::active() const {
	return m_active;
}

/**
 * WeatherService::requestWeatherInformation(const QString &zipCode)
 *
 * Construct and submit a SOAP request for a specific location
 */
//! [1]
// ######### Media Feeds Enable/Disable check  ######## //
void WeatherService::getMediaFeedsEnable() {

	currentWS = 'mediaEnable';
	QVariantList paramKeys;
	QVariantList paramValues;

	QString message = getWCFMessageString("GetAllSocialMediaCredentials",
			paramKeys, paramValues);
	QString action =
			"http://tempuri.org/IHelperService/GetAllSocialMediaCredentials";
	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservices/HelperService.svc";

	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobile/helperservice.svc";

	callSVC(action, host, prefix, message, false);

}
void WeatherService::requestAboutusTab(const QString &uniqueName,
        const QString &langId) {

        currentWS = "Aboutus";
        QVariantList paramKeys;
        paramKeys.append("uniqueName");
        paramKeys.append("langId");

        QVariantList paramValues;
        paramValues.append(uniqueName);
        paramValues.append(langId);

        QString message = getWCFMessageString("FixedlinksByUniqueName",
                paramKeys, paramValues);
        QString action =
                "http://tempuri.org/IHelperService/FixedlinksByUniqueName";
       // QString host = "alameen.gov.ae";
        //QString prefix = "/mobileservices/helperservice.svc";

        QString host = "demoserver.tacme.net";
        QString prefix = "/AlameenMobile/helperservice.svc";

        callSVC(action, host, prefix, message, false);

}
void WeatherService::requestWeatherInformation(const QString &langid,
		const QString &CatUniqueName, const QString &length) {
	currentWS = 'Usefullink';

	QVariantList paramKeys;
	paramKeys.append("LangID");
	paramKeys.append("CatUniqueName");
	paramKeys.append("ItemCount");

	QVariantList paramValues;
	paramValues.append(langid);
	paramValues.append(CatUniqueName);
	paramValues.append(length);

	QString message = getWCFMessageString("GetWebLinksByCategoryUniqueName",
			paramKeys, paramValues);
	QString action =
			"http://tempuri.org/IWebLinksService/GetWebLinksByCategoryUniqueName";
	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservices/WebLinksService.svc";

	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobile/WebLinksService.svc";

	callSVC(action, host, prefix, message, false);
}
void WeatherService::requestNewlistData(const QString &langid,
		const QString &ItemCount) {
	currentWS = 'Newslist';

	QVariantList paramKeys;
	paramKeys.append("LangID");
	paramKeys.append("ItemCount");

	QVariantList paramValues;
	paramValues.append(langid);
	paramValues.append(ItemCount);

	QString message = getWCFMessageString("GetLatestNews", paramKeys,
			paramValues);
	QString action = "http://tempuri.org/INewsService/GetLatestNews";

	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservices/NewsService.svc";

	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobile/NewsService.svc";

	callSVC(action, host, prefix, message, false);
}
void WeatherService::requestNewlistDetail(const QString &strUniqueName,
		const QString &langid) {
	currentWS = 'NewsDetailn';

	QVariantList paramKeys;
	paramKeys.append("strUniqueName");
	paramKeys.append("LangID");

	QVariantList paramValues;
	paramValues.append(strUniqueName);
	paramValues.append(langid);

	QString message = getWCFMessageString("GetNewsByUniqueName", paramKeys,
			paramValues);
	QString action = "http://tempuri.org/INewsService/GetNewsByUniqueName";

	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservices/NewsService.svc";

	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobile/NewsService.svc";

	callSVC(action, host, prefix, message, false);
}
void WeatherService::doPOST_image(const QString &filesName) {
	currentWS = "imageUpload";

	qDebug() << "read data from image file";

	m_uploadCount = m_uploadCount +1;


	QByteArray fileContent;

	QString workingDir = QDir::currentPath();

	QFile* file = new QFile(filesName);

	//QFile* file = new QFile("/accounts/1000/shared/camera/IMG_20140514_023205.jpg");
	bool ok = file->open(QIODevice::ReadOnly);
	if (!ok) {
		qDebug() << "error read image";
		return;
	}
	fileContent = file->readAll().toBase64();

	QString data = fileContent;
	QtSoapMessage request;
	request.setMethod(QtSoapQName("UploadFileAndroid", "http://tempuri.org/"));
	request.addMethodArgument("byteArray", "http://tempuri.org/", data);
	request.addMethodArgument("strExt", "http://tempuri.org/", "png");
	QString action = "http://tempuri.org/UploadFileAndroid";
	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservicesupload/ImageUploaderService.asmx";
	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobileImageUpload/ImageUploaderService.asmx";

	//QString message = request;

	/*QtSoapMessage data1 = request;

	m_soap.setAction(action);

	if (currentWS == "UploadImage") {
		qDebug("UploadImage...");
		m_soap.setHost(host, false);
	} else {
		m_soap.setHost(host, false, 8085);
	}



	m_soap.submitRequest(data1, prefix, "", false);*/
	 callWS(action, host, prefix, request, false);


}

void WeatherService::callWS(const QString &action, const QString &host,
        const QString &prefix, const QtSoapMessage &request,
        const bool &isSecure) {

    QtSoapMessage data = request;

    m_soap.setAction(action);

    if (currentWS == "imageUpload") {
        qDebug("UploadImage...");
        m_soap.setHost(host, isSecure);
    } else {
        m_soap.setHost(host, isSecure, 8085);
    }



    m_soap.submitRequest(data, prefix, "", false);

}

void WeatherService::parseimageUpload(const QtSoapType &data) {

    const QtSoapType& firstElemenet = data;

    QString fileUrl;

   // m_uploadCount = 0;

   // m_uploadCount = m_uploadCount +1;
    if (currentWS == "imageUpload") {


        qDebug() << "url= >" << firstElemenet[0]["Url"].toString();

        responseStatusValue = firstElemenet[0]["Url"].toString();

        qDebug() << "endswithpng >" << responseStatusValue.endsWith("png");
        qDebug() << "endswithmp3 >" << responseStatusValue.endsWith("mp3");

        if(responseStatusValue.endsWith("png") == true)
        {
            imageTotalCount = imageTotalCount + 1;
            u_imagePath[imageTotalCount] = responseStatusValue;
            qDebug() << "url array store = >" << u_imagePath[imageTotalCount] << imageTotalCount;


        }
        else if(responseStatusValue.endsWith("mp3") == true)
        {
            audioTotalcount = audioTotalcount+1;
            u_audioPath[audioTotalcount] = responseStatusValue;
        }  //mp4
        else if(responseStatusValue.endsWith("mp4") == true)
        {
                   videoTotalcount = videoTotalcount+1;
                   u_videoPath[videoTotalcount] = responseStatusValue;
        }

        int total_all = audioTotalcount + imageTotalCount + videoTotalcount;

        qDebug() << "total count of all compare >" << total_all;
        qDebug() << "total count of all media compare >" << totalMediaCount;
        qDebug() << "total count of audio compare >" << audioTotalcount;
        qDebug() << "total count of images compare >" << imageTotalCount;
        qDebug() << "total count of video compare >" << videoTotalcount;

        if (total_all == totalMediaCount) {
                        for (int x = 1; x <= imageTotalCount; x++) {
                            qDebug() << "url array image lop= >" << u_imagePath[x];
                        }
                        for (int a = 1; a <= audioTotalcount; a++) {
                                                    qDebug() << "url array audioloop= >" << u_audioPath[a];
                        }
                        for (int v = 1; v <= videoTotalcount; v++) {
                                 qDebug() << "url array video loop= >" << u_videoPath[v];
                         }

                        submitRortComments();
         }
    }


}


void WeatherService::doPOST_audio() {
	currentWS = "imageUpload";

	QByteArray fileContent;

	m_uploadCount = m_uploadCount +1;

	QString workingDir = QDir::currentPath();

	QFile* file = new QFile(workingDir + "/shared/voice/recording.m4a");

	bool ok = file->open(QIODevice::ReadOnly);
	if (!ok) {
		qDebug() << "error read audio";
		return;
	}
	fileContent = file->readAll().toBase64();

	QString data = fileContent;
	QtSoapMessage request;

	request.setMethod(QtSoapQName("UploadFileAndroid", "http://tempuri.org/"));
	request.addMethodArgument("byteArray", "http://tempuri.org/", data);
	request.addMethodArgument("strExt", "http://tempuri.org/", "mp3");
	QString action = "http://tempuri.org/UploadFileAndroid";
	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobileImageUpload/ImageUploaderService.asmx";
	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservicesupload/ImageUploaderService.asmx";

	/*QtSoapMessage data1 = request;

	m_soap.setAction(action);

	if (currentWS == "UploadImage") {
		qDebug("UploadImage...");
		m_soap.setHost(host, false);
	} else {
		m_soap.setHost(host, false, 8085);
	}

	m_soap.submitRequest(data1, prefix, "", false);*/
	callWS(action, host, prefix, request, false);
}

void WeatherService::doPOST_video(const QString &filesName) {

	currentWS = "imageUpload";

	QByteArray fileContent;

	qDebug() << "read data from video file"+filesName;

	QString workingDir = QDir::currentPath();

	QFile* file = new QFile(filesName);

	bool ok = file->open(QIODevice::ReadOnly);
	if (!ok) {
		qDebug() << "error read video file";
		return;
	}
	fileContent = file->readAll().toBase64();

	QString data = fileContent;
	QtSoapMessage request;

	request.setMethod(QtSoapQName("UploadFileAndroid", "http://tempuri.org/"));
	request.addMethodArgument("byteArray", "http://tempuri.org/", data);
	request.addMethodArgument("strExt", "http://tempuri.org/", "mp4");
	QString action = "http://tempuri.org/UploadFileAndroid";
	//QString host = "alameen.gov.ae";
	//QString prefix = "/mobileservicesupload/ImageUploaderService.asmx";
	QString host = "demoserver.tacme.net";
	QString prefix = "/AlameenMobileImageUpload/ImageUploaderService.asmx";

	QtSoapMessage data1 = request;

	/*m_soap.setAction(action);

	if (currentWS == "UploadImage") {
		qDebug("UploadImage...");
		m_soap.setHost(host, false);
	} else {
		m_soap.setHost(host, false, 8085);
	}

	m_uploadCount = m_uploadCount +1;

	m_soap.submitRequest(data1, prefix, "", false);*/
	callWS(action, host, prefix, request, false);

}

void WeatherService::postFinished() {
	QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

	QString response;
	if (reply) {
		if (reply->error() == QNetworkReply::NoError) {
			const int available = reply->bytesAvailable();
			if (available > 0) {
				const QByteArray buffer(reply->readAll());
				response = QString::fromUtf8(buffer);
				qDebug() << response;
			}
		} else {
			response =
					tr("Error: %1 status: %2").arg(reply->errorString(),
							reply->attribute(
									QNetworkRequest::HttpStatusCodeAttribute).toString());
			qDebug() << response;
		}

		reply->deleteLater();
	}

	if (response.trimmed().isEmpty()) {
		response = tr("Unable to retrieve post response");
		qDebug() << response;
	}

	//emit complete(response);
}



void WeatherService::submitReport(const QString &report, const QString &contact,
		int conMethod, const QString &latitdue, const QString &longitude,
		bool audioRecord, const QString &image1, const QString &image2,
		const QString &image3, const QString &image4, const QString &video1, const QString &video2,
		const QString &video3, const QString &video4) {

	QString arr_image;
	QString mp3_filename;
	QString video_arry;

	 m_resposeSend = 0;

	m_reportComment =  report;
	m_contactComment =  contact;
	m_conMethodComment =  conMethod;
	m_latitdueComment =  latitdue;
	m_longitudeComment =  longitude;
	m_contactMethod = conMethod;
	audioRecordSet =audioRecord;

	m_uploadCountActual = 0;

	imageTotalCount = 0;

	totalMediaCount = 0;
	audioTotalcount = 0;
	videoTotalcount = 0;

	for ( int em = 0; em < 4; em++ ) {

	   // u_imagePath[em] = {0};
	}
	for ( int am = 0; am < 1; am++ ) {
	   // u_audioPath[am] ={ 0};
	}

	//u_imagePath.length() = 0;

	 if (image1 != NULL) {
        doPOST_image(image1);
        totalMediaCount = totalMediaCount + 1;
        //imageTotalCount = imageTotalCount +1;
    }
    if (image2 != NULL) {
        doPOST_image(image2);
        totalMediaCount = totalMediaCount + 1;
        //imageTotalCount = imageTotalCount +1;
    }
    if (image3 != NULL) {
        doPOST_image(image3);
        totalMediaCount = totalMediaCount + 1;
        //imageTotalCount = imageTotalCount +1;
    }
    if (image4 != NULL) {
        doPOST_image(image4);
        totalMediaCount = totalMediaCount + 1;
        //imageTotalCount = imageTotalCount +1;
    }


	if (audioRecord == true) {
		doPOST_audio();
		totalMediaCount = totalMediaCount + 1;
	}

	   if (video1 != NULL) {
	        doPOST_video(video1);
	        totalMediaCount = totalMediaCount + 1;
	    }
	    if (video2 != NULL) {
	        doPOST_video(video2);
	        totalMediaCount = totalMediaCount + 1;
	    }
	    if (video3 != NULL) {
	        doPOST_video(video3);
	        totalMediaCount = totalMediaCount + 1;
	    }
	    if (video4 != NULL) {
	        doPOST_video(video4);
	        totalMediaCount = totalMediaCount + 1;
	    }

	  if(totalMediaCount == 0)
	  {
	      submitRortComments();
	  }


}

void WeatherService::submitRortComments()
{


                currentWS = "submitComment";
                QString emailadd;
                QString mobileno;

                QString image_arr_soap = "<tem:strImageFileNames>";

                //if (imageTotalCount == 0) {
                    for ( int im = 1; im <= imageTotalCount; im++ ) {
                        image_arr_soap = image_arr_soap + "<arr:string>" + u_imagePath[im]
                                                               + "</arr:string>";
                        qDebug()  << "url array store comment submit = >" << u_imagePath[im] << imageTotalCount;

                    }

                      //image_arr_soap = image_arr_soap + "<arr:string></arr:string>";
               // }
                image_arr_soap = image_arr_soap + "</tem:strImageFileNames>";

                QString audiofilesoap = "";
                if(audioRecordSet == true) {
                    audiofilesoap =
                            "<tem:strAudioFileName>"+u_audioPath[1]+"</tem:strAudioFileName>";
                } else {
                    audiofilesoap = "<tem:strAudioFileName></tem:strAudioFileName>";
                }

                QString videosoap = "<tem:strVideoFilenames>";

               // if (videoTotalcount == 0) {

                    for (int vm = 1; vm <= videoTotalcount; vm++) {
                        videosoap = videosoap + "<arr:string>" + u_videoPath[vm] + "</arr:string>";
                        qDebug() << "url array store comment submit = >" << u_videoPath[vm] << videoTotalcount;
                    }

                    //videosoap = videosoap + "<arr:string></arr:string>";
               // }
                videosoap = videosoap + "</tem:strVideoFilenames>";


                if (m_contactMethod == 1) {
                    mobileno = m_contactComment;
                } else {
                    emailadd = m_contactComment;
                }

                QString strGeoCordinateLongitude = "<tem:strGeoCordinateLongitude>"
                        + m_latitdueComment + "</tem:strGeoCordinateLongitude>";
                QString strGeoCordinateLatitude = "<tem:strGeoCordinateLatitude>" + m_longitudeComment
                        + "</tem:strGeoCordinateLatitude>";
                QString strUserEmail = "<tem:strUserEmail>" + emailadd
                        + "</tem:strUserEmail>";
                QString strUserMobileNumber = "<tem:strUserMobileNumber>" + mobileno
                        + "</tem:strUserMobileNumber>";
                QString strComments = "<tem:strComments>" + m_reportComment + "</tem:strComments>";

                //QString message = getWCFMessageString("SendEmail", paramKeys,paramValues);
                QString action = "http://tempuri.org/IHelperService/SendEmail";

                QString host = "demoserver.tacme.net";
                QString prefix = "/AlameenMobile/HelperService.svc";
                //QString host = "alameen.gov.ae";
                //QString prefix = "/mobileservices/HelperService.svc";

                QString prefixdata =
                        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\"  xmlns:arr=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\">";
                QString headerstart = "<soapenv:Header/>";
                QString bodyStart = "<soapenv:Body><tem:SendEmail>";
                //QString parameter = "<tem:strImageFileNames><arr:string>?</arr:string></tem:strImageFileNames><tem:strAudioFileName></tem:strAudioFileName>";

                //parameter = parameter + "<tem:strVideoFilenames></tem:strVideoFilenames><tem:strGeoCordinateLongitude></tem:strGeoCordinateLongitude>";
                //parameter = parameter + "<tem:strGeoCordinateLatitude></tem:strGeoCordinateLatitude><tem:strUserEmail></tem:strUserEmail>";
                //parameter = parameter +"<tem:strUserMobileNumber></tem:strUserMobileNumber><tem:strComments></tem:strComments>";
                QString parameter = image_arr_soap;
                parameter = parameter + audiofilesoap;
                parameter = parameter + videosoap;

                parameter = parameter + strGeoCordinateLongitude;
                parameter = parameter + strGeoCordinateLatitude;
                parameter = parameter + strUserEmail;
                parameter = parameter + strUserMobileNumber;
                parameter = parameter + strComments;

                qDebug() << " parameter = " << parameter;

                //for (int i = 0; i < paramKeys.size(); i++) {
                //parameter = parameter + "<tem:" + paramKeys.at(i) + ">" + paramValues.at(i) + "</tem:" + paramKeys.at(i) + ">";
                //}
                QString bodyEnd = "</tem:SendEmail></soapenv:Body></soapenv:Envelope>";

                QString message = prefixdata + headerstart + bodyStart + parameter
                        + bodyEnd;

                callSVC(action, host, prefix, message, false);

}
//! [1]

bb::cascades::DataModel* WeatherService::model() const {
	return mm_model;
}
bb::cascades::DataModel* WeatherService::modelPlateList() const {
	return m_modelAuctionList;
}

void WeatherService::reset() {
	m_temperature.clear();
	m_description.clear();

	emit temperatureChanged();
	emit descriptionChanged();
}

void WeatherService::callSVC(const QString &action, const QString &host,
		const QString &prefix, const QString &request, const bool &isSecure) {

	qDebug() << " action = " << action;
	qDebug() << " host = " << host;
	qDebug() << " prefix = " << prefix;
	qDebug() << " request = " << request+ '/n';

	if (m_active)
		return;

	m_active = true;
	emit activeChanged();

	m_succeeded = false;

	m_soap.setAction(action);
	m_soap.setHost(host, isSecure);
	//	m_soap.setHost(host,8085);

	//QtSoapMessage request;

	QtSoapMessage data;

	// Submit the method request to the web service.
	//	 m_soap.submitRequest(request, "/WeatherWS/Weather.asmx");

	m_soap.submitRequest(data, prefix, request, true);

}

QString WeatherService::getWCFMessageString(const QString &methodName,
		const QVariantList &paramKeys, const QVariantList &paramValues) {

	QString message;
	message =
			"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://tempuri.org/\">";
	message = message + "<soap:Header/>";
	message = message + "<soap:Body><" + methodName + ">";

	for (int i = 0; i < paramKeys.size(); i++) {
		QString key = paramKeys[i].toString();
		QString val = paramValues[i].toString();
		message = message + "<" + key + ">" + val + "</" + key + ">";
	}
	message = message + "</" + methodName + "></soap:Body></soap:Envelope>";

	setParcebleString = message;

	return setParcebleString;

}

/**
 * WeatherService::onServiceResponse()
 *
 * SLOT  parsegetProjectList
 * Called when the SOAP interface returns a response
 * Retrieves the SOAP result, sets member variables and
 * emits a signal indicating the request is complete
 */
//! [2]
void WeatherService::parsegetFinesbyTrafficFileNumberImpl(QString data) {

	JsonDataAccess jda;
	QVariant qtData = jda.loadFromBuffer(data);

	const QVariantList list = qtData.value<QVariantList>();

	for (int i = 0; i < list.size(); i++) {

		QVariantMap map = list.at(i).toMap();

		QString title_useful = map.value("Title", "").toString();
		QString Description_useful = map.value("ImageFileName", "").toString();
		QString ExternalUrl = map.value("ExternalUrl", "").toString();

		//QString Description_useful =  QString("http://alameen.ae%1").arg(Description_useful_set); ExternalUrl

		qDebug() << "title_useful Data = >" << title_useful;
		qDebug() << "Description_useful Data = >" << Description_useful;
		m_modelAuctionList->append(
				new StationListData(title_useful, "", ExternalUrl, "", "",
						Description_useful, "", "", "", "", "", "", "", "", "",
						"", this));
	}

}

void WeatherService::parseAboutTablist(QString data) {

        JsonDataAccess jda;

        QVariant qtData = jda.loadFromBuffer(data);

        QVariantMap map = qtData.toMap();

        QVariantMap mListData;

        QString id_title_count;

        QVariantList SubLinksLength = map.value("SubLinks", "").toList();
        qDebug() << "SubLinksLength count = >" << SubLinksLength.length();
        for (int i = 0; i < SubLinksLength.size(); i++) {
            QVariantMap map = SubLinksLength.at(i).toMap();
            QString title_about = map.value("Title", "").toString();
            QString contentaboutus = map.value("Content", "").toString();
            id_title_count = id_title_count + '1';
            QString id_title = id_title_count;
            qDebug() << "title_about  Data = >" << title_about;
            m_modelAuctionList->append(
                            new StationListData(title_about, id_title, contentaboutus,
                                    "", "", "", "",
                                    "", "", "", "", "", "", "", "", "", this));
            mListData.insert("Content", map.value("Content", "").toString());
            aboutTabcontents.insert(0, mListData);
        }


        emit activeChanged();
        emit dataLoaded();
}

QVariantList WeatherService::getAboutustabcontent() {
    qDebug() << "return getAboutustabcontent called = >" ;
    return aboutTabcontents;

}

void WeatherService::parseNewsList(QString data) {

	JsonDataAccess jda;
	QVariant qtData = jda.loadFromBuffer(data);

	const QVariantList list = qtData.value<QVariantList>();

	for (int i = 0; i < list.size(); i++) {

		QVariantMap map = list.at(i).toMap();

		QVariantMap maplastuniqname = list.at(14).toMap();
		QString lastUniqname = maplastuniqname.value("NextUniqueName", "").toString();
		qDebug() << "last uniq name c++ fetch = >" << lastUniqname;

		QString title_useful = map.value("Headline", "").toString();
		QString DescriptionNews = map.value("Description", "").toString();
		QString ExternalUrl = map.value("UniqueName", "").toString();
		QString PrevUniqueName = map.value("PrevUniqueName", "").toString();
		QString NextUniqueName = map.value("NextUniqueName", "").toString();
		//QString newscount = i;

		QVariantList listData = map.value("Images", "").toList();
		qDebug() << "title_useful Data = >" << listData.length();
		QString Description_useful;
		if(listData.length() > 0)
		{
		  QVariantMap mapImg = listData.at(0).toMap();
		  Description_useful =
				mapImg.value("ImageThumbFileName", "").toString();
		  qDebug() << "Description_useful Data = >" << Description_useful;
		}else
		{
		   // Description_useful =  '';
		}

		//QString Description_useful =  QString("http://alameen.ae%1").arg(Description_useful_set); var imagesText = curentItem.Images;
		//imagesText[0].ImageThumbFileName
		qDebug() << "title_useful Data = >" << title_useful;
		//qDebug() << "Description_useful Data = >" << Description_useful;
		m_modelAuctionList->append(
				new StationListData(title_useful, DescriptionNews, ExternalUrl,
						PrevUniqueName, NextUniqueName, Description_useful, lastUniqname,
						"", "", "", "", "", "", "", "", "", this));
	}

}

void WeatherService::parseNewsDetails(QString data) {

	JsonDataAccess jda;

	QVariant qtData = jda.loadFromBuffer(data);

	QVariantMap map = qtData.toMap();

	QString title_useful = map.value("Title", "").toString();
	QString datedetail = map.value("StartDate", "").toString();

	//QString Description_useful =  QString("http://alameen.ae%1").arg(Description_useful_set); var imagesText = curentItem.Images;
	//imagesText[0].ImageThumbFileName Content
	qDebug() << "title_useful Data = >" << title_useful;
	qDebug() << "Description_useful Data = >" << datedetail;

	strTitle = map.value("Title", "").toString();
	strDescribtion = map.value("Description", "").toString();
	strConetent = map.value("Content", "").toString();
	strDate = map.value("StartDate", "").toString();
	QVariantList listData = map.value("Images", "").toList();
	//strImagepath = listData.length();
	if(listData.length() > 0)
	{
	 QVariantMap mapImg = listData.at(0).toMap();
	 strImagepath = mapImg.value("ImageFileName", "").toString();
	}

	strcurrentUniq = map.value("EndDate", "").toString();
	strpreUniq = map.value("PrevUniqueName", "").toString();
	strNextUniq = map.value("NextUniqueName", "").toString();

	emit dataLoaded();

}


QString WeatherService::getNewDetailTitle() {
	qDebug() << "testtitle Data = >" << strTitle;
	return strTitle;
}
QString WeatherService::getNewDetailDescribtion() {
	qDebug() << "testtitle Data = >" << strTitle;
	return strDescribtion;
}
QString WeatherService::getNewDetailConetent() {
    qDebug() << "strConetent Data = >" << strTitle;
    return strConetent;
}
QString WeatherService::getNewDetailDate() {
	return strDate;
}
QString WeatherService::getNewDetailImagePath() {
	return strImagepath;
}
QString WeatherService::getNewDetailCurUnniquename() {
	return strcurrentUniq;
}
QString WeatherService::getNewDetailpreUnqName() {
	return strpreUniq;
}
QString WeatherService::getNewDetailNextUnqName() {
	return strNextUniq;
}

void WeatherService::parseMediaEnableOptions(QString data) {

	qDebug() << "test response media enable iotin Data = >";

	JsonDataAccess jda;

	QVariant qtData = jda.loadFromBuffer(data);

	//qDebug() << "Responce Data = >" << qtData.;

	QVariantMap map = qtData.toMap();
	const QVariantList list = qtData.value<QVariantList>();

	for (int i = 0; i < list.size(); i++) {

		QVariantMap map = list.at(i).toMap();

		QString title_useful = map.value("SocialMediaType", "").toString();
		QString ExternalUrl = map.value("isEnabled", "").toString();

		qDebug() << "title_useful Data = >" << title_useful;
		qDebug() << "Description_useful Data = >" << ExternalUrl;
		if (i == 0) {
			strTitle = map.value("SocialMediaType", "").toString();
			strDescribtion = map.value("isEnabled", "").toString();
			strFacebookAccess = map.value("AccessToken", "").toString();
		}
		if (i == 1) {
			strDate = map.value("SocialMediaType", "").toString();
			strImagepath = map.value("isEnabled", "").toString();
			strTwitAccess = map.value("AccessToken", "").toString();
		}
		if (i == 2) {
			strcurrentUniq = map.value("SocialMediaType", "").toString();
			strpreUniq = map.value("isEnabled", "").toString();
			strInstagramAccess = map.value("AccessToken", "").toString();
			instagramAccesstoken = strInstagramAccess;
		}
	}

	emit dataLoaded();

}
QString WeatherService::getTwitterAccesstoken() {
	return strTwitAccess;
}
QString WeatherService::getFacebookAccesstoken() {
	return strFacebookAccess;
}
QString WeatherService::getInstagramAccesstoken() {
	return strInstagramAccess;
}

void WeatherService::onServiceResponse() {
	// Get the response, check for error.
	//qDebug() << "title 1: " << m_soap.getResponse();
	const QtSoapMessage& response = m_soap.getResponse();

	qDebug() << "Responce Data main= >" << response.returnValue().toString();
	qDebug() << "Responce currentWS = >" << currentWS;
	qDebug() << "Responce upload count = >" << m_uploadCount;

	QString mData = response.returnValue().toString();
	//writeResponse(mData, currentWS);

	if (currentWS == "k") {

		parsegetFinesbyTrafficFileNumberImpl(mData);
	} else if (currentWS == "t") {

		parseNewsList(mData);

	} else if (currentWS == "n") {

		parseNewsDetails(mData);

	} else if (currentWS == "e") {

		parseMediaEnableOptions(mData);

	}
	else if(currentWS == "Aboutus")
	{
	    parseAboutTablist(mData);
	}
	else if(currentWS == "imageUpload")
	{
	    parseimageUpload(response.returnValue());
	    m_succeeded= "";
	    return;
	}

	else if(currentWS == "submitComment")
	{
        QString mdataset = mData;
        if (mdataset == "true") {
            qDebug() << "Responce true = >" << m_uploadCount;
            m_succeeded = true;
            emit statusChanged();

            m_active = false;
            emit activeChanged();

            emit complete();

            m_resposeSend = 1;
            return;
        } else {
            qDebug() << "Responce false = >";
            m_succeeded = false;
            emit statusChanged();

            m_active = false;
            emit activeChanged();

            emit complete();
            return;
        }
	}
	else if (currentWS == "rt" ) {

		//qDebug() << "Responce Data = >" << mData;


		QString mdataset =  mData;
		//qDebug() << "Responce Data s = >" << mdataset;

		if(mdataset == "true" || mdataset == "")
		{
		    m_uploadCount = m_uploadCount -1;


		    if((m_uploadCount <= 1 ||  m_uploadCount <= 0) && m_resposeSend == 0)
		    {
		       qDebug() << "Responce true = >" << m_uploadCount;
		       m_succeeded = true;
               emit statusChanged();

               m_active = false;
               emit activeChanged();

              emit complete();
              m_uploadCount = 0;
              m_resposeSend = 1;
              return;
		    }
            return;
		}
		else
		{
		    qDebug() << "Responce false = >" ;
		    m_succeeded = false;
            emit statusChanged();

            m_active = false;
            emit activeChanged();

            emit complete();
            return;
		}

	}

	if (response.isFault()) {
		m_error = tr("Query failed: %1").arg(
				response.faultString().value().toString());
		emit statusChanged();

		m_active = false;
		emit activeChanged();

		emit complete();
		return;
	}

	// Extract the return value from this method response, check for
	// errors.
	const QtSoapType& responseValue = response.returnValue();
	if (!responseValue.isValid()) {
		m_error = tr("Query failed: invalid return value");
		emit statusChanged();

		m_active = false;
		emit activeChanged();

		emit complete();
		return;
	}

	// response.returnValue();

	if (QString::compare("true", responseValue["Success"].toString(),
			Qt::CaseInsensitive) == 0) {

		m_succeeded = true;
		m_error.clear();

		qDebug() << "Responce Data = >" << response.returnValue().toString();

		emit descriptionChanged();

	} else {
		m_succeeded = false;
		m_error = responseValue["ResponseText"].toString();
	}

	emit statusChanged();

	m_active = false;
	emit activeChanged();

	emit complete();
}

// ######### Instagram fetch result ######## //

void WeatherService::getInstagramFeed(const QString &accesstoken) {
	qDebug() << "instagram field called  newsetup-----------------------------:"+accesstoken;

	currentWS = "instagramfeed";

	m_active = true;
	emit activeChanged();

	m_succeeded = false;

	//QString tocken ="https://graph.facebook.com/233729955181?fields=feed&access_token="+accesstoken;

	QString strUrl =
			"https://api.instagram.com/v1/users/self/feed?access_token="+accesstoken;
	request.setUrl(QUrl(strUrl));
	mNetworkAccessManager->get(request);

}
// ######### Facebook fetch result ######## //
void WeatherService::getFacebookFeed(QString accesstoken) {
	qDebug() << "parsegetfacebook field called -----------------------------:"+accesstoken;

	currentWS = "facebookfeed";

	m_active = true;
	emit activeChanged();

	m_succeeded = false;

	QString strUrl = "https://graph.facebook.com/233729955181?fields=posts&access_token="+accesstoken;

	//QString strUrl ="https://graph.facebook.com/233729955181?fields=feed&access_token=210665145671703%7C2GFZgdD3y5uR2I-GfxvzIncSjRY";
	request.setUrl(QUrl(strUrl));
	//request.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
	//request.setRawHeader("Authorization",
	//		"Basic Tzk4QkpPNTNNRTBHRW44bU5SR1lFUTpOYkVncHIwSjlaRllDbU04VzhZbTRkeDBlbWNYZlZJQjh4aDZsOTNz");
	QByteArray bytes;
	QUrl params;
	//params.addQueryItem(QString::fromStdString("grant_type"),
	//"client_credentials");
	//bytes = params.encodedQuery();
	mNetworkAccessManager->get(request);

}
// ######### twitter fetch result ######## //
void WeatherService::getTweetsToken(QString accesstoken) {
	qDebug() << "parsegetTweetsList called -----------------------------:";

	currentWS = "getTweetsToken";

	m_active = true;
	emit activeChanged();

	m_succeeded = false;

	QString strUrl = "https://api.twitter.com/oauth2/token";
	request.setUrl(QUrl(strUrl));
	request.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
	request.setRawHeader("Authorization",
			"Basic Tzk4QkpPNTNNRTBHRW44bU5SR1lFUTpOYkVncHIwSjlaRllDbU04VzhZbTRkeDBlbWNYZlZJQjh4aDZsOTNz");
	QByteArray bytes;
	QUrl params;
	params.addQueryItem(QString::fromStdString("grant_type"),
			"client_credentials");
	bytes = params.encodedQuery();
	mNetworkAccessManager->post(request, bytes);

}
void WeatherService::parsegetTweetsToken(QString mData) {

	qDebug() << "Debude Tocken :" << mData;

	JsonDataAccess jda;
	QVariant qtData = jda.loadFromBuffer(mData);

	QVariantMap map = qtData.toMap();
	QString tocken = "Bearer " + map.value("access_token").toString();

	getTweetsList(tocken);

}
void WeatherService::getTweetsList(QString tocken) {

	currentWS = "getTweetsList";

	QString strUrl;

	strUrl =
			"https://api.twitter.com//1.1/statuses/user_timeline.json?count=20&screen_name=alameenservice";

	request.setUrl(QUrl(strUrl));
	request.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
	request.setRawHeader("Authorization", tocken.toUtf8());
	//	request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json; charset=utf-8");
	QByteArray bytes;
	QUrl params;
	bytes = params.encodedQuery();
	mNetworkAccessManager->get(request);

}

void WeatherService::pasrseInstagramFeed(QString mData) {

	JsonDataAccess jda;
	QVariantList list =
			jda.loadFromBuffer(mData).toMap().value("data").toList();
	foreach(const QVariant &data, list)
	{
		qDebug() << " << value for instagram parse>>:"
				<< data.toMap().value("caption").toMap().value("text").toString();

		qDebug() << " << value for instagram parse>>:"
				<< data.toMap().value("images").toMap().value("thumbnail").toMap().value(
						"url").toString();

		QString title =
				data.toMap().value("caption").toMap().value("text").toString();
		QString imageID = data.toMap().value("images").toMap().value(
				"thumbnail").toMap().value("url").toString();

		m_modelAuctionList->append(
				new StationListData(title, imageID, "", "", "", "", "", "", "",
						"", "", "", "", "", "", "", this));
	}

	emit statusChanged();

	m_active = false;
	emit activeChanged();

	emit complete();

}
void WeatherService::pasrseFacebookFeed(QString mData) {

	mm_model->setGrouping(ItemGrouping::None);
	mm_model->setSortedAscending(true);

	JsonDataAccess jda;

	QVariant list = jda.loadFromBuffer(mData);
	QVariantMap result = list.value<QVariantMap>();
	QVariantMap response = result.value("posts").toMap();

	qDebug() << " << value for facebook parse>>:" << response;

	QVariantList data = response.value("data").toList();
	qDebug() << " << value for facebook parse>>:" << data;
	foreach (QVariant dataset, data)
	{
		QVariantMap datamap = dataset.toMap();
		//Announcer::showToast(venueMap.value("name").toString());
		//qDebug() << " << value for facebook parse>>:" << datamap.value("message").toString();
		QVariantMap from = datamap.value("from").toMap();
		qDebug() << " << value for facebook image id>>:" << from.value("id").toString();


		QString message = datamap.value("message").toString();
		QString name = datamap.value("name").toString();
		QString description = datamap.value("description").toString();
		QString imageID = from.value("id").toString();

		m_modelAuctionList->append(
				new StationListData(name, imageID, message, description, "", "", "", "",
						"", "", "", "", "", "", "", "", this));
	}

	emit statusChanged();

	m_active = false;
	emit activeChanged();

	emit complete();

}
void WeatherService::parsegetTweetsList(QString mData) {

	//qDebug() << "parsegetTweetsList :" << mData ;

	mm_model->setGrouping(ItemGrouping::None);
	mm_model->setSortedAscending(true);

	JsonDataAccess jda;
	QVariant qtData = jda.loadFromBuffer(mData);
	const QVariantList listData = qtData.value<QVariantList>();
	//qDebug() << " << value for facebook parse>>:" << qtData;
	//qDebug() << "parsegetTweetsList :" << listData.size();
	//    changeDataModelOrder(mm_model);

	QVariantList indexPath = mm_model->last();
	QVariantList mListPrevious;

	for (int i = 0; i < mm_model->size(); i++) {
		QVariantMap entry = mm_model->data(indexPath).toMap();
		indexPath = mm_model->before(indexPath);
		mListPrevious.append(entry);
	}

	mm_model->clear();

	for (int j = listData.size() - 1; j >= 0; j--) {

		QVariantMap mapData = listData.at(j).toMap();
		// max_id = listData.at(listData.size() - 1).toMap().value("id", "").toString();

		QVariantMap user = mapData.value("user", "").toMap();
		QVariantMap entities = mapData.value("entities", "").toMap();

		QVariantMap mListData;

		if (entities.value("media", "").toList().size() != 0) {
			QString media_url =
					entities.value("media", "").toList().at(0).toMap().value(
							"media_url", "").toString();
			//			qDebug() << "media :" << entities.value("media", "").toList().at(0).toMap().value("media_url","").toString();
		} else {
			QString media_url = "";
		}

		QString max_id = mapData.value("id", "").toString();
		QString name = user.value("name", "").toString();
		QString profile_image_url =
				user.value("profile_image_url", "").toString();
		QString textDesc = mapData.value("text", "").toString();
		QString description = user.value("description", "").toString();

		//qDebug() << "parsegetTweetsList :" <<  mListData["textDesc"] ;

		QString mGotDate = mapData.value("created_at", "").toString();

		QDateTime nowDate = mapData.value("created_at", "").toDateTime();
		int hour = nowDate.time().hour();
		int minit = nowDate.time().minute();

		QString created_at;

		if (hour > 12) {

			QDateTime mdate = QDateTime::fromString(mGotDate,
					"ddd MMM dd hh:mm:ss +0000 yyyy");
			QString mDateValue = mdate.toString("ddd MMM d yyyy");

			hour = hour - 12;

			mDateValue = mDateValue + " " + QString::number(hour) + ":"
					+ QString::number(minit) + "PM";

			created_at = mDateValue;

		} else {

			QDateTime mdate = QDateTime::fromString(mGotDate,
					"ddd MMM dd hh:mm:ss +0000 yyyy");
			QString mDateValue = mdate.toString("ddd MMM d yyyy hh:mm");

			mDateValue = mDateValue + " " + "AM";

			created_at = mDateValue;
		}

		QString user_url = user.value("url", "").toString();

		m_modelAuctionList->append(
				new StationListData(name, profile_image_url, textDesc,
						description, created_at, user_url, "", "", "", "", "",
						"", "", "", "", "", this));

	}

	emit statusChanged();

	m_active = false;
	emit activeChanged();

	emit complete();

}

void WeatherService::requestFinished(QNetworkReply* reply) {
	// Check the network reply for errors
	if (reply->error() == QNetworkReply::NoError) {
//		m_succeeded = true;
//		m_active = false;
//		emit activeChanged();
//		emit statusChanged();

		//qDebug() << " << requestFinished succeeded>>:" << currentWS;

		QByteArray response = reply->readAll();
		QString mData = mData.fromUtf8(response);

		qDebug() << " << currentWS succeeded>>:" << currentWS;
		qDebug() << " << mData succeeded>>:" << mData;

		if (currentWS == "getTweetsToken") {

			parsegetTweetsToken(mData);

		} else if (currentWS == "getTweetsList") {

			parsegetTweetsList(mData);

		} else if (currentWS == "facebookfeed") {

			pasrseFacebookFeed(mData);
		} else if (currentWS == "instagramfeed") {

			pasrseInstagramFeed(mData);
		}

	} else {
		m_succeeded = false;
		// emit dataLoaded();
		//emit dataLoadedVideo();
		qDebug() << "<< Problem with the network >>";
		qDebug() << "<< requestFinished failed >>";
		qDebug() << "\n" << reply->errorString();
	}
}
//! [2]

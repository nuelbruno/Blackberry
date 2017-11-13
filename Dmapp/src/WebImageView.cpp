/*
 * WebImageView.cpp
 *
 */

#include "WebImageView.h"
#include <bb/cascades/Image>

WebImageView::WebImageView() {

	mNetManager = new QNetworkAccessManager;

}

const QUrl& WebImageView::url() const {
	return mUrl;
}

void WebImageView::setUrl(const QUrl& url) {

	mUrl = url;
	QNetworkReply * reply = mNetManager->get(QNetworkRequest(url));
	connect(reply,SIGNAL(finished()), this, SLOT(imageLoaded()));
	emit setImageUrl();
}

void WebImageView::imageLoaded() {
    //clearCache();
	QNetworkReply * reply = qobject_cast<QNetworkReply*>(sender());
	setImage(Image(reply->readAll()));
	emit urlChanged();

}






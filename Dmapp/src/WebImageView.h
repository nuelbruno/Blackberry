/*
 * WebImageView.h
 *
 */

#ifndef WEBIMAGEVIEW_H_
#define WEBIMAGEVIEW_H_

#include <bb/cascades/ImageView>
#include <QNetworkAccessManager>
#include <QUrl>
using namespace bb::cascades;

class WebImageView: public bb::cascades::ImageView {
	Q_OBJECT
	Q_PROPERTY (QUrl url READ url WRITE setUrl NOTIFY urlChanged)

public:
	WebImageView();
	const QUrl& url() const;

	public Q_SLOTS:
	void setUrl(const QUrl& url);


	private Q_SLOTS:
	void imageLoaded();

	signals:
	void urlChanged();
	void setImageUrl();


private:
	QNetworkAccessManager * mNetManager;
	QUrl mUrl;
};

#endif /* WEBIMAGEVIEW_H_ */

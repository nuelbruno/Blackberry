/*
 * PoiData.h
 *
 *  Created on: 06-Jan-2014
 *      Author: ubuntu
 */

#ifndef POIDATA_H_
#define POIDATA_H_
#include <QtCore/QObject>

class PoiData: public QObject {
	Q_OBJECT

	Q_PROPERTY(QString getpoiname READ getpoiname NOTIFY getpoinameChanged)
	Q_PROPERTY(QString getpoilatitude READ getpoilatitude NOTIFY getpoilatitudeChanged)
	Q_PROPERTY(QString poilongitude READ poilongitude NOTIFY getpoilongitudeChanged)
	Q_PROPERTY(QString poidistance READ poidistance NOTIFY getpoidistanceChanged)
	Q_PROPERTY(bool getChecked READ getChecked WRITE setChecked NOTIFY getCheckedChanged)
//	Q_PROPERTY(QString getChecked READ getChecked NOTIFY getCheckedChanged)
public:
	PoiData(const QString &name, const QString &latitude, const QString &longitude, const QString &distance,
			 QObject* parent = 0);
	virtual ~PoiData();
	void load();

Q_SIGNALS:
	void getpoinameChanged();
	void getpoilatitudeChanged();
	void getpoilongitudeChanged();
	void getpoidistanceChanged();
	void getCheckedChanged();

private:
	QString getpoiname()  const;
	QString getpoilatitude()  const;
	QString poilongitude()  const;
	QString poidistance()  const;
	bool getChecked();
	void setChecked(bool checkedValue) ;

	QString poiName;
	QString poiLatitude;
	QString poiLongitude;
	QString poiDistance;
	bool isChecked;
};

#endif /* POIDATA_H_ */

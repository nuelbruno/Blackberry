/*
 * StationListData.h
 *
 *  Created on: 07-Mar-2013
 *      Author: niranj
 */

#ifndef STATIONLISTDATA_H_
#define STATIONLISTDATA_H_
#include <QtCore/QObject>

class StationListData : public QObject {

	Q_OBJECT

	Q_PROPERTY(QString getTitle READ getTitle NOTIFY getTitleChanged)
	Q_PROPERTY(QString getStationID READ getStationID NOTIFY getStationIDChanged)
	Q_PROPERTY(QString getArea READ getArea NOTIFY getAreaChanged)
	Q_PROPERTY(QString getZoneNo READ getZoneNo NOTIFY getZoneNoChanged)
	Q_PROPERTY(QString getDistance READ getDistance NOTIFY getDistanceChanged)
	Q_PROPERTY(QString getDescription READ getDescription NOTIFY getDescriptionChanged)
	Q_PROPERTY(QString getID READ getID NOTIFY getIDChanged)
	Q_PROPERTY(QString getGeoCoordinateX READ getGeoCoordinateX NOTIFY getGeoCoordinateXChanged)
	Q_PROPERTY(QString getGeoCoordinateY READ getGeoCoordinateY NOTIFY getGeoCoordinateYChanged)

	Q_PROPERTY(QString getPublished READ getPublished NOTIFY getPublishedChanged)
	Q_PROPERTY(QString getCreatedDate READ getCreatedDate NOTIFY getCreatedDateChanged)
	Q_PROPERTY(QString getCreatedBy READ getCreatedBy NOTIFY getCreatedByChanged)
	Q_PROPERTY(QString getUniqueName READ getUniqueName NOTIFY getUniqueNameChanged)
	Q_PROPERTY(QString getWorkingTime READ getWorkingTime NOTIFY getWorkingTimeChanged)
	Q_PROPERTY(QString getContactNo READ getContactNo NOTIFY getContactNoChanged)
	Q_PROPERTY(QString getService READ getService NOTIFY getServiceChanged)




public:
	StationListData(const QString &getTitle, const QString &getStationID, const QString &getArea, const QString &getZoneNo
			, const QString &getDistance, const QString &getDescription, const QString &getID, const QString &getGeoCoordinateX, const QString &getGeoCoordinateY,
			const QString &getPublished, const QString &getCreatedDate, const QString &getCreatedBy, const QString &getUniqueName,
			const QString &getWorkingTime,const QString &getContactNo,const QString &getService,QObject* parent = 0);
	virtual ~StationListData();

	 void load();

Q_SIGNALS:
	// The change notification signals of the properties

	void getTitleChanged();
	void getStationIDChanged();
	void getAreaChanged();
	void getZoneNoChanged();
	void getDistanceChanged();
	void getDescriptionChanged();
	void getIDChanged();
	void getGeoCoordinateXChanged();
	void getGeoCoordinateYChanged();

	void getPublishedChanged();
	void getCreatedDateChanged();
	void getCreatedByChanged();
	void getUniqueNameChanged();
	void getWorkingTimeChanged();
	void getContactNoChanged();
	void getServiceChanged();



private:
	QString getTitle()  const;
	QString getStationID()  const;
	QString getArea()  const;
	QString getZoneNo()  const;
	QString getDistance()  const;
	QString getDescription()  const;
	QString getID()  const;
	QString getGeoCoordinateX()  const;
	QString getGeoCoordinateY()  const;
	QString getPublished()  const;
	QString getCreatedDate()  const;
	QString getCreatedBy()  const;
	QString getUniqueName()  const;
	QString getWorkingTime() const;
	QString getContactNo() const;
	QString getService() const;




	QString vehicleNo;
	QString amount;
	QString ticketNo;
	QString date;
	QString location;
	QString totalAmount;
	QString discountRate;
	QString amountAfter;
	QString blackPoint;
	QString IsExternalTicket;
	QString TicketSourceCode;
	QString TicketYear;
	QString LateCharges;
	QString WorkingTime;
	QString ContactNo;
	QString Service;

};
#endif /* STATIONLISTDATA_H_ */

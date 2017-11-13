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

	Q_PROPERTY(QString getVal1 READ getVal1 NOTIFY getVal1Changed)
	Q_PROPERTY(QString getVal2 READ getVal2 NOTIFY getVal2Changed)
	Q_PROPERTY(QString getVal3 READ getVal3 NOTIFY getVal3Changed)

	Q_PROPERTY(QString getVal4 READ getVal4 NOTIFY getVal4Changed)
    Q_PROPERTY(QString getVal5 READ getVal5 NOTIFY getVal5Changed)
    Q_PROPERTY(QString getVal6 READ getVal6 NOTIFY getVal6Changed)
    Q_PROPERTY(QString getVal7 READ getVal7 NOTIFY getVal7Changed)
    Q_PROPERTY(QString getVal8 READ getVal8 NOTIFY getVal8Changed)
    Q_PROPERTY(QString getVal9 READ getVal9 NOTIFY getVal9Changed)
    Q_PROPERTY(QString getVal10 READ getVal10 NOTIFY getVal10Changed)
    Q_PROPERTY(QString getVal11 READ getVal11 NOTIFY getVal11Changed)
    Q_PROPERTY(QString getVal12 READ getVal12 NOTIFY getVal12Changed)




public:
	StationListData(const QString &getTitle, const QString &getStationID, const QString &getArea, const QString &getZoneNo
			, const QString &getDistance, const QString &getDescription, const QString &getID, const QString &getGeoCoordinateX, const QString &getGeoCoordinateY,
			const QString &getPublished, const QString &getCreatedDate, const QString &getCreatedBy, const QString &getUniqueName,
			const QString &getWorkingTime,const QString &getContactNo,const QString &getService, const QString &getVal1,
			const QString &getVal2, const QString &getVal3, const QString &getVal4, const QString &getVal5,
			const QString &getVal6, const QString &getVal7, const QString &getVal8, const QString &getVal9,
			const QString &getVal10, const QString &getVal11, const QString &getVal12, QObject* parent = 0);
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

	void getVal1Changed();
	void getVal2Changed();
	void getVal3Changed();

	void getVal4Changed();
    void getVal5Changed();
    void getVal6Changed();

    void getVal7Changed();
    void getVal8Changed();
    void getVal9Changed();

    void getVal10Changed();
    void getVal11Changed();
    void getVal12Changed();





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

	QString getVal1() const;
	QString getVal2() const;
	QString getVal3() const;

	QString getVal4() const;
    QString getVal5() const;
    QString getVal6() const;
    QString getVal7() const;
    QString getVal8() const;
    QString getVal9() const;
    QString getVal10() const;
    QString getVal11() const;
    QString getVal12() const;




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

	QString Passval1;
	QString Passval2;
	QString Passval3;

	QString Passval4;
    QString Passval5;
    QString Passval6;
    QString Passval7;
    QString Passval8;
    QString Passval9;
    QString Passval10;
    QString Passval11;
    QString Passval12;

};
#endif /* STATIONLISTDATA_H_ */

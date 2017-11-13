/*
 * TrafficListData.cpp
 *
 *  Created on: 16-Feb-2013
 *      Author: niranj
 */

#include "StationListData.h"

StationListData::StationListData(const QString &getTitle,
		const QString &getStationID, const QString &getArea,
		const QString &getZoneNo, const QString &getDistance,
		const QString &getDescription, const QString &getID,
		const QString &getGeoCoordinateX, const QString &getGeoCoordinateY,
		const QString &getPublished, const QString &getCreatedDate,
		const QString &getCreatedBy, const QString &getUniqueName,
		const QString &getWorkingTime,const QString &getContactNo,
		const QString &getService,const QString &getVal1,const QString &getVal2, const QString &getVal3,
		const QString &getVal4, const QString &getVal5, const QString &getVal6, const QString &getVal7,
		const QString &getVal8, const QString &getVal9, const QString &getVal10, const QString &getVal11, const QString &getVal12,QObject* parent) :
		QObject(parent), vehicleNo(getTitle), amount(getStationID), ticketNo(
				getArea), date(getZoneNo), location(getDistance), totalAmount(
				getDescription), discountRate(getID), amountAfter(
				getGeoCoordinateX), blackPoint(getGeoCoordinateY), IsExternalTicket(
				getPublished), TicketSourceCode(getCreatedDate), TicketYear(
				getCreatedBy), LateCharges(getUniqueName), WorkingTime(getWorkingTime)
				, ContactNo(getContactNo), Service(getService), Passval1(getVal1), Passval2(getVal2), Passval3(getVal3),
Passval4(getVal4), Passval5(getVal5), Passval6(getVal6), Passval7(getVal7), Passval8(getVal8), Passval9(getVal9),
Passval10(getVal10), Passval11(getVal11), Passval12(getVal12){
	// TODO Auto-generated constructor stub
	/*emit getTitleChanged();
	 emit getStationIDChanged();
	 emit getAreaChanged();
	 emit getZoneNoChanged();
	 emit getDistanceChanged();
	 emit getDescriptionChanged();
	 emit getIDChanged();
	 emit getGeoCoordinateXChanged();
	 emit getGeoCoordinateYChanged();*/
	load();

}

StationListData::~StationListData() {
	// TODO Auto-generated destructor stub
}

void StationListData::load() {

	emit getTitleChanged();
	emit getStationIDChanged();
	emit getAreaChanged();
	emit getZoneNoChanged();
	emit getDistanceChanged();
	emit getDescriptionChanged();
	emit getIDChanged();
	emit getGeoCoordinateXChanged();
	emit getGeoCoordinateYChanged();
	emit getPublishedChanged();
	emit getCreatedDateChanged();
	emit getCreatedByChanged();
	emit getUniqueNameChanged();

	emit getWorkingTimeChanged();
	emit getContactNoChanged();
	emit getServiceChanged();

	emit getVal1Changed();
	emit getVal2Changed();
	emit getVal3Changed();

	emit getVal4Changed();
    emit getVal5Changed();
    emit getVal6Changed();

    emit getVal7Changed();
    emit getVal8Changed();
    emit getVal9Changed();
    emit getVal10Changed();
    emit getVal11Changed();
    emit getVal12Changed();


}

QString StationListData::getGeoCoordinateY() const {
	return blackPoint;
}
QString StationListData::getGeoCoordinateX() const {
	return amountAfter;
}
QString StationListData::getID() const {
	return discountRate;
}
QString StationListData::getDescription() const {
	return totalAmount;
}
QString StationListData::getDistance() const {
	return location;
}
QString StationListData::getZoneNo() const {
	return date;
}
QString StationListData::getArea() const {
	return ticketNo;
}
QString StationListData::getStationID() const {
	return amount;
}
QString StationListData::getTitle() const {

	return vehicleNo;
}

QString StationListData::getPublished() const {
	return IsExternalTicket;
}
QString StationListData::getCreatedDate() const {
	return TicketSourceCode;
}
QString StationListData::getCreatedBy() const {
	return TicketYear;
}
QString StationListData::getUniqueName() const {
	return LateCharges;
}
QString StationListData::getWorkingTime() const {
	return WorkingTime;
}
QString StationListData::getContactNo() const {
	return ContactNo;
}
QString StationListData::getService() const {
	return Service;
}

QString StationListData::getVal1() const {
    return Passval1;
}
QString StationListData::getVal2() const {
    return Passval2;
}
QString StationListData::getVal3() const {
    return Passval3;
}

QString StationListData::getVal4() const {
    return Passval4;
}
QString StationListData::getVal5() const {
    return Passval5;
}
QString StationListData::getVal6() const {
    return Passval6;
}QString StationListData::getVal7() const {
    return Passval7;
}
QString StationListData::getVal8() const {
    return Passval8;
}
QString StationListData::getVal9() const {
    return Passval9;
}QString StationListData::getVal10() const {
    return Passval10;
}
QString StationListData::getVal11() const {
    return Passval11;
}
QString StationListData::getVal12() const {
    return Passval12;
}


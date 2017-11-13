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
		const QString &getWorkingTime,const QString &getContactNo,const QString &getService,QObject* parent) :
		QObject(parent), vehicleNo(getTitle), amount(getStationID), ticketNo(
				getArea), date(getZoneNo), location(getDistance), totalAmount(
				getDescription), discountRate(getID), amountAfter(
				getGeoCoordinateX), blackPoint(getGeoCoordinateY), IsExternalTicket(
				getPublished), TicketSourceCode(getCreatedDate), TicketYear(
				getCreatedBy), LateCharges(getUniqueName), WorkingTime(getWorkingTime)
				, ContactNo(getContactNo), Service(getService){
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


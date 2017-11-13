/*
 * PoiData.cpp
 *
 *  Created on: 06-Jan-2014
 *      Author: ubuntu
 */

#include "PoiData.h"

PoiData::PoiData(const QString &name, const QString &latitude, const QString &longitude, const QString &distance,
		 QObject* parent) :
	QObject(parent), poiName(name), poiLatitude(latitude), poiLongitude(longitude),
	poiDistance(distance), isChecked(false){

}

PoiData::~PoiData() {
	// TODO Auto-generated destructor stub
}

void PoiData::load() {

	emit getpoinameChanged();
	emit getpoilatitudeChanged();
	emit getpoilongitudeChanged();
	emit getpoidistanceChanged();
	emit getCheckedChanged();

}

QString PoiData::getpoiname() const {
	return poiName;
}
QString PoiData::getpoilatitude() const {
	return poiLatitude;
}
QString PoiData::poilongitude() const {
	return poiLongitude;
}
QString PoiData::poidistance() const {
	return poiDistance;
}

bool PoiData::getChecked() {
	return isChecked;
}
void PoiData::setChecked(bool checkedValue) {
	isChecked = checkedValue;
	emit getCheckedChanged();
}


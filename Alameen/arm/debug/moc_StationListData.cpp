/****************************************************************************
** Meta object code from reading C++ file 'StationListData.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/StationListData.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'StationListData.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_StationListData[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
      16,   94, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      16,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      35,   16,   16,   16, 0x05,
      57,   16,   16,   16, 0x05,
      74,   16,   16,   16, 0x05,
      93,   16,   16,   16, 0x05,
     114,   16,   16,   16, 0x05,
     138,   16,   16,   16, 0x05,
     153,   16,   16,   16, 0x05,
     180,   16,   16,   16, 0x05,
     207,   16,   16,   16, 0x05,
     229,   16,   16,   16, 0x05,
     253,   16,   16,   16, 0x05,
     275,   16,   16,   16, 0x05,
     298,   16,   16,   16, 0x05,
     322,   16,   16,   16, 0x05,
     344,   16,   16,   16, 0x05,

 // properties: name, type, flags
     372,  364, 0x0a495001,
     381,  364, 0x0a495001,
     394,  364, 0x0a495001,
     402,  364, 0x0a495001,
     412,  364, 0x0a495001,
     424,  364, 0x0a495001,
     439,  364, 0x0a495001,
     445,  364, 0x0a495001,
     463,  364, 0x0a495001,
     481,  364, 0x0a495001,
     494,  364, 0x0a495001,
     509,  364, 0x0a495001,
     522,  364, 0x0a495001,
     536,  364, 0x0a495001,
     551,  364, 0x0a495001,
     564,  364, 0x0a495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,
       6,
       7,
       8,
       9,
      10,
      11,
      12,
      13,
      14,
      15,

       0        // eod
};

static const char qt_meta_stringdata_StationListData[] = {
    "StationListData\0\0getTitleChanged()\0"
    "getStationIDChanged()\0getAreaChanged()\0"
    "getZoneNoChanged()\0getDistanceChanged()\0"
    "getDescriptionChanged()\0getIDChanged()\0"
    "getGeoCoordinateXChanged()\0"
    "getGeoCoordinateYChanged()\0"
    "getPublishedChanged()\0getCreatedDateChanged()\0"
    "getCreatedByChanged()\0getUniqueNameChanged()\0"
    "getWorkingTimeChanged()\0getContactNoChanged()\0"
    "getServiceChanged()\0QString\0getTitle\0"
    "getStationID\0getArea\0getZoneNo\0"
    "getDistance\0getDescription\0getID\0"
    "getGeoCoordinateX\0getGeoCoordinateY\0"
    "getPublished\0getCreatedDate\0getCreatedBy\0"
    "getUniqueName\0getWorkingTime\0getContactNo\0"
    "getService\0"
};

void StationListData::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        StationListData *_t = static_cast<StationListData *>(_o);
        switch (_id) {
        case 0: _t->getTitleChanged(); break;
        case 1: _t->getStationIDChanged(); break;
        case 2: _t->getAreaChanged(); break;
        case 3: _t->getZoneNoChanged(); break;
        case 4: _t->getDistanceChanged(); break;
        case 5: _t->getDescriptionChanged(); break;
        case 6: _t->getIDChanged(); break;
        case 7: _t->getGeoCoordinateXChanged(); break;
        case 8: _t->getGeoCoordinateYChanged(); break;
        case 9: _t->getPublishedChanged(); break;
        case 10: _t->getCreatedDateChanged(); break;
        case 11: _t->getCreatedByChanged(); break;
        case 12: _t->getUniqueNameChanged(); break;
        case 13: _t->getWorkingTimeChanged(); break;
        case 14: _t->getContactNoChanged(); break;
        case 15: _t->getServiceChanged(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObjectExtraData StationListData::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject StationListData::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_StationListData,
      qt_meta_data_StationListData, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &StationListData::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *StationListData::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *StationListData::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_StationListData))
        return static_cast<void*>(const_cast< StationListData*>(this));
    return QObject::qt_metacast(_clname);
}

int StationListData::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getTitle(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getStationID(); break;
        case 2: *reinterpret_cast< QString*>(_v) = getArea(); break;
        case 3: *reinterpret_cast< QString*>(_v) = getZoneNo(); break;
        case 4: *reinterpret_cast< QString*>(_v) = getDistance(); break;
        case 5: *reinterpret_cast< QString*>(_v) = getDescription(); break;
        case 6: *reinterpret_cast< QString*>(_v) = getID(); break;
        case 7: *reinterpret_cast< QString*>(_v) = getGeoCoordinateX(); break;
        case 8: *reinterpret_cast< QString*>(_v) = getGeoCoordinateY(); break;
        case 9: *reinterpret_cast< QString*>(_v) = getPublished(); break;
        case 10: *reinterpret_cast< QString*>(_v) = getCreatedDate(); break;
        case 11: *reinterpret_cast< QString*>(_v) = getCreatedBy(); break;
        case 12: *reinterpret_cast< QString*>(_v) = getUniqueName(); break;
        case 13: *reinterpret_cast< QString*>(_v) = getWorkingTime(); break;
        case 14: *reinterpret_cast< QString*>(_v) = getContactNo(); break;
        case 15: *reinterpret_cast< QString*>(_v) = getService(); break;
        }
        _id -= 16;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 16;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 16;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 16;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 16;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 16;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 16;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 16;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void StationListData::getTitleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void StationListData::getStationIDChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void StationListData::getAreaChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void StationListData::getZoneNoChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void StationListData::getDistanceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void StationListData::getDescriptionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void StationListData::getIDChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void StationListData::getGeoCoordinateXChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void StationListData::getGeoCoordinateYChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}

// SIGNAL 9
void StationListData::getPublishedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, 0);
}

// SIGNAL 10
void StationListData::getCreatedDateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, 0);
}

// SIGNAL 11
void StationListData::getCreatedByChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 11, 0);
}

// SIGNAL 12
void StationListData::getUniqueNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 12, 0);
}

// SIGNAL 13
void StationListData::getWorkingTimeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 13, 0);
}

// SIGNAL 14
void StationListData::getContactNoChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 14, 0);
}

// SIGNAL 15
void StationListData::getServiceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 15, 0);
}
QT_END_MOC_NAMESPACE

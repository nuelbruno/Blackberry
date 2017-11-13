/****************************************************************************
** Meta object code from reading C++ file 'PoiData.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/PoiData.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'PoiData.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_PoiData[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       5,   39, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
       9,    8,    8,    8, 0x05,
      29,    8,    8,    8, 0x05,
      53,    8,    8,    8, 0x05,
      78,    8,    8,    8, 0x05,
     102,    8,    8,    8, 0x05,

 // properties: name, type, flags
     130,  122, 0x0a495001,
     141,  122, 0x0a495001,
     156,  122, 0x0a495001,
     169,  122, 0x0a495001,
     186,  181, 0x01495003,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,

       0        // eod
};

static const char qt_meta_stringdata_PoiData[] = {
    "PoiData\0\0getpoinameChanged()\0"
    "getpoilatitudeChanged()\0"
    "getpoilongitudeChanged()\0"
    "getpoidistanceChanged()\0getCheckedChanged()\0"
    "QString\0getpoiname\0getpoilatitude\0"
    "poilongitude\0poidistance\0bool\0getChecked\0"
};

void PoiData::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        PoiData *_t = static_cast<PoiData *>(_o);
        switch (_id) {
        case 0: _t->getpoinameChanged(); break;
        case 1: _t->getpoilatitudeChanged(); break;
        case 2: _t->getpoilongitudeChanged(); break;
        case 3: _t->getpoidistanceChanged(); break;
        case 4: _t->getCheckedChanged(); break;
        default: ;
        }
    }
    Q_UNUSED(_a);
}

const QMetaObjectExtraData PoiData::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject PoiData::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_PoiData,
      qt_meta_data_PoiData, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &PoiData::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *PoiData::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *PoiData::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_PoiData))
        return static_cast<void*>(const_cast< PoiData*>(this));
    return QObject::qt_metacast(_clname);
}

int PoiData::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getpoiname(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getpoilatitude(); break;
        case 2: *reinterpret_cast< QString*>(_v) = poilongitude(); break;
        case 3: *reinterpret_cast< QString*>(_v) = poidistance(); break;
        case 4: *reinterpret_cast< bool*>(_v) = getChecked(); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 4: setChecked(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 5;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void PoiData::getpoinameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void PoiData::getpoilatitudeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void PoiData::getpoilongitudeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void PoiData::getpoidistanceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void PoiData::getCheckedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE

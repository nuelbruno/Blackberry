/****************************************************************************
** Meta object code from reading C++ file 'ADNOC.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/ADNOC.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ADNOC.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ADNOC[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      18,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
       7,    6,    6,    6, 0x05,

 // slots: signature, parameters, type, tag, flags
      41,   29,    6,    6, 0x0a,
      98,   82,    6,    6, 0x0a,
     132,    6,    6,    6, 0x0a,
     148,    6,    6,    6, 0x0a,
     193,  163,    6,    6, 0x0a,

 // methods: signature, parameters, type, tag, flags
     231,  226,    6,    6, 0x02,
     250,  226,    6,    6, 0x02,
     272,  226,    6,    6, 0x02,
     307,  296,    6,    6, 0x02,
     338,    6,    6,    6, 0x02,
     356,  349,    6,    6, 0x02,
     386,    6,  378,    6, 0x02,
     405,    6,  378,    6, 0x02,
     448,  426,    6,    6, 0x02,
     502,  478,  378,    6, 0x02,
     536,    6,  531,    6, 0x02,
     567,  557,    6,    6, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ADNOC[] = {
    "ADNOC\0\0networkStateChanged()\0status,type\0"
    "networkStatusUpdateHandler(bool,QString)\0"
    "geoPositionInfo\0positionUpdated(QGeoPositionInfo)\0"
    "localeChanged()\0onFullscreen()\0"
    "fileName,imageCount,typeMedia\0"
    "manipulatePhoto(QString,int,int)\0data\0"
    "shareOnFB(QString)\0shareOnEmail(QString)\0"
    "shareOnTwitter(QString)\0translator\0"
    "initLocalization(QTranslator*)\0"
    "startGPS()\0locale\0updateLocale(QString)\0"
    "QString\0getCurrentLocale()\0"
    "getCurrentLanguage()\0objectName,inputValue\0"
    "saveValueFor(QString,QString)\0"
    "objectName,defaultValue\0"
    "getValueFor(QString,QString)\0bool\0"
    "isNetworkAvailable()\0mapObject\0"
    "clearPins(QObject*)\0"
};

void ADNOC::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ADNOC *_t = static_cast<ADNOC *>(_o);
        switch (_id) {
        case 0: _t->networkStateChanged(); break;
        case 1: _t->networkStatusUpdateHandler((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 2: _t->positionUpdated((*reinterpret_cast< QGeoPositionInfo(*)>(_a[1]))); break;
        case 3: _t->localeChanged(); break;
        case 4: _t->onFullscreen(); break;
        case 5: _t->manipulatePhoto((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 6: _t->shareOnFB((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->shareOnEmail((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->shareOnTwitter((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->initLocalization((*reinterpret_cast< QTranslator*(*)>(_a[1]))); break;
        case 10: _t->startGPS(); break;
        case 11: _t->updateLocale((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: { QString _r = _t->getCurrentLocale();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 13: { QString _r = _t->getCurrentLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 14: _t->saveValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 15: { QString _r = _t->getValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 16: { bool _r = _t->isNetworkAvailable();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 17: _t->clearPins((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ADNOC::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ADNOC::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ADNOC,
      qt_meta_data_ADNOC, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ADNOC::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ADNOC::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ADNOC::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ADNOC))
        return static_cast<void*>(const_cast< ADNOC*>(this));
    return QObject::qt_metacast(_clname);
}

int ADNOC::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 18)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 18;
    }
    return _id;
}

// SIGNAL 0
void ADNOC::networkStateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE

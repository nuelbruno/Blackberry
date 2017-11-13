/****************************************************************************
** Meta object code from reading C++ file 'MOL.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/MOL.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MOL.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MOL[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      24,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
       5,    4,    4,    4, 0x05,

 // slots: signature, parameters, type, tag, flags
      39,   27,    4,    4, 0x0a,
      96,   80,    4,    4, 0x0a,
     130,    4,    4,    4, 0x0a,
     152,  146,    4,    4, 0x0a,
     179,    4,    4,    4, 0x0a,
     193,    4,    4,    4, 0x0a,

 // methods: signature, parameters, type, tag, flags
     235,  208,    4,    4, 0x02,
     270,    4,    4,    4, 0x02,
     303,  281,    4,    4, 0x02,
     364,  354,    4,    4, 0x02,
     393,  384,    4,    4, 0x02,
     430,  419,    4,    4, 0x02,
     484,  461,    4,    4, 0x02,
     519,  515,    4,    4, 0x02,
     546,  536,    4,    4, 0x02,
     580,  573,    4,    4, 0x02,
     610,    4,  602,    4, 0x02,
     631,    4,  602,    4, 0x02,
     672,  650,    4,    4, 0x02,
     726,  702,  602,    4, 0x02,
     760,    4,  755,    4, 0x02,
     794,    4,  781,    4, 0x02,
     822,  813,    4,    4, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_MOL[] = {
    "MOL\0\0networkStateChanged()\0status,type\0"
    "networkStatusUpdateHandler(bool,QString)\0"
    "geoPositionInfo\0positionUpdated(QGeoPositionInfo)\0"
    "localeChanged()\0title\0onMyButtonClicked(QString)\0"
    "onThumbnail()\0onFullscreen()\0"
    "toMail,subject,description\0"
    "sendEmail(QString,QString,QString)\0"
    "startGPS()\0mapObject,mFrom,title\0"
    "addPinAtCurrentMapCenter(QObject*,QString,QString)\0"
    "mapObject\0clearPins(QObject*)\0filename\0"
    "shareFileWithBBM(QString)\0translator\0"
    "initLocalization(QTranslator*)\0"
    "mContainerButton,title\0"
    "createButton(QObject*,QString)\0url\0"
    "openURL(QString)\0shareLink\0"
    "shareFaceBookLink(QString)\0locale\0"
    "updateLocale(QString)\0QString\0"
    "getCurrentLanguage()\0getCurrentLocale()\0"
    "objectName,inputValue\0"
    "saveValueFor(QString,QString)\0"
    "objectName,defaultValue\0"
    "getValueFor(QString,QString)\0bool\0"
    "isNetworkAvailable()\0QVariantList\0"
    "getENetwasalData()\0fileName\0"
    "manipulatePhoto(QString)\0"
};

void MOL::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MOL *_t = static_cast<MOL *>(_o);
        switch (_id) {
        case 0: _t->networkStateChanged(); break;
        case 1: _t->networkStatusUpdateHandler((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 2: _t->positionUpdated((*reinterpret_cast< QGeoPositionInfo(*)>(_a[1]))); break;
        case 3: _t->localeChanged(); break;
        case 4: _t->onMyButtonClicked((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->onThumbnail(); break;
        case 6: _t->onFullscreen(); break;
        case 7: _t->sendEmail((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 8: _t->startGPS(); break;
        case 9: _t->addPinAtCurrentMapCenter((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3]))); break;
        case 10: _t->clearPins((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        case 11: _t->shareFileWithBBM((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->initLocalization((*reinterpret_cast< QTranslator*(*)>(_a[1]))); break;
        case 13: _t->createButton((*reinterpret_cast< QObject*(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 14: _t->openURL((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 15: _t->shareFaceBookLink((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 16: _t->updateLocale((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 17: { QString _r = _t->getCurrentLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 18: { QString _r = _t->getCurrentLocale();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 19: _t->saveValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 20: { QString _r = _t->getValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 21: { bool _r = _t->isNetworkAvailable();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 22: { QVariantList _r = _t->getENetwasalData();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        case 23: _t->manipulatePhoto((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MOL::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MOL::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MOL,
      qt_meta_data_MOL, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MOL::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MOL::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MOL::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MOL))
        return static_cast<void*>(const_cast< MOL*>(this));
    return QObject::qt_metacast(_clname);
}

int MOL::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 24)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 24;
    }
    return _id;
}

// SIGNAL 0
void MOL::networkStateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE

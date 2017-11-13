/****************************************************************************
** Meta object code from reading C++ file 'WeatherService.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/WeatherService.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'WeatherService.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_WeatherService[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      28,   14, // methods
       7,  154, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: signature, parameters, type, tag, flags
      16,   15,   15,   15, 0x05,
      27,   15,   15,   15, 0x05,
      40,   15,   15,   15, 0x05,
      61,   15,   15,   15, 0x05,
      82,   15,   15,   15, 0x05,
      98,   15,   15,   15, 0x05,

 // slots: signature, parameters, type, tag, flags
     142,  114,   15,   15, 0x0a,
     210,  193,   15,   15, 0x0a,
     267,  246,   15,   15, 0x0a,
     305,   15,   15,   15, 0x0a,
     350,  313,   15,   15, 0x0a,
     401,  396,   15,   15, 0x0a,
     447,  396,   15,   15, 0x0a,
     470,  396,   15,   15, 0x0a,
     496,   15,   15,   15, 0x0a,
     513,  396,   15,   15, 0x0a,
     549,  542,   15,   15, 0x0a,
     572,  396,   15,   15, 0x0a,
     600,   15,   15,   15, 0x08,
     626,  620,   15,   15, 0x08,

 // methods: signature, parameters, type, tag, flags
     666,   15,  658,   15, 0x02,
     686,   15,  658,   15, 0x02,
     712,   15,  658,   15, 0x02,
     731,   15,  658,   15, 0x02,
     755,   15,  658,   15, 0x02,
     784,   15,  658,   15, 0x02,
     809,   15,  658,   15, 0x02,
     868,  835,  658,   15, 0x02,

 // properties: name, type, flags
     923,  658, 0x0a495001,
     935,  658, 0x0a495001,
     952,  947, 0x01495001,
     962,  658, 0x0a495001,
     968,  947, 0x01495001,
    1000,  975, 0x00095409,
    1006,  975, 0x00095409,

 // properties: notify_signal_id
       2,
       3,
       4,
       4,
       5,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_WeatherService[] = {
    "WeatherService\0\0complete()\0dataLoaded()\0"
    "temperatureChanged()\0descriptionChanged()\0"
    "statusChanged()\0activeChanged()\0"
    "langid,CatUniqueName,length\0"
    "requestWeatherInformation(QString,QString,QString)\0"
    "langid,ItemCount\0requestNewlistData(QString,QString)\0"
    "strUniqueName,langid\0"
    "requestNewlistDetail(QString,QString)\0"
    "reset()\0xmlData,host,prefix,request,isSecure\0"
    "callSVC(QString,QString,QString,QString,bool)\0"
    "data\0parsegetFinesbyTrafficFileNumberImpl(QString)\0"
    "parseNewsList(QString)\0parseNewsDetails(QString)\0"
    "getTweetsToken()\0parsegetTweetsToken(QString)\0"
    "tocken\0getTweetsList(QString)\0"
    "parsegetTweetsList(QString)\0"
    "onServiceResponse()\0reply\0"
    "requestFinished(QNetworkReply*)\0QString\0"
    "getNewDetailTitle()\0getNewDetailDescribtion()\0"
    "getNewDetailDate()\0getNewDetailImagePath()\0"
    "getNewDetailCurUnniquename()\0"
    "getNewDetailpreUnqName()\0"
    "getNewDetailNextUnqName()\0"
    "methodName,paramKeys,paramValues\0"
    "getWCFMessageString(QString,QVariantList,QVariantList)\0"
    "temperature\0description\0bool\0succeeded\0"
    "error\0active\0bb::cascades::DataModel*\0"
    "model\0modelPlateList\0"
};

void WeatherService::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        WeatherService *_t = static_cast<WeatherService *>(_o);
        switch (_id) {
        case 0: _t->complete(); break;
        case 1: _t->dataLoaded(); break;
        case 2: _t->temperatureChanged(); break;
        case 3: _t->descriptionChanged(); break;
        case 4: _t->statusChanged(); break;
        case 5: _t->activeChanged(); break;
        case 6: _t->requestWeatherInformation((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3]))); break;
        case 7: _t->requestNewlistData((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 8: _t->requestNewlistDetail((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 9: _t->reset(); break;
        case 10: _t->callSVC((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const bool(*)>(_a[5]))); break;
        case 11: _t->parsegetFinesbyTrafficFileNumberImpl((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->parseNewsList((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->parseNewsDetails((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 14: _t->getTweetsToken(); break;
        case 15: _t->parsegetTweetsToken((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 16: _t->getTweetsList((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 17: _t->parsegetTweetsList((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 18: _t->onServiceResponse(); break;
        case 19: _t->requestFinished((*reinterpret_cast< QNetworkReply*(*)>(_a[1]))); break;
        case 20: { QString _r = _t->getNewDetailTitle();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 21: { QString _r = _t->getNewDetailDescribtion();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 22: { QString _r = _t->getNewDetailDate();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 23: { QString _r = _t->getNewDetailImagePath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 24: { QString _r = _t->getNewDetailCurUnniquename();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 25: { QString _r = _t->getNewDetailpreUnqName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 26: { QString _r = _t->getNewDetailNextUnqName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 27: { QString _r = _t->getWCFMessageString((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QVariantList(*)>(_a[2])),(*reinterpret_cast< const QVariantList(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData WeatherService::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject WeatherService::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_WeatherService,
      qt_meta_data_WeatherService, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &WeatherService::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *WeatherService::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *WeatherService::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_WeatherService))
        return static_cast<void*>(const_cast< WeatherService*>(this));
    return QObject::qt_metacast(_clname);
}

int WeatherService::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 28)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 28;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = temperature(); break;
        case 1: *reinterpret_cast< QString*>(_v) = description(); break;
        case 2: *reinterpret_cast< bool*>(_v) = succeeded(); break;
        case 3: *reinterpret_cast< QString*>(_v) = error(); break;
        case 4: *reinterpret_cast< bool*>(_v) = active(); break;
        case 5: *reinterpret_cast< bb::cascades::DataModel**>(_v) = model(); break;
        case 6: *reinterpret_cast< bb::cascades::DataModel**>(_v) = modelPlateList(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void WeatherService::complete()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void WeatherService::dataLoaded()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void WeatherService::temperatureChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void WeatherService::descriptionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void WeatherService::statusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void WeatherService::activeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}
QT_END_MOC_NAMESPACE

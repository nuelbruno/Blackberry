/****************************************************************************
** Meta object code from reading C++ file 'ADNOCwebservice.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/ADNOCwebservice.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ADNOCwebservice.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ADNOCwebservice[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      31,   14, // methods
       7,  169, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      11,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      28,   16,   16,   16, 0x05,
      41,   16,   16,   16, 0x05,
      57,   16,   16,   16, 0x05,
      75,   16,   16,   16, 0x05,
      92,   16,   16,   16, 0x05,
     108,   16,   16,   16, 0x05,
     124,   16,   16,   16, 0x05,
     145,   16,   16,   16, 0x05,
     166,   16,   16,   16, 0x05,
     182,   16,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
     198,   16,   16,   16, 0x0a,
     236,  206,   16,   16, 0x0a,
     330,  284,   16,   16, 0x0a,
     397,  392,   16,   16, 0x0a,
     435,   16,   16,   16, 0x0a,
     467,  392,   16,   16, 0x0a,
     521,  504,   16,   16, 0x0a,
     584,  563,   16,   16, 0x0a,
     617,  392,   16,   16, 0x0a,
     647,  563,   16,   16, 0x0a,
     681,  392,   16,   16, 0x0a,
     721,  712,   16,   16, 0x0a,
     752,  392,   16,   16, 0x0a,
     880,  788,   16,   16, 0x0a,
    1046,  988,   16,   16, 0x0a,
    1126,   16,   16,   16, 0x08,
    1183, 1146,   16,   16, 0x08,

 // methods: signature, parameters, type, tag, flags
    1242,   16, 1229,   16, 0x02,
    1264,   16, 1229,   16, 0x02,
    1325, 1292, 1284,   16, 0x02,

 // properties: name, type, flags
    1380, 1284, 0x0a495001,
    1392, 1284, 0x0a495001,
    1409, 1404, 0x01495001,
    1419, 1284, 0x0a495001,
    1425, 1404, 0x01495001,
    1457, 1432, 0x00095409,
    1463, 1432, 0x00095409,

 // properties: notify_signal_id
       7,
       8,
       9,
       9,
      10,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_ADNOCwebservice[] = {
    "ADNOCwebservice\0\0complete()\0dataLoaded()\0"
    "dataLoadedSec()\0dataLoadedthird()\0"
    "dataLoadedfour()\0dataLoadAlert()\0"
    "dataLoadFinal()\0temperatureChanged()\0"
    "descriptionChanged()\0statusChanged()\0"
    "activeChanged()\0reset()\0"
    "language,notused,facilityType\0"
    "getAllFacilitiesParent(QString,QString,QString)\0"
    "latitude,longitude,language,category,viewType\0"
    "searchNearByLocation(QString,QString,QString,QString,QString)\0"
    "data\0parseSearchNearByLocation(QtSoapType)\0"
    "parseSearchNearByLocationLIST()\0"
    "parseAllFacilitiesParent(QtSoapType)\0"
    "words,searchType\0"
    "searchDataNearBylocation(QString,QString)\0"
    "websiteID,languageID\0"
    "getNewslistings(QString,QString)\0"
    "parseNewslistings(QtSoapType)\0"
    "getContastusList(QString,QString)\0"
    "parseContastusList(QtSoapType)\0language\0"
    "getMediagalleryImages(QString)\0"
    "parseMediagalleryImages(QtSoapType)\0"
    "fileIMG1,fileIMG2,fileVide1,Name,Email,Phone,FeedType,Location,subject"
    ",description,language\0"
    "submitFeedbackForm(QString,QString,QString,QString,QString,QString,QSt"
    "ring,QString,QString,QString,QString)\0"
    "latitude,longitude,language,facilityArr,category,viewType\0"
    "searchNearByLocationFacilities(QString,QString,QString,QString,QString"
    ",QString)\0"
    "onServiceResponse()\0"
    "xmlData,host,prefix,request,isSecure\0"
    "callSVC(QString,QString,QString,QString,bool)\0"
    "QVariantList\0getQVariantListData()\0"
    "getQVfacilityData()\0QString\0"
    "methodName,paramKeys,paramValues\0"
    "getWCFMessageString(QString,QVariantList,QVariantList)\0"
    "temperature\0description\0bool\0succeeded\0"
    "error\0active\0bb::cascades::DataModel*\0"
    "model\0modelPlateList\0"
};

void ADNOCwebservice::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ADNOCwebservice *_t = static_cast<ADNOCwebservice *>(_o);
        switch (_id) {
        case 0: _t->complete(); break;
        case 1: _t->dataLoaded(); break;
        case 2: _t->dataLoadedSec(); break;
        case 3: _t->dataLoadedthird(); break;
        case 4: _t->dataLoadedfour(); break;
        case 5: _t->dataLoadAlert(); break;
        case 6: _t->dataLoadFinal(); break;
        case 7: _t->temperatureChanged(); break;
        case 8: _t->descriptionChanged(); break;
        case 9: _t->statusChanged(); break;
        case 10: _t->activeChanged(); break;
        case 11: _t->reset(); break;
        case 12: _t->getAllFacilitiesParent((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3]))); break;
        case 13: _t->searchNearByLocation((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 14: _t->parseSearchNearByLocation((*reinterpret_cast< const QtSoapType(*)>(_a[1]))); break;
        case 15: _t->parseSearchNearByLocationLIST(); break;
        case 16: _t->parseAllFacilitiesParent((*reinterpret_cast< const QtSoapType(*)>(_a[1]))); break;
        case 17: _t->searchDataNearBylocation((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 18: _t->getNewslistings((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 19: _t->parseNewslistings((*reinterpret_cast< const QtSoapType(*)>(_a[1]))); break;
        case 20: _t->getContastusList((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 21: _t->parseContastusList((*reinterpret_cast< const QtSoapType(*)>(_a[1]))); break;
        case 22: _t->getMediagalleryImages((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 23: _t->parseMediagalleryImages((*reinterpret_cast< const QtSoapType(*)>(_a[1]))); break;
        case 24: _t->submitFeedbackForm((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5])),(*reinterpret_cast< const QString(*)>(_a[6])),(*reinterpret_cast< const QString(*)>(_a[7])),(*reinterpret_cast< const QString(*)>(_a[8])),(*reinterpret_cast< const QString(*)>(_a[9])),(*reinterpret_cast< const QString(*)>(_a[10])),(*reinterpret_cast< const QString(*)>(_a[11]))); break;
        case 25: _t->searchNearByLocationFacilities((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5])),(*reinterpret_cast< const QString(*)>(_a[6]))); break;
        case 26: _t->onServiceResponse(); break;
        case 27: _t->callSVC((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const bool(*)>(_a[5]))); break;
        case 28: { QVariantList _r = _t->getQVariantListData();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        case 29: { QVariantList _r = _t->getQVfacilityData();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        case 30: { QString _r = _t->getWCFMessageString((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QVariantList(*)>(_a[2])),(*reinterpret_cast< const QVariantList(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ADNOCwebservice::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ADNOCwebservice::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ADNOCwebservice,
      qt_meta_data_ADNOCwebservice, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ADNOCwebservice::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ADNOCwebservice::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ADNOCwebservice::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ADNOCwebservice))
        return static_cast<void*>(const_cast< ADNOCwebservice*>(this));
    return QObject::qt_metacast(_clname);
}

int ADNOCwebservice::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 31)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 31;
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
void ADNOCwebservice::complete()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void ADNOCwebservice::dataLoaded()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void ADNOCwebservice::dataLoadedSec()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void ADNOCwebservice::dataLoadedthird()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void ADNOCwebservice::dataLoadedfour()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void ADNOCwebservice::dataLoadAlert()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void ADNOCwebservice::dataLoadFinal()
{
    QMetaObject::activate(this, &staticMetaObject, 6, 0);
}

// SIGNAL 7
void ADNOCwebservice::temperatureChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, 0);
}

// SIGNAL 8
void ADNOCwebservice::descriptionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, 0);
}

// SIGNAL 9
void ADNOCwebservice::statusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, 0);
}

// SIGNAL 10
void ADNOCwebservice::activeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, 0);
}
QT_END_MOC_NAMESPACE

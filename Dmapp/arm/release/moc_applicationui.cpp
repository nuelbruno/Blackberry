/****************************************************************************
** Meta object code from reading C++ file 'applicationui.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/applicationui.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationui.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ApplicationUI[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      37,   14,   14,   14, 0x08,
      75,   63,   14,   14, 0x0a,
     116,   14,   14,   14, 0x0a,
     132,   14,   14,   14, 0x0a,

 // methods: signature, parameters, type, tag, flags
     154,  147,   14,   14, 0x02,
     185,  174,   14,   14, 0x02,
     221,  216,   14,   14, 0x02,
     240,  216,   14,   14, 0x02,
     262,  216,   14,   14, 0x02,
     286,  216,   14,   14, 0x02,
     315,  216,  310,   14, 0x02,
     344,   14,  310,   14, 0x02,
     372,  365,   14,   14, 0x02,
     402,   14,  394,   14, 0x02,
     423,   14,  394,   14, 0x02,
     442,   14,  310,   14, 0x02,
     475,  453,   14,   14, 0x02,
     529,  505,  394,   14, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_ApplicationUI[] = {
    "ApplicationUI\0\0networkStateChanged()\0"
    "onSystemLanguageChanged()\0status,type\0"
    "networkStatusUpdateHandler(bool,QString)\0"
    "localeChanged()\0onFullscreen()\0number\0"
    "AddContact(QString)\0translator\0"
    "initLocalization(QTranslator*)\0data\0"
    "shareOnFB(QString)\0shareOnEmail(QString)\0"
    "shareOnTwitter(QString)\0shareOnMessage(QString)\0"
    "bool\0copyDataToClipboard(QString)\0"
    "isNetworkAvailable()\0locale\0"
    "updateLocale(QString)\0QString\0"
    "getCurrentLanguage()\0getCurrentLocale()\0"
    "checkGPS()\0objectName,inputValue\0"
    "saveValueFor(QString,QString)\0"
    "objectName,defaultValue\0"
    "getValueFor(QString,QString)\0"
};

void ApplicationUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ApplicationUI *_t = static_cast<ApplicationUI *>(_o);
        switch (_id) {
        case 0: _t->networkStateChanged(); break;
        case 1: _t->onSystemLanguageChanged(); break;
        case 2: _t->networkStatusUpdateHandler((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 3: _t->localeChanged(); break;
        case 4: _t->onFullscreen(); break;
        case 5: _t->AddContact((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->initLocalization((*reinterpret_cast< QTranslator*(*)>(_a[1]))); break;
        case 7: _t->shareOnFB((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->shareOnEmail((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->shareOnTwitter((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 10: _t->shareOnMessage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: { bool _r = _t->copyDataToClipboard((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 12: { bool _r = _t->isNetworkAvailable();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 13: _t->updateLocale((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 14: { QString _r = _t->getCurrentLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 15: { QString _r = _t->getCurrentLocale();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 16: { bool _r = _t->checkGPS();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 17: _t->saveValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 18: { QString _r = _t->getValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ApplicationUI::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ApplicationUI::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationUI,
      qt_meta_data_ApplicationUI, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ApplicationUI::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ApplicationUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ApplicationUI::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationUI))
        return static_cast<void*>(const_cast< ApplicationUI*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    }
    return _id;
}

// SIGNAL 0
void ApplicationUI::networkStateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE

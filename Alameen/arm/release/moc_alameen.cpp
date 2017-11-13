/****************************************************************************
** Meta object code from reading C++ file 'alameen.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/alameen.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'alameen.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_alameen[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
       9,    8,    8,    8, 0x0a,

 // methods: signature, parameters, type, tag, flags
      36,   25,    8,    8, 0x02,
      74,   67,    8,    8, 0x02,
     104,    8,   96,    8, 0x02,
     125,    8,   96,    8, 0x02,
     166,  144,    8,    8, 0x02,
     220,  196,   96,    8, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_alameen[] = {
    "alameen\0\0localeChanged()\0translator\0"
    "initLocalization(QTranslator*)\0locale\0"
    "updateLocale(QString)\0QString\0"
    "getCurrentLanguage()\0getCurrentLocale()\0"
    "objectName,inputValue\0"
    "saveValueFor(QString,QString)\0"
    "objectName,defaultValue\0"
    "getValueFor(QString,QString)\0"
};

void alameen::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        alameen *_t = static_cast<alameen *>(_o);
        switch (_id) {
        case 0: _t->localeChanged(); break;
        case 1: _t->initLocalization((*reinterpret_cast< QTranslator*(*)>(_a[1]))); break;
        case 2: _t->updateLocale((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: { QString _r = _t->getCurrentLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 4: { QString _r = _t->getCurrentLocale();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 5: _t->saveValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 6: { QString _r = _t->getValueFor((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData alameen::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject alameen::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_alameen,
      qt_meta_data_alameen, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &alameen::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *alameen::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *alameen::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_alameen))
        return static_cast<void*>(const_cast< alameen*>(this));
    return QObject::qt_metacast(_clname);
}

int alameen::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE

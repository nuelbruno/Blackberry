/****************************************************************************
** Meta object code from reading C++ file 'DatabaseConnectionApi.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/DatabaseConnectionApi.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'DatabaseConnectionApi.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DatabaseConnectionApi[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       3,   69, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      30,   23,   22,   22, 0x05,
      59,   53,   22,   22, 0x05,
      92,   81,   22,   22, 0x05,
     124,  119,   22,   22, 0x05,
     155,  145,   22,   22, 0x05,

 // slots: signature, parameters, type, tag, flags
     194,  188,   22,   22, 0x08,

 // methods: signature, parameters, type, tag, flags
     243,   22,   22,   22, 0x02,
     278,  266,  250,   22, 0x02,
     316,  307,  250,   22, 0x22,
     341,  266,   22,   22, 0x02,
     363,  307,   22,   22, 0x22,

 // properties: name, type, flags
      23,  381, 0x0a495103,
      53,  381, 0x0a495103,
      81,  381, 0x0a495103,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

static const char qt_meta_stringdata_DatabaseConnectionApi[] = {
    "DatabaseConnectionApi\0\0source\0"
    "sourceChanged(QString)\0query\0"
    "queryChanged(QString)\0connection\0"
    "connectionChanged(QString)\0data\0"
    "dataLoaded(QVariant)\0replyData\0"
    "reply(bb::data::DataAccessReply)\0reply\0"
    "onLoadAsyncResultData(bb::data::DataAccessReply)\0"
    "load()\0DataAccessReply\0criteria,id\0"
    "executeAndWait(QVariant,int)\0criteria\0"
    "executeAndWait(QVariant)\0execute(QVariant,int)\0"
    "execute(QVariant)\0QString\0"
};

void DatabaseConnectionApi::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DatabaseConnectionApi *_t = static_cast<DatabaseConnectionApi *>(_o);
        switch (_id) {
        case 0: _t->sourceChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->queryChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->connectionChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->dataLoaded((*reinterpret_cast< const QVariant(*)>(_a[1]))); break;
        case 4: _t->reply((*reinterpret_cast< const bb::data::DataAccessReply(*)>(_a[1]))); break;
        case 5: _t->onLoadAsyncResultData((*reinterpret_cast< const bb::data::DataAccessReply(*)>(_a[1]))); break;
        case 6: _t->load(); break;
        case 7: { DataAccessReply _r = _t->executeAndWait((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< DataAccessReply*>(_a[0]) = _r; }  break;
        case 8: { DataAccessReply _r = _t->executeAndWait((*reinterpret_cast< const QVariant(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< DataAccessReply*>(_a[0]) = _r; }  break;
        case 9: _t->execute((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 10: _t->execute((*reinterpret_cast< const QVariant(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DatabaseConnectionApi::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DatabaseConnectionApi::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DatabaseConnectionApi,
      qt_meta_data_DatabaseConnectionApi, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DatabaseConnectionApi::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DatabaseConnectionApi::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DatabaseConnectionApi::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DatabaseConnectionApi))
        return static_cast<void*>(const_cast< DatabaseConnectionApi*>(this));
    return QObject::qt_metacast(_clname);
}

int DatabaseConnectionApi::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = source(); break;
        case 1: *reinterpret_cast< QString*>(_v) = query(); break;
        case 2: *reinterpret_cast< QString*>(_v) = connection(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setSource(*reinterpret_cast< QString*>(_v)); break;
        case 1: setQuery(*reinterpret_cast< QString*>(_v)); break;
        case 2: setConnection(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void DatabaseConnectionApi::sourceChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void DatabaseConnectionApi::queryChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void DatabaseConnectionApi::connectionChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void DatabaseConnectionApi::dataLoaded(const QVariant & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void DatabaseConnectionApi::reply(const bb::data::DataAccessReply & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_END_MOC_NAMESPACE

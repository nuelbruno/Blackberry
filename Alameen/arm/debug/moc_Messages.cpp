/****************************************************************************
** Meta object code from reading C++ file 'Messages.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/Messages.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'Messages.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Messages[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       4,   59, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      10,    9,    9,    9, 0x05,

 // slots: signature, parameters, type, tag, flags
      36,   26,    9,    9, 0x0a,
      83,   68,    9,    9, 0x0a,
     125,    9,    9,    9, 0x0a,
     142,    9,    9,    9, 0x0a,
     164,    9,    9,    9, 0x0a,
     178,    9,    9,    9, 0x0a,
     194,    9,    9,    9, 0x08,

 // methods: signature, parameters, type, tag, flags
     226,  211,    9,    9, 0x02,

 // properties: name, type, flags
     278,  248, 0x00095409,
     292,  284, 0x0a495103,
     314,  299, 0x00095409,
     345,  328, 0x00095409,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_Messages[] = {
    "Messages\0\0filterChanged()\0indexPath\0"
    "setCurrentMessage(QVariantList)\0"
    "selectedOption\0setSelectedAccount(bb::cascades::Option*)\0"
    "composeMessage()\0composeReplyMessage()\0"
    "viewMessage()\0deleteMessage()\0"
    "filterMessages()\0dropDownObject\0"
    "addAccounts(QObject*)\0"
    "bb::cascades::GroupDataModel*\0model\0"
    "QString\0filter\0MessageViewer*\0"
    "messageViewer\0MessageComposer*\0"
    "messageComposer\0"
};

void Messages::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        Messages *_t = static_cast<Messages *>(_o);
        switch (_id) {
        case 0: _t->filterChanged(); break;
        case 1: _t->setCurrentMessage((*reinterpret_cast< const QVariantList(*)>(_a[1]))); break;
        case 2: _t->setSelectedAccount((*reinterpret_cast< bb::cascades::Option*(*)>(_a[1]))); break;
        case 3: _t->composeMessage(); break;
        case 4: _t->composeReplyMessage(); break;
        case 5: _t->viewMessage(); break;
        case 6: _t->deleteMessage(); break;
        case 7: _t->filterMessages(); break;
        case 8: _t->addAccounts((*reinterpret_cast< QObject*(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData Messages::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject Messages::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Messages,
      qt_meta_data_Messages, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &Messages::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *Messages::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *Messages::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Messages))
        return static_cast<void*>(const_cast< Messages*>(this));
    return QObject::qt_metacast(_clname);
}

int Messages::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bb::cascades::GroupDataModel**>(_v) = model(); break;
        case 1: *reinterpret_cast< QString*>(_v) = filter(); break;
        case 2: *reinterpret_cast< MessageViewer**>(_v) = messageViewer(); break;
        case 3: *reinterpret_cast< MessageComposer**>(_v) = messageComposer(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 1: setFilter(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void Messages::filterChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE

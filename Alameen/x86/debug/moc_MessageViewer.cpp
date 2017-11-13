/****************************************************************************
** Meta object code from reading C++ file 'MessageViewer.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/MessageViewer.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MessageViewer.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MessageViewer[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       4,   39, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      15,   14,   14,   14, 0x05,
      32,   14,   14,   14, 0x05,
      48,   14,   14,   14, 0x05,
      62,   14,   14,   14, 0x05,

 // slots: signature, parameters, type, tag, flags
      80,   76,   14,   14, 0x08,

 // properties: name, type, flags
     228,  220, 0x0a495001,
     236,  220, 0x0a495001,
     243,  220, 0x0a495001,
     248,  220, 0x0a495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

       0        // eod
};

static const char qt_meta_stringdata_MessageViewer[] = {
    "MessageViewer\0\0subjectChanged()\0"
    "senderChanged()\0timeChanged()\0"
    "bodyChanged()\0,,,\0"
    "messageUpdated(bb::pim::account::AccountKey,bb::pim::message::Conversa"
    "tionKey,bb::pim::message::MessageKey,bb::pim::message::MessageUpdate)\0"
    "QString\0subject\0sender\0time\0body\0"
};

void MessageViewer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MessageViewer *_t = static_cast<MessageViewer *>(_o);
        switch (_id) {
        case 0: _t->subjectChanged(); break;
        case 1: _t->senderChanged(); break;
        case 2: _t->timeChanged(); break;
        case 3: _t->bodyChanged(); break;
        case 4: _t->messageUpdated((*reinterpret_cast< bb::pim::account::AccountKey(*)>(_a[1])),(*reinterpret_cast< bb::pim::message::ConversationKey(*)>(_a[2])),(*reinterpret_cast< bb::pim::message::MessageKey(*)>(_a[3])),(*reinterpret_cast< const bb::pim::message::MessageUpdate(*)>(_a[4]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MessageViewer::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MessageViewer::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MessageViewer,
      qt_meta_data_MessageViewer, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MessageViewer::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MessageViewer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MessageViewer::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MessageViewer))
        return static_cast<void*>(const_cast< MessageViewer*>(this));
    return QObject::qt_metacast(_clname);
}

int MessageViewer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
        case 0: *reinterpret_cast< QString*>(_v) = subject(); break;
        case 1: *reinterpret_cast< QString*>(_v) = senderContact(); break;
        case 2: *reinterpret_cast< QString*>(_v) = time(); break;
        case 3: *reinterpret_cast< QString*>(_v) = body(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
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
void MessageViewer::subjectChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void MessageViewer::senderChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void MessageViewer::timeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void MessageViewer::bodyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE

/****************************************************************************
** Meta object code from reading C++ file 'MessageComposer.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/MessageComposer.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'MessageComposer.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MessageComposer[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       4,   49, // properties
       1,   65, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      34,   16,   16,   16, 0x05,
      53,   16,   16,   16, 0x05,
      67,   16,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
      91,   81,   16,   16, 0x0a,
     133,   16,   16,   16, 0x0a,
     150,   16,   16,   16, 0x0a,

 // properties: name, type, flags
     166,  158, 0x0a495103,
     174,  158, 0x0a495103,
     184,  158, 0x0a495103,
     194,  189, 0x0049510b,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,

 // enums: name, flags, count, data
     189, 0x0,    2,   69,

 // enum data: key, value
     199, uint(MessageComposer::CreateMode),
     210, uint(MessageComposer::ReplyMode),

       0        // eod
};

static const char qt_meta_stringdata_MessageComposer[] = {
    "MessageComposer\0\0subjectChanged()\0"
    "recipientChanged()\0bodyChanged()\0"
    "modeChanged()\0messageId\0"
    "loadMessage(bb::pim::message::MessageKey)\0"
    "composeMessage()\0reset()\0QString\0"
    "subject\0recipient\0body\0Mode\0mode\0"
    "CreateMode\0ReplyMode\0"
};

void MessageComposer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MessageComposer *_t = static_cast<MessageComposer *>(_o);
        switch (_id) {
        case 0: _t->subjectChanged(); break;
        case 1: _t->recipientChanged(); break;
        case 2: _t->bodyChanged(); break;
        case 3: _t->modeChanged(); break;
        case 4: _t->loadMessage((*reinterpret_cast< bb::pim::message::MessageKey(*)>(_a[1]))); break;
        case 5: _t->composeMessage(); break;
        case 6: _t->reset(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MessageComposer::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MessageComposer::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MessageComposer,
      qt_meta_data_MessageComposer, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MessageComposer::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MessageComposer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MessageComposer::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MessageComposer))
        return static_cast<void*>(const_cast< MessageComposer*>(this));
    return QObject::qt_metacast(_clname);
}

int MessageComposer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = subject(); break;
        case 1: *reinterpret_cast< QString*>(_v) = recipient(); break;
        case 2: *reinterpret_cast< QString*>(_v) = body(); break;
        case 3: *reinterpret_cast< Mode*>(_v) = mode(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setSubject(*reinterpret_cast< QString*>(_v)); break;
        case 1: setRecipient(*reinterpret_cast< QString*>(_v)); break;
        case 2: setBody(*reinterpret_cast< QString*>(_v)); break;
        case 3: setMode(*reinterpret_cast< Mode*>(_v)); break;
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
void MessageComposer::subjectChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void MessageComposer::recipientChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void MessageComposer::bodyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void MessageComposer::modeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE

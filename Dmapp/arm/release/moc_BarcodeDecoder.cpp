/****************************************************************************
** Meta object code from reading C++ file 'BarcodeDecoder.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/BarcodeDecoder.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'BarcodeDecoder.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_bb__community__barcode__BarcodeDecoderControl[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      55,   47,   46,   46, 0x05,
      83,   46,   46,   46, 0x05,
     101,   46,   46,   46, 0x05,

 // slots: signature, parameters, type, tag, flags
     158,  119,   46,   46, 0x0a,
     251,   46,   46,   46, 0x0a,
     268,   46,   46,   46, 0x0a,
     290,   46,   46,   46, 0x0a,
     306,   46,   46,   46, 0x0a,

       0        // eod
};

static const char qt_meta_stringdata_bb__community__barcode__BarcodeDecoderControl[] = {
    "bb::community::barcode::BarcodeDecoderControl\0"
    "\0barcode\0newBarcodeDetected(QString)\0"
    "scanningStarted()\0scanningStopped()\0"
    "previewBuffer,size,width,height,stride\0"
    "onPreviewFrameAvailable(bb::cascades::multimedia::SharedUCharPointer,q"
    "uint64,uint,uint,uint)\0"
    "onCameraOpened()\0onViewfinderStopped()\0"
    "startScanning()\0stopScanning()\0"
};

void bb::community::barcode::BarcodeDecoderControl::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        BarcodeDecoderControl *_t = static_cast<BarcodeDecoderControl *>(_o);
        switch (_id) {
        case 0: _t->newBarcodeDetected((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->scanningStarted(); break;
        case 2: _t->scanningStopped(); break;
        case 3: _t->onPreviewFrameAvailable((*reinterpret_cast< bb::cascades::multimedia::SharedUCharPointer(*)>(_a[1])),(*reinterpret_cast< quint64(*)>(_a[2])),(*reinterpret_cast< uint(*)>(_a[3])),(*reinterpret_cast< uint(*)>(_a[4])),(*reinterpret_cast< uint(*)>(_a[5]))); break;
        case 4: _t->onCameraOpened(); break;
        case 5: _t->onViewfinderStopped(); break;
        case 6: _t->startScanning(); break;
        case 7: _t->stopScanning(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData bb::community::barcode::BarcodeDecoderControl::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject bb::community::barcode::BarcodeDecoderControl::staticMetaObject = {
    { &bb::cascades::CustomControl::staticMetaObject, qt_meta_stringdata_bb__community__barcode__BarcodeDecoderControl,
      qt_meta_data_bb__community__barcode__BarcodeDecoderControl, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &bb::community::barcode::BarcodeDecoderControl::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *bb::community::barcode::BarcodeDecoderControl::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *bb::community::barcode::BarcodeDecoderControl::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_bb__community__barcode__BarcodeDecoderControl))
        return static_cast<void*>(const_cast< BarcodeDecoderControl*>(this));
    typedef bb::cascades::CustomControl QMocSuperClass;
    return QMocSuperClass::qt_metacast(_clname);
}

int bb::community::barcode::BarcodeDecoderControl::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    typedef bb::cascades::CustomControl QMocSuperClass;
    _id = QMocSuperClass::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void bb::community::barcode::BarcodeDecoderControl::newBarcodeDetected(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void bb::community::barcode::BarcodeDecoderControl::scanningStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void bb::community::barcode::BarcodeDecoderControl::scanningStopped()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE

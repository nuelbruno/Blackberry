/****************************************************************************
** Meta object code from reading C++ file 'DownloadManager.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../src/DownloadManager.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'DownloadManager.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DownloadManager[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       6,   74, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      39,   16,   16,   16, 0x05,
      62,   16,   16,   16, 0x05,
      87,   16,   16,   16, 0x05,
     110,   16,   16,   16, 0x05,
     133,   16,   16,   16, 0x05,
     167,  158,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
     198,  194,   16,   16, 0x0a,
     219,   16,   16,   16, 0x08,
     264,  239,   16,   16, 0x08,
     296,   16,   16,   16, 0x08,
     315,   16,   16,   16, 0x08,

 // properties: name, type, flags
     343,  335, 0x0a495001,
     356,  335, 0x0a495001,
     374,  370, 0x02495001,
     390,  370, 0x02495001,
     404,  370, 0x02495001,
     418,  335, 0x0a495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,

       0        // eod
};

static const char qt_meta_stringdata_DownloadManager[] = {
    "DownloadManager\0\0errorMessageChanged()\0"
    "statusMessageChanged()\0activeDownloadsChanged()\0"
    "progressTotalChanged()\0progressValueChanged()\0"
    "progressMessageChanged()\0basename\0"
    "downloadCompleted(QString)\0url\0"
    "downloadUrl(QString)\0startNextDownload()\0"
    "bytesReceived,bytesTotal\0"
    "downloadProgress(qint64,qint64)\0"
    "downloadFinished()\0downloadReadyRead()\0"
    "QString\0errorMessage\0statusMessage\0"
    "int\0activeDownloads\0progressTotal\0"
    "progressValue\0progressMessage\0"
};

void DownloadManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DownloadManager *_t = static_cast<DownloadManager *>(_o);
        switch (_id) {
        case 0: _t->errorMessageChanged(); break;
        case 1: _t->statusMessageChanged(); break;
        case 2: _t->activeDownloadsChanged(); break;
        case 3: _t->progressTotalChanged(); break;
        case 4: _t->progressValueChanged(); break;
        case 5: _t->progressMessageChanged(); break;
        case 6: _t->downloadCompleted((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->downloadUrl((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 8: _t->startNextDownload(); break;
        case 9: _t->downloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 10: _t->downloadFinished(); break;
        case 11: _t->downloadReadyRead(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DownloadManager::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DownloadManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DownloadManager,
      qt_meta_data_DownloadManager, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DownloadManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DownloadManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DownloadManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DownloadManager))
        return static_cast<void*>(const_cast< DownloadManager*>(this));
    return QObject::qt_metacast(_clname);
}

int DownloadManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = errorMessage(); break;
        case 1: *reinterpret_cast< QString*>(_v) = statusMessage(); break;
        case 2: *reinterpret_cast< int*>(_v) = activeDownloads(); break;
        case 3: *reinterpret_cast< int*>(_v) = progressTotal(); break;
        case 4: *reinterpret_cast< int*>(_v) = progressValue(); break;
        case 5: *reinterpret_cast< QString*>(_v) = progressMessage(); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 6;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 6;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void DownloadManager::errorMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void DownloadManager::statusMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void DownloadManager::activeDownloadsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void DownloadManager::progressTotalChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void DownloadManager::progressValueChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void DownloadManager::progressMessageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}

// SIGNAL 6
void DownloadManager::downloadCompleted(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_END_MOC_NAMESPACE

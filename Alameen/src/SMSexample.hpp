// Default empty project template
#ifndef SMSexample_HPP_
#define SMSexample_HPP_

#include <QObject>
#include <QtCore/QtCore>
#include <QString>
#include <bb/cascades/Application>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class SMSexample : public QObject
{
    Q_OBJECT
public:
    SMSexample(QObject *parent);
   // virtual ~SMSexample() {}

	Q_INVOKABLE void sendSMS(QString regID, QString contactNumber);
	Q_INVOKABLE void showSuccessMessage();

};


#endif /* SMSexample_HPP_ */

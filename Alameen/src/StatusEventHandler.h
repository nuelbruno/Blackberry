/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
#ifndef STATUSEVENTHANDLER_H_
#define STATUSEVENTHANDLER_H_

#include <QObject>
#include <QString>
#include <bb/AbstractBpsEventHandler>

class StatusEventHandler: public QObject, public bb::AbstractBpsEventHandler {
    Q_OBJECT

public:
    StatusEventHandler();
    virtual ~StatusEventHandler();
    virtual void event(bps_event_t *event);

signals:
	void networkStatusUpdated(bool status, QString type);
	void localeUpdated(QString language, QString country, QString locale);
};

#endif /* STATUSEVENTHANDLER_H_ */

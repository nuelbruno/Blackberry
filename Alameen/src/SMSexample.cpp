// Default empty project template
#include "SMSexample.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

#include <bb/system/SystemToast>

#include <bb/pim/message/ConversationBuilder>
#include <bb/pim/message/MessageBuilder>
#include <bb/pim/message/MessageService>
#include <bb/pim/message/MessageContact>
#include <bb/pim/account/AccountService>

#include <bb/cascades/Page>
#include <QSettings>

using namespace bb::cascades;
using namespace bb::pim::account;

SMSexample::SMSexample(QObject *parent)
: QObject(parent){

}

// Following lines are for SMS sending (all of them)
void SMSexample::sendSMS(QString regID, QString contactNumber) {
	bb::pim::message::MessageService messageService;
	bb::pim::account::AccountService accountService;

	//Get the SMS/MMS account
	QList<Account> accountList = accountService.accounts(Service::Messages,"sms-mms");
	AccountKey accountId = accountList.first().id();

	// Create a contact to whom you want to send sms/mms.
	int contactKey = -1;
	bb::pim::message::MessageContact recipient = bb::pim::message::MessageContact(contactKey,bb::pim::message::MessageContact::To,contactNumber,contactNumber);

	//Create a conversation  because sms/mms chats most of the time is a conversation
    bb::pim::message::ConversationBuilder* conversationBuilder = bb::pim::message::ConversationBuilder::create();
    conversationBuilder->accountId(accountId);
    QList<bb::pim::message::MessageContact>participants;
    participants.append(recipient);
    conversationBuilder->participants(participants);
    bb::pim::message::Conversation conversation = *conversationBuilder;
    bb::pim::message::ConversationKey conversationId = messageService.save(accountId,conversation);

	//Create a message Builder for sms/mms
	bb::pim::message::MessageBuilder* messageBuilder = bb::pim::message::MessageBuilder::create(accountId);
	messageBuilder->addRecipient(recipient);
	// SMS API's handle body as an attachment.
	QString body = regID;
	messageBuilder->addAttachment(bb::pim::message::Attachment("text/plain", "body.txt", body));
	messageBuilder->conversationId(conversationId);
	bb::pim::message::Message message;
	message = *messageBuilder;

	//Sending SMS/MMS
	//messageService.send(accountId, message);
	bb::pim::message::MessageKey key = messageService.send(accountId, message);

	showSuccessMessage();
}

void SMSexample::showSuccessMessage() {
	using namespace bb::system;

	SystemToast *toast = new SystemToast(this);

    toast->setBody("SMS sending success!");
    toast->show();
}

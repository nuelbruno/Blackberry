#include "DatabaseConnectionApi.h"

int const DatabaseConnectionApi::LOAD_EXECUTION = 0;

DatabaseConnectionApi::DatabaseConnectionApi(QObject *parent) :
		QObject(parent) {

}

DatabaseConnectionApi::~DatabaseConnectionApi() {
	delete mSqlConnector;
}

void DatabaseConnectionApi::copyFileToDataFolder(const QString fileName) {
	// Since we need read and write access to the file, it has
	// to be moved to a folder where we have access to it. First,
	// we check if the file already exists (previously copied).
	QString dataFolder = QDir::homePath();
	QString newFileName = dataFolder + "/" + fileName;
	QFile newFile(newFileName);

	if (!newFile.exists()) {
		// If the file is not already in the data folder, we copy it from the
		// assets folder (read only) to the data folder (read and write).
		QString appFolder(QDir::homePath());
		appFolder.chop(4);
		QString originalFileName = appFolder + "app/native/assets/" + fileName;
		QFile originalFile(originalFileName);

		if (originalFile.exists()) {
			// Create sub folders if any creates the SQL folder for a file path like e.g. sql/quotesdb
			QFileInfo fileInfo(newFileName);
			QDir().mkpath(fileInfo.dir().path());

			if (!originalFile.copy(newFileName)) {
				qDebug() << "Failed to copy file to path: " << newFileName;
			}
		} else {
			qDebug() << "Failed to copy file data base file does not exists.";
		}
	}

	mSourceInDataFolder = newFileName;
}

void DatabaseConnectionApi::setSource(const QString source) {
	if (mSource.compare(source) != 0) {
		// Copy the file to the data folder to get read and write access.
		copyFileToDataFolder(source);
		mSource = source;
		emit sourceChanged(mSource);
	}
}

QString DatabaseConnectionApi::source() {
	return mSource;
}
void DatabaseConnectionApi::setConnection(const QString connection) {

	mConnection = connection;
	emit connectionChanged(mConnection);

}
QString DatabaseConnectionApi::connection() {
	return mConnection;
}

void DatabaseConnectionApi::setQuery(const QString query) {
	if (mQuery.compare(query) != 0) {
		mQuery = query;
		emit queryChanged(mQuery);
	}
}

QString DatabaseConnectionApi::query() {

	qDebug() << "Query:" << mQuery;

	return mQuery;
}

bool DatabaseConnectionApi::checkConnection() {
	if (mSqlConnector) {
		return true;
	} else {
		QFile newFile(mSourceInDataFolder);

		if (newFile.exists()) {

			// Remove the old connection if it exists
			if (mSqlConnector) {
				disconnect(mSqlConnector,
						SIGNAL(reply(const bb::data::DataAccessReply&)),
						this,
						SLOT(onLoadAsyncResultData(const bb::data::DataAccessReply&)));
				delete mSqlConnector;
			}

			// Set up a connection to the data base
			mSqlConnector = new SqlConnection(mSourceInDataFolder, mConnection);

			// Connect to the reply function
			connect(mSqlConnector,
					SIGNAL(reply(const bb::data::DataAccessReply&)), this,
					SLOT(onLoadAsyncResultData(const bb::data::DataAccessReply&)));

			return true;

		} else {
			qDebug()
					<< "CustomSqlDataSource::checkConnection Failed to load data base, file does not exist.";
		}
	}
	return false;
}

DataAccessReply DatabaseConnectionApi::executeAndWait(const QVariant &criteria,
		int id) {
	DataAccessReply reply;

	if (checkConnection()) {
		reply = mSqlConnector->executeAndWait(criteria, id);

		if (reply.hasError()) {
			qWarning() << "DatabaseConnectionApi::executeAndWait error "
					<< reply;
		}
	}
	return reply;
}

void DatabaseConnectionApi::execute(const QVariant &criteria, int id) {
	if (checkConnection()) {
		mSqlConnector->execute(criteria, id);
	}
}

void DatabaseConnectionApi::load() {
	qDebug() << " = >" << mQuery;

	if (mQuery.isEmpty() == false) {
		execute(mQuery, LOAD_EXECUTION);
	}
}

void DatabaseConnectionApi::onLoadAsyncResultData(
		const bb::data::DataAccessReply& replyData) {
	qDebug() << "replyData = " << replyData;

	if (replyData.hasError()) {
		qWarning() << "onLoadAsyncResultData: " << replyData.id()
				<< ", SQL error: " << replyData;

	} else {

		if (replyData.id() == LOAD_EXECUTION) {
			// The reply belongs to the execution of the query property of the data source
			// Emit the the data loaded signal so that the model can be populated.
			QVariantList resultList = replyData.result().value<QVariantList>();
			emit dataLoaded(resultList);
		} else {
			// Forward the reply signal.
			emit reply(replyData);
		}
	}
}


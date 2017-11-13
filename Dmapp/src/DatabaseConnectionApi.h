#ifndef QUOTESSQLDATASOURCE_H_
#define QUOTESSQLDATASOURCE_H_

#include <QObject>
#include <bb/data/DataSource>
#include <bb/data/SqlConnection>

using namespace bb::data;

namespace bb {
namespace data {
class SqlConnection;
}
}
/**
 * QuotesSqlDataSource Description:
 *
 * A custom data source for accessing a SQL data source, with the ability
 * to execute SQL queries.
 */
class DatabaseConnectionApi: public QObject {
	Q_OBJECT

	/**
	 * The path to the SQL database.
	 */
	Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

	/**
	 * The initial query that will be run on the database.
	 */
	Q_PROPERTY(QString query READ query WRITE setQuery NOTIFY queryChanged)

	Q_PROPERTY(QString connection READ connection WRITE setConnection NOTIFY connectionChanged)

public:
	DatabaseConnectionApi(QObject *parent = 0);
	~DatabaseConnectionApi();

	/**
	 * Sets the path to the SQK database
	 *
	 * @param newStatusText the new string
	 */
	void setSource(const QString source);

	/**
	 * Returns the current source path used by the data source
	 *
	 * @return A string for the current source path
	 */
	QString source();

	/**
	 * Sets the SQL query that should be executed.
	 *
	 * @param query The new SQL query.
	 */
	void setQuery(const QString query);

	void setConnection(const QString connection);

	QString connection();

	/**
	 * The query property contains an SQL query.
	 *
	 * @return A string containing the query.
	 */
	QString query();

	/**
	 * Loads the data from the data source.
	 */
	Q_INVOKABLE
	void load();

	/**
	 * Executes a SQL query on the database the execution will block and wait for a result.
	 * The id has to greater than or equal to 1 (0 is reserved for loading data using the query property)
	 *
	 * @param The query which should be executed
	 * @param An id that can be used to match requests
	 */
	Q_INVOKABLE
	DataAccessReply executeAndWait(const QVariant &criteria, int id = 1);

	/**
	 * Executes a SQL query on the database the execution is non blocking the result will be delivered
	 * in the dataLoaded signal. The id has to greater than or equal to 1 (0 is reserved
	 * for loading data using the query property)
	 *
	 * @param The query which should be executed
	 * @param An id that can be used to match requests
	 */
	Q_INVOKABLE
	void execute(const QVariant &criteria, int id = 1);signals:

	/**
	 * Emitted when the source path changes
	 *
	 * @param A string containing the new source
	 */
	void sourceChanged(QString source);

	/**
	 * Emitted when the query changes
	 *
	 * @param A string containing the new query
	 */
	void queryChanged(QString query);

	void connectionChanged(QString connection);

	/**
	 * Emitted when data has been recieved.
	 *
	 * @param A variant containing the new data.
	 */
	void dataLoaded(const QVariant &data);

	/**
	 * Emitted when an asynchronous execute operation has completed and has results to return.
	 *
	 * @param replyData The reply data from the execute operation.
	 */
	void reply(const bb::data::DataAccessReply &replyData);

private slots:
	/**
	 * Function that is connected to the SqlConnection reply signal.
	 *
	 * @param reply The reply data delivered from the asynchronous request to the SqlConnection
	 */
	void onLoadAsyncResultData(const bb::data::DataAccessReply& reply);

private:
	/**
	 * Helper function for moving a file from the assets folder to the
	 * read writable applicaiton data folder.
	 *
	 * @param fileName The name of the file that should be moved.
	 */
	void copyFileToDataFolder(const QString fileName);
	bool checkConnection();

	QString mSource;
	QString mQuery;
	QString mSourceInDataFolder;
	QString mConnection;

	// Data base connector
	SqlConnection *mSqlConnector;

	DataSource *mDataSource;

	static int const LOAD_EXECUTION;

};

#endif /* QUOTESDATASOURCE_H_ */

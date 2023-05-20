#include "taskcarditemlist.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
	QSqlDatabase db;
	db = QSqlDatabase::addDatabase("QSQLITE");
	db.setDatabaseName("E:/MyTESTFILE/PET_PROJECT/PET_github/TOMATODO/TOMATODO_QtQuick/TOMATODO/db/tomatodoDB.db");

	bool connectStatus = db.open();

	qDebug()<< "Connection to db" << connectStatus;

	TaskCardItemList *taskCardItemList = new TaskCardItemList();

	engine.rootContext()->setContextProperty("myModel", taskCardItemList);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

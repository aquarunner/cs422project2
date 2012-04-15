#ifndef SETTINGS_H
#define SETTINGS_H

#include <QDeclarativeItem>
#include <string>
#include <vector>
#include <map>
#include <fstream>
#include <sstream>
#include <dirent.h>
#include <dir.h>

#define _DEFAULT_SETTINGS_FILE "settings.ini"

using namespace std;

class Settings : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(QString iniPath READ getPath WRITE setPath)
public:
    explicit Settings (QDeclarativeItem *parent = 0);

private:
    map< string, map<string, string> > settingsFiles;
    vector<string> findSettingsFiles();
    string iniPath;
    QString iniPrefix;

public:
    Q_INVOKABLE QString getPath();
    Q_INVOKABLE void setPath(QString path = "");
    Q_INVOKABLE void setSetting(QString key, QString val, QString app = "", QString prefix = "");
    Q_INVOKABLE QString getSetting(QString key, QString app = "", QString prefix = "");
    Q_INVOKABLE void save(string appfile = "");

private:
    void load();
    void writeFile(string);

signals:
    void settingsChanged();

public slots:

};

QML_DECLARE_TYPE(Settings)

#endif // SETTINGS_H

#include "settings.h"

Settings::Settings(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
    load();
}

// Find settings files in the working directory,
// read them into the settings files map in memory.
void Settings::load()
{
    //ofstream help("help.txt", ios::app);

    ifstream file;
    string line;
    string key;
    string val;

    // Get a list of all settings files
    vector<string> files = findSettingsFiles();

    // Iterate each settings file
    for (int i = 0; i < (int)files.size(); ++i) {

        string filename;

        if (!iniPrefix.isEmpty())
            filename = iniPrefix.toStdString() + files[i];
        else
            filename = iniPath + files[i];

        //help << filename << endl;
        file.open(filename.c_str());

        if (!file.is_open()) {
            return;
        }

        // For each file, create a separate settings map
        map<string, string> settings;

        while (!file.eof()) {
            getline(file, line);

            // Abort if there's nothing to read
            if (file.eof() && line.length() <= 1)
                break;

            // Skip lines starting with ';', these are
            // comments in the file
            if (line[0] == ';')
                continue;

            unsigned colon = line.find_first_of(":");

            if (colon == line.npos)
                continue;

            key = line.substr(0, colon);
            val = line.substr(colon + 1);

            unsigned content = val.find_first_not_of(" ");

            // If there is no value (nothing after the colon),
            // let val be the empty string
            if (content == val.npos) {
                val = "";
            } else {
                val = val.substr(content);
            }

            // Store the variable (key) and its value (val)
            // in the settings map for this file
            settings[key] = val;
        }

        // Add the file (files[i]) and its settings map (settings)
        // to the settingsFiles map
        settingsFiles[files[i]] = settings;

        file.close();
    }
}

// appfile is optional.
// If appfile specified, save that file.
// If no appfile specified, save all files.
void Settings::save(string appfile)
{
    // If specifying a particular app / file
    if (appfile != "") {
        writeFile(appfile);
    }
    else // save all files
    {
        map<string, map<string, string> >::iterator j;
        for (j = settingsFiles.begin(); j != settingsFiles.end(); ++j) {
            appfile = (*j).first;
            writeFile(appfile);
        }
    }
}

// app is optional
// If app is specified, save the variable and value in that
// app file.  Otherwise, save it in the default settings file.
void Settings::setSetting(QString key, QString val, QString app, QString prefix)
{
    if (!prefix.isEmpty())
        iniPrefix = prefix;

    string appfile;

    if (app.isEmpty())
        appfile = _DEFAULT_SETTINGS_FILE;
    else
        appfile = QString(app + ".ini").toStdString(); /* WARNING */
    /*
        We are not checking the app name is also a valid file name.
        Be sensible with app names.  E.g., no spaces.  Otherwise
        writeFile() will fail.

        If there were such a check, here is where it should go.
    */

    // Start with an empty settings map
    map<string, string> settings;

    // If an existing settings map for this file exists
    // import that one
    if (settingsFiles.find(appfile) != settingsFiles.end())
        settings = settingsFiles[appfile];

    string k = key.toStdString();
    string v = val.toStdString();

    // Store the setting, overwriting the old one if necessary
    settings[k] = v;

    // Store the updated settings map
    settingsFiles[appfile] = settings;

    save(appfile);
}

// app is optional.  If specified, and the setting you are
// looking for (key) exists, return the setting for that file
// If no app specified, return the setting from the default
// settings file.  Otherwise, returns empty string.
QString Settings::getSetting(QString key, QString app, QString prefix)
{
    if (!prefix.isEmpty()) {
        iniPrefix = prefix;
        load();
        iniPrefix.clear();
    }

    string appfile;
    QString result;

    if (app.isEmpty())
        appfile = _DEFAULT_SETTINGS_FILE;
    else
        appfile = QString(app + ".ini").toStdString();

    // Returns empty string if the settings file
    // does not exist
    if (settingsFiles.find(appfile) == settingsFiles.end())
        return result;

    // References the existing settings map
    map<string, string> &settings = settingsFiles[appfile];

    // Returns empty string if the setting does not exist
    // for that file
    if (settings.find(key.toStdString()) == settings.end())
        return result;

    result = QString::fromStdString(settings[key.toStdString()]);

    return result;
}

// Look for ini files on the hard drive in the working directory
// and put the file names in a vector
vector<string> Settings::findSettingsFiles()
{
    //ofstream f("help.txt", ios::app);
    vector<string> result;

    string d;
    if (!iniPrefix.isEmpty()) {
        d = iniPrefix.toStdString();
    }
    else if (!iniPath.empty()) {
        d = iniPath;
    }
    else {
        d = ".";
    }

    DIR* dir = opendir(d.c_str());
    //f << d << endl;


    if (dir == 0)
        return result;

    struct dirent* direntry;
    string filename;

    while ((direntry = readdir(dir)) != 0)
    {
        filename = string(direntry->d_name);

        if (filename.find(".ini") != string::npos)
            result.push_back(filename);
    }

    closedir(dir);

    return result;
}

// Write the contents of any settings file,
// or abort if no settings file exists.
void Settings::writeFile(string filename)
{
    if (settingsFiles.find(filename) == settingsFiles.end())
        return;

    ofstream file;
    string result = ";" + filename + "\n";

    string path;
    // iniPrefix overrides iniPath
    if (!iniPrefix.isEmpty()) {
        path = iniPrefix.toStdString() + filename;
        iniPrefix.clear();
    } else {
        // Add the path prefix
        path = iniPath + filename;
    }


    // Clears previous contents if there were any
    file.open(path.c_str());

    if (!file.is_open())
        return;

    map<string, string>::iterator i;

    // Get a reference to the existing settings map
    map<string, string> &settings = settingsFiles[filename];

    // Append the variable (first) and its value (second)
    // to the file contents
    for (i = settings.begin(); i != settings.end(); ++i) {
        result += (*i).first + ": " + (*i).second + "\n";
    }

    // Insert the file contents into the file
    file << result;

    file.close();

}


QString Settings::getPath()
{
    return QString::fromStdString(iniPath);
}


void Settings::setPath(QString path)
{
    iniPath = path.toStdString();
    load();
}

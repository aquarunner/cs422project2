#ifndef MIRROR_PLUGIN_H
#define MIRROR_PLUGIN_H

#include <QtDeclarative/QDeclarativeExtensionPlugin>

class MirrorPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
    
public:
    void registerTypes(const char *uri);
};

#endif // MIRROR_PLUGIN_H


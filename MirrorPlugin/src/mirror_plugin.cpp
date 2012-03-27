#include "mirror_plugin.h"
#include "settings.h"

#include <QtDeclarative/qdeclarative.h>

void MirrorPlugin::registerTypes(const char *uri)
{
    // @uri MirrorPlugin
    uri = "MirrorPlugin";
    qmlRegisterType<Settings>(uri, 1, 0, "Settings");
}

Q_EXPORT_PLUGIN2(MirrorPlugin, MirrorPlugin)


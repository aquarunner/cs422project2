TEMPLATE = lib
TARGET = MirrorPlugin
QT += declarative
CONFIG += qt plugin

#DESTDIR = ../TheMirror

TARGET = $$qtLibraryTarget($$TARGET)
uri = MirrorPlugin

# Input
SOURCES += \
    src/settings.cpp \
    src/mirror_plugin.cpp \

HEADERS += \
    src/settings.h \
    src/mirror_plugin.h \

OTHER_FILES = \
    qml/qmldir \
    qml/Main.qml \
    deploy.bat

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
symbian {
    TARGET.EPOCALLOWDLLDATA = 1
} else:unix {
    maemo5 | !isEmpty(MEEGO_VERSION_MAJOR) {
        installPath = /usr/lib/qt4/imports/$$replace(uri, \\., /)
    } else {
        installPath = $$[QT_INSTALL_IMPORTS]/$$replace(uri, \\., /)
    }
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}


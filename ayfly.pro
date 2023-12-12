HEADERS += decoderayflyfactory.h \
           decoder_ayfly.h \
           ayflyhelper.h

SOURCES += decoderayflyfactory.cpp \
           decoder_ayfly.cpp \
           ayflyhelper.cpp \
           libayfly/AbstractAudio.cpp \
           libayfly/ay.cpp \
           libayfly/formats.cpp \
           libayfly/speccy.cpp \
           libayfly/lha.cpp \
           libayfly/common.cpp \
           libayfly/ayflyString.cpp \
           libayfly/Filter3.cpp \
           libayfly/z80ex/z80ex.c

INCLUDEPATH += $$PWD/libayfly \
               $$PWD/libayfly/z80ex

DEFINES += DISABLE_AUDIO

#CONFIG += BUILD_PLUGIN_INSIDE
contains(CONFIG, BUILD_PLUGIN_INSIDE){
    include($$PWD/../../plugins.pri)
    TARGET = $$PLUGINS_PREFIX/Input/ayfly

    unix{
        target.path = $$PLUGIN_DIR/Input
        INSTALLS += target
    }
}else{
    CONFIG += warn_off plugin lib thread link_pkgconfig c++11
    TEMPLATE = lib

    unix{
        PKGCONFIG += qmmp-1

        PLUGIN_DIR = $$system(pkg-config qmmp-1 --variable=plugindir)/Input
        INCLUDEPATH += $$system(pkg-config qmmp-1 --variable=prefix)/include

        plugin.path = $${PLUGIN_DIR}
        plugin.files = lib$${TARGET}.so
        INSTALLS += plugin
    }
}

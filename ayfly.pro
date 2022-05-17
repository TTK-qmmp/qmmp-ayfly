include($$PWD/../../plugins.pri)

TARGET = $$PLUGINS_PREFIX/Input/ayfly

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

unix {
    target.path = $$PLUGIN_DIR/Input
    INSTALLS += target
}

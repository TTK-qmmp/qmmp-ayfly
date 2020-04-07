
include($$PWD/common/common.pri)

HEADERS += decoderayflyfactory.h \
           decoder_ayfly.h \
           ayflyhelper.h \
           ayfly/AbstractAudio.h \
           ayfly/ay.h  \
           ayfly/ayfly.h  \
           ayfly/ayflyString.h  \
           ayfly/Filter3.h \
           ayfly/z80ex/z80ex.h
    
SOURCES += decoderayflyfactory.cpp \
           decoder_ayfly.cpp \
           ayflyhelper.cpp \
           ayfly/AbstractAudio.cpp \
           ayfly/ay.cpp  \
           ayfly/formats.cpp  \
           ayfly/speccy.cpp  \
           ayfly/lha.cpp  \
           ayfly/common.cpp  \
           ayfly/ayflyString.cpp  \
           ayfly/Filter3.cpp \
           ayfly/z80ex/z80ex.c

CONFIG += warn_on plugin link_pkgconfig c++11

TEMPLATE = lib

QMAKE_CLEAN += lib$${TARGET}.so

unix {
  CONFIG += link_pkgconfig
  PKGCONFIG += qmmp

  QMMP_PREFIX = $$system(pkg-config qmmp --variable=prefix)
  PLUGIN_DIR = $$system(pkg-config qmmp --variable=plugindir)/Input
  LOCAL_INCLUDES = $${QMMP_PREFIX}/include
  LOCAL_INCLUDES -= $$QMAKE_DEFAULT_INCDIRS
  INCLUDEPATH += $$LOCAL_INCLUDES

  plugin.path = $${PLUGIN_DIR}
  plugin.files = lib$${TARGET}.so
  INSTALLS += plugin
}

#include "ayflyhelper.h"
#include "decoder_ayfly.h"
#include "decoderayflyfactory.h"

#include <QMessageBox>

bool DecoderAyflyFactory::canDecode(QIODevice *) const
{
    return false;
}

DecoderProperties DecoderAyflyFactory::properties() const
{
    DecoderProperties properties;
    properties.name = "ALFLY Plugin";
    properties.shortName = "alfly";
    properties.filters << "*.vtx" << "*.asc" << "*.sqt" << "*psg";
    properties.filters << "*.stc" << "*.stp";
    properties.filters << "*.pt1" << "*.pt2" << "*.pt3" << "*.psc";
    properties.filters << "*.ay";
    properties.description = "AY/YM Audio File";
    properties.protocols << "file";
    properties.noInput = true;
    return properties;
}

Decoder *DecoderAyflyFactory::create(const QString &path, QIODevice *input)
{
    Q_UNUSED(input);
    return new DecoderAyfly(path);
}

QList<TrackInfo*> DecoderAyflyFactory::createPlayList(const QString &path, TrackInfo::Parts parts, QStringList *)
{
    TrackInfo *info = new TrackInfo(path);

    if(parts == TrackInfo::Parts())
    {
        return QList<TrackInfo*>() << info;
    }

    AyflyHelper helper(path);
    if(!helper.initialize())
    {
        delete info;
        return QList<TrackInfo*>();
    }

    if(parts & TrackInfo::MetaData)
    {
        info->setValue(Qmmp::ARTIST, helper.artist());
        info->setValue(Qmmp::TITLE, helper.title());
    }

    if(parts & TrackInfo::Properties)
    {
        info->setValue(Qmmp::BITRATE, helper.bitrate());
        info->setValue(Qmmp::SAMPLERATE, helper.sampleRate());
        info->setValue(Qmmp::CHANNELS, helper.channels());
        info->setValue(Qmmp::BITS_PER_SAMPLE, helper.bitsPerSample());
        info->setValue(Qmmp::FORMAT_NAME, "ALFLY");
        info->setDuration(helper.totalTime());
    }

    return QList<TrackInfo*>() << info;
}

MetaDataModel* DecoderAyflyFactory::createMetaDataModel(const QString &path, bool readOnly)
{
    Q_UNUSED(path);
    Q_UNUSED(readOnly);
    return nullptr;
}

void DecoderAyflyFactory::showSettings(QWidget *parent)
{
    Q_UNUSED(parent);
}

void DecoderAyflyFactory::showAbout(QWidget *parent)
{
    QMessageBox::about (parent, tr("About Ayfly Reader Plugin"),
                        tr("Qmmp Ayfly Reader Plugin")+"\n"+
                        tr("Written by: Greedysky <greedysky@163.com>"));
}

QString DecoderAyflyFactory::translation() const
{
    return QString();
}

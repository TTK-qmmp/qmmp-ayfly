#include "ayflyhelper.h"

bool endCallback(void *)
{
    return true;
}

AyflyHelper::AyflyHelper(const QString &path)
    : m_path(path)
{

}

AyflyHelper::~AyflyHelper()
{
    deinit();
}

void AyflyHelper::deinit()
{
    if(m_input)
     {
        ay_closesong(&m_input);
    }
}

bool AyflyHelper::initialize()
{
    QFile file(m_path);
    if(!file.open(QIODevice::ReadOnly))
    {
        qWarning("AyflyHelper: open file failed");
        return false;
    }

    const QByteArray &buffer = file.readAll();
    file.close();

    if(!ay_initsongindirect((unsigned char *)buffer.constData(), sampleRate(), buffer.length()))
    {
        qWarning("AyflyHelper: ay_initsongindirect error");
        return false;
    }

    m_input = ay_initsong(qPrintable(m_path), sampleRate());
    if(!m_input)
    {
        qWarning("AyflyHelper: ay_initsong error");
        return false;
    }

    m_length = ay_getsonglength(m_input) / 50 * 1000;
    ay_setelapsedcallback(m_input, endCallback, nullptr);
    return true;
}

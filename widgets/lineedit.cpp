/*
 *   Copyright 2008 Aaron Seigo <aseigo@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#include "lineedit.h"

#include <QGraphicsSceneResizeEvent>
#include <QIcon>
#include <QPainter>

#include <klineedit.h>
#include <kmimetype.h>

#include "applet.h"
#include "framesvg.h"
#include "private/style_p.h"
#include "private/focusindicator_p.h"
#include "private/themedwidgetinterface_p.h"
#include "theme.h"

namespace Plasma
{

class LineEditPrivate
{
public:
    LineEditPrivate(LineEdit *lineEdit) : ThemedWidgetInterface<Label>
        : ThemedWidgetInterface(lineEdit)
    {
    }

    ~LineEditPrivate()
    {
    }

    LineEdit *q;
    Plasma::Style::Ptr style;
    Plasma::FrameSvg *background;
};

LineEdit::LineEdit(QGraphicsWidget *parent)
    : QGraphicsProxyWidget(parent),
      d(new LineEditPrivate(this))
{
    d->style = Plasma::Style::sharedStyle();
    d->background = new Plasma::FrameSvg(this);
    d->background->setImagePath("widgets/lineedit");
    d->background->setCacheAllRenderedFrames(true);

    new FocusIndicator(this, d->background);
    setNativeWidget(new KLineEdit);
}

LineEdit::~LineEdit()
{
    delete d;
    Plasma::Style::doneWithSharedStyle();
}

void LineEdit::setText(const QString &text)
{
    static_cast<KLineEdit*>(widget())->setText(text);
}

QString LineEdit::text() const
{
    return static_cast<KLineEdit*>(widget())->text();
}

void LineEdit::setClearButtonShown(bool show)
{
    nativeWidget()->setClearButtonShown(show);
}

bool LineEdit::isClearButtonShown() const
{
    return nativeWidget()->isClearButtonShown();
}

void LineEdit::setClickMessage(const QString &message)
{
    nativeWidget()->setClickMessage(message);
}

QString LineEdit::clickMessage() const
{
    return nativeWidget()->clickMessage();
}

void LineEdit::setStyleSheet(const QString &stylesheet)
{
    widget()->setStyleSheet(stylesheet);
}

QString LineEdit::styleSheet()
{
    return widget()->styleSheet();
}

void LineEdit::setNativeWidget(KLineEdit *nativeWidget)
{
    if (widget()) {
        widget()->deleteLater();
    }

    connect(nativeWidget, SIGNAL(editingFinished()), this, SIGNAL(editingFinished()));
    connect(nativeWidget, SIGNAL(returnPressed()), this, SIGNAL(returnPressed()));
    connect(nativeWidget, SIGNAL(textEdited(const QString&)), this, SIGNAL(textEdited(const QString&)));
    connect(nativeWidget, SIGNAL(textChanged(const QString&)), this, SIGNAL(textChanged(const QString&)));


    nativeWidget->setWindowFlags(nativeWidget->windowFlags()|Qt::BypassGraphicsProxyWidget);
    setWidget(nativeWidget);
    nativeWidget->setWindowIcon(QIcon());

    nativeWidget->setAttribute(Qt::WA_NoSystemBackground);
    nativeWidget->setStyle(d->style.data());
    d->initTheming();
}

KLineEdit *LineEdit::nativeWidget() const
{
    return static_cast<KLineEdit*>(widget());
}

void LineEdit::hoverEnterEvent(QGraphicsSceneHoverEvent *event)
{
    Q_UNUSED(event)
    update();
}

void LineEdit::hoverLeaveEvent(QGraphicsSceneHoverEvent *event)
{
    Q_UNUSED(event)
    update();
}

void LineEdit::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    Q_UNUSED(option)
    Q_UNUSED(widget)

    nativeWidget()->render(painter, QPoint(0, 0), QRegion(), QWidget::DrawChildren|QWidget::IgnoreMask);
}

void LineEdit::changeEvent(QEvent *event)
{
    d->changEvent();
    QGraphicsProxyWidget::changeEvent(event);
}

void LineEdit::mousePressEvent(QGraphicsSceneMouseEvent *event)
{
    QGraphicsWidget *widget = parentWidget();
    Plasma::Applet *applet = qobject_cast<Plasma::Applet *>(widget);

    while (!applet && widget) {
        widget = widget->parentWidget();
        applet = qobject_cast<Plasma::Applet *>(widget);
    }

    if (applet) {
        applet->setStatus(Plasma::AcceptingInputStatus);
    }
    QGraphicsProxyWidget::mousePressEvent(event);
}

void LineEdit::focusInEvent(QFocusEvent *event)
{
    QGraphicsProxyWidget::focusInEvent(event);
    if (!nativeWidget()->hasFocus()) {
        // as of Qt 4.7, apparently we have a bug here in QGraphicsProxyWidget
        nativeWidget()->setFocus(event->reason());
    }
}

void LineEdit::focusOutEvent(QFocusEvent *event)
{
    QGraphicsWidget *widget = parentWidget();
    Plasma::Applet *applet = qobject_cast<Plasma::Applet *>(widget);

    while (!applet && widget) {
        widget = widget->parentWidget();
        applet = qobject_cast<Plasma::Applet *>(widget);
    }

    if (applet) {
        applet->setStatus(Plasma::UnknownStatus);
    }
    QGraphicsProxyWidget::focusOutEvent(event);
}

} // namespace Plasma

#include <lineedit.moc>


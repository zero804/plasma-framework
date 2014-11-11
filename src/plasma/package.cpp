/******************************************************************************
*   Copyright 2007 by Aaron Seigo <aseigo@kde.org>                            *
*   Copyright 2010 by Marco Martin <notmart@gmail.com>                        *
*   Copyright 2010 by Kevin Ottens <ervin@kde.org>                            *
*   Copyright 2009 by Rob Scheepmaker                                         *
*                                                                             *
*   This library is free software; you can redistribute it and/or             *
*   modify it under the terms of the GNU Library General Public               *
*   License as published by the Free Software Foundation; either              *
*   version 2 of the License, or (at your option) any later version.          *
*                                                                             *
*   This library is distributed in the hope that it will be useful,           *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of            *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU          *
*   Library General Public License for more details.                          *
*                                                                             *
*   You should have received a copy of the GNU Library General Public License *
*   along with this library; see the file COPYING.LIB.  If not, write to      *
*   the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,      *
*   Boston, MA 02110-1301, USA.                                               *
*******************************************************************************/

#include "package.h"

#include <qtemporarydir.h>

#include <karchive.h>
#include <QDebug>
#include <kdesktopfile.h>
#include <kservicetypetrader.h>
#include <ktar.h>
#include <kzip.h>

#include "config-plasma.h"

#include <qstandardpaths.h>
#include <qmimedatabase.h>

#include "packagestructure.h"
#include "pluginloader.h"
#include "private/package_p.h"
#include "private/packagestructure_p.h"
#include "private/packages_p.h"

namespace Plasma
{

PackagePrivate::PackagePrivate()
    : internalPackage(0),
      fallbackPackage(0),
      structure(0)
{
}

PackagePrivate::~PackagePrivate()
{
}


Package::Package(PackageStructure *structure)
    : d(new Plasma::PackagePrivate())
{
    d->structure = structure;

    if (structure && structure->d->internalStructure) {
        d->internalPackage = new KPackage::Package(structure->d->internalStructure);
    } else {
        d->internalPackage = new KPackage::Package(new KPackage::PackageStructure);
        //for retrocompatibility
        if (structure) {
            structure->initPackage(this);
        }
    }
}

Package::Package(const Package &other)
    : d(new Plasma::PackagePrivate())
{
    d->internalPackage = new KPackage::Package(*other.d->internalPackage);
}

Package::~Package()
{
    delete d->internalPackage;
}

Package &Package::operator=(const Package &rhs)
{
    if (&rhs != this) {
        d->internalPackage = new KPackage::Package(*rhs.d->internalPackage);
    }

    return *this;
}

bool Package::hasValidStructure() const
{
    return d->internalPackage->hasValidStructure();
}

bool Package::isValid() const
{
    return d->internalPackage->isValid();
}

QString Package::name(const char *key) const
{
    return d->internalPackage->name(key);
}

bool Package::isRequired(const char *key) const
{
    return d->internalPackage->isRequired(key);
}

QStringList Package::mimeTypes(const char *key) const
{
    return d->internalPackage->mimeTypes(key);
}

QString Package::defaultPackageRoot() const
{
    return d->internalPackage->defaultPackageRoot();
}

void Package::setDefaultPackageRoot(const QString &packageRoot)
{
    d->internalPackage->setDefaultPackageRoot(packageRoot);
}

void Package::setFallbackPackage(const Plasma::Package &package)
{
    d->fallbackPackage = new Package(package);
    d->internalPackage->setFallbackPackage(*package.d->internalPackage);
}

Plasma::Package Package::fallbackPackage() const
{
    if (d->fallbackPackage) {
        return (*d->fallbackPackage);
    } else {
        return Package();
    }
}

QString Package::servicePrefix() const
{
    return d->internalPackage->servicePrefix();
}

void Package::setServicePrefix(const QString &servicePrefix)
{
    d->internalPackage->setServicePrefix(servicePrefix);
}

bool Package::allowExternalPaths() const
{
    return d->internalPackage->allowExternalPaths();
}

void Package::setAllowExternalPaths(bool allow)
{
    d->internalPackage->setAllowExternalPaths(allow);
}

KPluginInfo Package::metadata() const
{
    return KPluginInfo::fromMetaData(d->internalPackage->metadata());
}

QString Package::filePath(const char *fileType, const QString &filename) const
{
    return d->internalPackage->filePath(fileType, filename);
}

QStringList Package::entryList(const char *key) const
{
    return d->internalPackage->entryList(key);
}

void Package::setPath(const QString &path)
{
    if (path == d->internalPackage->path()) {
        return;
    }

    if (d->structure && !d->structure->d->internalStructure) {
        d->structure->pathChanged(this);
    }
    d->internalPackage->setPath(path);
}

const QString Package::path() const
{
    return d->internalPackage->path();
}

QStringList Package::contentsPrefixPaths() const
{
    return d->internalPackage->contentsPrefixPaths();
}

void Package::setContentsPrefixPaths(const QStringList &prefixPaths)
{
    d->internalPackage->setContentsPrefixPaths(prefixPaths);
}

QString Package::contentsHash() const
{
    return d->internalPackage->contentsHash();
}

void Package::addDirectoryDefinition(const char *key, const QString &path, const QString &name)
{
    d->internalPackage->addDirectoryDefinition(key, path, name);
}

void Package::addFileDefinition(const char *key, const QString &path, const QString &name)
{
    d->internalPackage->addDirectoryDefinition(key, path, name);
}

void Package::removeDefinition(const char *key)
{
    d->internalPackage->removeDefinition(key);
}

void Package::setRequired(const char *key, bool required)
{
    d->internalPackage->setRequired(key, required);
}

void Package::setDefaultMimeTypes(QStringList mimeTypes)
{
    d->internalPackage->setDefaultMimeTypes(mimeTypes);
}

void Package::setMimeTypes(const char *key, QStringList mimeTypes)
{
    d->internalPackage->setMimeTypes(key, mimeTypes);
}

QList<const char *> Package::directories() const
{
    return d->internalPackage->directories();
}

QList<const char *> Package::requiredDirectories() const
{
    return d->internalPackage->requiredDirectories();
}

QList<const char *> Package::files() const
{
    return d->internalPackage->files();
}

QList<const char *> Package::requiredFiles() const
{
    return d->internalPackage->requiredFiles();
}

KJob *Package::install(const QString &sourcePackage, const QString &packageRoot)
{
    return d->internalPackage->install(sourcePackage, packageRoot);
}

KJob *Package::uninstall(const QString &packageName, const QString &packageRoot)
{
    return d->internalPackage->uninstall(packageName, packageRoot);
}

} // Namespace

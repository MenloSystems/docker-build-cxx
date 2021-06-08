CXX build image for Docker
==========================

C++ build image for Docker with many additional tools for compiling
and postprocessing.

This image uses the official [Debian Bullseye][1] image as a basis
and installs many packages and a few extra files. The focus is on
compiling fairly complex Qt5 based applications (including QML) that
use Boost and several other, more minor libraries.

Build tools
-----------

* cmake
* git
* make
* ninja-build

Set cmake to use ninja as its build-tool by default.

Compiling
---------

* g++
* libboost-all-dev
* libgraphviz-dev
* libpam0g-dev
* libqca-qt5-2-dev
* libqt5scxml5-dev
* libqt5serialbus5-dev
* libqt5serialport5-dev
* libqt5svg5-dev
* libqt5webchannel5-dev
* libqt5websockets5-dev
* libqwt-qt5-dev
* libreadline-dev
* libssl-dev
* pkg-config
* python3-lxml
* qml-module-qtqml
* qml-module-qtqml-statemachine
* qml-module-qtquick-controls2
* qml-module-qtquick-layouts
* qml-module-qttest
* qtbase5-private-dev
* qtdeclarative5-private-dev
* qtquickcontrols2-5-dev

The qtquickcontrols2-5-dev package is patched to also include private
headers. See [#958521][2] for details.

Testing
-------

* gcovr
* sudo
* xsltproc

In addition, uses python3-setuptools during the installation of gcovr.

Documentation
-------------

* doxygen-latex
* [doxyqml][3]
* graphviz
* mscgen
* pandoc
* python3

In addition, uses python3-setuptools during the installation of doxyqml.

[1]: https://hub.docker.com/_/debian
[2]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=958521
[3]: https://github.com/agateau/doxyqml

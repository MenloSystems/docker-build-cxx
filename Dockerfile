FROM debian:bullseye as build

COPY keep_private_modules.patch /tmp

RUN\
 sed -i 's,^deb \(.*\),&\ndeb-src \1,' /etc/apt/sources.list &&\
 apt-get update &&\
 apt-get build-dep -y qtquickcontrols2-5-dev &&\
 cd /tmp &&\
 apt-get source qtquickcontrols2-5-dev &&\
 cd qtquickcontrols2-opensource-src-5* &&\
 patch -p1 </tmp/keep_private_modules.patch &&\
 dpkg-buildpackage -b -uc

FROM debian:bullseye

COPY --from=build /tmp/qtquickcontrols2-5-dev_* /tmp

RUN\
 apt-get update &&\
 apt-get install -y\
  cmake\
  curl\
  doxygen-latex\
  g++\
  git\
  graphviz\
  jq\
  libboost-all-dev\
  libgraphviz-dev\
  libpam0g-dev\
  libqca-qt5-2-dev\
  libqt5serialbus5-dev\
  libqt5serialport5-dev\
  libqt5svg5-dev\
  libqt5webchannel5-dev\
  libqt5websockets5-dev\
  libqwt-qt5-dev\
  libreadline-dev\
  libssl-dev\
  make\
  mscgen\
  ninja-build\
  pkg-config\
  pandoc\
  python3\
  python3-lxml\
  python3-setuptools\
  qtbase5-private-dev\
  qtdeclarative5-private-dev\
  qml-module-qtqml\
  qml-module-qtqml-statemachine\
  qml-module-qttest\
  qtquickcontrols2-5-dev\
  sudo\
  xsltproc\
 &&\
 dpkg -i /tmp/qtquickcontrols2-5-dev_* &&\
 rm /tmp/qtquickcontrols2-5-dev_* &&\
 git -C /tmp clone https://github.com/gcovr/gcovr &&\
 git -C /tmp/gcovr config advice.detachedHead false &&\
 git -C /tmp/gcovr checkout 4240ddcd &&\
 (cd /tmp/gcovr; python3 setup.py install) &&\
 rm -rf /tmp/gcovr &&\
 git -C /tmp clone https://invent.kde.org/sdk/doxyqml.git &&\
 git -C /tmp/doxyqml config advice.detachedHead false &&\
 git -C /tmp/doxyqml checkout 1fd5a64 &&\
 (cd /tmp/doxyqml; python3 setup.py install) &&\
 rm -rf /tmp/doxyqml &&\
 apt-get autoremove --purge -y python3-setuptools &&\
 rm -rf /var/lib/apt/lists/*

ENV CMAKE_GENERATOR=Ninja

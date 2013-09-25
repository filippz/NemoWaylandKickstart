# -*-mic2-options-*- -f fs --compress-disk-image=tar.bz2 --copy-kernel --record-pkgs=name --pkgmgr=zypp --arch=armv7hl -*-mic2-options-*-
# 
# Do not Edit! Generated by:
# kickstarter.py
# 

lang en_US.UTF-8
keyboard us
timezone --utc UTC
part / --size 1500 --ondisk sda --fstype=ext3
rootpw nemo

user --name nemo  --groups audio,video --password nemo 

repo --name=mer-core --baseurl=http://releases.merproject.org/releases/@MER_RELEASE@/builds/armv7hl/packages  --debuginfo
repo --name=nemo-ux --baseurl=http://repo.merproject.org/obs/nemo:/@FLAVOUR@:/ux/@NEMO_RELEASE@_armv7hl/ 
repo --name=nemo-apps --baseurl=http://repo.merproject.org/obs/nemo:/@FLAVOUR@:/apps/@NEMO_RELEASE@_armv7hl/ 
repo --name=nemo-mw --baseurl=http://repo.merproject.org/obs/nemo:/@FLAVOUR@:/mw/@NEMO_RELEASE@_armv7hl/ 
repo --name=mer-qt --baseurl=http://repo.merproject.org/obs/mer:/qt:/devel/latest_armv7hl/
repo --name=mer-tools --baseurl=http://repo.pub.meego.com/releases/Mer-Tools/rolling/builds/armv7hl/packages/


%packages

zypper
rpm-build
meego-rpm-config
shadow-utils
passwd
gdb
strace
vim

glibc-devel
mesa-llvmpipe-libEGL-devel
mesa-llvmpipe-libGLESv2-devel
qt5-qmake
qt5-tools
qt5-default
qt5-qttools-linguist
qt5-qtcore-devel
qt5-qtdeclarative-devel
qt5-qtdeclarative-qtquick-devel
qt5-qtgui-devel
qt5-qtnetwork-devel
qt5-qtopengl-devel
qt5-qtxml-devel
qt5-qtwidgets-devel
qt5-qtplatformsupport-devel
qt5-qtpublishsubscribe-devel 
qt5-qtserviceframework-devel
qt5-qtquick1-devel
qt5-qtwayland-wayland_egl-devel
qt5-qtsql-devel
qmf-qt5-devel
qt5-qtqml-import-webkitplugin
qt5-qtdeclarative-import-multimedia
qt5-qtdeclarative-import-particles2
qt5-qtdeclarative-import-qtquick2plugin
qt5-qtdeclarative-import-sensors
qt5-qtdeclarative-qtquickparticles-devel
qt5-qtdeclarative-import-dialogs
qt5-qtdeclarative-import-folderlistmodel
qt5-qtdeclarative-import-localstorageplugin
qt5-qtdeclarative-import-location
qt5-qtdeclarative-import-models2
qt5-qtdeclarative-import-privatewidgets
qt5-qtdeclarative-import-qttest
qt5-qtdeclarative-import-window2
qt5-qtdeclarative-pim-contacts
qt5-qtdeclarative-pim-organizer
qt5-qtdeclarative-plugin-accessible
qt5-qtdeclarative-plugin-qmlinspector
qt5-qtdeclarative-qtquick
qt5-qtdeclarative-publishsubscribe
qt5-qtdeclarative-qtquickparticles
qt5-qtdeclarative-qtquicktest
qt5-qtdeclarative-serviceframework
qt5-qtdeclarative-systeminfo
qt5-qtdeclarative

#optional for a 'full' target:

libqtwebkit5-devel
qt5-qtsvg-devel
qt5-qtsensors-devel
qt5-qtconcurrent-devel
qt5-qtdocgallery-devel
qt5-qtconnectivity-qtbluetooth-devel
qt5-qtlocation-devel
qt5-qtfeedback-devel
qt5-qtmultimedia-devel
qt5-qtpim-contacts-devel
qt5-qtpim-organizer-devel
qt5-qtpim-versit-devel
qt5-qtpim-versitorganizer-devel
ssu
ssu-vendor-data-nemo

%end

%post

%end

%post --nochroot
if [ -n "$IMG_NAME" ]; then
    echo "BUILD: $IMG_NAME" >> $INSTALL_ROOT/etc/meego-release
fi


%end

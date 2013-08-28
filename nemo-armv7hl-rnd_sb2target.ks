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


%packages
@Mer Core
@Mer Connectivity 

cjkuni-fonts
liberation-fonts-common
liberation-mono-fonts
liberation-sans-fonts
liberation-serif-fonts
droid-sans-fonts
droid-sans-mono-fonts
droid-serif-fonts

# No Xorg stuff
#@mer-minimal-xorg

# Nemo
@nemo-mw
# We add this package to the MW
maliit-plugins-maliit-keyboard


# Deleting some Qt4 stuff from the rnd pattern
#@nemo-rnd

# We're getting rid of most of nemo-mw pattern
#@nemo-ux

#------ BEGIN NEMO-RND -------
connman-test
diffutils
gdb
iotop
libaccounts-glib-tools
#edited (it was libcommhistory-tools)
libcommhistory-qt5-tools
#edited (it was lipstick-tools)
lipstick-qt5-tools
lynx
mce-tools
mer-gfx-tests
nano
ofono-tests
openssh-clients
openssh-server
#edited (it was nemo-qml-plugin-contacts-tools)
nemo-qml-plugin-contacts-qt5-tools
screen
tar
tracker-utils
vim-enhanced
vim-minimal
wget
#------ END NEMO-RND -------

#------ BEGIN NEMO-UX -------
#Added to official pattern
mapplauncherd-qt5

nemo-firstsession
nemo-mobile-session-wayland
nemo-theme-default
meegotouch-theme-darko
lipstick-colorful-home-qt5
# Wifi indicator needs this.
contextkit-plugin-mce
# For splash screen
ce-backgrounds
plymouth-lite
#------ END NEMO-UX ---------

#------ START NEMO-APPS------
#fingerterm
#qt-components-qt5-gallery
#qmlcalc
#qmlnotes
#qmlmaps
#qmlgallery
#qmlcalendar
#qmlpinquery
#qmlmusicplayer
#qmlfilemuncher
#qmlmail
#qmlsettings
#voicecall-ui-reference
#qmlcontacts
#qmlmessages
#------ END NEMO-APPS--------

qt5-plugin-generic-evdev
qt5-qtdeclarative-qmlscene
qt5-qtwayland-wayland_egl
qt5-qtwayland-wayland_egl-examples 
qt5-plugin-imageformat-jpeg 
qt5-plugin-platform-eglfs 
qt5-qtsvg-plugin-imageformat-svg

meego-rpm-config
glibc-devel
%end

%post

Config_Src=`gconftool-2 --get-default-source`

#Set theme name
gconftool-2 --direct --config-source $Config_Src \
  -s -t string /meegotouch/theme/name "darko"

# Set up proper target for libmeegotouch
gconftool-2 --direct --config-source $Config_Src \
  -s -t string /meegotouch/target/name N950

# Hack to fix the plymouth based splash screen on N900
mv /usr/bin/ply-image /usr/bin/ply-image-real
cat > /usr/bin/ply-image << EOF
#!/bin/sh
echo 32 > /sys/class/graphics/fb0/bits_per_pixel
exec /usr/bin/ply-image-real $@
EOF
chmod +x /usr/bin/ply-image
## rpm-rebuilddb.post from mer-kickstarter-configs package
# Rebuild db using target's rpm
echo -n "Rebuilding db using target rpm.."
rm -f /var/lib/rpm/__db*
rpm --rebuilddb
echo "done"
## end rpm-rebuilddb.post

if [ "@SSU_RELEASE_TYPE@" = "rnd" ]; then
    [ -n "@NEMO_RELEASE@" ] && ssu release -r @NEMO_RELEASE@
    [ -n "@FLAVOUR@" ] && ssu flavour @FLAVOUR@
    ssu mode 2
else
    [ -n "@NEMO_RELEASE@" ] && ssu release @NEMO_RELEASE@
    ssu mode 4
fi

## arch-armv7hl.post from mer-kickstarter-configs package
# Without this line the rpm don't get the architecture right.
echo -n 'armv7hl-meego-linux' > /etc/rpm/platform

# Also libzypp has problems in autodetecting the architecture so we force tha as well.
# https://bugs.meego.com/show_bug.cgi?id=11484
echo 'arch = armv7hl' >> /etc/zypp/zypp.conf
## end arch-armv7hl.post


%end

%post --nochroot
if [ -n "$IMG_NAME" ]; then
    echo "BUILD: $IMG_NAME" >> $INSTALL_ROOT/etc/meego-release
fi


%end
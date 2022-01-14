#!/bin/bash
# Installs pip, cffi (requires libffi-dev), 
# libgit2 with SSH support (requires cmake -j400 , cffi, libssh-4 and/or libssh-dev); 
# python modules: pygit2, keyring, flask; 
# nodejs (required by Mozilla's scanjs); 
# brakeman
# beautifulsoup for parsing php-rips html report
echo "SCRIPT PORTED FOR ARCHLINUX BY D3417_"
echo ""
sleep 5s

if [ "$EUID" -ne 0 ]
  then echo "Please run as root!!!"
  exit
fi

raptor_path="$(pwd)"
echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
echo "gem: --no-document" >> ~/.gemrc
echo "Updating Full System . . . "
echo ""
yay -Syyu
#php
yay --noconfirm -S php56 php54-common php54-curl php54-mcrypt php54-cli
#
yay --noconfirm -S git
yay --noconfirm -S nginx
yay --noconfirm -S apache2
yay --noconfirm -S libapache2-mod-php5.6
yay --noconfirm -S libapache2-mod-rpaf
yay --noconfirm -S libffi-dev
yay --noconfirm -S ruby
yay --noconfirm -S cmake 
yay --noconfirm -S libssh-4	
yay --noconfirm -S libssl-dev
yay --noconfirm -S linux-headers-generic
yay --noconfirm -S build-essential
yay --noconfirm -S autoconf
yay --noconfirm -S libtool
yay --noconfirm -S pkg-config
python2 -m pip install  pip
python2 -m pip install  opengl
python2 -m pip install  imaging
python2 -m pip install  pyrex
python2 -m pip install  pyside.qtopengl
yay --noconfirm -S idle-python2.7
yay --noconfirm -S libgle3
python2 -m pip install  dev
python2 -m pip install  dateutil
python2 -m pip install  docutils
python2 -m pip install  feedparser
python2 -m pip install  gdata
python2 -m pip install  jinja2
python2 -m pip install  ldap
python2 -m pip install  libxslt1
python2 -m pip install  lxml
python2 -m pip install  mako
python2 -m pip install  mock
python2 -m pip install  openid
python2 -m pip install  psycopg2
python2 -m pip install  psutil
python2 -m pip install  pybabel
python2 -m pip install  pychart
python2 -m pip install  pydot
python2 -m pip install  pyparsing
python2 -m pip install  reportlab
python2 -m pip install  simplejson
python2 -m pip install  tz
python2 -m pip install  unittest2
python2 -m pip install  vatnumber
python2 -m pip install  vobject
python2 -m pip install  webdav
python2 -m pip install  werkzeug
python2 -m pip install  xlwt
python2 -m pip install  yaml
python2 -m pip install  zsi
wget https://svn.apache.org/repos/asf/oodt/tools/oodtsite.publisher/trunk/distribute_setup.py
python distribute_setup.py
rm -rf distribute*
python2 -m pip install  cffi
wget https://codeload.github.com/libgit2/libgit2/tar.gz/v0.25.0 -O libgit2-0.25.0.tar.gz
tar xzf libgit2-0.25.0.tar.gz
cd libgit2-0.25.0/
cmake  .
make -j400  install
ldconfig
cd ~
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
yay --noconfirm -S nodejs
gem install brakeman
cd $raptor_path
rm -rf libgit2-0.25.0.tar.gz
rm -rf libgit2-0.25.0/
mkdir -p /var/raptor/scan_results
chmod -R 777 /var/raptor/scan_results #development purpose only
mkdir -p /var/raptor/log	
chmod -R 777 /var/raptor/log #development purpose only
mkdir -p /var/raptor/uploads
chmod -R 777 /var/raptor/uploads #development purpose only
mkdir -p /var/raptor/clones
chmod -R 777 /var/raptor/clones #development purpose only
mkdir -p /var/www/html/raptor
cp -r frontend/* /var/www/html/raptor
chmod -R 755 /var/www/html/raptor
rm -rf /etc/apache2/sites-available/raptor.conf
rm -rf /etc/apache2/sites-enabled/raptor.conf
rm -rf /etc/nginx/sites-available/raptor
rm -rf /etc/nginx/sites-enabled/raptor
rm -rf /etc/nginx/sites-enabled/default
cp -r confs/apache2/* /etc/apache2
cp -r confs/nginx/* /etc/nginx
ln -s /etc/apache2/sites-available/raptor.conf /etc/apache2/sites-enabled/raptor.conf
ln -s /etc/nginx/sites-available/raptor /etc/nginx/sites-enabled/raptor
yay -S apache22 --noconfirm && systemctl enable apache2 && systemctl start apache2
systemctl enable nginx && systemctl start nginx
python2 -m pip install pip
python2 -m pip install  certifi
python2 -m pip install  pygit2==0.25.0
python2 -m pip install  keyring
python2 -m pip install  flask
python2 -m pip install  gunicorn
python2 -m pip install  beautifulsoup
python2 -m pip install  Django
python2 -m pip install hjson
python2 -m pip install requests
echo ""
echo "FINISH."
echo ""

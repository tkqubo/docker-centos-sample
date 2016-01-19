#!/bin/sh
git clone --recursive git://github.com/hotosm/osm-tasking-manager2.git
cd osm-tasking-manager2
easy-install shapely
easy_install virtualenv
virtualenv --no-site-packages env
./env/bin/pip install -r requirements.txt
sudo -u postgres createdb -T template0 osmtm -E UTF8 -O www-data
sudo -u postgres psql -d osmtm -c "CREATE EXTENSION postgis;"

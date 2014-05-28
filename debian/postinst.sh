#!/bin/sh
set -e

case "$1" in
  configure)
    chown -R storm:storm /usr/lib/storm
    ldconfig

    if [ -f /usr/local/bin/storm ]; then
      rm -f /usr/local/bin/storm
    fi

    if [ ! -L /usr/local/bin/storm ]; then
      ln -s /usr/lib/storm/bin/storm /usr/local/bin/storm
    fi

    if [ -f /etc/storm/storm.yaml ]; then
      rm -f /etc/storm/storm.yaml
    fi

    if [ ! -L /etc/storm.yaml ]; then
      ln -s /usr/lib/storm/conf/storm.yaml /etc/storm/storm.yaml
    fi

    ;;

  abort-upgrade|abort-remove|abort-deconfigure)
    ;;

  *)
    echo "postinst called with unknown argument \`$1'" >&2
    exit 1
    ;;
esac

#DEBHELPER#

exit 0


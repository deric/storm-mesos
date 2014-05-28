#!/bin/bash
set -e

add_users()
{

  NAME="storm"
  GROUP=$NAME
  USER=$NAME
  HOMEDIR="/usr/lib/storm-mesos"

  if ! getent group $GROUP >/dev/null ; then
        # Adding system group
        addgroup --system $GROUP >/dev/null
  fi

  # creating storm user if he isn't already there
  if ! getent passwd $USER >/dev/null ; then
        # Adding system user
        adduser \
          --system \
          --disabled-login \
          --ingroup $GROUP \
          --home $HOMEDIR \
          --gecos "storm" \
          --shell /bin/false \
          $USER  >/dev/null
  fi

  chown -R $USER:$GROUP /var/log/$NAME
  chown -R $USER:$GROUP $HOMEDIR
}

case "$1" in
    install|upgrade)
        add_users
    ;;

    abort-upgrade|abort-remove|abort-deconfigure)
    ;;

    *)
        echo "preinst called with unknown argument \`$1'" >&2
        exit 1
    ;;
esac



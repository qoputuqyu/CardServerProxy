#!/bin/ash

. /var/etc/cspagent.conf

MSG="{PARAMS}"

if [ -z "$MSG" ]; then
  echo "No message specified."
  exit
else
  MSG="Message from $CSPHOST:%0A$MSG"
  MSG=$(echo "$MSG" | sed 's/[ ]/%20/g')
fi

if [ -n "$ENIGMAV" ]; then
  OSDTYPE="enigma"
  OSDVER=$ENIGMAV
fi

case $OSDTYPE in
  "enigma")
    if [ $OSDVER -eq 1 ]; then
      wget -q -O - "http://$OSDUSER:$OSDPASS@127.0.0.1/cgi-bin/xmessage?caption=message&body=$MSG&timeout=10"
    else
      wget -q -O - "http://$OSDUSER:$OSDPASS@127.0.0.1/web/message?text=$MSG&type=1&timeout=10"
    fi
    ;;

  "neutrino")
    if [ $OSDVER -eq 1 ]; then
      wget -q -O - "http://$OSDUSER:$OSDPASS@127.0.0.1/control/message?nmsg=$MSG"
    fi
    ;;
esac

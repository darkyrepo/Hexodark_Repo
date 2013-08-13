#!/bin/sh -e
# Start/Stop rtorrent sous forme de daemon.

NAME=ubuntu-daemon.sh
SCRIPTNAME=/etc/init.d/$NAME
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

case $1 in
        start)
                echo "Starting rtorrent... "
                su -l darky -c "screen -fn -dmS rtd nice -19 rtorrent"
                echo "Terminated"
        ;;
        stop)
                if [ "$(ps aux | grep -e '.*rtorrent$' -c)" != 0  ]; then
                {
                        echo "Shutting down rtorrent... "
                        killall -r "^.*rtorrent$"
                        echo "Terminated"
                }
                else
                {
                        echo "rtorrent not yet started !"
                        echo "Terminated"
                }
                fi
        ;;
        restart)
                if [ "$(ps aux | grep -e '.*rtorrent$' -c)" != 0  ]; then
                {
                        echo "Shutting down rtorrent... "
                        killall -r "^.*rtorrent$"
                        echo "Starting rtorrent... "
                        su -l darky -c "screen -fn -dmS rtd nice -19 rtorrent"
                        echo "Terminated"
                }
                else
                {
                        echo "rtorrent not yet started !"
                        echo "Starting rtorrent... "
                        su -l darky -c "screen -fn -dmS rtd nice -19 rtorrent"
                        echo "Terminated"
                }
                fi
        ;;
        *)
                echo "Usage: $SCRIPTNAME {start|stop|restart}" >&2
                exit 2
        ;;
esac

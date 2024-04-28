#!/bin/sh
echo
echo "███╗   ██╗ ██████╗ ██╗███╗   ██╗██╗  ██╗     ██╗   ██╗██████╗ ███████╗████████╗███████╗ █████╗ ███╗   ███╗";
echo "████╗  ██║██╔════╝ ██║████╗  ██║╚██╗██╔╝     ██║   ██║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║";
echo "██╔██╗ ██║██║  ███╗██║██╔██╗ ██║ ╚███╔╝█████╗██║   ██║██████╔╝███████╗   ██║   █████╗  ███████║██╔████╔██║";
echo "██║╚██╗██║██║   ██║██║██║╚██╗██║ ██╔██╗╚════╝██║   ██║██╔═══╝ ╚════██║   ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║";
echo "██║ ╚████║╚██████╔╝██║██║ ╚████║██╔╝ ██╗     ╚██████╔╝██║     ███████║   ██║   ███████╗██║  ██║██║ ╚═╝ ██║";
echo "╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝      ╚═════╝ ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝";
echo "                                                                                                          ";
echo "███╗   ███╗██╗   ██╗██████╗ ███████╗██╗      █████╗ ██╗   ██╗██████╗  █████╗  ██████╗ ███████╗";
echo "████╗ ████║╚██╗ ██╔╝██╔══██╗██╔════╝██║     ██╔══██╗╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝ ██╔════╝";
echo "██╔████╔██║ ╚████╔╝ ██████╔╝█████╗  ██║     ███████║ ╚████╔╝ ██████╔╝███████║██║  ███╗█████╗  ";
echo "██║╚██╔╝██║  ╚██╔╝  ██╔══██╗██╔══╝  ██║     ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██║██║   ██║██╔══╝  ";
echo "██║ ╚═╝ ██║   ██║   ██║  ██║███████╗███████╗██║  ██║   ██║   ██║     ██║  ██║╚██████╔╝███████╗";
echo "╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝";
echo "                                                                                              ";
echo "Getting IP address from $CONTAINER_MYRELAYPAGE ..."
myrelaypage_ip=$(ping -c 1 "$CONTAINER_MYRELAYPAGE" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
if [ "$myrelaypage_ip" = "Name does not resolve" ]; then
    echo ">>> Failed to retrieve IP for $CONTAINER_MYRELAYPAGE ❌"
    echo
    echo "Please verify if the container $CONTAINER_MYRELAYPAGE is on the same network than container nginx-upsteam-myrelaypage."
    echo "Exit."
    echo
    exit
else
    echo ">>> Found IP $myrelaypage_ip ✅"
    CONTAINER_MYRELAYPAGE=$myrelaypage_ip
fi
echo
echo "Getting IP address from $CONTAINER_NOSTR_RELAY ..."
nostr_relay_ip=$(ping -c 1 "$CONTAINER_NOSTR_RELAY" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
if [ "$nostr_relay_ip" = "Name does not resolve" ]; then
    echo ">>> Failed to retrieve IP for $CONTAINER_NOSTR_RELAY ❌"
    echo
    echo "Please verify if the container $CONTAINER_NOSTR_RELAY is on the same network than container nginx-upsteam-myrelaypage."
    echo "Exit."
    echo
    exit
else
    echo ">>> Found IP $nostr_relay_ip ✅"
    CONTAINER_NOSTR_RELAY=$nostr_relay_ip
fi
echo
echo -n "Replacing env with envsubst into nginx conf file ... "
envsubst '$CONTAINER_MYRELAYPAGE $CONTAINER_NOSTR_RELAY' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf
echo "✅"
echo
echo "Starting NGINX ..."
echo
exec "$@"
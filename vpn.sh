#!/bin/zsh
unset ACTION
export ACTION=$1

STATUS=`scutil --nc status $ACTION |awk 'NR==1{print $1}'`

defaultAction () {
  if [ -z $2 ]; then
    if [ "$STATUS" = "Disconnected" ]; then
      `scutil --nc start $ACTION`
      echo "Connected to $ACTION"
    elif [ "$STATUS" = "Connected" ]; then
      RESULT=`scutil --nc stop $ACTION`
      echo "Disconnected to $ACTION"
    elif [ "$STATUS" = "No Service" ]; then
      echo "No Service"
    fi
  fi
}

case $ACTION in
  start)  scutil --nc start $2;;
  stop)   scutil --nc stop $2;;
  *)      defaultAction ;;
esac

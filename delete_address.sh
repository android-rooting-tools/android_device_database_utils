#!/system/bin/sh
. ./setup_variables.sh

if [ z"$DEVICE_ID" != z ]; then
  SQL="delete from device_address where device_id=$DEVICE_ID;"
  echo "$SQL" | "$SQLITE3" device.db
fi
exit 0

#!/system/bin/sh
CHECK_PROP_NAME="$1"

. ./setup_variables.sh

if [ ! -f "$FILE" ]; then
  echo "Error: not found file to import: '$FILE'"

  SQL="delete from supported_devices where device_id=$DEVICE_ID;"
  echo "$SQL" | "$SQLITE3" device.db

  exit 1;
fi

./delete_address.sh

echo "Import address from '$FILE'"

while read line
do
  NAME=`echo $line | sed -e 's/|/ /g' | awk '{print $1}'`
  VALUE=`echo $line | sed -e 's/|/ /g' | awk '{print $2}'`
  echo $NAME: $VALUE

  echo "insert into device_address(device_id, name, value) values($DEVICE_ID, '$NAME', $VALUE);" \
    | "$SQLITE3" device.db

done < "$FILE"

exit $?
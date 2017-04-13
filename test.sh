#!/bin/bash -e

# Start the server with `foreman start`

echo 'Saving'
echo '------'

curl -d 'It works!' localhost:5000/x

echo
echo

echo 'Retrieving'
echo '----------'

curl localhost:5000/x

echo

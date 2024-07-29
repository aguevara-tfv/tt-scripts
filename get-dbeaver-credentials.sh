#!/bin/bash

credentials_path="$HOME/snap/dbeaver-ce/current/.local/share/DBeaverData/workspace6/General/.dbeaver/credentials-config.json"

echo "Decrypting credentials located in '$credentials_path'..."
echo ""

openssl aes-128-cbc -d \
  -K babb4a9f774ab853c96c2d653dfe544a \
  -iv 00000000000000000000000000000000 \
  -in $credentials_path | \
  dd bs=1 skip=16 2>/dev/null

echo ""
echo ""
echo "Done."

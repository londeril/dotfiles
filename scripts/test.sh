#!/bin/bash

json_data=`hyprctl -j monitors`

# Loop through each item in the array
for item in $(echo "$json_data" | jq -c '.[] | .id'); do
    # Extract the content of the "id" field for each item
    echo $item
    $id
done


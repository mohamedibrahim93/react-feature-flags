#!/bin/sh

#TODO: issue in variables contains spaces and keep default if not exist in new env variables

# Create the config.js file
CONFIG_FILE="/usr/share/nginx/html/config.js"
echo "window._env_ = {" > $CONFIG_FILE

# Iterate through all environment variables prefixed with REACT_APP_
first_var=true
for env_var in $(env | grep '^REACT_APP_'); do
    # Extract the key and value
    key=$(echo "$env_var" | cut -d '=' -f 1)
    value=$(echo "$env_var" | cut -d '=' -f 2-)

    # Escape special characters in the value
    value=$(echo "$value" | sed 's/"/\\"/g')

    # Add a comma after the previous variable (except the first one)
    if [ "$first_var" = false ]; then
        echo "," >> $CONFIG_FILE
    fi
    first_var=false

    # Write the key-value pair to config.js
    echo "  \"$key\": \"$value\"" >> $CONFIG_FILE
done

# Close the JSON object
echo "" >> $CONFIG_FILE
echo "};" >> $CONFIG_FILE

# Print the generated config.js for debugging purposes
echo "Generated $CONFIG_FILE:"
cat $CONFIG_FILE

# Execute the given command (default: Nginx)
exec "$@"

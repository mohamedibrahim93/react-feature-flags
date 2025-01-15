#!/bin/sh

#TODO: issue in variables contains spaces and keep default if not exist in new env variables

# Start creating the config.js file
echo "window._env_ = {" > /usr/share/nginx/html/config.js

# Iterate through all environment variables
first_var=true
for env_var in $(env | grep '^REACT_APP_'); do
    # Extract the key and value from the environment variable
    key=$(echo "$env_var" | cut -d '=' -f 1)
    value=$(echo "$env_var" | cut -d '=' -f 2-)

    # Add a comma after the previous variable (except the first one)
    if [ "$first_var" = false ]; then
        echo "," >> /usr/share/nginx/html/config.js
    fi
    first_var=false

    # Add the key-value pair to config.js
    echo "  $key: \"$value\"" >> /usr/share/nginx/html/config.js
done

# Close the config.js file
echo "" >> /usr/share/nginx/html/config.js
echo "};" >> /usr/share/nginx/html/config.js

# Start Nginx or any given command
exec "$@"

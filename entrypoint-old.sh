#!/bin/sh

# Generate the config.js file with dynamic environment variables
cat <<EOF > /usr/share/nginx/html/config.js
window._env_ = {
    REACT_APP_API_URL: "${REACT_APP_API_URL:-default_value}",
    REACT_APP_OTHER_VAR: "${REACT_APP_OTHER_VAR:-default_value}"
};
EOF

# Start Nginx
exec "$@"
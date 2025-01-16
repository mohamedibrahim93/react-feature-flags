# Stage 1: Build React App
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build 

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the React build from the first stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]

# Expose the port (e.g., port 8080)
EXPOSE 8080

# Default command to start Nginx
CMD ["nginx", "-g", "daemon off;"]

# docker build . -f Dockerfile -t react-ff  --no-cache --progress=plain  
# docker run -d -p 8080:8080  -e REACT_APP_API_URL="https://api.example_1.com" -e REACT_APP_OTHER_VAR="some_value_1" react-ff
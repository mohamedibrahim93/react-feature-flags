# Stage 1: Build React App
FROM node:18-alpine AS build-env

# Set working directory
WORKDIR /src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the React app
RUN npm run build:all

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the React build from the first stage
COPY --from=build-env /src/dist /usr/share/nginx/html

# Copy default nginx configuration if exists
COPY nginx.conf* /etc/nginx/conf.d/default.conf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose the port (e.g., port 8080)
EXPOSE 8080

# Set entrypoint to the script
ENTRYPOINT ["/entrypoint.sh"]

# Default command to start Nginx
CMD ["nginx", "-g", "daemon off;"]

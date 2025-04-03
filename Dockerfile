# Use an Nginx base image
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove the default Nginx index page
RUN rm -rf ./*

# Copy HTML, CSS, and JavaScript files to the container
COPY build/ .

# Expose port 80 (default Nginx port)
EXPOSE 3000

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

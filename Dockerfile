# Use Nginx as the base image
FROM nginx:alpine

# Set working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove default Nginx content
RUN rm -rf ./*

# Copy HTML files
COPY ./REST/index.html ./  
COPY ./REST/about.html ./  
COPY ./REST/book.html ./  
COPY ./REST/menu.html ./  

# Copy CSS, JS, Fonts, and Images
COPY ./REST/css /usr/share/nginx/html/css/
COPY ./REST/js /usr/share/nginx/html/js/
COPY ./REST/fonts /usr/share/nginx/html/fonts/
COPY ./REST/images /usr/share/nginx/html/images/

# Expose port 80 for the container
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

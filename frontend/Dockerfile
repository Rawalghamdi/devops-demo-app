# using nginx to serve the static frontend files
# nginx is lightweight and good for serving HTML/CSS/JS

FROM nginx:alpine

# copy all frontend files into nginx's default serving directory
COPY . /usr/share/nginx/html

# override nginx config to proxy /api to backend
COPY nginx.conf /etc/nginx/conf.d/default.conf

# nginx listens on port 80 by default
EXPOSE 80
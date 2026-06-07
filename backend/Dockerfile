# using node 20 alpine — alpine images are smaller which is nice
FROM node:20-alpine

# set working directory inside the container
WORKDIR /app

# copy package files first so Docker can cache the npm install layer
# this way if only server.js changes, we don't have to re-run npm install
COPY package*.json ./
RUN npm install --production

# copy the rest of the backend code
COPY . .

EXPOSE 3000

CMD ["node", "server.js"]

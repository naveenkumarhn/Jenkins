FROM node:10.15.3-alpine

# Create app directory
WORKDIR /usr/src/app

COPY helloworld/package*.json ./

RUN npm install

# Bundle app source
COPY helloworld .

EXPOSE 8080

CMD [ "node", "server.js" ]

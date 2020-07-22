FROM node:14.5.0-alpine

COPY index.js /index.js
COPY package.json /package.json
COPY package-lock.json /package-lock.json

RUN npm install

CMD ["node", "/index.js"]

FROM node:14.5.0-alpine

COPY index.js /app/index.js
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

RUN npm install

CMD ["node", "/index.js"]

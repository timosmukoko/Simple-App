# syntax=docker/dockerfile:1
FROM cimg/node:20.17

ENV NODE_ENV=production

# Copy package files and install dependencies
COPY ["package.json", "package-lock.json*", "./"]

RUN npm ci --unsafe-perm  

COPY . .

CMD ["npm", "start"]

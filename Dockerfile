FROM node:18-alpine

WORKDIR /usr/src/app

COPY app/package*.json ./
RUN npm install

COPY app/ ./

# Runtime configuration is injected with --env-file / -e.
# Never bake credentials or secrets into an image layer.

CMD [ "npm", "start" ]

FROM node:22-alpine AS build
WORKDIR /app

RUN apk add --no-cache python3 make g++

COPY vite-project/package*.json ./
RUN npm install --verbose

COPY vite-project/ ./
RUN npm run build
RUN ls -al && cat package.json

FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html


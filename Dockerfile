FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . ./
RUN npm run build
RUN is /app

FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html


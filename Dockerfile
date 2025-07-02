FROM node:22-alpine AS build
WORKDIR /app

# Optional: add build tools for native dependencies
RUN apk add --no-cache python3 make g++
COPY package*.json ./
RUN npm install --verbose


COPY . ./
RUN npm run build
RUN ls -al && cat package.json


FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html

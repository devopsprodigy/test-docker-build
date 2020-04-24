FROM node:12.16.2-alpine3.11 as builder
RUN apk --no-cache --update --virtual build-dependencies add \
    python \
    make \
    g++
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build --prod

FROM nginx:stable-alpine
WORKDIR /app
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/static.conf /etc/nginx/conf.d
COPY --from=builder /app/dist/app .

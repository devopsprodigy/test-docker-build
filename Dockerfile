FROM exsmund/node-for-angular:latest as builder
RUN apk --no-cache --update --virtual build-dependencies add \
    python \
    make \
    g++
WORKDIR /app
COPY app/package*.json ./
RUN npm ci
COPY app/ .
RUN npm run build --prod

FROM nginx:1.17.10-alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/static.conf /etc/nginx/conf.d
COPY --from=builder /app/dist/app .
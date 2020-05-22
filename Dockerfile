FROM node:13.12.0-alpine as build

COPY ./ /app
COPY .env /app

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

#RUN npm install react-scripts@3.4.1 -g

RUN npm install

RUN npm run build

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

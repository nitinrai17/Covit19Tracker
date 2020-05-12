#Step 1 :
FROM node:14 as build-deps

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN yarn

COPY . ./

RUN yarn build

# Step 2:

FROM nginx:1.17-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

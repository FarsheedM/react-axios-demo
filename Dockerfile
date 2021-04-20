FROM node:14-alpine AS BUILDER

WORKDIR /BUILD/

COPY . .

RUN npm install && npm run build

# ---

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY --from=BUILDER /BUILD/build /usr/share/nginx/html
COPY --from=BUILDER /BUILD/nginx/nginx.conf /etc/nginx/conf.d

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
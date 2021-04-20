FROM node:14-alpine AS BUILDER

WORKDIR /BUILD/

COPY . .
COPY /config/.npmrc /root/

RUN npm install && npm run build

# ---

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf
COPY --from=BUILDER /BUILD/nginx/nginx.conf /etc/nginx/conf.d
COPY --from=BUILDER /BUILD/dist .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
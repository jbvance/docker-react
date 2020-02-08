FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Now start a separate phase to copy over the /build directory and run it in inginx
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# Default CMD of ingnx is to run it, so we don't have to have a separate run command for that
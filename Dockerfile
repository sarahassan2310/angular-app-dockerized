# Stage 1: Build Angular App
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build -- --configuration production

# Stage 2: Nginx to serve content
FROM nginx:alpine

# Remove default nginx index
RUN rm -rf /usr/share/nginx/html/*

# Copy Angular build output (adjust path if needed)
COPY --from=build /app/dist/helpdesk/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

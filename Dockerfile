FROM node:alpine3.23 as build

WORKDIR /app


# Copy package.json and yarn.lock to the container
COPY --chown=node . .

# Install dependencies
RUN npm install -g yarn
RUN yarn install

# Copy the app's source code to the container
COPY . .

# Build the Next app
RUN yarn build

# # Serve the production build
# CMD ["yarn", "start"]
# EXPOSE 80
## Second Stage - Nginx ##
FROM nginx:stable-alpine3.24-slim
EXPOSE 80
COPY --from=build /app/build/ /usr/share/nginx/html
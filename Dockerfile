# chuẩn bị môi trường node20-alpine
FROM node:20-alpine

# tạo nơi lưu trữ source code
WORKDIR /smartshop/backend

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN npm run build

# Start the server using the production build
CMD [ "npm", "run", "start:prod" ]

FROM node:slim

RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# Create app directory
WORKDIR /app

# where available (npm@5+)
COPY package*.json ./

# Bundle app source
COPY . /app
# Install app dependencies

RUN npm install
#RUN npm install pm2@latest -g

EXPOSE 4000
CMD [ "npm", "start" ]



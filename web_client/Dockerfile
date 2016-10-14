FROM node:argon

RUN mkdir /myapp
WORKDIR /myapp

ADD package.json /myapp/package.json
RUN npm install

ADD . /myapp

EXPOSE 3000

CMD [ "npm", "run", "start:prod" ]

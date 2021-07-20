FROM python:3.9-alpine

# ADDS SCRIPTS TO CONTAINER
ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /app
COPY . /app
WORKDIR /app
COPY ./scripts /scripts

RUN mkdir -p /blog/web/media 
RUN mkdir -p /blog/web/static

# USER_CREATION AND PERMISSION_SETUP
RUN chmod +x /scripts/*

# CREATES_USER
RUN adduser -D user

# SETS THE USER CREATED TO BE OWN OF /blog FOLDER
RUN chown -R user:user /blog

# GIVE FULL ACCESS 
RUN chmod -R 755 /blog/web

# SWITCH TO USER CREATED
USER user

CMD ["entrypoint.sh"]
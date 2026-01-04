FROM python:3.11.14-alpine3.23 AS build

COPY . /app
WORKDIR /app
RUN pip3 install -r ./requirements.txt
RUN pip3 install -e  .

FROM build AS test

WORKDIR /app/tests
RUN ./check.sh

FROM build AS app
USER 1000:1000
ENTRYPOINT [ "/app/transferwee.py" ]
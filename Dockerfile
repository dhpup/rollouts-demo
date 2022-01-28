FROM golang:1.16 as build
WORKDIR /go/src/app
COPY . .
ENV ELASTIC_APM_SERVICE_NAME=
ENV ELASTIC_APM_SERVER_URL=https://5b85c6fd11e44de9b120f63c89f8f843.apm.us-west-1.aws.cloud.es.io:443
ENV ELASTIC_APM_SECRET_TOKEN=Ueju5wbb7izfFX2Hgb
ENV ELASTIC_APM_ENVIRONMENT=prod
RUN go get go.elastic.co/apm
RUN go get go.elastic.co/apm/module/apmhttp
RUN make

FROM scratch
COPY *.html ./
COPY *.png ./
COPY *.js ./
COPY *.ico ./
COPY *.css ./
COPY --from=build /go/src/app/rollouts-demo /rollouts-demo

ARG COLOR
ENV COLOR=purple
ARG ERROR_RATE
ENV ERROR_RATE=0
ARG LATENCY
ENV LATENCY=0

ENTRYPOINT [ "/rollouts-demo" ]

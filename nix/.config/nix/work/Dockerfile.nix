# vim:ft=dockerfile

FROM alpine

RUN adduser -D iainearl

ENV GOPATH=/home/iainearl
ENV CLOUDPATH=/home/iainearl/src/CloudExperiments

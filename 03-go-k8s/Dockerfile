######## Builder Base #######
FROM golang:1.22-alpine as builder-base

RUN apk add --no-cache upx

######## Builder 1 #######
FROM builder-base as builder1

COPY client/ /client/

RUN cd /client \
  && go mod download \
  # && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-k8s . \
  && go build -o client . \
  && upx client

######## Builder 2 #######
FROM builder-base as builder2

COPY api/ /api/

RUN cd /api \
  && go mod download \
  && go build -o api . \
  && upx api

######## Start a new stage from scratch #######
FROM alpine:latest

ARG UID="${UID:-1000}"
ARG GID="${GID:-1000}"
ARG UNAME="${UNAME:-mbrav}"
ARG GNAME="${GNAME:-mbrav}"

RUN apk add --upgrade --latest --no-cache  \
  ca-certificates \
  && apk clean cache \
  && addgroup -S -g "${GID}" "${GNAME}" \
  && adduser -S -G "${GNAME}" -u "${UID}" "${UNAME}" -s /bin/ash \
  && mkdir /app

COPY --from=builder1 /client/client /usr/local/bin/
COPY --from=builder2 /api/api /usr/local/bin/

RUN chown -R "${GNAME}:${UNAME}" /app

WORKDIR /app
EXPOSE 3000
USER "${UNAME}"

# CMD ["client"]

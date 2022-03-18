FROM golang:1.17 as builder
RUN update-ca-certificates
WORKDIR /app
COPY ./ ./
ARG version=dev
ENV GO111MODULE=on
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-X main.version=$version" -o app ./main.go

FROM alpine:3.11

WORKDIR /app
COPY --from=builder /app .

EXPOSE 80

CMD ["/app/app"]

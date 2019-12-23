FROM golang:alpine as builder
ADD ./ ./placeholder
RUN mkdir /build
WORKDIR ./placeholder
ENV GOOS=linux GOARCH=amd64 CGO_ENABLED=0
RUN go build -a -ldflags="-w -s" -installsuffix cgo -o /build/placeholder ./

FROM scratch
COPY --from=builder /build/placeholder /placeholder
ENTRYPOINT ["/placeholder"]

FROM golang:1.16.0-alpine3.13 as builder

WORKDIR /src

COPY . .

RUN ["go", "mod", "download"]

RUN ["go", "mod", "verify"]

RUN ["go", "build", "-o", "build/server", "cmd/server/main.go"]

WORKDIR /app

COPY --from=builder build/server .

ENTRYPOINT ["server"]
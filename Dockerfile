FROM golang:1.24-alpine as builder

WORKDIR /app

# 安装 Git（go get 需要）
RUN apk add --no-cache git

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# 静态编译，防止 musl 与 glibc 不兼容
RUN go build -o app -ldflags="-w -s" .

# 运行阶段
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/app .

# 确保是可执行文件
RUN chmod +x ./app

CMD ["./app"]

# 构建阶段
FROM golang:1.24 as builder

WORKDIR /app

# 先拷贝 go.mod 和 go.sum，有利于缓存
COPY go.mod go.sum ./

# 下载依赖
RUN go mod download

# 再拷贝代码
COPY . .

# 构建
RUN go build -o app

# 运行阶段
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/app .

CMD ["./app"]


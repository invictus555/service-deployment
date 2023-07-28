# 第一阶段的构建用于编译项目
FROM golang:1.16.0 AS development
WORKDIR $GOPATH/src/
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN git clone https://github.com/invictus555/greeting-server.git

# 切换源码目录下执行编译流程
WORKDIR greeting-server
RUN go build -o greeting-server main.go serverimpl.go

# 第二阶段的构建用于打包运行镜像
FROM ubuntu:latest AS production
WORKDIR /usr/local/bin
COPY --from=development /go/src/greeting-server/greeting-server .
ENTRYPOINT ["/usr/local/bin/greeting-server"]
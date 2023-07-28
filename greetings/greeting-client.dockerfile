# 第一阶段的构建用于编译项目
FROM golang:1.16.0 AS development
WORKDIR $GOPATH/src/
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN git clone https://github.com/invictus555/greeting-client.git

# 切换源码目录下执行编译流程
WORKDIR greeting-client
RUN go build -o greeting-client main.go

# 第二阶段的构建用于打包运行镜像
FROM ubuntu:latest AS production
WORKDIR /usr/local/bin
COPY --from=development /go/src/greeting-client/greeting-client .
ENTRYPOINT [ "/usr/local/bin/greeting-client" ]
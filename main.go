package main

import (
    "github.com/gin-gonic/gin"
)

func main() {
    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "message": "Hello, Azure devops!",
        })
    })

    r.Run(":8080") // 启动服务，监听 8080 端口
}


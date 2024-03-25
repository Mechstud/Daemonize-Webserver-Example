package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
	"time"
)

func main() {
	r := gin.Default()

	// Add V1 APIs
	{
		rgV1 := r.Group("/api/v1")

		// Ping test
		rgV1.GET("/ping", func(c *gin.Context) {
			c.String(http.StatusOK, "pong")
		})

		// Get current datetime
		rgV1.POST("/datetime", func(c *gin.Context) {
			// Format: "Mon, 02 Jan 2006 15:04:05 -0700"
			c.JSONP(http.StatusOK, map[string]string{"dt": time.Now().Format(time.RFC1123Z)})
		})
	}

	// Listen and Server in 0.0.0.0:12345
	err := r.Run(":12345")
	if err != nil {
		fmt.Println("Failed to run the server", err)

		// We need to fail with exit code - systemd service will reboot on failure, if configured.
		os.Exit(1)
	}
}

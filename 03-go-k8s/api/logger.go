package main

import (
	"os"
	"sync"

	"github.com/go-kit/log"
	"github.com/go-kit/log/level"
)

// Define global vars
var (
	logger log.Logger
	once   sync.Once
)

// GetLogger returns a logger instance
func GetLogger() log.Logger {
	once.Do(func() {
		// logger = log.NewJSONLogger(log.NewSyncWriter(os.Stdout))
		logger = log.NewLogfmtLogger(log.NewSyncWriter(os.Stdout))
		logger = log.With(logger, "time", log.DefaultTimestampUTC)

		// Set up log level filter
		logger = level.NewFilter(logger, level.AllowAll())
	})
	return logger
}

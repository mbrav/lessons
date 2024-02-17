package main

import (
	"flag"
)

type Config struct {
	Verbose    bool
	KubeConfig string
	Namespace  string
}

var (
	conf Config
)

func ParseConfig() {
	flag.StringVar(&conf.KubeConfig, "kubeconfig", "~/.kube/config", "Kubeconfig location")
	flag.StringVar(&conf.Namespace, "n", "go", "Namespace")
	flag.BoolVar(&conf.Verbose, "v", false, "Verbose")
	flag.Parse()
}

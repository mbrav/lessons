package main

import (
	"fmt"
	// "time"
)

func main() {
	ParseConfig()
	config := LoadKubeConfig(&conf.KubeConfig)
	client := InitKubeConfig(config)

	loop := 0

	for {
		loop += 1

		fmt.Printf("Loop: %d\n", loop)
		for _, pod := range GetPods(*client, conf.Namespace).Items {
			fmt.Printf("Pod %s (%s)\n", pod.Name, pod.Namespace)
		}
		for _, deploy := range GetDeployments(*client, conf.Namespace).Items {
			fmt.Printf("Deployment %s (%s)\n", deploy.Name, deploy.Namespace)
		}
		// time.Sleep(1 * time.Second)
	}
}

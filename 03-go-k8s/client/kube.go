package main

import (
	"context"
	"fmt"
	"os"

	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
)

// Load kubeconfig
func LoadKubeConfig(kubeconfig *string) *rest.Config {
	config, err := clientcmd.BuildConfigFromFlags("", *kubeconfig)
	if conf.Verbose {
		fmt.Println(*kubeconfig)
	}
	if err != nil {
		fmt.Printf("Error %s, when parsing kubeconfig\n", err.Error())
		fmt.Printf("Info, trying to parse in InClusterConfig\n")
		config, err = rest.InClusterConfig()
		if err != nil {
			fmt.Printf("Error %s, when getting InClusterConfig\n", err.Error())
			os.Exit(1)
		}
	}
	if conf.Verbose {
		fmt.Println(config)
	}
	return config
}

// Init kube client
func InitKubeConfig(config *rest.Config) *kubernetes.Clientset {
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		fmt.Printf("Error %s, when initializing kube client", err.Error())
		os.Exit(1)
	}
	if conf.Verbose {
		fmt.Println(clientset)
	}
	return clientset
}

// Get pods from a given namespace
func GetPods(client kubernetes.Clientset, namespace string) corev1.PodList {
	pods, err := client.CoreV1().Pods(namespace).List(context.Background(), metav1.ListOptions{})
	if err != nil {
		fmt.Printf("Error %s, when fetching pods", err.Error())
		os.Exit(1)
	}
	return *pods
}

// Get deployments from a given namespace
func GetDeployments(client kubernetes.Clientset, namespace string) appsv1.DeploymentList {
	deployments, err := client.AppsV1().Deployments(namespace).List(context.Background(), metav1.ListOptions{})
	if err != nil {
		fmt.Printf("Error %s, when fetching deployments", err.Error())
		os.Exit(1)
	}
	return *deployments
}

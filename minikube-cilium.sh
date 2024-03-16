#!/usr/bin/env bash

profile=${profile:-cilium}
version=${version:-latest}
nodes=${nodes:-1}
memory=${memory:-4096}
cores=${cores:-4}
apiserver_ips=${apiserver_ips:-192.168.1.2} # Replace this with your host ip
minikube_addons=(
	"ingress"
	"metrics-server"
)

set -e

echo "This script starts a new k8s cluster with Cilium as CNI"
echo "Current settings (can be set with exporting variables)"
echo "  profile:       ${profile}"
echo "  version:       ${version}"
echo "  nodes:         ${nodes}"
echo "  memory:        ${memory}MB"
echo "  cores:         ${cores}"
echo "  apiserver_ips: ${apiserver_ips}"

# Fetching latest version of cilium
function fetch_version_cilium {
	# Get latest cilium version and print result
	curl -s "https://api.github.com/repos/cilium/cilium/tags" |
		# Get all tag names
		jq -r '.[]|.name' |
		# Get latest "vx.x.x" pattern without additional characters
		grep -P -m 1 'v[0-9]+\.[0-9]+\.[0-9]+$'
}

# For installing Cilium CLI
function install_cilium {
	local CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
	local CLI_ARCH=amd64
	if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
	curl -sL --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
	sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
	sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
	rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
}

# For installing Hubble CLI
function install_hubble {
	HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
	HUBBLE_ARCH=amd64
	if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
	curl -sL --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
	sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
	sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
	rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
}

if ! command -v jq >/dev/null; then
	echo "Please install jq JSON parsing utility"
	exit 1
fi

if ! command -v curl >/dev/null; then
	echo "Please install curl"
	exit 1
fi

# Start cluser with no CNI
minikube start \
	--profile $profile \
	--kubernetes-version $version \
	--nodes $nodes \
	--memory $memory \
	--cpus $cores \
	--cni=false \
	--embed-certs \
	--apiserver-ips=$apiserver_ips

if ! command -v cilium >/dev/null; then
	echo "Installing Cilium CLI"
	install_cilium
else
	echo "Cilium CLI already installed"
fi

if ! command -v hubble >/dev/null; then
	echo "Installing Hubble CLI"
	install_hubble
else
	echo "Hubble CLI already installed"
fi

cilium_latest="$(fetch_version_cilium)"
echo "Installing Cilium $cilium_latest"
cilium install --version "$cilium_latest"
echo "Enabling hubble"
cilium hubble enable

echo "Enabling minikube addons"
for a in "${minikube_addons[@]}"; do
	echo "Enabling $a minikube addon"
	minikube addons enable $a --profile $profile
done

cilium status
echo "Script (probably) successful"

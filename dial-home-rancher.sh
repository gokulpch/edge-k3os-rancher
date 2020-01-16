#!/bin/bash -x
export curl
export jq
export RANCHER_IP=34.70.139.14
export CLUSTER_NAME=test-cluster-new
export OUTPUT_DIR=/var/lib/rancher/k3s/server/manifests

while true; do
  curl -sLk https://${RANCHER_IP}/ping && break
  sleep 5
done
while true; do
    LOGIN_RESPONSE=$(curl -s "https://$RANCHER_IP/v3-public/localProviders/local?action=login" -H 'content-type: application/json' --data-binary '{"username":"admin","password":"rancher"}' --insecure)
    LOGIN_TOKEN=$(echo $LOGIN_RESPONSE | jq -r .token)
    echo "$LOGIN_TOKEN"
    if [ "$LOGIN_TOKEN" != "null" ]; then
        break
    else
        sleep 5
    fi
done
# Create API key
API_RESPONSE=$(curl -s "https://$RANCHER_IP/v3/token" -H 'content-type: application/json' -H "Authorization: Bearer $LOGIN_TOKEN" --data-binary '{"type":"token","description":"automation"}' --insecure)
# Extract and store token
API_TOKEN=`echo $API_RESPONSE | jq -r .token`
# Configure server-url
RANCHER_SERVER_URL="https://$RANCHER_IP/latest/meta-data/public-ipv4"
curl -s 'https://$RANCHER_IP/v3/settings/server-url' -H 'content-type: application/json' -H "Authorization: Bearer $API_TOKEN" -X PUT --data-binary '{"name":"server-url","value":"'$RANCHER_SERVER_URL'"}' --insecure
# Create cluster
CLUSTER_RESPONSE=$(curl -s "https://$RANCHER_IP/v3/cluster" -H 'content-type: application/json' -H "Authorization: Bearer $API_TOKEN" --data-binary '{"dockerRootDir":"/var/lib/docker","enableNetworkPolicy":false,"type":"cluster","rancherKubernetesEngineConfig":{"addonJobTimeout":30,"ignoreDockerVersion":true,"sshAgentAuth":false,"type":"rancherKubernetesEngineConfig","authentication":{"type":"authnConfig","strategy":"x509"},"network":{"type":"networkConfig","plugin":"canal"},"ingress":{"type":"ingressConfig","provider":"nginx"},"monitoring":{"type":"monitoringConfig","provider":"metrics-server"},"services":{"type":"rkeConfigServices","kubeApi":{"podSecurityPolicy":false,"type":"kubeAPIService"},"etcd":{"creation":"12h","extraArgs":{"heartbeat-interval":500,"election-timeout":5000},"retention":"72h","snapshot":false,"type":"etcdService","backupConfig":{"enabled":true,"intervalHours":12,"retention":6,"type":"backupConfig"}}}},"localClusterAuthEndpoint":{"enabled":true,"type":"localClusterAuthEndpoint"},"name":"'$CLUSTER_NAME'"}' --insecure)
# Extract clusterid to use for generating the docker run command
CLUSTER_ID=`echo $CLUSTER_RESPONSE | jq -r .id`
# Generate registrationtoken
CLUSTER_JSON=$(curl -s "https://$RANCHER_IP/v3/clusterregistrationtoken" -H 'content-type: application/json' -H "Authorization: Bearer $API_TOKEN" --data-binary '{"type":"clusterRegistrationToken","clusterId":"'$CLUSTER_ID'"}' --insecure)
CLUSTER_TOKEN=`echo $CLUSTER_JSON | jq -r .token`
curl -o $OUTPUT_DIR/cattle-agent.yaml "https://$RANCHER_IP/v3/import/$CLUSTER_TOKEN.yaml" --insecure

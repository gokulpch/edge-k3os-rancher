# edge-k3os-rancher
Cloud Init for installing/managing edge K3OS Hosts using remote Rancher



# Dial Remote Rancher Script:

### Steps
1. Grab an auth token from a remote Rancher server
2. Create an API key
3. Extract and store the auth token
4. Configure the server URL
5. Create the cluster via the Rancher API
6. Extract the Cluster ID
7. Generate the Registration token
8. Output the yaml to a /manifests folder

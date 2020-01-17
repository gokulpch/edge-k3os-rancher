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


# Feeding Cloud Init URL While installing K3OS

![Image](https://github.com/gokulpch/edge-k3os-rancher/blob/master/Screen%20Shot%202020-01-16%20at%201.43.34%20PM.png)


# IPSEC VPN - CGW AWS

###### https://hackmd.io/-vkARIFSRyq1PU1wO268ig?utm_content=buffer89fdf&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer
###### https://medium.com/@pahud/turn-raspberry-pi-into-aws-vpn-customer-gateway-with-docker-41b200140e7c#.v0bl2gz7f


# K3OS Installer RaPi

Follow this for installling K3OS:

* https://github.com/sgielen/picl-k3os-image-generator
* https://github.com/pagong/k3os-on-arm/tree/master/arm64/raspberry-pi3

# Installing K3OS on Raspberry PI

https://thepracticalsysadmin.com/build-a-pine64-kubernetes-cluster-with-k3os/
https://github.com/rancher/k3os#arm-overlay-installation
https://gist.github.com/hagmonk/6d0e53b5a74c935f814d576286918cd7


# Making K3OS Images for RaspberryPi

https://github.com/sgielen/picl-k3os-image-generator

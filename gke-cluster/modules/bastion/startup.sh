#! /bin/bash
# Install Tiny proxy

sudo apt update
sudo apt install tinyproxy
sudo echo "Allow localhost" >> /etc/tinyproxy/tinyproxy.conf
sudo service tinyproxy restart

# Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# OR
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list 
sudo apt-get update
sudo apt-get install -y kubectl

#Install plugin Configure with 
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

#Configure cluster
gcloud container clusters get-credentials $cluster --region us-central1 --project cool-academy-433713-g7
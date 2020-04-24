#/bin(/bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# run app as single container...
docker run -d --restart unless-stopped -p 80:80 adess/vmc-demo-k8s:v5


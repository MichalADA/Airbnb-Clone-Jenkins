# Airbnb-Clone-Jenkins
TECHNOLOGY: React App , AWS, ANSIBLE , JENKINS , DOCKER , SONARQUBE , TRIVY , PROMETHEUS , GRAFANA , SmokePING


### **PHASE 1  Setup**

**Step 1: Launch EC2 (Ubuntu 22.04): Ansible Host MAchine**

-  Provision an EC2 instance on AWS with Ubuntu 22.04.
-  -  Connect to the instance using SSH.
   - Clone the code 
   -  Install Ansible  look on ansible.sh
   -  Make inventory of hosts  example inventory.yml
   -  Copy key for instance change permission chmod 600 keys

**Step 2 Install Tools on Jenkins Host by ansible jenkins.yml**
 -  go to ANSIBLE dir
 -   ansible-playbook -i inventory.yml jenkins.yml

 
 **Step 3  Install Prometheus and Grafana by Ansible**
   - ansible-playbook -i inventory monitoring.yml

 **Step 4 Install Database by Ansible**
  - ansible-playbook -i inventory database.yml

### **PHASE 2  Configuration Jenkins**
 **2.Install Necessary Plugins in Jenkins**:

Goto Manage Jenkins →Plugins → Available Plugins →

Install below plugins

1 Eclipse Temurin Installer (Install without restart)

2 SonarQube Scanner (Install without restart)

3 NodeJs Plugin (Install Without restart)

4 Docker
Docker Commons
Docker Pipeline
Docker API
docker-build-step
5 OWASP Dependency-Check. 


Add DockerHub Credentials:

```
To securely handle DockerHub credentials in your Jenkins pipeline, follow these steps:
Go to "Dashboard" → "Manage Jenkins" → "Manage Credentials."
Click on "System" and then "Global credentials (unrestricted)."
Click on "Add Credentials" on the left side.
Choose "Secret text" as the kind of credentials.
Enter your DockerHub credentials (Username and Password) and give the credentials an ID (e.g., "docker").
Click "OK" to save your DockerHub credentials.
```
Now we can use ass Jenkinsfile as new job in jenkins 


I find that we need to add jenkins to docker group 
```
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

```

**PHASE 3 : Configuration Monitoring**

```
We need to edit prometheus.yml

git clone https://github.com/Michal-Devops/Airbnb-Clone-Jenkins.git
cd Airbnb-CLone-Jenkins
cd Monitoring
sudo cp prometheus.yml /etc/prometheus/prometheus.yml
promtool check config /etc/prometheus/prometheus.yml
curl -X POST http://localhost:9090/-/reload


```

Now we need to add Jenkins Plugins to Prometheus 
```
Go to manage jenkis , plugins , avaliable and find prometheus metrics

```

Configure Grafana Dashboards

```

  We click imprort dashboard to node exporter we write id 1860
        to jenkins we write id 9964

```


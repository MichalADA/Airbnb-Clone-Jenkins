pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/Michal-Devops/Airbnb-Clone-Jenkins.git'
            }
        }
        stage("Sonarqube Analysis"){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh "${SCANNER_HOME}/bin/sonar-scanner \
                    -Dsonar.projectKey=airbnb \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://35.169.69.128:9000 \
                    -Dsonar.login=sqp_147bf509adf6ab3493b4d895c18b5704b7ed2f4b"
                }
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
                       sh "docker build -t airbnb ."
                       sh "docker tag airbnb darin912/airbnb:latest"
                       sh "docker push darin912/airbnb:latest"
                    }
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image darin912/airbnb:latest > trivyimage.txt" 
            }
        }
        stage("OWASP ZAP Scan"){
            steps{
                zaproxy scan: [
                    context: '',
                    failAllAlerts: false,
                    failBuild: true,
                    recursive: true,
                    rules: '',
                    session: '',
                    spider: true,
                    target: 'http://35.169.69.128:8081',
                    zapHome: '/path/to/zap'
                ]
            }
        }
        stage('Deploy to container'){
            steps{
                sh 'docker run -d --name airbnb -p 8081:80 darin912/airbnb:latest'
            }
        }
    }
}

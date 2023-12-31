pipeline {
    agent any
    environment {
        PROJECT_ID = 'devops-capstone-project-395319'
        LOCATION = 'us-central1-docker'
        CREDENTIALS_ID = 'gcr:devops-capstone-project-395319'
    }
    stages {
        stage("Checkout code") {
            steps {
                git([url: 'https://github.com/mwangiwambui/authoritative-dns', branch: 'main', credentialsId: 'mwangiwambuigit'])
            }
        }
    stage("Build image") {
            steps {
                script {
                  agent {
                docker {
                    app = docker.build("us-central1-docker.pkg.dev/devops-capstone-project-395319/dns-authoritative/dns-authoritative")
                }
                  }
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    agent {
                      docker {
                        docker.withRegistry('https://gcr.io', 'gcr:devops-capstone-project-395319') {
                                myapp.push("latest")
                                myapp.push("${env.BUILD_ID}")
                        }
                      }
                    }
                }
            }
        }        
        stage('Deploy to GKE') {
            steps{
                sh '''
                sed -i 's/us-central1-docker.pkg.dev/devops-capstone-project-395319/dns-authoritative/dns-authoritative:latest/us-central1-docker.pkg.dev/devops-capstone-project-395319/dns-authoritative/dns-authoritative:${env.BUILD_ID}/g' deployment.yml"
                '''
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }    
}

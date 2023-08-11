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
                    docker.withRegistry('https://gcr.io', 'gcr:devops-capstone-project-395319') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }        
        stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/hello:latest/hello:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
    }    
}



// @Library('global_shared_library') _ runPipeline(agent: 'nodejs-docker', environment: 'aws', technology: 'nodejs', account_name: 'DE', ENV_UAT: 'SIMPORTALSERVER_UAT', include_env:'true')
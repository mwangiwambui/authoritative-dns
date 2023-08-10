try {
  node {
        def app
        
        stage('Clone Repository') 
        {
            git([url: 'https://github.com/mwangiwambui/authoritative-dns', branch: 'main', credentialsId: 'mwangiwambuigit'])
        }
        
 
        stage('Build Docker Image') {
            app = docker.build("us-central1-docker.pkg.dev/devops-capstone-project-395319/dns-authoritative/dns-authoritative")
        }
        
        
        stage('Push Image to openshift prod Registry') {
            retry(3) {
                env.VERSION = version()
                docker.withRegistry('https://gcr.io', 'gcr:devops-capstone-project-395319') {
                    // app.push("us-central1-docker.pkg.dev/devops-capstone-project-395319/dns-authoritative/dns-authoritative")
                    app.push("latest")
                }
            }
            }
        
    }   
} catch(Error|Exception e) {
  //Finish failing the build after telling someone about it
  throw e
} finally {
    // Post build steps here
    /* Success or failure, always run post build steps */
    // send email
    // publish test results etc etc
}
def version()
{
    
    return 1.0
}


// @Library('global_shared_library') _ runPipeline(agent: 'nodejs-docker', environment: 'aws', technology: 'nodejs', account_name: 'DE', ENV_UAT: 'SIMPORTALSERVER_UAT', include_env:'true')
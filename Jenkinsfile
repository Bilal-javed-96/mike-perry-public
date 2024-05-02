pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pull the git repo
                cleanWs()
                checkout scm
            }
        }

        
        stage('Terraform Deployment') {
            steps {
                script {
                    // CD into deployment folder and run terraform commands
                    
                        sh '''
                            terraform init
                            terraform plan
                            terraform apply -auto-approve
                        '''
                    
                }
            }
        }
    }
}

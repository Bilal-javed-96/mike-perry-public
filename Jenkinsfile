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
        stage('Configure AWS Profile') {
            steps {
                script {
                    // Configure AWS CLI with the provided profile
                    sh "aws configure set aws_access_key_id ${aws_access} --profile ${aws_profile}"
                    sh "aws configure set aws_secret_access_key ${aws_secret} --profile ${aws_profile}"
                    sh "aws configure set region ca-central-1 --profile ${aws_profile}"
                    // You can set other configurations as well if needed
                }
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

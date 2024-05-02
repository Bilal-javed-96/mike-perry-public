pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret')
    }
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
                    sh "aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID --profile ${env.aws_profile}"
                    sh "aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile ${env.aws_profile}"
                    sh "aws configure set region ca-central-1 --profile ${env.aws_profile}"
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

pipeline {
    agent any 
    tools{             
        maven 'maven-3.8'  
        }
    stages{
        stage('build jar') {
            steps {
                script {
                    echo "Building the application..."
                    sh 'mvn package'
                }
            }
        }
        stage('build image') {
            steps {
                script {
                    echo "Building the dockerimage..."
                    
                }
            }
        }
        stage('provision server') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('Jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('Jenkins_aws_secret_access_key')
            }
            steps {
                script {
                    dir('terraform') {
                 sh "terraform init"
                 sh "terraform apply --auto-approve"
                 EC2_PUBLIC_IP = sh(
                    script: "terraform output ec2_public_ip"
                    )

                }
            }
            
        }
    }
        stage('deploy') {
            steps {
                script {
                    echo "waiting for EC2 server to initialize"
                    sleep(time: 100, unit: "SECONDS")
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                    sshagent(['jenkins-terraform-demo3-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance}"
}
                }
            }        }
    }
}

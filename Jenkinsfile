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
            emvironment {
                AWS_ACCESS_KEY_ID = credentials('Jenkins_aws_access_key_id')
                AWS_SECRET_ACCESS_KEY = credentials('Jenkins_aws_secret_access_key')
            }
            dir('terraform') {
                 sh "terraform init"
                 sh "terraform apply --auto-approve"
                 EC2_PUBLIC_IP = sh(
                    script "terraform output ec2_public_ip"
                    returnStdout: true
                 ).trim()
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "waiting for EC2 server to initialize"
                    sleep(time: 100, unit: "SECONDS")
                    def dockerCmd = 'docker run -p 3080:3080 -d prashantdocker2623/pipeline'
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${dockerCmd}"
}
                }
            }        }
    }
}
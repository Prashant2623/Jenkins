pipeline {
    agent any 
    stages{
       stage('Build and push docker image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]){
                        sh 'docker build -t prashantdocker2623/pipeline .'
                        sh "docker login -u $USER -p $PASS"
                        sh 'docker push prashantdocker2623/pipeline'
                    }                    
                }
            }
        }
       stage('Provision server') {
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
                    script: "terraform output ec2_public_ip",
                    returnStdout: true
                    ).trim()

                }
            }
            
        }
    }
        stage('Deploy') {
            environment {
                DOCKER_CREDS = credentials('docker-hub-repo')
            }
            steps {
                script {
                    echo "waiting for EC2 server to initialize"
                    sleep(time: 100, unit: "SECONDS")
                    def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"
                    def shellCmd = "bash ./entry-script.sh ${Docker_CREDS_USR} ${DOCKER_CREDS_PSW}"
                    sshagent(['jenkins-terraform-demo3-server-key']) {
                    sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
}
                }
            }        }
    }
}
 

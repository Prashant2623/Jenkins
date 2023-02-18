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
        stage('deploy') {
            steps {
                script {
                    def dockerCmd = 'docker run -p 3080:3080 -d prashantdocker2623/pipeline'
                    sshagent(['ec2-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@18.234.105.130 ${dockerCmd}"
}
                }
            }        }
    }
}

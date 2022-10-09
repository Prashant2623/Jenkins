pipeline {
    agent any 
    tools {
        maven 'maven-3.8'
    }
    
    stages {

        stage('build jar file ') {
            steps {
                echo "build app"
                sh 'mvn-package'
                }
            }
        }
        stage('build docker image') {
            steps {
                script{
                    echo "building docker image"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'docker build -t docker2624/pipeline .'
                    sh 'docker login -u ${USER} -p ${PASS}'
                    sh 'docker push docker2624/pipeline'
}
                }
            }
        }
        stage('deploy') {
            steps {
                 echo "deploy app"
            }        }
}

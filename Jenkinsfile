pipeline {
    agent any 
    environment{             
        NEW_VERSION = '1.3.0'
        }
    stages {
        stage("init"){
            steps{
            script {
                gv = load "script.groovy"
            }
            }
        } 
        stage('build') {
            steps {
                script {
                    gv.buildApp()
                }
            }
        }
        stage('test') {
            when {
                expression{
                  branch 'master'   
                }
            }
            steps {
                script {                    
                    gv.testApp()
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "Deploying the application..."
                    withCredentials([usernamePassword(credentialsId: 'server-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        echo 'username : ${USERNAME} password : ${PASSWORD}'
}   
                }
            }        }
    }
}

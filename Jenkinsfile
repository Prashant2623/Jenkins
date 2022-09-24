pipeline {
    agent any 
    environment{              //environment attribute. What is defined in this block will be available for all stages   
        NEW_VERSION = '1.3.0'
        }
    stages { 
        stage('build') {
            steps {
                script {
                    echo "Building the application..."
                    echo "building version ${NEW_VERSION}"
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
                    echo "Testing the application..."
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
            }
        }
    }
}

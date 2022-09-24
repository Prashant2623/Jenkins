pipeline {
    agent any 
    
    
    stages {
        stage('build') {
            steps {
                script {
                    echo "Building the application..."
                    
                }
            }
        }
        stage('test') {
            when {
                branch "master"
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
                }
            }
        }
    }
}

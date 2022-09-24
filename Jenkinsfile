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
            steps {
                script {
                    // when this stage should execute
                    when {
                        expression {
                            BRANCH_NAME == 'master'
                        }
                    }
                    echo "Testing the application..."
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "Deploying the application..."
                    withCredentials([

                    ])
                }
            }
        }
    }
}

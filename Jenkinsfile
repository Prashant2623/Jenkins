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
                    env.ENV = input message: 'Select the environment to deploy to ', OK: 'Done', parameters: [choice(choices: ['DEV', 'STAGE', 'PROD'], name: '')]
                    gv.deployApp()    
                }
            }        }
    }
}

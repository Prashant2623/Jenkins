#!/usr/bin/env groovy

@Library('jenkins-sharedlibrary')

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
                    build()
                    
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo "deploying the application..."    
                }
            }        }
    }
}

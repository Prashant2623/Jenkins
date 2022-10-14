#!/usr/bin/env groovy

@Library('jenkins-sharedlibrary')_



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
                    build()
                }
            }
        }
        stage('deploy') {
            steps {
                 echo "deploy app"
            }        }
}

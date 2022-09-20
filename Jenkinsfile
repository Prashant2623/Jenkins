// this is a declarative pipeline. Declartive pipeline have a predefined structure and always start with the word pipeline//
pipeline {                              
    agent none                
    stages {
        stage('Example Build') {                          
            agent { docker 'maven:3.8.1-adoptopenjdk-11' } 
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
    }
}

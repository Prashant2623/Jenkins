def buildJar() {
    echo "building the application..."
    sh 'mvn package'
} 

def buildImage() {
    echo "building the docker image..."
    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t docker2624/demo-app .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push docker2624/demo-app'
    }
} 

def deployApp() {
    echo 'deploying the application...'
} 

return this

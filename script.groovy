def buildApp() {
    echo "Building the application..."
    echo "building version ${env.NEW_VERSION}"
}
return this

def testApp() {
    echo "Testing the application..."
}
return this
def deployApp() {
     echo "Deploying the application..."
         withCredentials([usernamePassword(credentialsId: 'server-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
//some block
}                
}
return this

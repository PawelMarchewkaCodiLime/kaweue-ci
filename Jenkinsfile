pipeline {
    agent any

    stages {
        stage('Preparetion') {
            steps {
                deleteDir()
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        git url: 'git://github.com/kaweue/api-um-warsaw-client.git', branch: "${API_CLIENT_BRANCH}"
                        sh 'go get -u github.com/onsi/ginkgo/ginkgo'
                        sh 'go get -u github.com/onsi/gomega/...'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        sh 'ginkgo lib/authenticator/'
               	        sh 'ginkgo lib/client/'
                    }
                }
            }
        }
        
        stage('Build') {
            steps {
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
               	        sh 'go build -v cmd/main.go'
                    }
                }
            }
        }
    }
}
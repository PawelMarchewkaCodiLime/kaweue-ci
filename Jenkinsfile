pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                deleteDir()
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        git url: 'git://github.com/kaweue/api-um-warsaw-client.git', branch: "${API_CLIENT_BRANCH}"
                        sh 'go get -u github.com/golang/dep/cmd/dep'
                        sh 'go get -u github.com/onsi/ginkgo/ginkgo'
                        sh 'go get -u github.com/onsi/gomega/...'
                        sh 'dep ensure -v'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        sh 'ginkgo -r --randomizeAllSpecs --randomizeSuites --failOnPending --cover --trace --progress'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                withEnv(['GOPATH=' + pwd(), 'PATH+=' + pwd() + '/bin/']){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
               	        sh 'go build -v .'
                    }
                }
            }
        }
    }
}
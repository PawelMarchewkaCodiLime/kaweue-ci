pipeline {
    agent {
        docker { image 'golang:1.11' }
    }

    stages {
        stage('Preparation') {
            steps {
                withEnv(['GOPATH=' + pwd()]){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        git url: 'git://github.com/kaweue/api-um-warsaw-client.git', branch: "master"
                        sh 'go get -u github.com/golang/dep/cmd/dep'
                        sh 'go get -u github.com/onsi/ginkgo/ginkgo'
                        sh 'go get -u github.com/onsi/gomega/...'
                        sh '$GOPATH/bin/dep ensure -v'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                withEnv(['GOPATH=' + pwd()]){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
                        sh '$GOPATH/bin/ginkgo -r --randomizeAllSpecs --randomizeSuites --failOnPending --cover --trace --progress'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                withEnv(['GOPATH=' + pwd()]){
                    dir ('src/github.com/kaweue/api-um-warsaw-client') {
               	        sh 'go build -v .'
                    }
                }
            }
        }
    }
}

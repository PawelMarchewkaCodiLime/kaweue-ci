pipeline {

    agent {
        docker { image 'golang:1.9' }
    }

    stages {
        stage('Preparation') {
            steps {
                deleteDir()
                dir ('src/github.com/kaweue/api-um-warsaw-client') {
                   git url: 'git://github.com/kaweue/api-um-warsaw-client.git', branch: "${API_CLIENT_BRANCH}"
                    sh 'go get -u github.com/golang/dep/cmd/dep'
                    sh 'go get -u github.com/onsi/ginkgo/ginkgo'
                    sh 'go get -u github.com/onsi/gomega/...'
                    sh 'dep ensure -v'
                }
            }
        }
        stage('Test') {
            steps {
                dir ('src/github.com/kaweue/api-um-warsaw-client') {
                    sh 'ginkgo -r --randomizeAllSpecs --randomizeSuites --failOnPending --cover --trace --progress'
                }
            }
        }
        stage('Build') {
            steps {
                dir ('src/github.com/kaweue/api-um-warsaw-client') {
               	    sh 'go build -v .'
                }
            }
        }
        stage('Integration tests') {
            steps {
                dir ('src/github.com/kaweue/api-um-warsaw-client') {
                    withEnv(['PATH+=' + pwd()]){
                        sh 'python integration_tests/integration.py'
                    }
                }
            }
        }
    }
}

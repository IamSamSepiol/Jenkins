
@Library('jenkins-shared-library') _

pipeline {
    agent any

    stages {
        stage('Initialize') {
            steps {
                script {
                    example('Developer')
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-app:latest .'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh '''
                docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                -v $PWD/trivy-report:/root/.cache/ aquasec/trivy image --exit-code 1 \
                --severity HIGH,CRITICAL my-app:latest | tee trivy-report.txt
                '''
            }
        }

        stage('Post Scan Actions') {
            steps {
                script {
                    def scanResults = readFile('trivy-report.txt')
                    echo scanResults
                }
            }
        }
    }
}

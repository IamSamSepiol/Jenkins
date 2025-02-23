@Library('jenkins-shared-library') _

pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-app"
        IMAGE_TAG = "latest"
        REPO_URL = 'https://github.com/IamSamSepiol/Jenkins.git'  // Your Git repo URL
        BRANCH = 'main'  // Change if needed
        example 'joel'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                deleteDir() // Clean old files to ensure fresh checkout
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Check Workspace') {
            steps {
                sh 'pwd'
                sh 'ls -l'  // Check if Dockerfile is available
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
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

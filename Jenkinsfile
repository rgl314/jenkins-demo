pipeline {

    agent any

    tools {
        maven 'M3'   // must match the name you gave it in step 3
    }

    environment {
        IMAGE_NAME = 'rgl314/jenkins-demo'
        IMAGE_TAG  = '1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rgl314/jenkins-demo'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests=false'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }

    post {
        success {
            slackSend(channel: '#builds', color: 'good',
                    message: "✅ ${env.JOB_NAME} #${env.BUILD_NUMBER} succeeded — ${env.BUILD_URL}")
        }
        failure {
            slackSend(channel: '#builds', color: 'danger',
                    message: "❌ ${env.JOB_NAME} #${env.BUILD_NUMBER} failed — ${env.BUILD_URL}console")
        }
    }

}
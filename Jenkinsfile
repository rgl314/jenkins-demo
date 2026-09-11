pipeline {

    agent any

    tools {
        maven 'M3'   // must match the name you gave it in step 3
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
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        stage('Credentials') {
            steps {
                withCredentials([string(credentialsId: 'test-secret', variable: 'MY_SECRET')]) {
                    sh 'echo "The secret is: $MY_SECRET"'
                }
            }
        }
    }

    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed — check console output for detailed review.'
        }
    }

}
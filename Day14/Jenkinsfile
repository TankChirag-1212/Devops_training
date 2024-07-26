pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'd784ec34-84a6-4363-8d99-5ac8be4a8df8'
        REPO_NAME = 'chirag1212/my_repo'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/TankChirag-1212/my-java-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.REPO_NAME}:java-app")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        // dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push('java-app')
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh """
                    docker run -itd --name java-container \
                    ${env.REPO_NAME}:java-app
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Build and test succeeded!'
            script{
                sh """
                docker rm --force java-container
                """
            }
        }
        failure {
            echo 'Build or test failed!'
        }
    }
}

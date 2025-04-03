pipeline {
    agent any

    environment {
        DOCKER_USERNAME = 'nandhini1694'
        DOCKER_PASSWORD = 'changemee'
        IMAGE_NAME = 'final-res'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/itsnandhu2004/TASK-6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_USERNAME}/${IMAGE_NAME}:latest", "--file Dockerfile .")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    echo "Logged in to Docker Hub as ${DOCKER_USERNAME}"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.image("${DOCKER_USERNAME}/${IMAGE_NAME}:latest").push()
                }
            }
        }
    }  

}
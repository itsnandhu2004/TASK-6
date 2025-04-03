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
                git 'https://github.com/itsnandhu2004/TASK-6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_USERNAME}/${IMAGE_NAME}:latest", "-f Dockerfile .")
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

        stage('Set up Minikube') {
            steps {
                script {
                    echo "Starting Minikube with Docker driver..."
                    sh """
                    minikube delete || true
                    minikube start --driver=docker --memory=4096 --cpus=4 --force
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Applying Kubernetes deployment..."
                    sh 'kubectl apply -f k8s-deployment.yaml'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed. Cleaning up..."
            sh "docker logout"
            sh "minikube stop"
            sh "minikube delete"
        }
    }
}
pipeline {
    agent any

    environment {
        IMAGE_NAME = "nandhini1694/rest-app"
        K8S_DEPLOYMENT = "rest-app-deployment"
        K8S_SERVICE = "rest-app-service"
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
                    sh '''
                    minikube start
                    eval $(minikube docker-env)
                    docker build -t ${IMAGE_NAME} .
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                        sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    sh 'kubectl get pods -o wide'
                    sh 'kubectl get services'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh 'docker system prune -f'
                }
            }
        }
    }
}
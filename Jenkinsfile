pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nandhini1694/webapp:latest'
        KUBE_CONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/itsnandhu2004/TASK-6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub', url: '']) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh 'kubectl get pods'
            }
        }

        stage('Set Up Monitoring (Prometheus & Grafana)') {
            steps {
                sh 'kubectl apply -f monitoring/prometheus.yaml'
                sh 'kubectl apply -f monitoring/grafana.yaml'
            }
        }

        stage('Verify Monitoring') {
            steps {
                sh 'kubectl get pods -n monitoring'
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for errors.'
        }
    }
}

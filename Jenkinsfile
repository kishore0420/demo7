pipeline {
agent any

    environment {
        DOCKER_HUB_REPO = "kishoreking90/myrepo"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        CONTAINER_NAME = "nginxcontainer"

    }

    stages {
        stage ('cleaning local docker desktop') {
            steps {
                sh 'docker stop $(docker ps -a -q) || true && docker rm $(docker ps -a -q) || true && docker rmi -f $(docker images  -a -q) || true'
            }
        }
        
        stage ('Docker Image Build') {
            steps {
                sh 'docker build -t $DOCKER_HUB_REPO:$BUILD_NUMBER .'
            }
        }
        stage ('create container') {
            steps {
                sh 'docker run -d --name $CONTAINER_NAME -p 8085:80 --restart unless-stopped $DOCKER_HUB_REPO:$BUILD_NUMBER && docker ps'
            }
        } 
        stage ('Container Testing ') {
            steps {
                sh 'wget localhost:8085'
            }
        }
        stage ('DockerHub Login and push') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin && docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
            }
        }
    }
}

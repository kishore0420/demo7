pipeline {
agent any

    environment {
        DOCKER_HUB_REPO = "kishoreking90/myrepo"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        CONTAINER_NAME = "nginxcontainer"
        http_proxy = 'http://127.0.0.1:3128/'
        https_proxy = 'http://127.0.0.1:3128/'
        ftp_proxy = 'http://127.0.0.1:3128/'
        socks_proxy = 'socks://127.0.0.1:3128/'
    }

    stages {
        stage ('Docker Image Build') {
            steps {
                sh 'docker build -t $DOCKER_HUB_REPO:$BUILD_NUMBER .'
            }
        }
        stage ('create container') {
            steps {
                sh 'docker run -d --name $CONTAINER_NAME$BUILD_NUMBER -p 80$BUILD_NUMBER:8080 --restart unless-stopped $DOCKER_HUB_REPO:$BUILD_NUMBER && docker ps'
            }
        }
        stage ('Container Testing ') {
            steps {
                sh 'wget localhost:800$BUILD_NUMBER'
            }
        }
        stage ('DockerHub Login and push') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin && docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
            }
        }
    }
}

pipeline {
    agendoc any
    triggers { pollSCM('* * * * *') }
    stages {
        stage('Create Network') {
            steps {
                sh 'docker network ls | grep django-info || docker network create django-info'
            }
        }
        stage('Cleanup Previous Container') {
            steps {
                sh '''
                docker ps -a -q --filter "name=django-info" | grep -q . && docker stop django-info && docker rm django-info || echo "No existing container found"
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t django-info .'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker run -d --network django-info -p 8081:8081 --name django-info django-info'
            }
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Build Image') {
            agent {
              kubernetes {
                label 'kubepod'
                idleMinutes 5
                yamlFile 'myweb.yaml'
                defaultContainer 'kaniko'
              }
            }
            steps {
              sh "/kaniko/executor \
                    --context=https://github.com/naveenkumarhn/Jenkins.git \
                    --dockerfile=Dockerfile \
                    --verbosity=debug \
                    --cache=true \
                    --insecure=true \
                    --destination=naveenkumar003/helloworld:latest"
            }
        }
    }
}

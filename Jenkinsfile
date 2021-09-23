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
                    --context=git://github.com/naveenkumarhn/Jenkins.git#refs/heads/master \
                    --dockerfile=Dockerfile \
                    --verbosity=debug \
                    --cache=true \
                    --insecure=true \
                    --destination=naveenkumar003/helloworld:latest"
            }
        }
    }
}

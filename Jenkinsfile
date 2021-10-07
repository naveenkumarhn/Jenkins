pipeline {

   agent {
    kubernetes {
        yaml """
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command:
    - /busybox/sh
    tty: true
    volumeMounts:
    - name: kaniko-secret
      mountPath: /kaniko/.docker
  volumes:
    - name: kaniko-secret
      secret:
        secretName: regcred
        items:
          - key: .dockerconfigjson
            path: config.json
   
"""
   }
     }
     stages {
     stage("Build and Publish") {
         steps {
               container('kaniko') {
                  script {
                     sh '''
                     /kaniko/executor --dockerfile `pwd`/Dockerfile \
                                      --context `pwd` \
                                      --destination=naveenkumar003/myweb:${BUILD_NUMBER}
                        '''
                  }
               }
               
        }
      }
      stage('Analyze with Anchore plugin') {
         steps {
            writeFile file: 'anchore_images', text: 'docker.io/naveenkumar003/myweb:2'
            anchore name: 'anchore_images'
         }
      }
     stage("Deployment") {
          steps {
                git branch: 'main', url: 'https://github.com/naveenkumarhn/Jenkins.git'
                
               sh '''
                  git config --global user.email "nkumar1805@yahoo.in"
                  git config --global user.name naveenkumarhn
                  sed -i "s/myweb:.*/myweb:${BUILD_NUMBER}/g" deploy/deploy.yaml
                  git add .
                  git commit -am "${BUILD_NUMBER}"
                  ls
                  git push --force origin master
                 '''
          }
       }
     }
}

podTemplate(yaml: '''
              kind: Pod
              spec:
                containers:
                - name: kaniko
                  image: gcr.io/kaniko-project/executor:v1.6.0-debug
                  imagePullPolicy: Always
                  command:
                  - sleep
                  args:
                  - 99d
                  volumeMounts:
                    - name: jenkins-docker-cfg
                      mountPath: /kaniko/.docker
                volumes:
                - name: jenkins-docker-cfg
                  projected:
                    sources:
                    - secret:
                        name: docker-credentials
                        items:
                          - key: .dockerconfigjson
                            path: config.json
'''
  ) {

  node(kubepod) {
    stage('Build with Kaniko') {
      git 'https://github.com/naveenkumarhn/Jenkins.git'
      container('kaniko') {
        sh '/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=true --destination=naveenkumar003/myimage'
      }
    }
  }
}

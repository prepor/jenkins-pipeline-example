podTemplate(label: 'tmp-builder',
            containers: [containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)],
            volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) {
  node('tmp-builder') {
    def project = 'prepor'
    def appName = 'tmp-app'
    def imageTag = "${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

    checkout scm

    stage('Build image') {
      container('docker') {
        sh("echo `pwd`")
        sh("docker build -t ${imageTag} .")
        sh("docker push ${imageTag}")
      }
    }

    stage 'Push image to registry'

    stage "Deploy Application"
    sh("echo hi!")
    // Create namespace if it doesn't exist
    // sh("kubectl get ns ${env.BRANCH_NAME} || kubectl create ns ${env.BRANCH_NAME}")
    // // Don't use public load balancing for development branches
    // sh("sed -i.bak 's#LoadBalancer#ClusterIP#' ./k8s/services/frontend.yaml")
    // sh("sed -i.bak 's#gcr.io/cloud-solutions-images/gceme:1.0.0#${imageTag}#' ./k8s/dev/*.yaml")
    // sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/services/")
    // sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/dev/")
    // echo 'To access your environment run `kubectl proxy`'
    // echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${env.BRANCH_NAME}/services/${feSvcName}:80/"

  }
}

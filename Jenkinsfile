node('myslave') {
  try {
    def image
    int build = "${env.BUILD_NUMBER}"
    //BigDecimal build = new BigDecimal.valueOf("${env.BUILD_NUMBER}")
    int ver = build //* 0.001
    int lastver = ver - 2 //0.002
    def version = "amitde7896/studentregister:" + ("${ver}")
    def lastversion = "amitde7896/studentregister:" + ("${lastver}")
    sh "echo ${lastversion}"
    def cred = 'docker_hub'

    stage("Checkout From Gitea") {
      checkout scm
    }

    stage("Build Docker Image") {
      echo "------------------------------------Build------------------------------------"
      image = docker.build("${version}", "Image/")

      //echo ("${num}" * 0.01)

    }

    stage("Run Test Container") {
      echo "------------------------------------Run------------------------------------"
      testcont = docker.image("${version}").run('-p 2000:3000')
    }

    node {
      stage("Test The Test Container") {
        checkout scm
        echo "------------------------------------Test------------------------------------"
        //sh 'pwd'
        //sh 'ls'
        def test = sh returnStdout: true, script: "sudo bash test.sh"
        //sh "echo ${test}"
        //sh 'TEST=$(sudo bash test.sh)'
        //echo "{$env.TEST}"
        if (test.trim().equals("Passed!")) {
          echo "Passed!!"
        } else {
          echo "Failed!!"
          currentBuild.result = "FAILED"
        }
        //def test = sh returnStdout: true, script: 'curl 10.0.0.91:2000/'
        //echo "${test}"
      }
    }
    stage("Approve For Deployment") {
      echo "------------------------------------Approve?------------------------------------"
      //def userInput = input(
      //  id: 'Proceed', message: 'Was this good?', parameters: [
      //  [$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you agree with this']
      //  ])
    }
    stage("Push To Registry") {
      echo "------------------------------------Push------------------------------------"
      docker.withRegistry( '', cred ) {
              image.push()
            }

    }
    stage("Deploy To Production Kubernetes") {
      echo "------------------------------------Deploy------------------------------------"
      //sh 'ssh packet@10.0.0.90 | echo 'aa' kubectl apply -f Deployments/amit.yaml'
      def amit = """apiVersion: apps/v1
kind: Deployment
metadata:
  name: amit-deploy
#    labels:
#      app: amitlabel
spec:
  replicas: 6
  selector:
    matchLabels:
      app: amitlabel
  strategy:
   type: RollingUpdate
   rollingUpdate:
     maxSurge: 1
     maxUnavailable: 0
  template:
    metadata:
      labels:
        app: amitlabel
    spec:
      containers:
      - name: amit
        image: ${version}
        ports:
        - containerPort: 3000"""


      writeFile file: 'amit.yaml', text: "${amit}"
      sh 'cat amit.yaml'
      kubernetesDeploy configs: 'amit.yaml', kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
    }

    stage("Stop Test Container") {
      echo "------------------------------------Stopping------------------------------------"
      testcont.stop()
      //sh "echo ${lastversion}"

      sh "docker rmi ${lastversion}"
      //dockerimage.remove("amitde7896/studentregister:" + (${env.BUILD_NUMBER} - 1))
      //image.remove()
    }
  }
  catch (e) {
  currentBuild.result = "FAILED"
  echo '------------------------------------The Build Failed!!!------------------------------------'
  testcont.stop()
  }
}

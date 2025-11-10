pipeline {
  agent any

  environment {
    REGISTRY = "ghcr.io/devpandai"
    IMAGE_NAME = "phpmyadmin"
    IMAGE_TAG = "latest"
    GITOPS_REPO = "https://github.com/devpandai/phpmyadmin-deploy.git"
  }

  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', url: 'https://github.com/devpandai/phpmyadmin-app.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh """
          docker build -t $REGISTRY/$IMAGE_NAME:$IMAGE_TAG .
          """
        }
      }
    }

    stage('Login & Push Image') {
      steps {
        withCredentials([string(credentialsId: 'github-token', variable: 'TOKEN')]) {
          sh """
          echo $TOKEN | docker login ghcr.io -u devpandai --password-stdin
          docker push $REGISTRY/$IMAGE_NAME:$IMAGE_TAG
          """
        }
      }
    }

    stage('Update GitOps Repo') {
      steps {
        script {
          sh """
          git clone $GITOPS_REPO deploy-repo
          cd deploy-repo
          sed -i 's|image:.*|image: $REGISTRY/$IMAGE_NAME:$IMAGE_TAG|' phpmyadmin-deployment.yaml
          git config user.name "jenkins"
          git config user.email "jenkins@local"
          git add .
          git commit -m "update image to $IMAGE_TAG"
          git push
          """
        }
      }
    }
  }
}

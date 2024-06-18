pipeline {
	agent any
	
	environment {
		DOCKER_HUB_TOKEN = credentials('dockerhub_token')
		DOCKER_HOST = 'unix://var/run/docker.sock'
		}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
				script {
					def lastTag = sh(script: 'git describe --tags `git rev-list --tags -max-count=1`', returnStdout: true).trim()
					echo "Last tag: ${lastTag}"

					env.VERSION = lastTag
					}
				}
				}

		stage('Build Docker image') {
			steps {
				script {
					sh "echo ${DOCKER_HUB_TOKEN} | docker login --username annijakaupere --password-stdin"
					
					sh "annijakaupere/build-1c.sh ${env.VERSION}"
				
					sh "docker push annijakaupere/1c-server-slk-3033:${env.VERSION}"
					}
				}
				}
		
		stage('Cleaning') {
			steps {
				script {
					sh "docker rmi -f annijakaupere/1c-server-slk-3033:${env.VERSION}"

					sh "docker pull annijakaupere/1c-server-slk-3033:${env.VERSION}"
					}
				}
				}
		}

	post {
		always {
			echo 'Pipeline completed'
			}
		success {
			echo 'Pipeline succeesed'
			{
		failure {
			echo 'Pipeline failed'
			}
		}
	} 

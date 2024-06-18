pipeline {
	agent any
	
	environment {
		DOCKER_HUB_TOKEN = credentials('dockerhub-token')
		DOCKER_HOST = 'unix://var/run/docker.sock'
		ROOT_PASSWD = 'root'
		}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
				script {
					def lastTag = sh(script: 'git describe --tags `git rev-list --tags --max-count=1`', returnStdout: true).trim()
					echo "Last tag: ${lastTag}"
					env.VERSION= lastTag

					}
				}
				}

		stage('Build Docker images') {
			steps {
				script {
					sh "echo ${DOCKER_HUB_TOKEN} | docker login --username annijakaupere --password-stdin"
					
					sh "chmod +x -R ./"
					sh "echo ${ROOT_PASSWD} | sudo -S ./build-1c.sh ${env.VERSION}"
				
					sh "echo ${ROOT_PASSWD} | sudo -S docker push 1c-server-slk-3033:${env.VERSION}"
					
					sh "echo ${ROOT_PASSWD} | sudo -S docker volume create --name pg-data"
					sh "echo ${ROOT_PASSWD} | sudo -S docker volume create --name pg-run"
					sh "echo ${ROOT_PASSWD} | sudo -S docker run --name postgresql --restart always -v pg-data:/var/lib/postgresql -v pg-run:/run/postgresql \
--net host -d rsyuzyov/docker-postgresql-pro-1c"
						
					}
				}
				}
		
		stage('Cleaning') {
			steps {
				script {
					sh "echo ${ROOT_PASSWD} | sudo -S docker rmi -f annijakaupere/1c-server-slk-3033:${env.VERSION}"

					sh "echo ${ROOT_PASSWD} | sudo -S docker pull annijakaupere/1c-server-slk-3033:${env.VERSION}"
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
			}
		failure {
			echo 'Pipeline failed'
			}
		}
	} 

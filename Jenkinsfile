pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'paycare-etl'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url:'https://github.com/VeeraK81/paycare.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Run unit tests in Docker Container') {
            steps {
                script {
                    
                    // Run the Docker container with mounted input/output files
                    sh 'docker run --rm -v  $(pwd):/app ${DOCKER_IMAGE} pytest --junitxml=unit-tests.xml'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Create input data file dynamically
                    sh 'echo -e "employee_id,employee_name,salary\n101,Alice,5000\n102,Bob,7000" > input_data.csv'

                    // Run the Docker container with mounted input/output files
                    sh 'docker run --rm -v $(pwd):/app ${DOCKER_IMAGE}'
                }
            }
        }
    }

    post {
        success {
            script {
                echo "Success"
                emailext(
                    subject: "Jenkins Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """<p>Good news!</p>
                             <p>The build <b>${env.JOB_NAME} #${env.BUILD_NUMBER}</b> was successful.</p>
                             <p>View the details <a href="${env.BUILD_URL}">here</a>.</p>""",
                    to: 'v.kannan@tbs-education.org'
                )
            }
        }
        failure {
            script {
                echo "Failure"
                emailext(
                    subject: "Jenkins Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """<p>Unfortunately, the build <b>${env.JOB_NAME} #${env.BUILD_NUMBER}</b> has failed.</p>
                             <p>Please check the logs and address the issues.</p>
                             <p>View the details <a href="${env.BUILD_URL}">here</a>.</p>""",
                    to: 'v.kannan@tbs-education.org'
                )
            }
        }
    }
}
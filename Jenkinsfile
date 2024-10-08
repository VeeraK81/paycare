pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'paycare-etl'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('paycare_etl:latest')
                }
            }
        }
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/VeeraK81/paycare.git'
            }
        }
        
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             docker.image('paycare_etl:latest').inside {
        //                 sh 'pytest tests/test_etl.py --junitxml=unit-tests.xml'
        //             }
        //         }
        //     }
        // }
        // stage('Archive Results') {
        //     steps {
        //         junit 'unit-tests.xml'
        //     }
        // }
        // stage('Run Unit Tests') {
        //     steps {
        //         sh 'pytest tests/tests.py --junitxml=unit-tests.xml'
        //         // sh 'pytest --junitxml=unit-tests.xml'
        //     }
        //     post {
        //         always {
        //             junit 'unit-tests.xml'  // Publish test results
        //         }
        //     }
        // }
        // stage('Build Docker Image') {
        //     steps {
        //         sh 'docker build -t ${DOCKER_IMAGE} .'
        //     }
        // }
        // stage('Run Docker Container') {
        //     steps {
        //         script {
        //             docker.image('simple-scraper-veera:latest').inside {

        //             // Create input data file dynamically
        //             sh 'echo "employee_id,employee_name,salary\n101,Alice,5000\n102,Bob,7000" > input_data.csv'

        //             // Run the Docker container with mounted input/output files
        //             sh 'docker run --rm -v $(pwd)/input_data.csv:/app/input_data.csv -v $(pwd)/output_data.csv:/app/output_data.csv ${DOCKER_IMAGE}'
        //             }
        //         }
        //     }
        }
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             docker.build('paycare:latest')
        //         }
        //     }
        // }
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             docker.image('simple-scraper-veera:latest').inside {
        //                 sh 'pytest tests/tests.py --junitxml=results.xml'
        //             }
        //         }
        //     }
        // }
        // stage('Archive Results') {
        //     steps {
        //         junit 'results.xml'
        //     }
        // }
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
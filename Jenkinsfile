import groovy.json.JsonOutput

def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]

def getBuildUser() {
    return currentBuild.rawBuild.getCause(Cause.UserIdCause).getUserId()
}


pipeline {
    agent any
    
    environment {
        BUILD_USER = ''
    }

    tools {nodejs "node js"}
    
    //user-provided parameters
     parameters {
        string(name: 'SPEC', defaultValue: 'cypress/integration/**/**', description: 'Ex: cypress/integration/pom/*.spec.js')
        choice(name: 'BROWSER', choices: ['chrome', 'edge', 'firefox'], description: 'Pick the web browser you want to use to run your scripts')
    }
    
    //The options directive allows configuring Pipeline-specific options from within the Pipeline itself
    options {
        ansiColor('xterm')
    }

    //The stages with steps
    stages {
        
        stage('Build'){
            //Define steps
            steps {
                echo "Building the application"
                //sh "npm i"
                //sh 'npm config ls'
               /* sh "docker pull cypress/included:8.2.0"
                sh "docker images"
                sh "docker ps"

                sh "docker build cypress/included:8.2.0"
                */

                sh "docker build -t cypressTest:1.0.0 ." 
               
            }
        }
        
        stage('Testing') {
            steps {
                echo "Testing..."

                sh "docker run -t cypressTest:1.0.0 ."
               // sh "docker run -i -v '/home/jenkins/workspace/VF_IOT_MANAGED_CONNECTIVITY/Testing_Automation/Training Chapter/cypress-example':/my-cypress-project -t cypress/included:8.2.0 --spec cypress/integration/pom/*.spec.js"
                
                //sh "docker run -v '/home/jenkins/workspace/VF_IOT_MANAGED_CONNECTIVITY/Testing_Automation/Training Chapter/cypress-example':/e2e -w /e2e cypress/included:8.2.0 --spec '${SPEC}' --browser ${BROWSER}"
                // bat for windows cmd X sh 
                //sh "npm i"
                //sh "npx cypress run --browser ${BROWSER} --spec ${SPEC}"
                //sh "npx cypress run --spec ${SPEC} --headed"
            }
        }
        
        stage('Deploy'){
            steps {
                echo "Deploying"
            }
        }
    }

    post {
        always {
            //The script step takes a block of Scripted Pipeline and executes that in the Declarative Pipeline
            script {
                BUILD_USER = getBuildUser()
            }
            
            slackSend channel: '#jenkins-example',
                color: COLOR_MAP[currentBuild.currentResult],
                message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${BUILD_USER}\n Tests:${SPEC} executed at ${BROWSER} \n More info at: ${env.BUILD_URL}HTML_20Report/"
            
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'cypress/report', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: ''])
            deleteDir()
        }
    }
}

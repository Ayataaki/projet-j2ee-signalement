pipeline {
    agent any
    tools {
        jdk 'Java17'          // correspond au JDK configuré
        maven 'Maven-3.9'     // correspond à Maven configuré
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
                // Clonage avec Git
                git branch: 'develop', 
                    url: 'https://github.com/Ayataaki/projet-j2ee-signalement.git'
            }
        }
        stage('Compiler le projet') {
            steps {
                bat 'mvn clean'
            }
        }
        stage('Tester le projet') {
            steps {
                bat 'mvn test'
            }
        }
        // stage('Packager le projet') {
        //     steps {
        //         bat 'mvn package'
        //     }
        // }
        // stage('Analyse SonarQube') {
        //     environment {
        //         SONAR_TOKEN = credentials('squ_1cab12067fa4e40ed973a93f17379f3ea39b14ca') // le token que tu as ajouté dans Jenkins
        //     }
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             bat "mvn sonar:sonar -Dsonar.login=%SONAR_TOKEN%"
        //         }
        //     }
        // }
         stage('Packager le projet') {
            steps {
                bat 'mvn package -DskipTests'
            }
        }
        
        stage('Analyse SonarQube') {
            steps {
                withSonarQubeEnv('MySonarServer') {
                    withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                        bat '''
                            mvn sonar:sonar ^
                            -Dsonar.projectKey=plateforme-signalement-urbain
                        '''
                    }
                }
            }
        }
    }
}

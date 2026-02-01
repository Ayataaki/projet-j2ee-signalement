pipeline {
    agent any
    tools {
        jdk 'Java17'     
        maven 'Maven-3.9'    
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
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
         stage('Packager le projet') {
            steps {
                bat 'mvn package -DskipTests'
            }
        }
        
        stage('Analyse SonarQube') {
            steps {
                withSonarQubeEnv('MySonarServer') {
                    withCredentials([string(credentialsId: 'a52f7e79-5432-451e-8030-8b6f0df955ee', variable: 'SONAR_TOKEN')]) {
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

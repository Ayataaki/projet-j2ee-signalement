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
                // Compilation avec Maven
                sh 'mvn clean package'
            }
        }
    }
}

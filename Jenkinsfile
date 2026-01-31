pipeline {
    agent any
    stages {
        stage('Cloner le dépôt') {
            steps {
                // Clonage avec Git
                git branch: 'develop', 
                    url: 'https://github.com/Ayataaki/projet-j2ee-signalement.git'
            }
        }
    }
}

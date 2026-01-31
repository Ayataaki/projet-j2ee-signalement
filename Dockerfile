FROM tomcat:10.1-jdk17

# Nettoyer les apps par défaut
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier le WAR généré par Maven
COPY target/plateforme-urbaine.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

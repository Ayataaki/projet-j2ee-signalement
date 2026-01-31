package dao;

import java.io.InputStream;
import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import org.flywaydb.core.Flyway;

public class SingletonConnection {
	
	private static Connection connection;
    
	static {
        try {   	
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Récupérer la configuration depuis les variables d'environnement ou db.properties
            String url = getConfigValue("db.url", "DB_HOST", "DB_PORT", "DB_NAME");
            String user = getConfigValue("db.user", "DB_USER");
            String password = getConfigValue("db.password", "DB_PASSWORD");
            
            System.out.println("Tentative de connexion à : " + url);
            System.out.println("Utilisateur : " + user);
            
            // Migrer la BDD
            migrateDatabase(url, user, password);

            // Créer la connexion
            connection = DriverManager.getConnection(url, user, password);
            
            System.out.println("Connexion établie avec succès !");

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur de connexion à la base de données", e);
        }
    }
    
    /**
     * Récupère une valeur de configuration depuis les variables d'environnement
     * ou depuis db.properties en fallback
     */
    private static String getConfigValue(String propertyKey, String... envKeys) {
        // 1. Essayer les variables d'environnement (pour Docker)
        if (envKeys.length == 3) {
            // Cas de l'URL construite depuis DB_HOST, DB_PORT, DB_NAME
            String host = System.getenv(envKeys[0]);
            String port = System.getenv(envKeys[1]);
            String dbName = System.getenv(envKeys[2]);
            
            if (host != null && port != null && dbName != null) {
                return String.format("jdbc:mysql://%s:%s/%s?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", 
                                     host, port, dbName);
            }
        } else if (envKeys.length == 1) {
            // Cas simple (user, password)
            String envValue = System.getenv(envKeys[0]);
            if (envValue != null) {
                return envValue;
            }
        }
        
        // 2. Fallback sur db.properties
        try {
            Properties props = new Properties();
            InputStream in = SingletonConnection.class.getClassLoader()
                                .getResourceAsStream("db.properties");
            if (in != null) {
                props.load(in);
                return props.getProperty(propertyKey);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        throw new RuntimeException("Configuration introuvable pour : " + propertyKey);
    }
    
    private static void migrateDatabase(String url, String user, String password) {
        try {
            System.out.println("Migration Flyway en cours...");

            String migrationsPath;
            if (url.startsWith("jdbc:h2:")) {
                migrationsPath = "classpath:db/migration"; // tests
            } else {
                migrationsPath = "classpath:db/migration_mysql"; // MySQL
            }

            Flyway flyway = Flyway.configure()
            .locations(migrationsPath)
            .dataSource(url, user, password)
            .cleanDisabled(false)  // autorisé en test, mais désactiver pour prod si nécessaire
            .outOfOrder(true)      // migrations hors ordre autorisées
            .load();

            flyway.repair();
            flyway.migrate();

            // Flyway flyway = Flyway.configure()
            //     .dataSource(url, user, password)
            //     .cleanDisabled(false)
            //     .outOfOrder(true)  
            //     .load();
            
            // flyway.repair();
            // flyway.migrate();
            
            System.out.println("Migration réussie !");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la migration Flyway", e);
        }
    }
    
	public static Connection getConnection() {
		return connection;
	}
}
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
            // Charger le bon driver selon l'environnement
            String testMode = System.getProperty("test.mode");
            
            if ("true".equals(testMode)) {
                // Mode TEST : H2
                Class.forName("org.h2.Driver");
                String url = "jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1";
                String user = "sa";
                String password = "";
                
                System.out.println("🧪 MODE TEST : Connexion à H2");
                migrateDatabase(url, user, password);
                connection = DriverManager.getConnection(url, user, password);
                System.out.println("✅ Connexion H2 établie pour les tests");
            } else {
                // Mode PRODUCTION : MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                String url = getConfigValue("db.url", "DB_HOST", "DB_PORT", "DB_NAME");
                String user = getConfigValue("db.user", "DB_USER");
                String password = getConfigValue("db.password", "DB_PASSWORD");
                
                System.out.println("🚀 MODE PRODUCTION : Connexion à MySQL");
                System.out.println("Tentative de connexion à : " + url);
                System.out.println("Utilisateur : " + user);
                
                migrateDatabase(url, user, password);
                connection = DriverManager.getConnection(url, user, password);
                System.out.println("✅ Connexion MySQL établie avec succès !");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur de connexion à la base de données", e);
        }
    }
    
    private static String getConfigValue(String propertyKey, String... envKeys) {
        // 1. Essayer les variables d'environnement
        if (envKeys.length == 3) {
            String host = System.getenv(envKeys[0]);
            String port = System.getenv(envKeys[1]);
            String dbName = System.getenv(envKeys[2]);
            
            if (host != null && port != null && dbName != null) {
                return String.format("jdbc:mysql://%s:%s/%s?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", 
                                     host, port, dbName);
            }
        } else if (envKeys.length == 1) {
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

            Flyway flyway = Flyway.configure()
                .dataSource(url, user, password)
                .locations("classpath:db/migration")
                .cleanDisabled(false)
                .outOfOrder(true)
                .load();

            flyway.repair();
            flyway.migrate();
            
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
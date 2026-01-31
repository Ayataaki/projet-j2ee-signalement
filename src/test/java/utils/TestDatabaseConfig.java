package utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import org.flywaydb.core.Flyway;

import dao.SingletonConnection;

public class TestDatabaseConfig {

    private static boolean migrated = false;

    /** 
     * Appliquer Flyway UNE SEULE FOIS par JVM
     */
    public static void migrate() {
        if (!migrated) {
            Flyway flyway = Flyway.configure()
                    .dataSource("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "")
                    .locations("classpath:db/migration")
                    .load();

            flyway.migrate();
            migrated = true;
        }
    }

    /**
     * Nettoyer les données avant chaque test
     */
    public static void cleanDatabase() throws SQLException {
        Connection conn = SingletonConnection.getConnection();
        Statement stmt = conn.createStatement();

        stmt.executeUpdate("DELETE FROM TECHNICIEN");
        stmt.executeUpdate("DELETE FROM EMPLOYE");
        stmt.executeUpdate("DELETE FROM ADMINISTRATEUR");
        stmt.executeUpdate("DELETE FROM CITOYEN");
        // ajoute ici les autres tables si besoin

        stmt.close();
    }
}

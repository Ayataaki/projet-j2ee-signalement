package dao;


import static org.junit.Assert.*;
//import static org.junit.Assertion.*;

import java.sql.Connection;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import metier.Citoyen;

import org.flywaydb.core.Flyway;
import java.sql.Connection;
import java.sql.SQLException;

import utils.TestDatabaseConfig;


public class CitoyenCRUDTest {
	
	private CitoyenCRUDImpl crud = new CitoyenCRUDImpl();

    @Before
    public void setUp() throws Exception {

        // 1️⃣ S'assurer que le schéma existe
        TestDatabaseConfig.migrate();

        // 2️⃣ Nettoyer les données
        TestDatabaseConfig.cleanDatabase();

        // 3️⃣ Initialiser le 
        
		crud = new CitoyenCRUDImpl();
    }



	// @Before
	// public void setUp() throws Exception {

	//     Connection conn = SingletonConnection.getConnection();
	//     conn.createStatement().executeUpdate("DELETE FROM CITOYEN");


    //     Flyway flyway = Flyway.configure()
    //             .dataSource("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "")
    //             .locations("classpath:db/migration") // chemin de tes scripts SQL
    //             .load();

    //     // flyway.clean();   // optionnel : supprime la base avant chaque test
    //     flyway.migrate(); // applique tous les scripts

	// }
	
	private Citoyen createTestCitoyen(String nom, String prenom, String cin, String email) {
        Citoyen c = new Citoyen();
        c.setNom(nom);
        c.setPrenom(prenom);
        c.setCin(cin);
        c.setLieuNaissance("TestVille");
        c.setTelephone("0123456789");
        c.setEmail(email);
        c.setDateNaissance(new java.util.Date());
        c.setDateCreation(new java.util.Date()); 
        c.setMotDePasse("password123"); 
        c.setNomUtilisateur(nom + "." + prenom);
        c.setEmailAuth(cin + "@municipal.ma");
        c.setIdRegion(null);
        return c;
    }
	
	@Test
    public void testCreateAndGetById() {
        Citoyen c = createTestCitoyen("Dupont", "Jean", "C123456", "jean.dupont@example.com");
        crud.createCitoyen(c);

        assertNotNull("L'ID ne doit pas être null après création", c.getIdCitoyen());

        Citoyen fetched = crud.getById(c.getIdCitoyen().longValue());
        assertNotNull(fetched);
        assertEquals(c.getNom(), fetched.getNom());
        assertEquals(c.getPrenom(), fetched.getPrenom());
        assertEquals(c.getNomUtilisateur(), fetched.getNomUtilisateur());
        assertEquals(c.getEmailAuth(), fetched.getEmailAuth());
        assertNotEquals("newpassword", fetched.getMotDePasse());
    }

	@Test
    public void testDeleteCitoyen() {
        Citoyen c = createTestCitoyen("Delete", "Me", "D12345", "delete.me@example.com");
        crud.createCitoyen(c);
        Long id = c.getIdCitoyen();
        assertNotNull(id);

        crud.deleteCitoyen(id.longValue());
        Citoyen deleted = crud.getById(id.longValue());
        assertNull("Le citoyen doit être supprimé", deleted);
    }


	@Test
    public void testUpdateCitoyen() {
        Citoyen c = createTestCitoyen("Test", "User", "T12345", "test.user@example.com");
        crud.createCitoyen(c);

        // Modification
        c.setNom("TestModifie");
        c.setNomUtilisateur(c.getNom() + "." + c.getPrenom());
        c.setEmailAuth(c.getCin() + "@municipal.ma");
        c.setMotDePasse("newpassword");
        crud.updateCitoyen(c);

        Citoyen updated = crud.getById(c.getIdCitoyen().longValue());
        assertEquals("TestModifie", updated.getNom());
        assertEquals(c.getNomUtilisateur(), updated.getNomUtilisateur());
        assertEquals(c.getEmailAuth(), updated.getEmailAuth());
        assertNotEquals("newpassword", updated.getMotDePasse());
        assertTrue(updated.getMotDePasse().length() > 20);
    }

	@Test
	public void testGetAll() {
		 List<Citoyen> list = crud.getAll();
	     assertNotNull("La liste ne doit pas être null", list);
	}

	@Test
	public void testGetCitoyenByRegion() {
		List<Citoyen> list = crud.getCitoyenByRegion(1L);
        assertNotNull("La liste des citoyens par région ne doit pas être null", list);
	}

}

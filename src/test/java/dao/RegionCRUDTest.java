package dao;

import static org.junit.Assert.*;

import java.sql.Date;

import org.junit.Before;
import org.junit.Test;

import metier.Region;

import org.flywaydb.core.Flyway;
import java.sql.Connection;
import java.sql.SQLException;


public class RegionCRUDTest {

	private RegionCRUDImpl regionCRUD;

	@Before
	public void setUp() throws Exception {

		
	    Connection conn = SingletonConnection.getConnection();

		Flyway flyway = Flyway.configure()
                .dataSource("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "")
                .locations("classpath:db/migration") // chemin de tes scripts SQL
                .load();

        // flyway.clean();   // optionnel : supprime la base avant chaque test
        flyway.migrate(); // applique tous les scripts


		regionCRUD = new RegionCRUDImpl();
	}

	@Test
	public void testCreateRegion() {
		
//		NOM, CAPITALE_REGIONALE, SUPERFICIE,"
//		+ " POPULATION, DATE_CREATION
        Region r = new Region();
        r.setNom("Casa-settat");
        r.setCapitaleRegionale("Casa");
        r.setSuperficie(12333);
        r.setPopulation(1213331);
        r.setDateCreation(new Date(System.currentTimeMillis()));

        regionCRUD.createRegion(r);

        assertNotNull("L'ID de la région doit être généré",r.getIdRegion());
        
	}

	@Test
	public void testDeleteRegion() {
		Region r = new Region();
		r.setNom("Souss-Massa");
		r.setCapitaleRegionale("Agadir");
		r.setSuperficie(30000.0f);
		r.setPopulation(2000000);
		r.setDateCreation(new Date(System.currentTimeMillis()));

		regionCRUD.createRegion(r);
		Long id = r.getIdRegion();

		regionCRUD.deleteRegion(id.longValue());
		Region deleted = regionCRUD.getById(id.longValue());

		assertNull("La région doit être supprimée", deleted);
	}

	@Test
	public void testUpdateRegion() {
		Region r = new Region();
		r.setNom("Rabat-Salé-Kénitra");
		r.setCapitaleRegionale("Rabat");
		r.setSuperficie(20000.0f);
		r.setPopulation(2500000);
		r.setDateCreation(new Date(System.currentTimeMillis()));

		regionCRUD.createRegion(r);

		// Modification
		r.setNom("Rabat-Kénitra");
		r.setPopulation(2600000);

		regionCRUD.updateRegion(r);

		Region updated = regionCRUD.getById(r.getIdRegion().longValue());
		assertEquals("Nom doit être mis à jour", "Rabat-Kénitra", updated.getNom());
		assertEquals("Population doit être mise à jour", 2600000, updated.getPopulation());
	}

	@Test
	public void testGetById() {
		Region r = new Region();
		r.setNom("Fès-Meknès");
		r.setCapitaleRegionale("Fès");
		r.setSuperficie(40000.0f);
		r.setPopulation(3000000);
		r.setDateCreation(new Date(System.currentTimeMillis()));

		regionCRUD.createRegion(r);

		Region found = regionCRUD.getById(r.getIdRegion().longValue());
		assertNotNull("La région doit être trouvée", found);
		assertEquals("Les noms doivent correspondre", r.getNom(), found.getNom());
	}

}

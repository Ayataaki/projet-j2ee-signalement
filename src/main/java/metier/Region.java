package metier;

import java.util.Date;

public class Region {
	
	private Long idRegion;
	
	private float superficie;
	
	private int population;

	private String nom,
		capitaleRegionale;

	private Date dateCreation;
	
	

	@Override
	public String toString() {
		return "Region [idRegion=" + idRegion + ", superficie=" + superficie + ", population=" + population + ", nom="
				+ nom + ", capitaleRegionale=" + capitaleRegionale + ", dateCreation=" + dateCreation + "]";
	}

	public Region(float superficie, int population, String nom, String capitaleRegionale) {
		super();
		this.superficie = superficie;
		this.population = population;
		this.nom = nom;
		this.capitaleRegionale = capitaleRegionale;
		this.dateCreation = new Date();
	}

	public Region() {
		super();
	}

	public Long getIdRegion() {
		return idRegion;
	}

	public void setIdRegion(Long idRegion) {
		this.idRegion = idRegion;
	}

	public float getSuperficie() {
		return superficie;
	}

	public void setSuperficie(float superficie) {
		this.superficie = superficie;
	}

	public int getPopulation() {
		return population;
	}

	public void setPopulation(int population) {
		this.population = population;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getCapitaleRegionale() {
		return capitaleRegionale;
	}

	public void setCapitaleRegionale(String capitaleRegionale) {
		this.capitaleRegionale = capitaleRegionale;
	}

	public Date getDateCreation() {
		return dateCreation;
	}

	public void setDateCreation(Date dateCreation) {
		this.dateCreation = dateCreation;
	}
	
	

}

//
//CREATE TABLE IF NOT EXISTS REGION (
//	    ID_REGION BIGINT PRIMARY KEY AUTO_INCREMENT,
//	    NOM VARCHAR(255) NOT NULL,
//	    CAPITALE_REGIONALE VARCHAR(255) NOT NULL,
//	    SUPERFICIE FLOAT NOT NULL,
//	    POPULATION INT NOT NULL,
//	    DATE_CREATION TIMESTAMP DEFAULT CURRENT_TIMESTAMP
//	);
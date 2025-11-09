package dao;

import metier.Citoyen;
import java.util.List;

public interface ICitoyenCRUD {

	void createCitoyen(Citoyen citoyen);
	
	void deleteCitoyen(int id);
	
	Citoyen updateCitoyen(Citoyen citoyen);
	
	Citoyen getById(int id);
	
	Citoyen findByEmailAuth(String email);
	
	List<Citoyen> getAll();
	
	List<Citoyen> getCitoyenByRegion(Long idRegion);
}

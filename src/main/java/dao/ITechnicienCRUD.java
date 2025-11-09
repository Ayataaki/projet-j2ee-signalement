package dao;

import metier.Technicien;

public interface ITechnicienCRUD {
	
	void createTechnicien (Technicien  technicien);
	
	void deleteTechnicien (int  id);
	
	Technicien  updateTechnicien (Technicien  technicien);
	
	Technicien  getById(int id);

	Technicien findByEmailAuth(String email);
}

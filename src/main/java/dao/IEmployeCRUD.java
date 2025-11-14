package dao;

import java.util.List;

import metier.Employe;

public interface IEmployeCRUD {

	void createEmploye(Employe employe);
	
	void deleteEmploye(int id);
	
	Employe updateEmploye(Employe employe);
	
	Employe getById(int id);

	Employe findByEmailAuth(String email);
	
	int countEmploye();
	
	List<Employe> getAll();
}

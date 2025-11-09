package servlet;

import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import metier.Administrateur;
import metier.Citoyen;
import metier.Employe;
import metier.Technicien;
import utils.PasswordHashUtil;

import java.io.IOException;

import dao.AdminCRUDImpl;
import dao.CitoyenCRUDImpl;
import dao.EmployeCRUDImpl;
import dao.TechnicienCRUDImpl;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CitoyenCRUDImpl citoyenDao = new CitoyenCRUDImpl();
    private AdminCRUDImpl adminDao = new AdminCRUDImpl();
    private EmployeCRUDImpl employeDAO = new EmployeCRUDImpl();	
    private TechnicienCRUDImpl technicienDAO = new TechnicienCRUDImpl();	
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {		
		
		//un input à passer en hidden dans les formulaires de création d'un compte
		// citoyen/employe/adminGlobal
		String type = request.getParameter("typeCompte"); 
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String cin = request.getParameter("email") ;
        String telephone = request.getParameter("telephone") ; 
        String lieuNaissance = request.getParameter("lieuNaissance") ;        
        String dateStr = request.getParameter("dateNaissance");
        java.util.Date dateNaissance = java.sql.Date.valueOf(dateStr); 
        String password = request.getParameter("password");
        String hashedPassword = PasswordHashUtil.hashPassword(password);

        switch (type) {
            case "citoyen":
            	//il faut ajouter l'id de la région !!!!!!!!!!!!!!
            	citoyenDao.createCitoyen(new Citoyen(nom,prenom,cin,lieuNaissance,
            			telephone, email, hashedPassword, dateNaissance));
                break;
                
            case "employe":
            	// il faut ajouter l'id du municipal !!!!!
            	employeDAO.createEmploye(new Employe(nom,prenom,cin,lieuNaissance,
            			telephone, email, hashedPassword, dateNaissance));
                break;
                
            case "technicien":
            	// attention, le champ disponibilité à vérifier !!!
            	String specialite = request.getParameter("specialite");
            	String competence = request.getParameter("competence");
            	technicienDAO.createTechnicien(new Technicien(nom, prenom, cin, lieuNaissance,
            			telephone, email, hashedPassword, dateNaissance, specialite, competence));
                break;
                
            case "admin":
            	adminDao.createAdmin(new Administrateur(nom,prenom,cin,lieuNaissance,
            			telephone, email, hashedPassword, dateNaissance));
                break;
        }

        response.sendRedirect("success.jsp");
	
	}

}

package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import metier.Technicien;

import java.io.IOException;

import dao.ITechnicienCRUD;
import dao.TechnicienCRUDImpl;

/**
 * Servlet implementation class TechnicienServlet
 */
@WebServlet("/TechnicienServlet")
public class TechnicienServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ITechnicienCRUD technicienDao = new TechnicienCRUDImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.getRequestDispatcher("views/FormAjoutTechnicien.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String cin = request.getParameter("cin");
		String lieuNaissance = request.getParameter("lieuNaissance");
		String telephone = request.getParameter("telephone");
		String email = request.getParameter("email");

		String specialite = request.getParameter("specialite");
		String competence = request.getParameter("competence");
		Boolean disponibilite = Boolean.parseBoolean(request.getParameter("disponibilite"));
		
		try {
			String dateNaissanceStr = request.getParameter("dateNaissance");
			java.sql.Date dateNaissance = java.sql.Date.valueOf(dateNaissanceStr);
			// Mot de passe par défaut généré pour un technicien
			String motDePasseParDefaut = "123456789";

			Technicien technicien = new Technicien(nom,prenom,cin,lieuNaissance,telephone,email,dateNaissance,
					specialite,competence,disponibilite,motDePasseParDefaut);
			technicienDao.createTechnicien(technicien);
            request.setAttribute("messageSucces", "Technicien ajouté avec succès !");
        } catch (NumberFormatException e) {
            request.setAttribute("messageErreur", "Erreur numérique");
        } catch (Exception e) {
            request.setAttribute("messageErreur", "Erreur lors de l'ajout : " + e.getMessage());
        }

	}

}

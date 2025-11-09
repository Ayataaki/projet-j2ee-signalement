package servlet;

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


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private CitoyenCRUDImpl citoyenDao = new CitoyenCRUDImpl();
    private AdminCRUDImpl adminDao = new AdminCRUDImpl();
    private EmployeCRUDImpl employeDAO = new EmployeCRUDImpl();	
    private TechnicienCRUDImpl technicienDAO = new TechnicienCRUDImpl();	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    		
		String email = request.getParameter("emailAuth");
        String motDePasse = request.getParameter("motDePasse");

        Citoyen citoyen = citoyenDao.findByEmailAuth(email);
        Administrateur admin = adminDao.findByEmailAuth(email);
        Technicien technicien = technicienDAO.findByEmailAuth(email);
        Employe employe = employeDAO.findByEmailAuth(email);

        if (citoyen != null && PasswordHashUtil.verifyPassword(motDePasse, citoyen.getMotDePasse())) {
            request.getSession().setAttribute("user", citoyen);
            response.sendRedirect("citoyen/home.jsp");
        } else if (admin != null && PasswordHashUtil.verifyPassword(motDePasse, admin.getMotDePasse())) {
            request.getSession().setAttribute("admin", admin);
            response.sendRedirect("admin/dashboard.jsp");
        } else if (technicien != null && PasswordHashUtil.verifyPassword(motDePasse, technicien.getMotDePasse())) {
            request.getSession().setAttribute("technicien", technicien);
            response.sendRedirect("technicien/dashboard.jsp");
        } else if (employe != null && PasswordHashUtil.verifyPassword(motDePasse, employe.getMotDePasse())) {
            request.getSession().setAttribute("employe", employe);
            response.sendRedirect("employe/dashboard.jsp");
        }else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
	}

}

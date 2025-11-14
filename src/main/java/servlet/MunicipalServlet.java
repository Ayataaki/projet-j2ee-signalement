package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import metier.Municipal;
import metier.Region;

import java.io.IOException;
import java.util.List;


import dao.IMunicipalCRUD;
import dao.IRegionCRUD;
import dao.MunicipalCRUDImpl;
import dao.RegionCRUDImpl;

/**
 * Servlet implementation class MunicipalServlet
 */
@WebServlet("/MunicipalServlet")
public class MunicipalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IRegionCRUD regionDao = new RegionCRUDImpl();
	private IMunicipalCRUD municipalDao = new MunicipalCRUDImpl();
	

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Charger la liste des régions
		List<Region> regions = regionDao.getAll();
		request.setAttribute("regions", regions);
        request.getRequestDispatcher("views/FormMunicipal.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String typeMunicipal = request.getParameter("typeMunicipal");
        String idRegion = request.getParameter("idRegion");
        
        if (idRegion == null || idRegion.isEmpty()) {
            request.setAttribute("messageErreur", "Veuillez sélectionner une région valide.");
        } else {
            try {
            	Long idRegionM = Long.parseLong(idRegion.trim());
                Municipal municipal = new Municipal(nom, typeMunicipal, idRegionM);
                municipalDao.createMunicipal(municipal);
                request.setAttribute("messageSucces", "Municipal ajouté avec succès !");
            } catch (NumberFormatException e) {
                request.setAttribute("messageErreur", "Erreur : ID région invalide (non numérique)");
            } catch (Exception e) {
                request.setAttribute("messageErreur", "Erreur lors de l'ajout : " + e.getMessage());
            }
        }
                

        List<Region> regions = regionDao.getAll();
        request.setAttribute("regions", regions);
        request.getRequestDispatcher("views/FormMunicipal.jsp").forward(request, response);
    
    }

}

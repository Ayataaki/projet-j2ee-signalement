package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import metier.Region;

import java.io.IOException;
import java.util.List;

import dao.IRegionCRUD;
import dao.RegionCRUDImpl;

/**
 * Servlet implementation class RegionServlet
 */
@WebServlet("/RegionServlet")
public class RegionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private IRegionCRUD regionDao = new RegionCRUDImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		System.out.println(action+"from doGet");

		if (action == null || action.equals("list")) {
			
			listerRegions(request, response);

		} else if (action.equals("suppReg")) {
			
			supprimerRegion(request, response);

		} else if (action.equals("editForm")) {
			
			afficherFormulaireModification(request, response);
			
		} else if ("ajoutRegion".equals(action)) {
            // ✅ Afficher le formulaire d'ajout
            afficherFormulaireAjout(request, response);
            
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		System.out.println(action+"from doPost");
		

		try {
			if ("ajoutRegion".equals(action)) {
				ajouterRegion(request, response);

			} else if ("modifRegion".equals(action)) {
				modifierRegion(request, response);
			} else if (action.equals("ajoutRegion")) {
		        afficherFormulaireAjout(request, response);
		    }else if (action.equals("formAjoutRegion")) {
			    afficherFormulaireAjout(request, response);
			}


		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("messageErreur", "Erreur : " + e.getMessage());
			listerRegions(request, response);
		}
	}

	private void afficherFormulaireAjout(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		request.getRequestDispatcher("views/Region/FormRegion.jsp").forward(request, response);

	}

	private void listerRegions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Region> regions = regionDao.getAll();
        request.setAttribute("regions", regions);
        request.getRequestDispatcher("views/Region/RegionList.jsp").forward(request, response);
    }	

	private void ajouterRegion(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		String nom = request.getParameter("nom");
		String superficie = request.getParameter("superficie");
		String population = request.getParameter("population");
		String capitalRegional = request.getParameter("capitalRegional");
		float s = 0;
		int p = 0;
		try {
			s = Float.parseFloat(superficie);
			p = Integer.parseInt(population);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		regionDao.createRegion(new Region(s, p, nom, capitalRegional));
		
		listerRegions(request,response);
	}
	
	private void supprimerRegion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("idRegion");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            request.setAttribute("messageErreur", "ID région manquant");
            listerRegions(request, response);
            return;
        }
        
        try {
            long id = Long.parseLong(idStr);
            
            // Récupérer le nom avant suppression pour le message
            Region region = regionDao.getById(id);
            String nomRegion = (region != null) ? region.getNom() : "la région";
            
            // Supprimer
            regionDao.deleteRegion(id);
            
            // Message de succès
            request.setAttribute("messageSucces", "Région '" + nomRegion + "' supprimée avec succès !");
            listerRegions(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("messageErreur", "ID région invalide");
            listerRegions(request, response);
        } catch (Exception e) {
            request.setAttribute("messageErreur", "Impossible de supprimer : " + e.getMessage());
            listerRegions(request, response);
        }
    }
	
	private void modifierRegion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Récupérer les paramètres
        String idStr = request.getParameter("idRegion");
        String nom = request.getParameter("nom");
        String superficieStr = request.getParameter("superficie");
        String populationStr = request.getParameter("population");
        String capitaleRegionale = request.getParameter("capitalRegional");
        
        // Validation
        if (idStr == null || nom == null || nom.trim().isEmpty() ||
            superficieStr == null || superficieStr.trim().isEmpty() ||
            populationStr == null || populationStr.trim().isEmpty() ||
            capitaleRegionale == null || capitaleRegionale.trim().isEmpty()) {
            
            request.setAttribute("messageErreur", "Tous les champs sont obligatoires");
            listerRegions(request, response);
            return;
        }
        
        try {
            long id = Long.parseLong(idStr);
            float superficie = Float.parseFloat(superficieStr);
            int population = Integer.parseInt(populationStr);
            
            // Créer l'objet région avec l'ID
            Region region = new Region(superficie, population, nom, capitaleRegionale);
            region.setIdRegion(id);
            
            // Mettre à jour
            regionDao.updateRegion(region);
            
            // Message de succès
            request.setAttribute("messageSucces", "Région '" + nom + "' modifiée avec succès !");
            listerRegions(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("messageErreur", "Format de nombre invalide");
            listerRegions(request, response);
        }
    }

	private void afficherFormulaireModification(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		 String idStr = request.getParameter("idRegion");

	        if (idStr == null || idStr.trim().isEmpty()) {
	            request.setAttribute("messageErreur", "Aucune région sélectionnée pour la modification");
	            listerRegions(request, response);
	            return;
	        }

	        try {
	            long id = Long.parseLong(idStr);
	            Region region = regionDao.getById(id);

	            if (region == null) {
	                request.setAttribute("messageErreur", "Région introuvable !");
	                listerRegions(request, response);
	                return;
	            }

	            request.setAttribute("region", region);
	            request.getRequestDispatcher("/views/Region/RegionEdit.jsp").forward(request, response);

	        } catch (NumberFormatException e) {
	            request.setAttribute("messageErreur", "ID région invalide");
	            listerRegions(request, response);
	        }
	}
	
}

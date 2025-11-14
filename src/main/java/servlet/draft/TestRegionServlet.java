package servlet.draft;

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
 * Servlet implementation class TestRegionServlet
 */
@WebServlet("/TestRegionServlet")
public class TestRegionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestRegionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final IRegionCRUD regionDao = new RegionCRUDImpl();

		List<Region> regions = regionDao.getAll();
		request.setAttribute("regions", regions);
		request.getRequestDispatcher("views/testRegions.jsp").forward(request, response);
	 
	}

	

}
